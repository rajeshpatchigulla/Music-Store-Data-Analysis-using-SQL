CREATE DATABASE MUSIC_PROJECT;

USE MUSIC_PROJECT;

-- 1.table genre
CREATE TABLE Genre (
	genre_id INT PRIMARY KEY,
	name VARCHAR(120)
);

-- table mediatype
CREATE TABLE MediaType (
	media_type_id INT PRIMARY KEY,
	name VARCHAR(120)
);

-- 2.employee
CREATE TABLE Employee (
	employee_id INT PRIMARY KEY,
	last_name VARCHAR(120),
	first_name VARCHAR(120),
	title VARCHAR(120),
	reports_to INT,
	levels VARCHAR(255),
	birthdate DATE,
	hire_date DATE,
	address VARCHAR(255),
	city VARCHAR(100),
	state VARCHAR(100),
	country VARCHAR(100),
	postal_code VARCHAR(20),
	phone VARCHAR(50),
	fax VARCHAR(50),
	email VARCHAR(100)
);

INSERT INTO employee
    values 
    (9,'Madan','Mohan','Senior General Manager',NULL,'L7',
    '1961-01-26','2002-01-14',
    '1008 Vrine','Edmonton','AB','Canada','T5K 2N1',
    '+1 (780) 428-9482',
    '+1 (780) 428-3457',
    'madan.mohan@chinookcorp.com');

-- 3.customer
CREATE TABLE Customer (
	customer_id INT PRIMARY KEY,
	first_name VARCHAR(120),
	last_name VARCHAR(120),
	company VARCHAR(120),
	address VARCHAR(255),
	city VARCHAR(100),
	state VARCHAR(100),
	country VARCHAR(100),
	postal_code VARCHAR(20),
	phone VARCHAR(50),
	fax VARCHAR(50),
	email VARCHAR(100),
	support_rep_id INT,
	FOREIGN KEY (support_rep_id) REFERENCES Employee(employee_id)
);

--  4.Artist
CREATE TABLE Artist (
	artist_id INT PRIMARY KEY,
	name VARCHAR(120)
);

-- 5. Album
CREATE TABLE Album (
	album_id INT PRIMARY KEY,
	title VARCHAR(160),
	artist_id INT,
	FOREIGN KEY (artist_id) REFERENCES Artist(artist_id)
);

-- 6. Track
CREATE TABLE Track (
	track_id INT PRIMARY KEY,
	name VARCHAR(200),
	album_id INT,
	media_type_id INT,
	genre_id INT,
	composer VARCHAR(220),
	milliseconds INT,
	bytes INT,
	unit_price DECIMAL(10,2),
	FOREIGN KEY (album_id) REFERENCES Album(album_id),
	FOREIGN KEY (media_type_id) REFERENCES MediaType(media_type_id),
	FOREIGN KEY (genre_id) REFERENCES Genre(genre_id)
);

SELECT COUNT(*) FROM track;

-- 7. Invoice
CREATE TABLE Invoice (
	invoice_id INT PRIMARY KEY,
	customer_id INT,
	invoice_date DATE,
	billing_address VARCHAR(255),
	billing_city VARCHAR(100),
	billing_state VARCHAR(100),
	billing_country VARCHAR(100),
	billing_postal_code VARCHAR(20),
	total DECIMAL(10,2),
	FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

-- 8. InvoiceLine
CREATE TABLE InvoiceLine (
	invoice_line_id INT PRIMARY KEY,
	invoice_id INT,
	track_id INT,
	unit_price DECIMAL(10,2),
	quantity INT,
	FOREIGN KEY (invoice_id) REFERENCES Invoice(invoice_id),
	FOREIGN KEY (track_id) REFERENCES Track(track_id)
);

-- 9. Playlist
CREATE TABLE Playlist (
 	playlist_id INT PRIMARY KEY,
	name VARCHAR(255)
);

-- 10. PlaylistTrack
CREATE TABLE PlaylistTrack (
	playlist_id INT,
	track_id INT,
	PRIMARY KEY (playlist_id, track_id),
	FOREIGN KEY (playlist_id) REFERENCES Playlist(playlist_id),
	FOREIGN KEY (track_id) REFERENCES Track(track_id)
);

SHOW VARIABLES LIKE 'secure_file_priv';

LOAD DATA INFILE  'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\track.csv'
INTO TABLE  track
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(track_id, name, album_id, media_type_id, genre_id, composer, milliseconds, bytes, unit_price);

SHOW TABLES;

-- Genre
-- Mediatype
-- Employee
-- 1. Who is the senior most employee based on job title? 

SELECT CONCAT_WS(' ', first_name,last_name) AS FULL_NAME ,title AS JOB_TITLE FROM Employee
ORDER BY levels DESC LIMIT 1;

-- album Table
-- artist Table
-- customer
 

-- Invoice
-- Invoiceline

-- Playlist
-- Playlisttrack
-- Track

-- 2. Which countries have the most Invoices?
SELECT billing_country AS COUNTRY, COUNT(billing_country) AS CT_COUNT 
FROM Invoice
GROUP BY COUNTRY
ORDER BY CT_COUNT DESC LIMIT 1;

SELECT MAX(C.COUNTRY) as COUNTRY, COUNT(COUNTRY) FROM Customer AS C
LEFT JOIN Invoice AS I ON
C.Customer_id=I.Customer_id;

SELECT COUNT(*) AS COUNT_NUM, C.COUNTRY FROM Customer AS C
LEFT JOIN INVOICE AS I ON 
I.customer_id=C.customer_id
GROUP BY C.country
ORDER BY COUNT_NUM DESC;

-- 3. What are the top 3 values of total invoice?
SELECT total AS TOTAL 
FROM Invoice
ORDER BY TOTAL DESC LIMIT 3;

-- 4. Which city has the best customers? - We would like to throw a promotional Music Festival in the city we made the most money. Write a query that returns one city that has the highest sum of invoice totals. Return both the city name & sum of all invoice totals
SELECT billing_city AS CITY
FROM Invoice
GROUP BY CITY
ORDER BY SUM(total) DESC LIMIT 1;

SELECT billing_city AS CITY_NAME,SUM(total) AS TOTAL_INVOICE FROM Invoice
GROUP BY CITY_NAME
ORDER BY TOTAL_INVOICE DESC LIMIT 1;

SELECT city as CITY_N, SUM(total) as ST FROM customer C
JOIN invoice I ON 
C.customer_id=I.customer_id
GROUP BY city
ORDER BY Sum(total) DESC LIMIT 1;

-- 5. Who is the best customer? - The customer who has spent the most money will be declared the best customer. Write a query that returns the person who has spent the most money
SELECT CONCAT_WS(' ',C.first_name,C.last_name) AS FULL_NAME
FROM Customer C
JOIN Invoice I 
ON C.customer_id=I.customer_id
GROUP BY FULL_NAME
ORDER BY SUM(I.total) DESC LIMIT 1;

SELECT CONCAT_WS(' ',first_name,last_name) AS CUSTOMER_NAME FROM CUSTOMER C 
JOIN INVOICE I ON
C.customer_id=I.customer_id
GROUP BY C.customer_id
ORDER BY SUM(total) DESC LIMIT 1;

-- 6. Write a query to return the email, first name, last name, & Genre of all Rock Music listeners. Return your list ordered alphabetically by email starting with A
SELECT DISTINCT C.email AS EMAIL,C.first_name AS FIRST_NAME,C.last_name AS LAST_NAME
FROM customer C
JOIN invoice I 
ON C.customer_id=I.customer_id
JOIN invoiceline IL
ON I.invoice_id=IL.invoice_id
JOIN track T
ON IL.track_id=T.track_id
JOIN Genre G
ON T.genre_id=G.genre_id
WHERE G.name='Rock'
ORDER BY EMAIL;

SELECT * FROM GENRE;

SELECT DISTINCT C.email, C.first_name, C.last_name FROM customer AS C
JOIN Invoice I ON 
C.customer_id=I.customer_id
JOIN Invoiceline AS IL ON
IL.invoice_id=I.invoice_id
WHERE track_id IN (SELECT track_id FROM Track T
					JOIN Genre G ON
                    T.genre_id=G.genre_id
                    WHERE G.name LIKE 'Rock')
ORDER BY email;

-- 7. Let's invite the artists who have written the most rock music in our dataset. Write a query that returns the Artist name and total track count of the top 10 rock bands 
SELECT A.name ARTIST_NAME, COUNT(A.NAME) AS COUNT
FROM artist A 
JOIN album AL 
ON A.artist_id=AL.artist_id
JOIN track T
ON AL.album_id=T.album_id
JOIN genre G 
ON T.genre_id=G.genre_id
WHERE G.name='Rock'
GROUP BY ARTIST_NAME
ORDER BY COUNT DESC;

SELECT A.name, COUNT(A.name) as TC FROM artist A
JOIN album AL ON 
A.artist_id=AL.artist_id
JOIN track T ON
AL.album_id=T.album_id
WHERE track_id IN (SELECT track_id FROM Track T
					JOIN Genre G ON
                    T.genre_id=G.genre_id
                    WHERE G.name LIKE 'Rock')
GROUP BY A.name
ORDER BY TC  DESC LIMIT 10;

-- 8. Return all the track names that have a song length longer than the average song length.- Return the Name and Milliseconds for each track. Order by the song length, with the longest songs listed first
SELECT T.name AS TRACK_NAME, T.milliseconds AS TRACK_LENGTH
FROM track T
WHERE T.milliseconds>(SELECT AVG(milliseconds) FROM track)
ORDER BY TRACK_LENGTH DESC;

-- 9. Find how much amount is spent by each customer on artists? Write a query to return customer name, artist name and total spent 
SELECT CONCAT_WS(' ', C.first_name,c.last_name) AS CUSTOMER_NAME, A.name AS ARTIST_NAME,SUM(I.total) AS TOTAL_SPENT
FROM customer C 
JOIN invoice I 
ON C.customer_id=I.customer_id
JOIN invoiceline IL
ON I.invoice_id=IL.invoice_line_id
JOIN track T
ON IL.track_id=T.track_id
JOIN album AL
ON T.album_id=AL.album_id
JOIN artist A 
ON AL.artist_id=A.artist_id
GROUP BY CUSTOMER_NAME, ARTIST_NAME
ORDER BY TOTAL_SPENT DESC;

-- 10. We want to find out the most popular music Genre for each country. We determine the most popular genre as the genre with the highest amount of purchases. Write a query that returns each country along with the top Genre. For countries where the maximum number of purchases is shared, return all Genres

-- 11. Write a query that determines the customer that has spent the most on music for each country. Write a query that returns the country along with the top customer and how much they spent. For countries where the top amount spent is shared, provide all customers who spent this amount
