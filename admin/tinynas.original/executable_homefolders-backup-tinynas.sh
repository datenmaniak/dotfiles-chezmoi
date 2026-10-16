#!/usr/bin/env bash
#
# backup-tinynas.sh
# Respaldo iterativo por carpetas del home del usuario hacia /mnt/tinynas (NFS).
#
# Características:
#   - Sin --delete (respaldo acumulativo, limpieza manual).
#   - Lock con flock no bloqueante (evita solapamiento con ejecución manual).
#   - Validación de autofs con timeout.
#   - Centinela .tinynas-id solo como advertencia.
#   - Log en /home/wpp/backup.log.
#   - Códigos de salida rsync aceptables: 0 y 24.
#
set -uo pipefail

# ---------------------------------------------------------------------------
# Configuración
# ---------------------------------------------------------------------------
USUARIO="${USER}"
HOME_USUARIO="/home/${USUARIO}"
SCRIPT_DIR="/home/${USER}/admin/tinynas"
EXCLUDE_FILE="${SCRIPT_DIR}/exclude-tinynas.txt"
LOCK_FILE="${SCRIPT_DIR}/backup-tinynas.lock"

NFS_ROOT="/var/mnt/tinynas"
CENTINELA="${NFS_ROOT}/.tinynas-id"
DESTINO_BASE="${NFS_ROOT}/automated-backup"
DESTINO_HOME="${DESTINO_BASE}/home/${USUARIO}"
DESTINO_ETC="${DESTINO_BASE}/etc"

LOG_FILE="/home/${USER}/backup.log"

# Umbral mínimo de espacio libre en el destino (en MiB)
ESPACIO_MIN_MB=512

# Opciones rsync optimizadas para NFS
RSYNC_OPTS=(
  -aHAX
  --numeric-ids
  --exclude-from="${EXCLUDE_FILE}"
  --info=progress2
  --delete-after
  --filter='-x security.selinux'
  --filter='-x system.nfs4_acl'
  --partial
  --inplace
  -z
)

# ---------------------------------------------------------------------------
# Utilidades de log
# ---------------------------------------------------------------------------
log() {
  local nivel="$1"
  shift
  local ts
  ts="$(date '+%Y-%m-%d %H:%M:%S')"
  echo "[${ts}] [${nivel}] $*" >>"${LOG_FILE}"
}

log_info() { log "INFO" "$@"; }
log_warn() { log "WARN" "$@"; }
log_error() { log "ERROR" "$@"; }

# ---------------------------------------------------------------------------
# Lock para evitar solapamiento
# ---------------------------------------------------------------------------
exec 9>"${LOCK_FILE}"
if ! flock -n 9; then
  log_warn "Ejecución previa en curso (lock ${LOCK_FILE} tomado). Abortando."
  exit 0
fi

log_info "=== Inicio de respaldo por carpetas ==="

# ---------------------------------------------------------------------------
# Verificaciones previas
# ---------------------------------------------------------------------------
if ! command -v rsync >/dev/null 2>&1; then
  log_error "rsync no está instalado. Abortando."
  exit 1
fi

if [[ ! -r "${EXCLUDE_FILE}" ]]; then
  log_error "No se puede leer ${EXCLUDE_FILE}. Abortando."
  exit 1
fi

# Forzar montaje autofs con timeout
if ! timeout 20 ls "${NFS_ROOT}" >/dev/null 2>&1; then
  log_error "No se pudo acceder a ${NFS_ROOT} (autofs no montó o NFS caído). Abortando."
  exit 1
fi
log_info "autofs/NFS accesible en ${NFS_ROOT}."

# Centinela: solo advertencia
if [[ ! -e "${CENTINELA}" ]]; then
  log_warn "Centinela ${CENTINELA} no encontrado. Se continúa."
else
  log_info "Centinela encontrado: $(cat "${CENTINELA}" 2>/dev/null | head -n1)"
fi

# Espacio libre en destino
ESPACIO_LIBRE_MB=$(df -Pm "${NFS_ROOT}" | awk 'NR==2 {print $4}')
if [[ -z "${ESPACIO_LIBRE_MB}" || "${ESPACIO_LIBRE_MB}" -lt "${ESPACIO_MIN_MB}" ]]; then
  log_error "Espacio libre insuficiente en ${NFS_ROOT} (${ESPACIO_LIBRE_MB:-?} MiB < ${ESPACIO_MIN_MB} MiB). Abortando."
  exit 1
fi
log_info "Espacio libre en destino: ${ESPACIO_LIBRE_MB} MiB."

# Crear estructura base destino si no existe
mkdir -p "${DESTINO_HOME}" "${DESTINO_ETC}" 2>/dev/null || {
  log_error "No se pudo crear la estructura en ${DESTINO_BASE}. Abortando."
  exit 1
}

# ---------------------------------------------------------------------------
# Respaldo iterativo por subcarpetas del Home
# ---------------------------------------------------------------------------
# Define aquí las carpetas principales que deseas respaldar de forma independiente.
# Puedes añadir o quitar directorios según tus necesidades.
CARPETAS_A_RESPALDAR=(
  "Documentos"
  "Descargas"
  "Proyectos"
  "Imágenes"
  "Música"
  "Videos"
  "admin"
  "probar-homefolder-backup"
  "homelab-infra_ansible"
  "wjpp"
  # Agrega otros directorios relevantes de tu home si es necesario
)

RC_HOME=0

for carpeta in "${CARPETAS_A_RESPALDAR[@]}"; do
  ORIGEN_CARPETA="${HOME_USUARIO}/${carpeta}/"
  DESTINO_CARPETA="${DESTINO_HOME}/${carpeta}/"

  # Verificar si la carpeta de origen existe antes de intentar respaldar
  if [[ -d "${HOME_USUARIO}/${carpeta}" ]]; then
    log_info "Iniciando rsync de la carpeta: ${carpeta}"
    mkdir -p "${DESTINO_CARPETA}"

    sudo rsync "${RSYNC_OPTS[@]}" \
      "${ORIGEN_CARPETA}" \
      "${DESTINO_CARPETA}" >>"${LOG_FILE}" 2>&1

    RC_SUB=$?
    case "${RC_SUB}" in
    0) log_info "Carpeta [${carpeta}]: rsync OK (código 0)." ;;
    24) log_warn "Carpeta [${carpeta}]: rsync completó con código 24 (archivos desaparecieron)." ;;
    *)
      log_error "Carpeta [${carpeta}]: rsync falló con código ${RC_SUB}."
      RC_HOME=1
      ;;
    esac
  else
    log_warn "La carpeta origen ${HOME_USUARIO}/${carpeta} no existe. Omitiendo."
  fi
done

# ---------------------------------------------------------------------------
# Resumen final
# ---------------------------------------------------------------------------
TAM_HOME=$(du -sh "${DESTINO_HOME}" 2>/dev/null | awk '{print $1}')
log_info "Tamaño total destino home: ${TAM_HOME:-?}"

RC_FINAL=0
[[ "${RC_HOME}" -ne 0 ]] && RC_FINAL=1

log_info "=== Fin de respaldo por carpetas (código agregado: ${RC_FINAL}) ==="
exit "${RC_FINAL}"
