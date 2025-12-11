# Proyecto SQL – Máster Data Analytics (ThePowerMBA)

Este proyecto contiene la resolución completa del módulo de Bases de Datos utilizando **PostgreSQL** y **DBeaver**.  
El objetivo es demostrar dominio sobre:

- Manejo del motor PostgreSQL  
- Manejo de DBeaver  
- Consultas SQL sobre una o varias tablas  
- Subconsultas y CTE  
- Joins avanzados  
- Vistas  
- Tablas temporales  
- Buenas prácticas de estructura y documentación  

---

## 📁 Estructura del repositorio

├── README.md 

├── consultas_resueltas.sql (Todas las consulas resueltas y enumeradas)

├── proyecto.sql (Esquema de la BBDD proporcionada por The PowerMBA)


---

## 🧱 1. Creación y carga de la base de datos

1. Instalé **PostgreSQL** y **DBeaver**  
2. Creé una nueva conexión en DBeaver  
3. Activé la opción “Show all databases” para poder crear nuevas bases de datos  
4. Importé el archivo SQL proporcionado por la escuela (proyecto.sql)  
5. Verifiqué el modelo E-R y relaciones entre tablas  

---

## 🧪 2. Desarrollo de consultas SQL

Durante el proyecto desarrollé más de **60 consultas**, ordenadas y comentadas en el archivo `consultas_resueltas.sql`.

Se aplicaron los siguientes conceptos:

### 🔹 Consultas básicas  
SELECT, filtros, ordenaciones, funciones básicas…

### 🔹 Consultas multitabla  
Joins: INNER, LEFT, RIGHT, FULL, CROSS.

### 🔹 Subconsultas y CTE  
Utilizadas especialmente en ejercicios complejos (ej. #55).

### 🔹 Funciones de agregación  
SUM, AVG, MIN, MAX, COUNT, STDDEV, VARIANCE…

### 🔹 Vistas  
Como en el ejercicio #48 (actor_num_peliculas).

### 🔹 Tablas temporales  
Ejercicios #51 y #52.

---

## 📊 3. Análisis Final

Este proyecto permite practicar un dataset realista muy similar al de DVD Rental.

**Conclusiones del análisis:**

- Las categorías más rentables suelen ser *Action*, *Sports* y *Drama*.  
- Existen clientes con patrones de alquiler intensivos (más de 7 películas diferentes).  
- El coste de reemplazo (replacement_cost) tiene alta variabilidad.  
- La duración media de las películas se concentra entre 90 y 120 minutos.  
- El sistema permite analizar el comportamiento de clientes, películas, actores y categorías.

---

## 📝 4. Archivo con las consultas

Todas las consultas se encuentran en:

👉 **consultas_resueltas.sql**

Cada consulta aparece:

- Identificada con su número original  
- Comentada con el enunciado  
- Formateada siguiendo buenas prácticas SQL  
