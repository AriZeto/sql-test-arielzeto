-- Begin insertions into the book store database.

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

-- Insert users into the Users table.
INSERT INTO Users (username, password, email, role) VALUES
('arizeto', 'thisIsNotASecurePassword', 'arizetocs@gmail.com', 'ADMINISTRATOR'),
('milkyway_the_cat', 'theGreatestCat84', 'milky_the_book_worm@catmail.com', 'CUSTOMER'),
('jingo-jeans', 'sassyGreyCat28@!yum', 'jingo-jeans-loves-food@gmail.com', 'CUSTOMER'),
('maggie-tabby', 'a4jfqwh42we!', 'maggieThePrincess@gmail.com', 'CUSTOMER'),
('epicmanpro2', 'shadowslurking123', 'epicmanpro2@gmail.com', 'CUSTOMER'),
('bwindz', 'spicytaco925!$great', 'windowsbwindz@protonmail.com', 'CUSTOMER'),
('sherlock-holmes', 'elementaryMyDear', 'the_real_sherlock@aol.com', 'CUSTOMER');

-- Insert Books into the Books table.
-- Book information such as 'description', obtained via Amazon.
INSERT INTO Books (name, author, ISBN, price, genre, description) VALUES
('Harry Potter and the Sorcerer''s Stone', 'J.K. Rowling', '978-0545790352', 14.99, 'Fantasy', 'Harry Potter has no idea how famous he is. That's because he's being raised by his miserable aunt and uncle who are terrified Harry will learn that he''s really a wizard, just as his parents were. But everything changes when Harry is summoned to attend an infamous school for wizards, and he begins to discover some clues about his illustrious birthright. From the surprising way he is greeted by a lovable giant, to the unique curriculum and colorful faculty at his unusual school, Harry finds himself drawn deep inside a mystical world he never knew existed and closer to his own noble destiny.'),
('The Fellowship of the Ring (The Lord of the Rings, Part 1)', 'J.R.R. Tolkien', '978-0345339706', 5.84, 'Fantasy', 'The dark, fearsome Ringwraiths are searching for a Hobbit. Frodo Baggins knows that they are seeking him and the Ring he bears—the Ring of Power that will enable evil Sauron to destroy all that is good in Middle-earth. Now it is up to Frodo and his faithful servant, Sam, with a small band of companions, to carry the Ring to the one place it can be destroyed: Mount Doom, in the very center of Sauron''s realm.'),
('Twilight', 'Stephenie Meyer', '978-0316327336', 8.35, 'Young Adult', 'Isabella Swan''s move to Forks, a small, perpetually rainy town in Washington, could have been the most boring move she ever made. But once she meets the mysterious and alluring Edward Cullen, Isabella''s life takes a thrilling and terrifying turn.'),
('Lessons in Chemistry', 'Bonnie Garmus', '978-0385547345', 14.99, 'Tragicomedy', 'Chemist Elizabeth Zott is not your average woman. In fact, Elizabeth Zott would be the first to point out that there is no such thing as an average woman. But it’s the early 1960s and her all-male team at Hastings Research Institute takes a very unscientific view of equality. Except for one: Calvin Evans; the lonely, brilliant, Nobel–prize nominated grudge-holder who falls in love with—of all things—her mind. True chemistry results. '),
('To Kill a Mockingbird', 'Harper Lee', '978-0446310789', 18.99, 'Coming of Age', 'The unforgettable novel of a childhood in a sleepy Southern town and the crisis of conscience that rocked it, To Kill A Mockingbird became both an instant bestseller and a critical success when it was first published in 1960. It went on to win the Pulitzer Prize in 1961 and was later made into an Academy Award-winning film, also a classic.');

-- Insert Orders into the Orders table.
INSERT INTO Orders (user_id, book_id, quantity, status) VALUES
(1, 3, 2, 'PENDING'), -- arizeto orders Twilight, 2 copies, status = PENDING
(2, 1, 1, 'DELIVERED'), -- milkyway_the_cat orders Harry Potter and the Sorcerer''s Stone, 1 copy, status = DELIVERED
(2, 2, 1, 'SHIPPED'), -- milkyway_the_cat orders The Fellowship of the Ring, 1 copy, status = SHIPPED
(3, 4, 1, 'PENDING'), -- jingo-jeans orders Lessons in Chemistry, 1 copy, status = PENDING
(4, 5, 1, 'DELIVERED'), -- maggie-tabby orders To Kill a Mockingbird, 1 copy, status = DELIVERED
(5, 1, 1, 'DELIVERED'), -- epicmanpro2 orders Harry Potter and the Sorcerer''s Stone, 1 copy, status = DELIVERED
(6, 3, 1, 'PENDING'), -- bwindz orders Twilight, 1 copy, status = PENDING
(7, 2, 1, 'SHIPPED'), -- sherlock-holmes orders The Fellowship of the Ring, 1 copy, status = SHIPPED
(3, 3, 1, 'SHIPPED'), -- jingo-jeans orders Twilight, 1 copy, status = SHIPPED
(4, 1, 1, 'DELIVERED'); -- maggie-tabby orders Harry Potter and the Sorcerer''s Stone, 1 copy, status = DELIVERED

-- Insert Reviews into the Reviews table.
INSERT INTO Reviews (user_id, book_id, rating, comment) VALUES
(2, 1, 9, 'Truly one of my favorites.'), -- milkyway_the_cat reviews Harry Potter and the Sorcerer''s Stone, rating = 9, 
(4, 5, 10, 'Hate to admit, but it''s my favorite book.'), -- maggie-tabby reviews To Kill a Mockingbird, rating = 10
(5, 1, 7, 'Not my favorite in the series, but still an enteraining book.'), -- epicmanpro2 reviews Harry Potter and the Sorcerer''s Stone, rating = 7
(4, 1, 8, 'I can understand after reading this why it is considered a classic --however, it is not the best book in the world...'); -- maggie-tabby reviews Harry Potter and the Sorcerer''s Stone, rating = 8