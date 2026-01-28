#!/usr/bin/env python3
import subprocess
import sys
import os


def check_network(network_name):
    """Verifica si la red existe, si no, la crea."""
    networks = subprocess.run(
        ["podman", "network", "ls", "--format", "{{.Name}}"],
        capture_output=True,
        text=True,
    ).stdout.splitlines()
    if network_name not in networks:
        print(f"🌐 Creando red de Podman: {network_name}...")
        subprocess.run(["podman", "network", "create", network_name], check=True)


def run_command(command):
    try:
        result = subprocess.run(command, check=True, capture_output=True, text=True)
        return result.stdout.strip()
    except subprocess.CalledProcessError as e:
        print(f"❌ Error al ejecutar: {' '.join(command)}")
        print(f"Detalle: {e.stderr}")
        return None


def deploy_container(image, name, volumes):
    network = "webdev-net"
    ports = "8000:8000"

    # Asegurar que la red existe
    check_network(network)

    print(f"♻️  Limpiando instancia previa: {name}...")
    subprocess.run(["podman", "kill", name], capture_output=True)
    subprocess.run(["podman", "rm", name], capture_output=True)

    cmd = [
        "podman",
        "run",
        "-it",
        "-d",
        "--name",
        name,
        "--hostname",
        name,
        "--network",
        network,
        "-p",
        ports,
        "--privileged",
    ]

    print("📂 Configurando volúmenes...")
    for vol in volumes:
        if ":" in vol:
            host_path = os.path.expanduser(vol.split(":")[0])
            if not os.path.exists(host_path):
                print(f"⚠️  Ruta host inexistente: {host_path}. Saltando...")
                continue
            cmd.extend(["-v", f"{vol}:Z"])
            print(f"   -> Montado: {vol}")

    cmd.append(image)

    print(f"🚀 Iniciando contenedor desde {image}...")
    if run_command(cmd) is not None:
        print(f"✅ Éxito: Contenedor '{name}' desplegado.")
        subprocess.run(["podman", "ps", "-f", f"name={name}"])


if __name__ == "__main__":
    if len(sys.argv) < 3:
        print("Uso: ./podman_deploy <imagen> <nombre> [vol1] [vol2] ...")
        sys.exit(1)

    deploy_container(sys.argv[1], sys.argv[2], sys.argv[3:])
