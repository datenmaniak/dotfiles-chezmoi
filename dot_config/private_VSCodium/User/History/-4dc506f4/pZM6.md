# Backup & Restore - Contenedores 

Si tu objetivo es mover un contenedor de una computadora a otra (otro host), el método 
recomendado es el Método 2 (Commit + Save), pero con un detalle clave: asegurarte de 
incluir los metadatos.


## 1. En el Host de Origen: Empaquetar

Primero transformamos el contenedor en una imagen y esa imagen en un archivo transportable.


- Crear la imagen desde el contenedor encendido o apagado


```bash
podman commit nombre_contenedor mi_app_migracion:latest
```

- Guardar la imagen en un archivo comprimido para que pese menos
```bash
podman save mi_app_migracion:latest | gzip > respaldo_portatil.tar.gz
```

##  2. Transferir el archivo

Usa scp, un pendrive o cualquier medio para mover el archivo **respaldo_portatil.tar.gz** al nuevo servidor.


## 3. En el Host de Destino: Desempaquetar

- Cargar la imagen al motor de Podman local
```bash
podman load -i respaldo_portatil.tar.gz
```

- Verificar que la imagen *mi_app_migracion* aparece en la lista
```bash
➜ podman images
```
| REPOSITORY                    | TAG       |   IMAGE ID     |     CREATED          | SIZE   |
|-------------------------------|-----------|----------------|----------------------|--------|
| localhost/mi_app_migracion    |latest     | e10038bac8e1   | About an hour ago    | 585 MB |
|localhost/fedora               | 42        | 090cc9e5b245   |  21 hours ago        | 171 MB |





## 4. Comprobar si tuvo éxito el respaldo y la restauración ?

Por primera vez ejecuto lo siguiente para crear el contenedor

```bash
 podman run -it --name restored --hostname Fedora mi_app_migracion:latest

[willians@Fedora ~]$ 

## Si ves el este prompt, entonces se ha creado exitosamente!!
exit

```


He asignado el nombre **restored** al contenedor en lugar de **contenedor_recuperado**. Al mismo tiempo, le asigno el
nombre al hostname para identificar entre otros.



## 5. Verificar el estado de los contenedores y comprobar que aparece en la lista.

```bash

podman ps -a 

CONTAINER ID  IMAGE                                 COMMAND               CREATED        STATUS                          

ddeddc80b5b5  localhost/mi_app_migracion:latest     /bin/bash             2 seconds ago  Exited (0) 3 seconds ago                                restored


```


## Prueba final: Uso real con un script personal **podman_deploy**.

Ahora reinicio el contenedor

```bash
➜ podman start restored
restored
```

Accedo el contenedor utilizando mi estrategia preferida de manejo de volumenes.

```bash
➜ podman_deploy mi_app_migracion:latest restored \
/home/willians/containers/fedora/backups:/home/willians/backup \ 
/home/willians/proyectos:/home/willians

♻️  Limpiando instancia previa: restored...
📂 Configurando volúmenes...
   -> Montado: /home/willians/containers/fedora/backups:/home/willians/backup
   -> Montado: /home/willians/proyectos:/home/willians
🚀 Iniciando contenedor desde mi_app_migracion:latest...
✅ Éxito: Contenedor 'restored' desplegado.

CONTAINER ID  IMAGE                              COMMAND     CREATED                 STATUS                 PORTS                   NAMES
ed78397744db  localhost/mi_app_migracion:latest  /bin/bash   Less than a second ago  Up Less than a second  0.0.0.0:8000->8000/tcp  restored
```


## ¿Por qué este es el método recomendado?

    Conserva el "Punto de Entrada" (Entrypoint): A diferencia del método export, aquí no tienes 
    que recordar qué comando iniciaba la aplicación. La imagen ya sabe qué hacer cuando le das a run.

    Configuración de Red y Puertos: Mantiene la información de qué puertos necesita el contenedor.

    Integridad de Capas: Si el nuevo host ya tiene partes de la imagen (como una base de Debian), 
    el proceso de carga puede ser más eficiente.


## Observaciones

⚠️ El gran "Pero": Los Volúmenes

Ninguno de estos métodos mueve los datos guardados en volúmenes (bases de datos, archivos de usuario, etc.) porque Podman los guarda fuera del contenedor por seguridad.





## Como  resuelvo el gran "Pero" de los volumenes **Bind Mounts** y **Named Volumes**

### Estrategia 1: Si usas "Bind Mounts" (Carpetas locales)


Esta es la más sencilla. Si al crear tu contenedor usaste algo como -v /mis/datos:/data, 
los datos están en una carpeta de tu PC.

1. En el origen: Comprimir la carpeta

```bash
# Empaquetamos la carpeta de datos
tar -czvf datos_volumen.tar.gz /ruta/a/tus/datos
```

2. En el destino: Descomprimir y Vincular

Una vez que muevas ese .tar.gz al nuevo host:

```bash
# 1. Descomprimir
tar -xzvf datos_volumen.tar.gz -C /nueva/ruta/datos

# 2. Iniciar el contenedor restaurado apuntando a esa carpeta
podman run -d \
  --name contenedor_restaurado \
  -v /nueva/ruta/datos:/data:Z \
  mi_app_migracion:latest
```

Este proceso puede resultar más delicado o complicado, por lo que personalmente prefiero indicar al contenedor los volumenes
que preciso mantener  persistencia, entonces utilizo la estrategia siguiente.

### Estrategia 2: Si usas "Named Volumes" (Volúmenes gestionados)



