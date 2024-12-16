-- Description: This file contains a SQL DDL script that creates the database schema for a fictional bookstore hosted online.

-- Drop the tables if they exist.
DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS Books;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Reviews;

-- Define the tables.
CREATE TABLE Users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(255) NOT NULL UNIQUE, -- Username has to be unique.
    password VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE, -- Email has to be unique.
    role ENUM('ADMINISTRATOR', 'CUSTOMER') NOT NULL DEFAULT 'CUSTOMER' -- Default role is Customer.
);

CREATE TABLE Books (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    ISBN VARCHAR(255) NOT NULL UNIQUE,  -- ISBN must be unique to the book.
    price DECIMAL(10, 2) NOT NULL,
    genre VARCHAR(255) NOT NULL,
    description TEXT NOT NULL
);

CREATE TABLE Orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    book_id INT NOT NULL,
    order_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    quantity INT NOT NULL DEFAULT 1 CHECK (quantity > 0), -- Cannot have negative quantity.
    status ENUM('PENDING', 'SHIPPED', 'DELIVERED') NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(id) ON DELETE CASCADE, -- If user is deleted, also delete the order.
    FOREIGN KEY (book_id) REFERENCES Books(id) ON DELETE CASCADE -- If book is deleted, also delete the order.
);

CREATE TABLE Reviews (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    book_id INT NOT NULL,
    rating INT NOT NULL CHECK (rating >= 1 AND rating <= 10), -- Rating between 1 - 10.
    comment TEXT NOT NULL,
    UNIQUE (user_id, book_id), -- A user can only review the book once.
    FOREIGN KEY (user_id) REFERENCES Users(id) ON DELETE CASCADE, -- If user is deleted, delete the review.
    FOREIGN KEY (book_id) REFERENCES Books(id) ON DELETE CASCADE -- If Book is deleted, delete review.
);