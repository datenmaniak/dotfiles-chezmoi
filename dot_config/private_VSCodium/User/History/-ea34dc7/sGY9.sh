#!/usr/bin/bash

# fedora 43

# Para el entorno de desarrollo; editores, navegadores web, etc.




MAIN="$HOME/containers"

SOURCE="$MAIN/tools"

USR="willians"

NETWORK="webdev-net"

CONTAINER="toolsbox"


IMAGE="fedora:43"



# LIMPIAR + RECREAR
distrobox rm -f $CONTAINER || true



# Crear CORRECTO
distrobox create --name $CONTAINER \
  --hostname $CONTAINER \
  -i $IMAGE \

  # --pre-init-hooks "dnf update" \
  # --additional-packages "vim nano git curl wget " \

  # --unshare-all \
  #--init-hooks "bash $MAIN/pkg/install-vscodium.sh" \
  #--additional-packages "systemd libpam-systemd pipewire-audio-client-libraries" \

  #--volume $SOURCE/vscodium/.vscode-oss:$HOME/.vscode-oss:Z \

#
# distrobox enter $CONTAINER  -- bash  "bash $MAIN/pkg/install-vscodium.sh"



# No funciona para Distrobox
  # --privileged \
