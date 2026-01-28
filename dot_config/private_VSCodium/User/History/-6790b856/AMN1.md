# Herramientas de respaldo

He desarrollado esto para optimizar el respaldo y minimizar los requerimientos de espacio para almacenaje.


## Requerimientos

Restaurar al host local, la carpeta de componentes: **backup-tools**


```bash

# Crea este directorio en tu $HOME
cd  ~/.bin

# agrega esto a tu .bashrc o .zshrc

export PATH="$HOME/.bin:$HOME/.local/bin:$PATH"
```

1. Copiar la lista de exclusiones

```bash



cd ~/backup-tools

cp ~/backup-tools/ignore.json ~/.bin

````

2. Copiar el script principal
```bash
cp bakdir ~/.bin