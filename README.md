# Ariel Zeto's SQL Test

# Introduction:

This repository contains Ariel Zeto's SQL test for ChowaCo. The test itself is an evaluation of SQL level.

The purpose is to demonstrate that Ariel Zeto (myself) contains the ability to utilize modern practices with a database and tables, including querying from the database - as this is a necessity for web applications, and most large data.

The scope of the SQL I have written can be used for datasets small or large, as the SQL query operations match the schema.

# Scenario:

For this evaluation, I have created a **fictional online book store**.

The Book Store contains:

- Users with personal information, such as username, password, email, and role
- Products (in this case, Books) with details such as name, author, ISBN, description, price, and genre
- Orders with order_date, quantity, status, and foreign key references to the ID of a User, and the ID of a book
- Reviews with ratings, comment, and foreign key references to the ID of a User, and the ID of a book.

If you look upon the `schema.sql` file, you'll notice that constraints and uniqeness, as well as other identifiers have been applied to certain columns.

# Database Schema:

![Database Schema](https://file%2B.vscode-resource.vscode-cdn.net/Users/arizeto/sql-test-arielzeto/Database%20Schema%20Ariel%20Zeto.png?version%3D1734327177575)

# Relationships:

Down below consists of the relationships you'll see within this schema. You may also notice them in the diagram above, but here is in length the description of each.

Note: I used `dbdiagram.io` to diagram the schema, given that I do not have other software to diagram it.

## Users, Orders:

Relationship:

One to many - One user can place many orders, but each order has an associated user.

Foreign Key:

Orders.user_id references Users.id

An order within the Orders table is tied to an associated user. If the user is deleted, the orders from them are also removed (due to `ON DELETE CASCADE`).

## Books, Orders:

Relationship:

One to many - One book can be within many orders, but each order is for a particular book.

Foreign Key:

Orders.book_id references Books.id

An order within the Orders table is associated with a particular book. If the book is deleted, all associated orders are then deleted too.

## Users, Reviews:

Relationship:

One to many - One user can write many reviews, however, each review will be written by one user.

Foreign Key: Reviews.book_id references Users.id

Each review within the Reviews table written by a specific user. If the user is deleted, then all related reviews will also be deleted.

## Books, Reviews:

Relationship:

One to many (One book can contain many reviews, however, each review is for just one book)

Foreign Key: Reviews.book_id references Books.id

Each review within the reviews table is associated to a particular book. If the book is deleted, then all related reviews will be deleted too.

## Review Per User and Book:

Relationship:

Many to many - however, a user may only review a particular book once.

Unique restriction: (user_id, book_id) within the Reviews table is unique.

A user can only write one review per book. This is to ensure that a user does not write more than one review per book.

# Optimizations:

Index implementations have been added to the tables in `schema.sql`.

Typically, indexes are used to ensure that the querying of a common type can be sped up. I have applied these to particular columns, as well as foreign keys. Specifically, I have done these to columns in which I believe would be queried the most, optimizing the process.

# Files

## `schema.sql`

Contains DDL script that creates the database schema for the fictional online bookstore.

## `data_insertion.sql`

This file simply inserts sample data into the tables defined from the database schema.

## `queries.sql`

This file contains simple CRUD operations, such as inserting a new user, updating a products price, deleting an old order, etc.
Additionally, it satisfies the requirements of these complex queries:

- Find the total sales by product category for a specific month.
- List users who have never placed an order.
- Display the top 5 products by average review rating.
- Show the number of orders per day for the last 30 days.

Furthermore, my queries also use LEFT JOIN and JOIN operations, as required.

For fun, I included three more additional complex queries.
