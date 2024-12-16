-- The following queries will be used to demonstrate the CRUD operations of the database.

-- The following CRUD operations will also utilize JOIN operations, 

-- Additionally, I have satisfied the need for complex queries by satisfying the ones listed in the project requirements.

-- C - Create portion.
INSERT INTO USERS (USERNAME, PASSWORD, EMAIL, ROLE)
VALUES ('Joshua_the_Great', 'team_fortress_2_rocks_$', 'joshvenk28@gmail.com', 'CUSTOMER'),
('Walt Disney', 'mickey_mouse', 'walt@disney.com', 'CUSTOMER');

-- R - Read portion.
-- Reads all users.
SELECT *
FROM USERS;

-- Reads the name of the book with ID 1 (aka, 'Harry Potter and the Sorcerer's Stone')
SELECT name
FROM BOOKS
WHERE id = 1;

-- Reads the id, order date, and status of orders with quantity greater than 2.
SELECT id, order_date, status
FROM orders
WHERE quantity > 2 AND status = 'DELIVERED'
ORDER BY order_date DESC;

-- Reads name, author, genre, and ISBN of books that are status = 'PENDING'. 
-- Combines rows from the two tables of books and orders where book id matches the id of the book in the orders table.
-- Orders the result by name in descending order.
SELECT DISTINCT name, author, genre, ISBN
FROM books
JOIN orders
ON books.id = orders.book_id
WHERE orders.status = 'PENDING'
ORDER BY name DESC;

-- U - Update portion. 
-- Update a Books price, matching to the id of 'Twilight'.
UPDATE BOOKS
SET price = 19.99
WHERE id = 3;

-- Update a Books genre, matching to the id of 'Lessons in Chemistry'.
UPDATE BOOKS
SET genre = 'Historic Fiction'
WHERE id = 4;

-- D - Delete portion.
-- Delete an old book order.
DELETE FROM ORDERS
WHERE id = 4;

-- Delete a book from the database.
DELETE FROM BOOKS
WHERE ID = 2;

-- Delete every order made by the specific user (user with email 'joshvenk28@gmail.com')
DELETE FROM ORDERS
WHERE user_id = (SELECT id FROM USERS WHERE email = 'joshvenk28@gmail.com');

-- COMPLEX QUERIES --

-- Complex Query 1: Find all sales for each genre in the month of January 2024. Use alias as Joining two tables. Group by desc. order.
SELECT b.genre,
SUM(b.price * o.quantity) AS all_sales
FROM orders o
JOIN books b
ON o.book_id = b.id
WHERE order_date BETWEEN '2024-01-01' AND '2024-01-31'
GROUP BY b.genre
ORDER BY all_sales DESC;

-- Complex Query 2: List users who have never placed an order.
SELECT u.username
FROM users u
LEFT JOIN orders o -- Left Join to include all users, even if they have not placed an order.
ON u.id = o.user_id
WHERE o.user_id IS NULL;

-- Complex Query 3: Display the top 5 products (books) by average review rating.
SELECT b.name,
AVG(r.rating) as mean_rating
FROM books b
JOIN reviews r
ON b.id = r.book_id
GROUP BY b.name
ORDER BY mean_rating DESC
LIMIT 5;

-- Complex Query 4: Show the number of orders per day for the last 30 days
SELECT DATE(order_date) as day,
COUNT(*) as num_orders
FROM orders
WHERE order_date >= CURDATE() - INTERVAL 30 DAY -- Use CURDATE() to get the current date and use INTERVAL to get the last 30 days.
GROUP BY day
ORDER BY day DESC;

-- Additional Complex Queries --
-- Find all books that have not been reviewed.
SELECT b.name, b.author, b.genre
FROM books b
LEFT JOIN reviews r
ON b.id = r.book_id
WHERE r.rating IS NULL
ORDER BY b.name;

-- Find all users who placed an order for a book within the genre of 'Fantasy'.
SELECT u.username, b.name, b.genre
FROM users u
JOIN orders o
ON u.id = o.user_id
JOIN books b
ON o.book_id = b.id
WHERE b.genre = 'Fantasy';

-- Find the total sales from a user given a specific year.
SELECT u.username, 
SUM(b.price * o.quantity) as all_sales
FROM users u
JOIN orders o
ON u.id = o.user_id
JOIN books b
ON o.book_id = b.id
WHERE order_date BETWEEN '2024-01-01' AND '2024-12-31'
GROUP BY u.username;
