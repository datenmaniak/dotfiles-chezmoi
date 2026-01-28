#!/usr/bin/bash


# 1. Build simple
MAIN="$HOME/containers"

SOURCE="$MAIN/fedora"


IMAGE="fedora"


podman rmi --force $IMAGE || true

mkdir -p $SOURCE/dotfiles

mkdir -p "$SOURCE/dotfiles" "$MAIN/pkg" "$SOURCE/backup"

rsync -av ~/.bashrc $SOURCE/dotfiles/bashrc/
rsync -av ~/.ssh $SOURCE/dotfiles/ssh/
rsync -av ~/.config/starship.toml $SOURCE/dotfiles/config/

podman build -t $IMAGE  -f $SOURCE/init/DebianContainerfile


#CONTAINER_ID=$(podman run -d fedora sleep 1500)




# 3. Copiar archivos
#podman cp -a $SOURCE/pkg "$CONTAINER_ID:/home/dk/"
# podman cp -a $SOURCE/bashrc/.bashrc "$CONTAINER_ID:/home/dk/"
# podman cp -a $SOURCE/ssh/.ssh "$CONTAINER_ID:/home/dk/"
# podman cp -a $SOURCE/config/starship.toml "$CONTAINER_ID:/home/dk/.config/"



# 4. Entrar
#podman exec -it "$CONTAINER_ID" bash
#bash ~/containers/fedora/init/run.sh

