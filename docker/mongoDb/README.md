
<img style="position: absolute; top: 0px; right: 60px;" height="80px" src="https://cdn.iconscout.com/icon/free/png-256/mongodb-226029.png">
<!-- <span style="position: absolute; top: 50px; right: 0px" >![Tag img]https://cdn.iconscout.com/icon/free/png-256/mongodb-226029.png)</span> -->
<!-- ![Mongo icon](https://cdn.iconscout.com/icon/free/png-256/mongodb-226029.png) -->


# MongoDb práctica

## Pasos antes de

Una vez subes docker entra al bash de mongo

```
docker exec -it mongodb_mongo_1 /bin/bash
```

Para importar información de un archivo json uso el siguiente comando respetectivamente en su collection usar --collection nombreMiColeccion
```
> mongoimport --db movieLens --collection users --file "$PWD/movielens_users.json"
> mongoimport --db movieLens --collection movies --file "$PWD/movielens_movies.json"
```
> use movieLens
## Consultas 

La colección movies contiene la información sobre las películas incluyendo su identificación, titulo y generos. 

Para consultar una película utilice el siguiente comando: 


> db.movies.findOne()

* Resultado
```json
{ 
"_id" : 1, 
"title" : "Toy Story (1995)", 
"genres" : "Animation|Children's|Comedy" 
}
```
La colección users contiente la información de las personas que han calificado dichas películas. 

Incluye su identificación, nombre, edad, ocupación y sexo. Las calificaciones están incluidas como un arreglo embebido de documentos, cada uno teniendo un identificador de película (el cual hace referencia a la colección movies), una calificación y una fecha que indica cuando se efectuo la 
calificación. 

Deduzca para que sirve el siguiente comando:

> db.users.findOne({},{movies : {$slice : 2}});

* Resultado
```json
{
    "_id" : 6038,
    "name" : "Yaeko Hassan",
    "gender" : "F",
    "age" : 95,
    "occupation" : "academic/educator",
    "movies" : [
            {
                    "movieid" : 1419,
                    "rating" : 4,
                    "timestamp" : 956714815
            },
            {
                    "movieid" : 920,
                    "rating" : 3,
                    "timestamp" : 956706827
            }
    ]
}
```

# Ejercicios

Conteste las siguientes preguntas utilizando el comando necesario. (En un documento de Word escriba la pregunta, el comando que utilizo para contestarla y la respuesta que dio la base de datos) 


**1.** ¿Cuantos documentos hay en la colección users? 
>  db.runCommand({ count: 'users' })

**2.** ¿Cuantos documentos hay en la colección movies? 
>   db.runCommand({ count: 'movies' })

**3.** ¿Cuál es el trabajo de Clifford Johnatan? Muestre solo su nombre y ocupación 

Similiar a LIKE SQL
> db.users.find({ name : /Clifford/ }, { occupation: 1, name: 1 } );

> db.users.find({ name : "Clifford Jonathan" }, { occupation: 1, name: 1 } );

```json
{ "_id" : 2593, "name" : "Clifford Jonathan", "occupation" : "self-employed" }
```

**4.** ¿Cuantos documentos de la colección user tienen entre 18 y 30 años? 
> db.users.find({ age : { "$gt" : 18, "$lt": 30 }}).count()

**5.** ¿Cuantos usuarios hay que sean científicos o artistas? (“artista” “scientist”) 
> db.users.find({ occupation : { "$in" : ["artista", "scientist"] }}).count()

```
144
```

**6.** ¿Cuales son las 10 mujeres con mayor edad? 
> db.users.find({ gender : "F", age : { "$gt" : 28 }}).count()

```
1121
```

**7.** Muestre todas las ocupaciones de los usuarios.
> db.users.find({}, { occupation: 1})


## Si quiere elimar la base de datos 

Una vez subes docker entra al bash de mongo

> use movieLens

> db.dropDatabase()



