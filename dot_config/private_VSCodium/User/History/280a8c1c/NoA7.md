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
sudo dnf install -y chezmoi pinentry

chezmoi init --apply https://github.com/tu-usuario/dotfiles-chezmoi.git

# chezmoi
gpg --import workstation.setup/gpg-public.asc

chezmoi cd

# En caso de haberse realizado cambios asociados a chezmoi

chezmoi update -v


#En caso de errores para importar las claves



```

## En caso de errores para subir los cambios a Github

¿Cómo evitar que te lo pida cada vez?

Si no quieres estar pegando ese token largo en el futuro, puedes "vincularlo" a la URL de tu repositorio localmente.

```bash
# Cambia 'USUARIO', 'TOKEN' y 'REPOSITORIO' por tus datos reales
git remote set-url origin https://USUARIO:TOKEN@github.com/USUARIO/dotfiles-chezmoi.git
git push --set-upstream origin main


git remote set-url origin https://datenmaniak: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@github.com/USUARIO/dotfiles-chezmoi.git

# Ejecuta este, en caso que persistan errores:
git remote set-url origin https://github.com/TU_USUARIO/TU_REPOSITORIO.git

```


# En caso de presentarse errores, como este:
```bash
[willians@fedora chezmoi]$ chezmoi apply -v
gpg: encrypted with cv25519 key, ID BC265166C808135E, created 2026-01-25
      "Willians Patino (principal) <ppwj@yahoo.com>"
gpg: public key decryption failed: No secret key
gpg: decryption failed: No secret key
chezmoi: .gitconfig: exit status 2


# Run this:
# Crear la carpeta con permisos restrictivos
mkdir -p -m 700 ~/.gnupg

# Crear el archivo con la instrucción necesaria
echo "allow-loopback-pinentry" > ~/.gnupg/gpg-agent.conf

# Ajustar permisos del archivo
chmod 600 ~/.gnupg/gpg-agent.conf

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






