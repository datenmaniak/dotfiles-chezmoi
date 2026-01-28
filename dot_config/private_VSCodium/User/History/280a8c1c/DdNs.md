# Fedora Bluefin Migration Steps

## essential GUI Apps 


```bash
flatpak remote-add --if-not-exists flathub ./flathub.flatpakrepo

```

```bash

flatpak install md.obsidian.Odsidian com.obsproject.Studio videolan.VLC com.vivaldi.Vivaldi
    

## Run 
flatpak install md.obsidian.Odsidian
flatpak install com.obsproject.Studio 
flatpak install videolan.VLC
flatpak install com.vivaldi.Vivaldi
```

## Configure OBS
Resolution 1920x1080
25 PAL





## Bootstrapping the workstation

- Mount USB Key

- Restaurar los componentes elementales del setup


```bash
sudo mount /dev/sdX /mnt

mkdir ~/workstation.setup

cp /mnt/* ~/workstation.setup

bash ~/workstation.setup/fedora

# the setup contains:
    rpm-ostree install libatomic alacritty  tmux zsh gcc gnupg2 
```

## Reboot 
```bash
systemctl reboot
```



# -- Workstation Setup CLI  Testing @ Fedora Container --

## fedora

```bash 
# Run as test at Fedora container
sudo dnf install vim nano wget curl git zsh pass 
```


```bash

# Run at Fedora Atomic Release Only
sudo usermod --shell /usr/bin/zsh $USER

# Run at container
chsh -s $(which zsh)

  En caso de fallar, agregar al .bashrc

# Ejecuta zsh si no está corriendo ya
if [ -t 1 ]; then
  exec zsh
fi

# Volver a entrar al contenedor, indicado el zsh en lugar de bash:

podman exec -it fedora zsh
```

## setup
```bash
sudo dnf install -y chezmoi

chezmoi init --apply https://github.com/tu-usuario/dotfiles-chezmoi.git

# chezmoi
gpg --import workstation.setup/gpg-public.asc

chezmoi cd


#En caso de errores para importar las claves



```



# Run at Podman container

podman exec -it Laravel zsh
```

## Install essential CLI Apps

```bash
# install mise and chezmoi
bbrew install mise chezmoi
````

```bash
chezmoi cd

gpg --import ~/workstation.setup/gpg-public.asc
```






