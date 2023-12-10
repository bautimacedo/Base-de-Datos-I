select SUM(category_id)
from category
group by category_id

1. a. Películas Ordenadas por duración de mayor a menor.[Tittle,release_year].
Rows=1000
select title,release_year as Titulo
FROM film
order by title asc


b. Toda la información de los clientes ordenada por Nombre y apellido
alfabéticamente. [ solo de la tabla customer]
Rows=599
select first_name as Nombre,last_name As Apellido
FROM customer
order by first_name asc





c. Apellidos de los actores ordenados por ID de actor de menor a mayor.
[Actor_id,last_name]
Rows=200
select actor_id as ID,last_name as Apellido
FROM actor
order by id asc

2. a. Actores Cuyos nombres Empiezan con la letra “w” [first_name].
Rows=8
select first_name
from actor
where first_name like 'w%'


b. Actores cuyos nombres empiecen con la letra “A” y contengan en alguna
parte la cadena “EL”. [first_name]
Rows=3
select first_name
from actor
where first_name like 'A%EL%'



c. Actores cuyos Nombres contengan solo 5 letras. [first_name]
Rows=43
select first_name
from actor
where first_name like '_____'



3. a. Nombres de las categorías existentes, ordenadas alfabéticamente al revés. solo
debe aparecer una vez el nombre de la categoría, es decir si hay 3 categorías el
resultset debe contener 3 filas solamente. [name,category_id].
Rows=16

select name,category_id 
from category
order by name desc


b. Cantidad de Categorías que hay. [Cantidad]
Rows= 1
SELECT sum(category_id) Cantidad
FROM category



4. a. Nombre del cliente, teléfono y 
dirección en la que vive [First_name,address,phone]
Rows=599
select first_name as Nombre, address as Direccion, phone as Telefono
FROM customer c INNER JOIN address a ON c.address_id=a.address_id



b. Ciudades en las que viven los clientes cuyos países son Afghanistan y
Argentina [Country,City]
Rows=14
SELECT country,city
FROM country c INNER JOIN city ci ON c.country_id=ci.country_id
where country='Afghanistan' or country='Argentina'


6. Cantidad de Dinero recaudado por las ventas en el tercer trimestre del año 2005
(formato de fecha yyyy/mm/dd hh/mm/ss) [Monto]
Rows=1
SELECT sum(amount) as Monto
FROM payment
WHERE year(payment_date)=2005 AND month(payment_date) between 7 and 9

	7. Películas que han sido alquiladas alguna vez [Title]
	Rows=958
	select (distinct) title
	FROM film


8. Clientes No Activos ordenados por Ciudad alfabéticamente [First_name,City]
Rows= 15
SELECT first_name, city
FROM customer c INNER JOIN address ad on ad.address_id=c.address_id
INNER JOIN city ci ON ci.city_id=ad.city_id
WHERE c.active=0

9. Las 4 películas más alquiladas en orden Descendente. [Cantidad_de_alquileres,Title]
Rows=4
SELECT 
SELECT count(f.film_id) as alquileres, title
FROM film f INNER JOIN inventory i ON i.film_id=f.film_id
inner join rental r on i.inventory_id=r.inventory_id 
group by title
order by alquileres desc limit 4



10. Película que nunca ha sido alquilada [Film_id,Title]
Rows=42
SELECT f.film_id from film f WHERE film_id not in (
SELECT f.film_id FROM film f INNER JOIN inventory i ON i.film_id=f.film_id
inner join rental r on i.inventory_id=r.inventory_id )


11. Cantidad de copias de cada película 
Por película Ordenadas en orden de cantidad de
películas de mayor a menor. [Film_id,Cantidad]
Rows=958

select f.film_id, count(i.film_id) as Cantidad
FROM film f INNER JOIN inventory i ON f.film_id=i.film_id
group by film_id
order by cantidad desc


12. Películas que fueron devueltas Fuera de fecha.
(Películas que han pagado recargo) .
[Title, Rental_date, rental_duration,
 payment_date ,Return_date, amount,
replacement_cost, inventori_id]
Rows=48

SELECT title, rental_date, rental_duration, payment_date, return_date, p.amount, replacement_cost, i.inventory_id
FROM payment p
INNER JOIN rental r ON p.customer_id = r.customer_id
INNER JOIN inventory i ON r.inventory_id = i.inventory_id
INNER JOIN film f ON f.film_id = i.film_id
WHERE r.return_date IN (DATE_ADD(r.rental_date, INTERVAL f.rental_duration DAY)) 


13. Cantidad de películas por categoría indicando su precio promedio. [Name,Promedio]
Rows=16
select name as Nombre, AVG(amount)
FROM category c INNER JOIN film_category fc ON fc.category_id=c.category_id
INNER JOIN film f ON fc.film_id=f.film_id
INNER JOIN inventory i ON i.film_id=f.film_id
INNER JOIN rental r ON i.inventory_id=r.inventory_id
INNER JOIN payment p ON r.customer_id=p.customer_id
GROUP BY Nombre

14. Lista de precios conteniendo 4 columnas: 
1) precio del alquiler
2) precio del alquiler + 10% del mismo por retraso de 1 DIA 
3) precio del alquiler + 20% del mismo poretraso de mas de 1 días .
 La lista debe estar ordenada por titulo y categoría
Rows=1000
SELECT  distinct title,rental_rate as 'Precio Renta',rental_rate*1.1 as 'Precio Retraso 1 Dia',rental_rate*1.2 as 'Precio Retraso Mas de un Dia' from
film f inner join film_category fc ON f.film_id=fc.film_id 
INNER JOIN category c ON fc.category_id=c.category_id 
INNER JOIN inventory i on i.film_id=f.film_id
INNER JOIN rental r ON i.inventory_id=r.inventory_id 
INNER JOIN payment p ON r.customer_id=p.customer_id
order by title


15. Países los cuales poseen clientes 
los cuales nunca han alquilado una película
[country]
Rows=0


SELECT country from country c 
INNER JOIN city ci ON ci.country_id=c.country_id
INNER JOIN address ad ON ad.city_id=ci.city_id
INNER JOIN customer cu ON cu.address_id=ad.address_id
INNER JOIN rental r ON r.customer_id=cu.customer_id 
WHERE r.customer_id=cu.customer_id

SELECT country FROM country where country not in(
	SELECT country from country c 
	INNER JOIN city ci ON ci.country_id=c.country_id
	INNER JOIN address ad ON ad.city_id=ci.city_id
	INNER JOIN customer cu ON cu.address_id=ad.address_id
	INNER JOIN rental r ON r.customer_id=cu.customer_id 
	WHERE r.customer_id=cu.customer_id) 

16. Paises en los cuales nunca se ha alquilado una película. [country]
Rows=1




17. Descripción de las películas con 
todos sus actores [First_name,Title,description]
Rows=5462
SELECT distinct title,first_name,description
FROM film f INNER JOIN language l 
ON f.language_id=l.language_id
INNER JOIN film_actor fa ON fa.film_id=f.film_id
INNER JOIN actor a ON fa.actor_id=a.actor_id

18. Películas cuyo precio de alquiler supere el 
promedio del costo de las películas para
mayores de 13 años. [Title,Rental_Rate]
Rows=336
select rental_rate, title 
FROM film f inner join inventory i on i.film_id=f.film_id
INNER JOIN rental r ON r.inventory_id=i.inventory_id
where rental_rate > 
(SELECT AVG(f.rental_rate) from film f where f.rating='PG-13')
SELECT f.rental_rate from film f where f.rating='P13'

SELECT * FROM peliculas_divertidas
peliculas_divertidas
INSERT INTO peliculas_divertidas (film_id) values (10039,'Las Aventuras de Massi','Mortal Para atras',2023,1,NULL,6,3.7,145,40,'G','Deleted Scenes','2023-11-06 20:04:23')

START TRANSACTION;
savepoint hola;
UPDATE peliculas_divertidas pl SET title= 'MASSIMO EL ACROBATA' where release_year=2006;
UPDATE peliculas_divertidas pl SET description= 'Una paradoja de Massimo y Magm' WHERE release_year=2006;
DELETE FROM peliculas_divertidas WHERE film_id=1006;
SELECT * FROM peliculas_divertidas;
ROLLBACK TO savepoint hola;
COMMIT;

select title,COALESCE(original_language_id, 'hola') AS 'Lenguaje' FROM peliculas_divertidas
DELETE FROM peliculas_divertidas WHERE film_id=1006

SELECT DISTINCT nombre, (ingreso-egreso) AS Saldo 
FROM Clientes c INNER JOIN Movimientos  m
				ON c.idcliente=m.idcliente
                
SELECT materiaPrima FROM MateriasPrimas mp
WHERE costo > (SELECT avg(costo) FROM materiasprimas mp)

SELECT * FROM film
SELECT title from film WHERE title LIKE '%'

START TRANSACTION;
SAVEPOINT a;
DELETE from film where film_id=1001;
SELECT * FROM film;
rollback to savepoint a;
COMMIT; 