-- 1. 
/*
Naudoti: sql_invoicing.invoices;
Pateikti 'client_id', 'invoice_total', 'number' stulpelius. Surūšiuokite duomenis pagal 'client_id'
nuo mažiausios reikšmės ir pagal 'invoice_total' nuo didžiausios reikšmės (1t);
*/

SELECT client_id, invoice_total, number
FROM sql_invoicing.invoices;

SELECT client_id, invoice_total, number
FROM sql_invoicing.invoices
order by client_id ASC;

SELECT client_id, invoice_total, number
FROM sql_invoicing.invoices
order by invoice_total DESC;

SELECT client_id, invoice_total, number
FROM sql_invoicing.invoices
order by client_id ASC, invoice_total DESC;

-- 2. 
/*
Naudoti: sql_invoicing.invoices; 
Pateikite visus unikalias 'client_id' reikšmes ir jas išrikiuokit
nuo didžiausios mažėjančia reikšme. (1t);
*/

SELECT client_id
FROM sql_invoicing.invoices;

SELECT 
distinct client_id
FROM sql_invoicing.invoices
ORDER BY client_id DESC;

-- 3.
/*
Naudoti: sql_invoicing.payments;
Parašykite SQL užklausą, kuri paskaičiuoja bendrą visų mokėjimų ('amount') sumą.
Rezultatą pateikite stulpelyje 'iš viso'. Taip pat paskaičiuokite mokėjimų vidurkį - 
pavadinkite stulpelį 'mokėjimų vidurkis'. Paskaičiuokite mažiausią ir didžiausią mokėjimą.
Šiuos stulpelius pavadinkite savo parinktais pavadinimais.
Taip pat paskaičiuokite unikalių pirkėjų ('client_id') skaičių, bei unikalių sąskaitų faktūrų kiekį ('invoice_id').
Šiuos stulpelius taip pat pavadinkite savo parinktais pavadinimais. (2t);
*/

SELECT * FROM sql_invoicing.payments;

SELECT
SUM(amount) AS iš_viso
FROM sql_invoicing.payments;

SELECT
	SUM(amount) AS iš_viso,
    AVG(amount) AS mokėjimų_vidurkis,
    min(amount) AS mažiausias_mokėjimas,
    max(amount) AS dižiausias_mokėjimas
FROM sql_invoicing.payments;

SELECT
	count( distinct client_id )  AS visi_klientai,
	count( distinct invoice_id )  AS visos_sąskaitos
FROM sql_invoicing.payments;

-- 4.
/*
Naudoti: sql_hr.employees; 
Parašykite SQL užklausą, kuri ištrauktų visus įrašus, kur stulpelio 'salary' 
reikšmė yra mažesnė už 40 000. Išrikiuokite įrašus nuo dižiausios algos ('salary') mažėjančia tvarka.
Prie šitų išfiltruotų įrašu pateikite papildomą stulpelį (užvadinkite jį 'new_salary'), kur 
alga būtų padidinta 15 procentų. (2t);
*/

SELECT * FROM sql_hr.employees;

SELECT *
FROM sql_hr.employees
where salary < 40000
order by salary Desc;

SELECT 
	*,
    salary * 1.15 AS new_salary
FROM sql_hr.employees
where salary < 40000
order by salary Desc;


-- 5. 
/*
Naudoti: sql_store.products;
Ištirkite produkto pavadinimo ('name') stulpelį. Kelinta raidė yra 'e' (galima naudoti mysql position funkciją). 
Išrikiuokite rezultatą nuo toliausiai esančios 'e' raidės. (1t);
*/

SELECT * FROM sql_store.products;

SELECT position('e' IN name) AS E_raidės_pozicija
FROM sql_store.products;

SELECT position('e' IN name) AS E_raidės_pozicija
FROM sql_store.products
order by E_raidės_pozicija desc;

-- 6. 
/*
Naudoti: sql_store.customers; 
Parašykite SQL užklausą, kuri ištrauktų visus įrašus, kurių miestas ('city') yra Vilnius, Klaipėda ir Alytus,
o lojalumo taškų ('points') pirkėjas yra surinkęs mažiau nei 1000.
Išrikiuoti rezultatus pagal lojalumo taškus didėjančia tvarka. (1t);
*/

SELECT * FROM sql_store.customers;

select * 
from sql_store.customers
where city IN ('Vilnius', 'Klaipėda', 'Alytus');

select * 
from sql_store.customers
where city IN ('Vilnius', 'Klaipėda', 'Alytus')
order by points ASC;

select * 
from sql_store.customers
where city IN ('Vilnius', 'Klaipėda', 'Alytus') and points < 1000
order by points ASC;

-- 7.
/*
Naudoti: sql_hr.employees;
Parašykite SQL užklausą, kuri suskaičiuotų algų sumą darbuotojų, 
kurių 'job_title' stulpelyje yra reikšmė 'Operacijų'.
Stulpelį pavadinkite `sum_salary` (1t);
*/

SELECT * FROM sql_hr.employees;

SELECT sum(salary) AS 'sum_salary'
FROM sql_hr.employees;

SELECT * 
FROM sql_hr.employees
where job_title like '%Operacijų%';

SELECT sum(salary) AS 'sum_salary'
FROM sql_hr.employees
where job_title like '%Operacijų%';

-- 8.
/*
Naudoti: sql_store.shippers,
         sql_store.orders,
         sql_store.order_items;
Parašykite užklausą, kuri pateiktų tiekėjų (SHIPPERS lentelė) pavadinimus, 
kiekį skirtingų prekių ('product_id') ir kiekį skirtingų užsakymų ('order_id') tiekėjas yra tiekęs.
Stulpelius pavadinkite atitinkamai 'Cnt_unique_products', 'Cnt_unique_orders'.
Išrikiuokite rezultatą pagal tiekėjo pavadinimą abacėlės tvarka. (3t);
*/

SELECT * from sql_store.shippers;
SELECT * from sql_store.orders;
SELECT * from  sql_store.order_items;

select 
 sh.name AS 'shipper name',
 count(oit.product_id) AS 'cnt_unique_products',
 count(oit.order_id) AS 'cnt_unique_orders'
 from shippers AS sh
 join orders AS o
 on sh.shipper_id = o.shipper_id
 join order_items AS oit
 on oit.order_id = o.order_id
  group by sh.name;

select 
 sh.name AS 'shipper name',
 count(oit.product_id) AS 'cnt_unique_products',
 count(oit.order_id) AS 'cnt_unique_orders'
 from shippers AS sh
 join orders AS o
 on sh.shipper_id = o.shipper_id
 join order_items AS oit
 on oit.order_id = o.order_id
 group by sh.name
 order by sh.name ASC;


-- 9.
/*
Naudoti: sakila.film;
Parašykite SQL užklausą, kuri pateiktų filmų pavadinimus ('title'), reitingus ('rating'), bei 
suskirstytų filmus pagal jų reitingus ('rating') į tokias kategorijas:
Jei reitingas yra 'PG' arba 'G' tada 'PG_G'
Jei reitingas yra 'NC-17' arba „PG-13“ tada „NC-17_PG-13“
Visus kitus reitingus priskirkite kategorijai 'Nesvarbu'
Kategorijas atvaizduokite stulpelyje 'Reitingo_grupė' (2t)
*/

SELECT * FROM sakila.film;

select title, rating,
case
when rating = 'PG' then 'PG_G'
when rating = 'G' then 'PG_G'
when rating = 'NC-17' then 'NC-17_PG-13'
when rating = 'PG-13' then 'NC-17_PG-13'
else 'Nesvarbu'
 end AS Reitingo_grupė
from sakila.film;

-- 10.
/*
Naudoti: sakila.film;
Parašykite SQL užklausą, kuri suskaičiuotų kiek filmų priklauso reitingo grupėms, kurios buvo sukurtos 9-ame uždavinyje.
Rezultate pateikite tik tokias reitingo grupes, kurioms priklausantis filmų kiekis yra 250 - 450 intervale. 
Išrikiuokite rezultatą nuo didžiausio filmų kiekio mažėjančia tvarka. (4t)
*/

SELECT * FROM sakila.film;

select 
case
when rating = 'PG' then 'PG_G'
when rating = 'G' then 'PG_G'
when rating = 'NC-17' then 'NC-17_PG-13'
when rating = 'PG-13' then 'NC-17_PG-13'
else 'Nesvarbu'
 end AS Reitingo_grupė,
 count(*) AS how_many
from sakila.film
group by Reitingo_grupė;


select 
case
when rating = 'PG' then 'PG_G'
when rating = 'G' then 'PG_G'
when rating = 'NC-17' then 'NC-17_PG-13'
when rating = 'PG-13' then 'NC-17_PG-13'
else 'Nesvarbu'
 end AS Reitingo_grupė,
 count(*) AS how_many
from sakila.film
group by Reitingo_grupė
having how_many between 250 and 450
order by Reitingo_grupė asc;


-- 11. 
/*
Naudoti: sakila.customer, 
		 sakila.rental, 
         sakila.inventory, 
         sakila.film;
Pateikite klientų vardus ('first_name') ir pavardes ('last_name') iš CUSTOMER lentelės, kurie išsinuomavo filmą 'AGENT TRUMAN'. 
Užduotį atlikite naudodami subquery konstruktus. Išrikiuokite rezultą pagal kliento vardą (first_name) abecėlės tvarka.
Užduotis atlikta teisingai be subquery vertinama (2t). 
P.S. teisingame subquery konstrukte turi būti 4 x SELECT sakiniai. (4t);
*/

SELECT * FROM sakila.film;
SELECT * FROM sakila.customer;
SELECT * FROM sakila.inventory;
SELECT * FROM sakila.rental;

SELECT film_id, title 
FROM sakila.film;

select * 
from sakila.film
where title like 'AGENT TRUMAN';

select *
from customer AS c
join rental AS r
on c.customer_id = r.customer_id
join inventory AS i
on r.inventory_id = i.inventory_id
join film AS f
on i.film_id = f.film_id;

select c.first_name, c.last_name, f.title
from customer AS c
join rental AS r
on c.customer_id = r.customer_id
join inventory AS i
on r.inventory_id = i.inventory_id
join film AS f
on i.film_id = f.film_id
where f.title = 'AGENT TRUMAN';

select c.first_name, c.last_name, f.title
from customer AS c
join rental AS r
on c.customer_id = r.customer_id
join inventory AS i
on r.inventory_id = i.inventory_id
join film AS f
on i.film_id = f.film_id
where f.title = 'AGENT TRUMAN'
order by c.first_name ASC;



-- 12.
/*
Naudoti: sql_invoicing.clients, 
		 sql_invoicing.invoices;
Parašykite užklausą, kuri pateiktų clientų id ('client_id'), klientų pavadinimą ('name') ir kiek tie klientai 
turi neapmokėtų sąskaitų. Neapmokėtom sąskaitom ieškoti naudokite 'payment_date' stulpelį.
Išrikiuokite rezultatą pagal kliento id nuo didžiausios reikšmės mažėjančia tvarka. (3t);
*/

SELECT * FROM sql_invoicing.clients;
SELECT * FROM sql_invoicing.invoices;

select *
from clients
join invoices
	on invoices.client_id = clients.client_id;
    
select clients.client_id, clients.name, invoices.payment_date
from clients
join invoices
	on invoices.client_id = clients.client_id
    order by clients.client_id DESC;
   
select clients.client_id, clients.name, count(*) AS kiek_neapmokėta
from clients
join invoices
	on invoices.client_id = clients.client_id
    where (invoices.payment_date) is null 
    group by clients.client_id
    order by clients.client_id DESC;


-- 13.
/*
Naudoti: sql_store.products;
Iš products lentelės pateikite produkto pavadinimą ('name').
Šalia pateikite ir kitą stulpelį, kuriame suformuotumėte naują produkto pavadinimo rašymo struktūrą ir pavadinkite jį 'new_name'.
Sąlyga: jei produkto pavadinimas turi tarpelį, tuomet naujoje struktūroje jį pakeiskite į tris žvaigždutes '***';
		jei produkto pavadinimas tarpelio neturi, tuomet pridėkite prieš pavadinimą trys šauktukus '!!!'. (2t);
*/

SELECT * FROM sql_store.products;

SELECT name FROM sql_store.products;

select 
if (name like '% %',
replace (name, ' ', '***'),
concat('!!!',name))
AS new_name
FROM sql_store.products;


select name, 
(select 
if (name like '% %',
replace (name, ' ', '***'),
concat('!!!',name))) AS new_name
FROM sql_store.products;


-- 14.
/*
Naudoti: sql_store.customers;
Pateikite įrašus iš CUSTOMERS lentelės jei pirkėjas turi daugiau lojalumo taškų ('points') už visų  
esančių pirkėjų lojalumo taškų vidurkį. Naudokite tokiai paieškai SUBQUERY konstruktą.
Išrikiuokite įrašus nuo daugiausiai lojalumo taškų turinčio pirkėjo. (2t);
*/

SELECT * FROM sql_store.customers;

SELECT 
AVG(points) AS lojalumo_taškų_vidurkis
FROM sql_store.customers;

SELECT first_name, last_name, points
FROM sql_store.customers
where points > (select avg (points) AS Lojalumo_taškų_vidurkis from sql_store.customers);

SELECT first_name, last_name, points
FROM sql_store.customers
where points > (select avg (points) AS Lojalumo_taškų_vidurkis from sql_store.customers)
order by points DESC;


-- 15.
/*
Parašykite SELECT užklausą, kuri atvaizduotų Jūsų vardą kaip reikšmę stulpelyje pavadinimu 'Vardas',
stulpelį 'VCS MySQL kursas' su reikšme 'Labai patiko :)' ir stulpelį 'Surinkau taškų' su taškų skaičiumi, kurį 
manote jog surinkote spręsdami šį testą. :)))
(1t);
*/

SELECT 'Laura' AS Vardas;

SELECT 'Labai patiko' AS VCS_MySQL_kursas;

SELECT 'maksimumas :)' AS Surinkau_taškų;




