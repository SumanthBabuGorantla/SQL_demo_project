select * from album;
select * from artist;
select * from customer;
select * from employee;
select * from genre;
select * from invoice;
select * from invoice_line;
select * from media_type;
select * from playlist;
select * from playlist_track;
select * from track;


-- EASY LEVEL


--1. Who is the senior most employee based on job title?

select employee.employee_id,CONCAT(employee.first_name,' ',employee.last_name), employee.title from employee order by employee.levels desc;


--2. Which countries have the most Invoices?

select count(invoice.customer_id) as no_of_invoice,invoice.billing_country
from invoice
group by invoice.billing_country
order by no_of_invoice desc;


--3. What are top 3 values of total invoice?

SELECT total 
FROM invoice
ORDER BY total DESC;

''' select COUNT(invoice_line.quantity) as total_quantity,
sum(invoice_line.unit_price)*COUNT(invoice_line.quantity) as price from invoice_line
group by invoice_id
order by price desc; '''

'''4. Which city has the best customers? We would like to throw a promotional Music 
Festival in the city we made the most money. Write a query that returns one city that 
has the highest sum of invoice totals. Return both the city name & sum of all invoice 
totals'''

select invoice.billing_city,sum(invoice.total) as total_amount
from invoice
group by invoice.billing_city
order by total_amount desc;

''' 5. Who is the best customer? The customer who has spent the most money will be 
declared the best customer. Write a query that returns the person who has spent the 
most money '''


select customer.customer_id,SUM(invoice.total) AS TOTAL_MONEY
FROM customer INNER JOIN invoice ON customer.customer_id = invoice.customer_id
GROUP BY customer.customer_id
ORDER BY TOTAL_MONEY DESC;







--MEDIUM LEVEL

'''1. Write query to return the email, first name, last name, & Genre of all Rock Music 
listeners. Return your list ordered alphabetically by email starting with A'''

select * from customer;
select * from genre;
select * from track;

select customer.email,customer.first_name,customer.last_name
from customer
join invoice on customer.customer_id=invoice.customer_id
join invoice_line on invoice.invoice_id=invoice_line.invoice_id
where track_id in (select track.track_id
from track join genre on track.genre_id = genre.genre_id where genre.name='Rock')
order by email;


'''2. Lets invite the artists who have written the most rock music in our dataset. Write a 
query that returns the Artist name and total track count of the top 10 rock bands'''

select * from artist;
select * from album;
select * from track;
select * from genre;

select artist.name,COUNT(artist.artist_id) as track_count
from artist join album on artist.artist_id = album.artist_id
join track on track.album_id = album.album_id
join genre on track.genre_id = genre.genre_id
--where track_id in (select track.track_id from track join genre on track.genre_id = genre.genre_id)
where genre.name like 'Rock'
group by artist.name
order by track_count desc;