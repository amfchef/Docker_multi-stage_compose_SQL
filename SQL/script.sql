USE mydb;

CREATE TABLE books
(
    id    INT         NOT NULL AUTO_INCREMENT,
    title VARCHAR(50) NOT NULL,
    PRIMARY KEY (id)
);

INSERT INTO books(title) VALUES ("jack");


SELECT * FROM books;

USE mydb;

SELECT title FROM books WHERE id = 1;