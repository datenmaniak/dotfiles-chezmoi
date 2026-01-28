#!/usr/bin/bash


# 1. Build simple
MAIN="$HOME/containers"

SOURCE="$MAIN/db"

IMAGE="mariadb-dk"

NETWORK="webdev-net"

podman rmi --force $IMAGE || true

mkdir -p $SOURCE/dotfiles

mkdir -p "$SOURCE/dotfiles" "$MAIN/pkg" "$SOURCE/sql" "$SOURCE/bak"


rsync -av ~/.bashrc $SOURCE/dotfiles/bashrc/
rsync -av ~/.ssh $SOURCE/dotfiles/ssh/
rsync -av ~/.config/starship.toml $SOURCE/dotfiles/config/

podman build -t $IMAGE -f $SOURCE/init/Dockerfile-root