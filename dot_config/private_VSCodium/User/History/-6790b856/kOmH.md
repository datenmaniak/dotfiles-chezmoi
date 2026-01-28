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

## Ahora lo esencial para que sea ejecutable desde cualquier ruta.

1. Copiar la lista de exclusiones

```bash
cd ~/backup-tools

cp ~/backup-tools/ignore.json ~/.bin

````

2. Copiar el ejecutable

```bash
cp bakdir ~/.bin
```

En caso que no se ejecute, ajusta los permisos antes del paso 2:
```bash
chmod +x bakdir
```