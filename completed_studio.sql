CREATE TABLE book (
   book_id INT AUTO_INCREMENT PRIMARY KEY,
   author_id INT,
   title VARCHAR(255),
   isbn INT,
   available BOOL,
   genre_id INT
);
CREATE TABLE author (
   author_id INT AUTO_INCREMENT PRIMARY KEY,
   first_name VARCHAR(255),
   last_name VARCHAR(255),
   birthday DATE,
   deathday DATE
);
CREATE TABLE patron (
   patron_id INT AUTO_INCREMENT PRIMARY KEY,
   first_name VARCHAR(255),
   last_name VARCHAR(255),
   loan_id INT
);
CREATE TABLE reference_books (
   reference_id INT AUTO_INCREMENT PRIMARY KEY,
   edition INT,
   book_id INT,
   FOREIGN KEY (book_id)
      REFERENCES book(book_id)
      ON UPDATE SET NULL
      ON DELETE SET NULL
);

INSERT INTO reference_books(edition, book_id)
VALUE (5,32);

CREATE TABLE genre (
   genre_id INT PRIMARY KEY,
   genres VARCHAR(100)
);
CREATE TABLE loan (
   loan_id INT AUTO_INCREMENT PRIMARY KEY,
   patron_id INT,
   date_out DATE,
   date_in DATE,
   book_id INT,
   FOREIGN KEY (book_id)
      REFERENCES book(book_id)
      ON UPDATE SET NULL
      ON DELETE SET NULL
);

SELECT title,isbn FROM book WHERE genre_id = 6;

SELECT title, first_name, last_name, deathday FROM book INNER JOIN author;

SELECT title, first_name, last_name, deathday FROM book INNER JOIN author ON author.author_id = book.author_id WHERE deathday IS NULL;

UPDATE book SET available = FALSE WHERE book_id = 17;
INSERT INTO loan (patron_id, date_out, book_id) VALUES (9, CURDATE(), 17);
UPDATE patron SET loan_id = (SELECT loan_id FROM loan WHERE book_id = 17) WHERE patron_id = 9;

UPDATE book SET available = TRUE WHERE book_id = 17;
INSERT INTO loan (patron_id, date_in, book_id) VALUES (9, CURDATE(), 17);
UPDATE patron SET loan_id = NULL WHERE patron_id = 9;

UPDATE book SET available = FALSE WHERE book_id = 1;
INSERT INTO loan (patron_id, date_out, book_id) VALUES (44, CURDATE(), 1);
UPDATE patron SET loan_id = (SELECT loan_id FROM loan WHERE book_id = 1) WHERE patron_id = 44;

UPDATE book SET available = FALSE WHERE book_id = 2;
INSERT INTO loan (patron_id, date_out, book_id) VALUES (45, CURDATE(), 2);
UPDATE patron SET loan_id = (SELECT loan_id FROM loan WHERE book_id = 2) WHERE patron_id = 45;

UPDATE book SET available = FALSE WHERE book_id = 3;
INSERT INTO loan (patron_id, date_out, book_id) VALUES (46, CURDATE(), 3);
UPDATE patron SET loan_id = (SELECT loan_id FROM loan WHERE book_id = 3) WHERE patron_id = 46;

UPDATE book SET available = FALSE WHERE book_id = 4;
INSERT INTO loan (patron_id, date_out, book_id) VALUES (43, CURDATE(), 4);
UPDATE patron SET loan_id = (SELECT loan_id FROM loan WHERE book_id = 4) WHERE patron_id = 43;

UPDATE book SET available = FALSE WHERE book_id = 5;
INSERT INTO loan (patron_id, date_out, book_id) VALUES (42, CURDATE(), 5);
UPDATE patron SET loan_id = (SELECT loan_id FROM loan WHERE book_id = 5) WHERE patron_id = 42;

-- DELETE FROM loan WHERE loan_id = 3;
-- DELETE FROM loan WHERE loan_id >3;

SELECT last_name FROM patron
WHERE loan_id IN (SELECT loan_id FROM loan WHERE book_id IN 
	(SELECT book_id FROM book WHERE genre_id));

-- ALIASED VERSION    
SELECT
p.last_name,
g.genres
FROM patron p
JOIN loan l ON p.loan_id = l.loan_id
JOIN book b ON l.book_id = b.book_id
JOIN genre g ON b.genre_id = g.genre_id;

-- NORMAL VERSION
SELECT
patron.last_name,
genre.genres
FROM patron
JOIN loan ON patron.loan_id = loan.loan_id
JOIN book ON loan.book_id = book.book_id
JOIN genre ON book.genre_id = genre.genre_id;




