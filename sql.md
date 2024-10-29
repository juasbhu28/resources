# Algunos estandares para escribir SQL

El nombre de las tablas debe ser un sustantivo en plural y en minúsculas. Si el nombre de la tabla está compuesto por más de una palabra, estas deben ir separadas por guiones bajos.

```sql

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

```

Existen muchos tipos de datos, pero los más comunes son:

- `VARCHAR(n)`: Cadena de caracteres de longitud fija.
- `TEXT`: Cadena de caracteres de longitud variable.
- `INT`: Número entero.
- `SERIAL`: Número entero autoincremental.
- `TIMESTAMP`: Fecha y hora.

Las llaves primarias normalmente se llaman `id` y son de tipo `INTEGER`también en mysql se agrega un UNSIGNED para que no se puedan agregar valores negativos. El valor para ser llaver primaria es PRIMARY y el AUTO_INCREMENT para que se auto incremente.

```sql

CREATE TABLE users (
    id INTEGER UNSINGED PRIMARY KEY AUTO_INCREMENT,
    user ,
    title VARCHAR(50) NOT NULL,
    content TEXT NOT NULL,
 );

```
