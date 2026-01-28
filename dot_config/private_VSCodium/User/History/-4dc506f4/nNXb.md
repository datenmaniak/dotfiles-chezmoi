# Backup & Restore - Contenedores 

Si tu objetivo es mover un contenedor de una computadora a otra (otro host), el método 
recomendado es el Método 2 (Commit + Save), pero con un detalle clave: asegurarte de 
incluir los metadatos.


## 1. En el Host de Origen: Empaquetar

Primero transformamos el contenedor en una imagen y esa imagen en un archivo transportable.



```bash
# 1. Crear la imagen desde el contenedor encendido o apagado
podman commit nombre_contenedor mi_app_migracion:latest

# 2. Guardar la imagen en un archivo comprimido para que pese menos
podman save mi_app_migracion:latest | gzip > respaldo_portatil.tar.gz
```

##  2. Transferir el archivo

Usa scp, un pendrive o cualquier medio para mover el archivo **respaldo_portatil.tar.gz** al nuevo servidor.


## 3. En el Host de Destino: Desempaquetar

```bash
# 1. Cargar la imagen al motor de Podman local
podman load -i respaldo_portatil.tar.gz

# 2. Verificar que la imagen aparece en la lista
podman images
```

¿Por qué este es el método recomendado?

    Conserva el "Punto de Entrada" (Entrypoint): A diferencia del método export, aquí no tienes 
    que recordar qué comando iniciaba la aplicación. La imagen ya sabe qué hacer cuando le das a run.

    Configuración de Red y Puertos: Mantiene la información de qué puertos necesita el contenedor.

    Integridad de Capas: Si el nuevo host ya tiene partes de la imagen (como una base de Debian), 
    el proceso de carga puede ser más eficiente.


## Observaciones

⚠️ El gran "Pero": Los Volúmenes

Ninguno de estos métodos mueve los datos guardados en volúmenes (bases de datos, archivos de usuario, etc.) porque Podman los guarda fuera del contenedor por seguridad.




## 4. Comprobar si tuvo éxito el respaldo y restaruración ?

```bash
podman run -d --name contenedor_recuperado mi_app_migracion:latest

## Verificar el estado de los contenedores y comprobar que aparece en la lista **contenedor_recuperado** 

podman ps -a 

```


## Como restauro un contenedor y resuelvo el **gran pero** de los volumenes **Bind Mounts**



