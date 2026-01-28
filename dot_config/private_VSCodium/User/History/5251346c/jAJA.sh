#!/usr/bin/bash

WORKDIR="$HOME/containers/fedora"

MAIN="$HOME/containers"

WORKDIR="$MAIN/fedora"

HOMEUSR="/home/willians"

SERVER="fedora"

NETWORK="webdev-net"

PORTS="8000:8000"

IMAGE="fedora:latest"

HOST="laboratorio"

mkdir -p "$WORKDIR/dotfiles" "$MAIN/pkg" "$WORKDIR/bak" 

# Para rootless: kill si existe y remover
podman kill "$SERVER" 2>/dev/null || true
podman rm "$SERVER" 2>/dev/null || true


podman run -it --name "$SERVER" --hostname "$SERVER" \
  --hostname "$HOSTING" \
  --network "$NETWORK" \
  -v "$MAIN/pkg:$HOMEUSR/pkg:Z" \
  -v "$HOME/Dev/proyectos:$HOMEUSR/legacy:Z" \
  -v "$HOME/Dev/ensayos:$HOMEUSR/ensayos:Z" \
  -v "$WORKDIR/backup:$HOMEUSR/backup:Z" \
  $IMAGE

#-v ~/.ssh:/home/dk/.ssh:ro \
#   --privileged \
#--userns=keep-id \

  # -p $PORTS \

# BEFORE
  # -v ~/containers/pkg:/home/dk/pkg:Z \
  # -v ~/proyectos:/home/dk/legacy:Z \
  # -v ~/containers/fedora/projects:/home/dk/fedora:Z \
  # -v $WORKDIR/dotfiles/bashrc/.bashrc:/home/dk/.bashrc:Z \
  # -v $WORKDIR/dotfiles/ssh/.ssh:/home/dk/.ssh \
  # -v $WORKDIR/dotfiles/config:/home/dk/.config/:Z \
  # fedora

  # -v "$WORKDIR/staging:/var/lib/mysql:Z" \

# Sera descargado con chezmoi
  -v "$WORKDIR/dotfiles/bashrc/.bashrc:$HOMEUSR/.bashrc:Z" \
  -v "$WORKDIR/dotfiles/ssh/.ssh:$HOMEUSR/.ssh:ro,Z" \
  -v "$WORKDIR/dotfiles/config:$HOMEUSR/.config/:Z" \