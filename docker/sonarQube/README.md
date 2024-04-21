# Sonarqube

Este proyecto contiene los archivos necesarios para levantar sonarqube en un contenedor de docker junto con una base de datos postgres, autocreando la base de datos y el usuario.

Solo es necesario tener docker y docker-compose instalado en la maquina y MAKE.

## Instrucciones

Para levantar el contenedor de sonarqube solo es necesario ejecutar el siguiente comando:

```bash
make run_all
```

Es necesario tener postgressql.jar para poder que ya está adjunto.