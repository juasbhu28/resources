
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


### 1. ¿Cuantos documentos hay en la colección users? 
+ Opción  1
``` js
    > db.runCommand({ count: 'users' })
 ```   
+ Opción 2
``` js
    > db.users.count()
```
### 2. ¿Cuantos documentos hay en la colección movies? 
+ Opción  1
``` js
    > db.runCommand({ count: 'movies' })
```
+ Opción 2
``` js
    > db.movies.count()
```
### 3. ¿Cuál es el trabajo de Clifford Johnatan? Muestre solo su nombre y ocupación 



+ Opcion 1
``` js
   > db.users.find( { name: "Clifford Johnathan" }, { "name": 1, "occupation": 1 } 
```
+ Opcion 2
``` js
   > db.users.find({ name : "Clifford Jonathan" }, { occupation: 1, name: 1 } );
```
+ Otro
``` js
    > db.users.find({ name : /Clifford/ }, { occupation: 1, name: 1 } ) //Similiar a LIKE in SQL
```
**Resultado**
```json
//Otro usuario con nombre similiar like
{ "_id" : 2593, "name" : "Clifford Jonathan", "occupation" : "self-employed" }

//Resultado esperado.
{ "_id" : 1276, "name" : "Clifford Johnathan", "occupation" : "technician/engineer" }
```

### 4. ¿Cuantos documentos de la colección user tienen entre 18 y 30 años? 
``` js
   > db.users.find({ age : { "$gt" : 18, "$lt": 30 }}).count()
```
### 5. ¿Cuantos usuarios hay que sean científicos o artistas? (“artista” “scientist”) 
+ Opcion 1
``` js
   > db.users.find({ occupation : { "$in" : ["artista", "scientist"] }}).count() `--144`
```
+ Opcion 2
``` js
   > db.users.find({ occupation: { $in: [ "artist", "scientist" ] }}).count() `--411`
```
### 6. ¿Cuales son las 10 mujeres con mayor edad? 
+ Top 10
``` js
  > db.users.find( { gender: "F" }, { name: 1, age: 1 } ).sort( { age: -1 } ).limit( 10 )
```
+ Total
``` js
  > db.users.find({ gender : "F", age : { "$gt" : 28 }}).count()
```

### 7. Muestre todas las ocupaciones de los usuarios.
+ Opcion 1
``` js
  > db.users.find({}, { occupation: 1})
```
+ Opcion 2
``` js
  > db.users.aggregate ( { $group: { _id: { occupation: "$occupation"  } } } )  `-- Agrupa para no repetir`
```
### 8. Inserte en la base de datos su propio nombre sin incluir el campo movies 

+ Insert
``` js
   > db.users.insert ( { "name" : "Juan Botello", "gender" : "M", "age" : 27, "occupation" : "technician/engineer"})
```
+ Buscar
``` js
   > db.users.find( { name: "Juan Botello" } )
```
### 9. Seleccione una película cualquiera existente en la colección movies y actualice el documento que inserto anteriormente adicionando la película que selecciono e incluya una calificación de la misma 
+ Update
``` js
    > db.users.update ( { name: "Juan Botello" }, { $set: { movies: [ { movieid: 1419, rating: 2 } ] } } )
```
### 10. Elimine el registro modificado en el punto anterior 
+ Delete registro
``` js
   > db.users.deleteOne( { name: "Alexander Andrade" } )
```
+ Delete actualización 
``` js
```
### 11. Cambie todos los usuarios que tengan la ocupación programador (programmer) por desarrollador (developer). Utilice expresiones regulares para contestar las siguientes preguntas: 
* Actualizar masivamente. (Update)
``` js
   > db.users.updateMany ( { occupation: "programmer" }, { $set: { occupation: "developer" } } )
```
### 12. ¿Qué títulos incluyen la fecha de lanzamiento entre paréntesis? 
+ Usando una operación con regex.
``` js
   > db.movies.find( { title: { $regex: /.*\([0-9]{4}\).*/ } }, { title: 1 } )
```
### 13. ¿Qué películas han sido estrenadas entre 1984 y 1992? 
+ Los titulo tienen la fecha de estreno, ejmp `Walkabout (1971)`.
``` js
   > db.movies.find( { title: { $regex: /.*\((198[4-9]{1}|199[0-2]{1})\)` } }, { title: 1 } )
```

### 14. ¿Cuantas películas de horror hay? 
+ Los titulos 
``` js
      > db.movies.find( { genres: { $regex: /.*Horror.*/ } } )
```
### 15. ¿Cuantas películas hay que sean de los géneros romance y musical al mismo tiempo (“Romance” “Musical”)?
``` js
> db.movies.find( { genres: { $regex: /.*Musical.*Romance.*|.*Romance.*Musical.*/ } } ).count()
```


## Para elimar la base de datos 

* Una vez subes docker entra al bash de mongo

   > use movieLens

  > db.dropDatabase()



