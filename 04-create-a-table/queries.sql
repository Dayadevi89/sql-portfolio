-- =====================================================================
-- Project 04: Create a Table
-- Author:  Dayadevi Kovananthal Raman
-- Goal:    Build a table from scratch and manage its data through the
--          full lifecycle: create, insert, read, update, alter, delete.
--
-- Note: the friends below are fictional, so no real personal data
--       is published.
-- =====================================================================


-- 1. Create the friends table
CREATE TABLE friends (
  id       INTEGER,
  name     TEXT,
  birthday DATE
);


-- 2. Add Ororo Munroe (dates use the ISO format YYYY-MM-DD)
INSERT INTO friends (id, name, birthday)
VALUES (1, 'Ororo Munroe', '1940-05-30');


-- 3. Check that the table exists and Ororo was added
SELECT *
FROM friends;


-- 4. Add two more friends
INSERT INTO friends (id, name, birthday)
VALUES (2, 'Maya Patel', '1992-08-14'),
       (3, 'Liam Carter', '1990-02-03');


-- 5. Ororo has changed her name to Storm
UPDATE friends
SET name = 'Storm'
WHERE id = 1;


-- 6. Add an email column
ALTER TABLE friends
ADD COLUMN email TEXT;


-- 7. Fill in everyone's email address
UPDATE friends
SET email = 'storm@codecademy.com'
WHERE id = 1;

UPDATE friends
SET email = 'maya.patel@example.com'
WHERE id = 2;

UPDATE friends
SET email = 'liam.carter@example.com'
WHERE id = 3;


-- 8. Storm is fictional, so remove her
DELETE FROM friends
WHERE id = 1;


-- 9. Final check
SELECT *
FROM friends;


-- =====================================================================
-- Extra: an improved version of the same table
-- The lab table has no rules, so it would accept duplicate ids, missing
-- names and repeated emails. Constraints let the database enforce
-- data quality itself.
-- =====================================================================

CREATE TABLE friends_v2 (
  id       INTEGER PRIMARY KEY,       -- unique identifier for each row
  name     TEXT    NOT NULL,          -- every friend must have a name
  birthday DATE,
  email    TEXT    UNIQUE,            -- no two friends share an email
  added_on DATE    DEFAULT CURRENT_DATE
);

INSERT INTO friends_v2 (id, name, birthday, email)
SELECT id, name, birthday, email
FROM friends;

-- Birthdays in calendar order (strftime is SQLite syntax)
SELECT name,
       birthday,
       strftime('%m-%d', birthday) AS month_day
FROM friends_v2
ORDER BY month_day;
