-- =====================================================================
-- Project 01: New York Restaurants
-- Author:  Dayadevi Kovananthal Raman
-- Goal:    Explore a table of NYC restaurants (nomnom) to find the best
--          dinner options by cuisine, rating, price, location and
--          health inspection grade.
--
-- Table: nomnom
--   name          TEXT     restaurant name
--   neighborhood  TEXT     NYC neighborhood
--   cuisine       TEXT     type of food
--   review        REAL     average customer rating (0-5)
--   price         TEXT     '$' (cheap) to '$$$' (expensive)
--   health        TEXT     health inspection grade (A, B, C, or NULL if pending)
-- =====================================================================


-- 1. Preview the data to understand its structure
SELECT *
FROM nomnom;


-- 2. Which neighborhoods are covered?
SELECT DISTINCT neighborhood
FROM nomnom;


-- 3. Which cuisines are available?
SELECT DISTINCT cuisine
FROM nomnom;


-- 4. Options for Chinese takeout
SELECT *
FROM nomnom
WHERE cuisine = 'Chinese';


-- 5. Highly rated restaurants (review of 4 or above)
SELECT *
FROM nomnom
WHERE review >= 4;


-- 6. Fancy date night: Italian restaurants in the top price bracket
SELECT *
FROM nomnom
WHERE cuisine = 'Italian'
  AND price = '$$$';


-- 7. Find a restaurant when you only remember part of its name
--    (any name containing the word "meatball")
SELECT *
FROM nomnom
WHERE name LIKE '%meatball%';


-- 8. Nearby delivery: restaurants in Midtown, Downtown or Chinatown
SELECT *
FROM nomnom
WHERE neighborhood = 'Midtown'
   OR neighborhood = 'Downtown'
   OR neighborhood = 'Chinatown';

-- 8b. Same result, written more concisely with IN
SELECT *
FROM nomnom
WHERE neighborhood IN ('Midtown', 'Downtown', 'Chinatown');


-- 9. Restaurants whose health grade is still pending
--    (missing values are stored as NULL, so "= NULL" would not work)
SELECT *
FROM nomnom
WHERE health IS NULL;


-- 10. Top 10 restaurants ranked by customer review
SELECT *
FROM nomnom
ORDER BY review DESC
LIMIT 10;


-- 11. Convert numeric ratings into descriptive labels with CASE
SELECT name,
       review,
       CASE
         WHEN review > 4.5 THEN 'Extraordinary'
         WHEN review > 4   THEN 'Excellent'
         WHEN review > 3   THEN 'Good'
         WHEN review > 2   THEN 'Fair'
         ELSE 'Poor'
       END AS rating_label
FROM nomnom
ORDER BY review DESC;
