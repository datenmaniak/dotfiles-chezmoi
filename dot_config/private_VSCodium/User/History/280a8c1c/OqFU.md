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

## Install essential CLI Apps

```bash
# install mise and chezmoi
bbrew install mise chezmoi
````


## Bootstrapping the workstation

Mount USB Key

```bash
sudo mount /dev/sdX /mnt

mkdir ~/workstation.setup

cp /mnt/* ~/workstation.setup

bash ~/workstation.setup/fedora

# fedora contains:
    rpm-ostree install libatomic alacritty  tmux zsh gcc gnupg2 
```







