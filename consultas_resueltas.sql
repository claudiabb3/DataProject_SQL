--1. Crear el esquema
CREATE SCHEMA IF NOT EXISTS videoclub;

--2. Películas con clasificación R
SELECT title
FROM film
WHERE rating = 'R';

--3. Actores con actor_id entre 30 y 40
SELECT first_name, last_name
FROM actor
WHERE actor_id BETWEEN 30 AND 40;

--4. Películas cuyo idioma coincide con el original
SELECT title
FROM film
WHERE language_id = original_language_id;

--5. Ordenar por duración ascendente
SELECT title, length
FROM film
ORDER BY length ASC;

--6. Actores cuyo apellido contiene ‘Allen’
SELECT first_name, last_name
FROM actor
WHERE last_name LIKE '%Allen%';

--7. Total de películas por clasificación
SELECT rating, COUNT(*) AS total
FROM film
GROUP BY rating;

--8. PG-13 o duración > 180
SELECT title
FROM film
WHERE rating = 'PG-13' OR length > 180;

--9. Variabilidad de replacement_cost
SELECT VARIANCE(replacement_cost)
FROM film;

--10. Máxima y mínima duración
SELECT MAX(length), MIN(length)
FROM film;

--11. Antepenúltimo alquiler
SELECT amount
FROM payment
ORDER BY payment_date DESC
OFFSET 2 LIMIT 1;

--12. Clasificación distinta de NC-17 y G
SELECT title
FROM film
WHERE rating NOT IN ('NC-17','G');

--13. Promedio de duración por clasificación
SELECT rating, AVG(length)
FROM film
GROUP BY rating;

--14. Películas de más de 180 min
SELECT title
FROM film
WHERE length > 180;

--15. Total generado por la empresa
SELECT SUM(amount)
FROM payment;

--16. Top 10 clientes por ID
SELECT customer_id, first_name, last_name
FROM customer
ORDER BY customer_id DESC
LIMIT 10;

--17. Actores de ‘Egg Igby’
SELECT a.first_name, a.last_name
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id
WHERE f.title = 'Egg Igby';

--18. Títulos únicos
SELECT DISTINCT title FROM film;

--19. Comedias de más de 180 min
SELECT f.title
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
WHERE c.name = 'Comedy' AND f.length > 180;

--20. Categorías con media > 110
SELECT c.name, AVG(f.length)
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY c.name
HAVING AVG(f.length) > 110;

--21. Media de duración del alquiler
SELECT AVG(return_date - rental_date)
FROM rental
WHERE return_date IS NOT NULL;

--22. Nombre completo de actores
SELECT first_name || ' ' || last_name AS nombre_completo
FROM actor;

--23. Número de alquileres por día
SELECT rental_date::date, COUNT(*)
FROM rental
GROUP BY rental_date::date
ORDER BY COUNT(*) DESC;

--24. Películas con duración superior al promedio
SELECT title, length
FROM film
WHERE length > (SELECT AVG(length) FROM film);

--25. Alquileres por mes
SELECT DATE_TRUNC('month', rental_date) AS mes, COUNT(*)
FROM rental
GROUP BY mes;

--26. Estadísticas de amount
SELECT AVG(amount), STDDEV(amount), VARIANCE(amount)
FROM payment;

--27. Películas con rental_rate > promedio
SELECT title
FROM film
WHERE rental_rate > (SELECT AVG(rental_rate) FROM film);

--28. Actores con más de 40 películas
SELECT actor_id, COUNT(*)
FROM film_actor
GROUP BY actor_id
HAVING COUNT(*) > 40;

--29. Películas con cantidad en inventario
SELECT f.title, COUNT(i.inventory_id)
FROM film f
LEFT JOIN inventory i ON i.film_id = f.film_id
GROUP BY f.title;

--30. Actores y número de películas
SELECT a.first_name, a.last_name, COUNT(fa.film_id)
FROM actor a
LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id;

--31. Películas con actores
SELECT f.title, a.first_name, a.last_name
FROM film f
LEFT JOIN film_actor fa ON f.film_id = fa.film_id
LEFT JOIN actor a ON fa.actor_id = a.actor_id;

--32. Actores con películas
SELECT a.first_name, a.last_name, f.title
FROM actor a
LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id
LEFT JOIN film f ON fa.film_id = f.film_id;

--33. Películas y alquileres
SELECT f.title, r.rental_id
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id;

--34. Top 5 clientes que más gastaron
SELECT c.first_name, c.last_name, SUM(p.amount)
FROM payment p
JOIN customer c ON p.customer_id = c.customer_id
GROUP BY c.customer_id
ORDER BY SUM(p.amount) DESC
LIMIT 5;

--35. Actores llamados Johnny
SELECT * FROM actor WHERE first_name = 'Johnny';

--36. Renombrar columnas
SELECT first_name AS nombre, last_name AS apellido
FROM actor;

--37. ID mínimo y máximo
SELECT MIN(actor_id), MAX(actor_id)
FROM actor;

--38. Nº total de actores
SELECT COUNT(*) FROM actor;

--39. Actores ordenados por apellido
SELECT * FROM actor ORDER BY last_name;

--40. Primeras 5 películas
SELECT * FROM film ORDER BY film_id LIMIT 5;

--41. Nombre más repetido
SELECT first_name, COUNT(*)
FROM actor
GROUP BY first_name
ORDER BY COUNT(*) DESC;

--42. Alquileres con nombre del cliente
SELECT r.*, c.first_name, c.last_name
FROM rental r
JOIN customer c ON c.customer_id = r.customer_id;

--43. Clientes y alquileres
SELECT c.*, r.rental_id
FROM customer c
LEFT JOIN rental r ON c.customer_id = r.customer_id;

--44. CROSS JOIN film x category
SELECT f.title, c.name
FROM film f
CROSS JOIN category c;




-- 45: Actores que han salido en películas de la categoría Action.
SELECT DISTINCT a.actor_id, a.first_name, a.last_name
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id              -- relación actor → película
JOIN film_category fc ON fa.film_id = fc.film_id            -- relación película → categoría
JOIN category c ON fc.category_id = c.category_id           
WHERE c.name = 'Action'                                     -- filtramos solo Action
ORDER BY a.last_name, a.first_name;


--46. Actores sin películas
SELECT a.*
FROM actor a
LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id
WHERE fa.film_id IS NULL;

--47. Actores y nº de películas
SELECT a.first_name, a.last_name, COUNT(fa.film_id)
FROM actor a
LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id;

--48. Vista actor_num_peliculas
CREATE VIEW actor_num_peliculas AS
SELECT a.first_name, a.last_name, COUNT(fa.film_id) AS num_peliculas
FROM actor a
LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id;

--49. Nº de alquileres por cliente
SELECT customer_id, COUNT(*)
FROM rental
GROUP BY customer_id;

--50. Duración total Action
SELECT SUM(f.length)
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
WHERE c.name = 'Action';

--51. Tabla temporal de alquileres por cliente
CREATE TEMP TABLE cliente_rentas_temporal AS
SELECT customer_id, COUNT(*)
FROM rental
GROUP BY customer_id;

--52. Tabla temporal películas con ≥10 alquileres
CREATE TEMP TABLE peliculas_alquiladas AS
SELECT f.film_id, COUNT(*)
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON r.inventory_id = i.inventory_id
GROUP BY f.film_id
HAVING COUNT(*) >= 10;

--53. Películas de Tammy Sanders sin devolver
SELECT DISTINCT f.title
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE c.first_name='Tammy' AND c.last_name='Sanders'
AND r.return_date IS NULL
ORDER BY f.title;

--54. Actores de Sci-Fi
SELECT DISTINCT a.first_name, a.last_name
FROM actor a
JOIN film_actor fa ON a.actor_id=fa.actor_id
JOIN film_category fc ON fa.film_id=fc.film_id
JOIN category c ON fc.category_id=c.category_id
WHERE c.name='Sci-Fi';

--55. Actores en películas alquiladas después de 'Spartacus Cheaper'
--Hallamos primero la primera fecha de alquiler del film 'Spartacus Cheaper'
WITH primera AS (
  SELECT MIN(rental_date) AS fecha
  FROM rental r
  JOIN inventory i ON r.inventory_id=i.inventory_id
  JOIN film f ON i.film_id=f.film_id
  WHERE f.title='Spartacus Cheaper'
)
-- Luego buscamos actores que actuaron en películas alquiladas después de esa fecha.
SELECT DISTINCT a.first_name, a.last_name
FROM actor a
JOIN film_actor fa ON a.actor_id=fa.actor_id
JOIN film f ON fa.film_id=f.film_id
JOIN inventory i ON f.film_id=i.film_id
JOIN rental r ON r.inventory_id=i.inventory_id
WHERE r.rental_date > (SELECT fecha FROM primera);

--56. Actores que no han actuado en 'Music'
SELECT a.*
FROM actor a
WHERE NOT EXISTS (
  SELECT 1
  FROM film_actor fa
  JOIN film_category fc ON fa.film_id=fc.film_id
  JOIN category c ON fc.category_id=c.category_id
  WHERE c.name='Music' AND fa.actor_id=a.actor_id
);

--57. Películas alquiladas > 8 días
SELECT DISTINCT f.title
FROM rental r
JOIN inventory i ON r.inventory_id=i.inventory_id
JOIN film f ON i.film_id=f.film_id
WHERE return_date - rental_date > INTERVAL '8 days';

--58. Películas de la misma categoría que Animation
SELECT DISTINCT f2.title
FROM film f1
JOIN film_category fc1 ON f1.film_id = fc1.film_id
JOIN film_category fc2 ON fc1.category_id = fc2.category_id
JOIN film f2 ON fc2.film_id = f2.film_id
JOIN category c ON fc1.category_id = c.category_id
WHERE c.name = 'Animation'
  AND f2.film_id <> f1.film_id                     -- excluimos la propia Animation si aparece repetida
ORDER BY f2.title;

--59. Películas con la misma duración que Dancing Fever
SELECT f2.title
FROM film f1
JOIN film f2 ON f1.length=f2.length
WHERE f1.title='Dancing Fever'
AND f2.film_id<>f1.film_id;

--60. Clientes con ≥7 películas distintas
SELECT c.first_name, c.last_name, COUNT(DISTINCT i.film_id)
FROM customer c
JOIN rental r ON c.customer_id=r.customer_id
JOIN inventory i ON r.inventory_id=i.inventory_id
GROUP BY c.customer_id
HAVING COUNT(DISTINCT i.film_id)>=7;

--61. Total de alquileres por categoría
SELECT c.name, COUNT(r.rental_id)
FROM category c
JOIN film_category fc ON c.category_id=fc.category_id
JOIN film f ON fc.film_id=f.film_id
JOIN inventory i ON f.film_id=i.film_id
JOIN rental r ON i.inventory_id=r.inventory_id
GROUP BY c.name;

--62. Películas por categoría estrenadas en 2006
SELECT c.name, COUNT(*)
FROM film f
JOIN film_category fc ON f.film_id=fc.film_id
JOIN category c ON c.category_id=fc.category_id
WHERE release_year=2006
GROUP BY c.name;

--63. Combinaciones trabajadores x tiendas
SELECT *
FROM store
CROSS JOIN staff;

--64. Total de alquileres por cliente (ID, nombre, apellido)
SELECT c.customer_id, c.first_name, c.last_name, COUNT(r.rental_id)
FROM customer c
LEFT JOIN rental r ON c.customer_id=r.customer_id
GROUP BY c.customer_id;