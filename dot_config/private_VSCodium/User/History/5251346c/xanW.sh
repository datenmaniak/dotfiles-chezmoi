#!/usr/bin/bash

SOURCE="$HOME/containers/fedora"

MAIN="$HOME/containers"
SOURCE="$MAIN/fedora"
HOMEUSR="/home/willians"
SERVER="fedora"
NETWORK="webdev-net"

PORTS="8000:8000"

IMAGE="fedora"

HOSTING="PHP-hosting"

mkdir -p "$SOURCE/dotfiles" "$MAIN/pkg" "$SOURCE/bak" 

# Para rootless: kill si existe y remover
podman kill "$SERVER" 2>/dev/null || true
podman rm "$SERVER" 2>/dev/null || true


# podman run -it --name fedora \
podman run -it --name "$SERVER" --hostname "$SERVER" \
  --hostname "$HOSTING" \
  -p $PORTS \
  --network "$NETWORK" \
  -v "$MAIN/pkg:$HOMEUSR/pkg:Z" \
  -v "$HOME/Dev/proyectos:$HOMEUSR/legacy:Z" \
  -v "$HOME/Dev/ensayos:$HOMEUSR/ensayos:Z" \
  -v "$MAIN/fedora/projects:$HOMEUSR/fedora:Z" \
  -v "$SOURCE/bak:$HOMEUSR/backup:Z" \
  -v "$SOURCE/dotfiles/bashrc/.bashrc:$HOMEUSR/.bashrc:Z" \
  -v "$SOURCE/dotfiles/ssh/.ssh:$HOMEUSR/.ssh:ro,Z" \
  -v "$SOURCE/dotfiles/config:$HOMEUSR/.config/:Z" \
  $IMAGE

#-v ~/.ssh:/home/dk/.ssh:ro \
#   --privileged \
#--userns=keep-id \


# BEFORE
  # -v ~/containers/pkg:/home/dk/pkg:Z \
  # -v ~/proyectos:/home/dk/legacy:Z \
  # -v ~/containers/fedora/projects:/home/dk/fedora:Z \
  # -v $SOURCE/dotfiles/bashrc/.bashrc:/home/dk/.bashrc:Z \
  # -v $SOURCE/dotfiles/ssh/.ssh:/home/dk/.ssh \
  # -v $SOURCE/dotfiles/config:/home/dk/.config/:Z \
  # fedora

  # -v "$SOURCE/staging:/var/lib/mysql:Z" \
