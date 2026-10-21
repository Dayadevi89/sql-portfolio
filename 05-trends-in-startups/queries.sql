-- =====================================================================
-- Project 05: Trends in Startups
-- Author:  Dayadevi Kovananthal Raman
-- Goal:    As a tech reporter, use aggregate functions to find trends
--          in a portfolio of well-known startups: funding, valuation by
--          sector, the most crowded markets, and company size by city.
--
-- Table: startups
--   name, location, category, employees, raised, valuation,
--   founded, stage, ceo, info
-- =====================================================================


-- ---------------------------------------------------------------------
-- Overview
-- ---------------------------------------------------------------------

-- 1. Preview the table (10 columns)
SELECT *
FROM startups;


-- 2. Total number of companies
SELECT COUNT(*) AS total_companies
FROM startups;


-- 3. Combined valuation of all companies
SELECT SUM(valuation) AS total_valuation
FROM startups;


-- 4. Largest amount raised by any startup
SELECT MAX(raised) AS max_raised
FROM startups;


-- 5. Largest amount raised at the Seed stage
SELECT MAX(raised) AS max_raised_seed
FROM startups
WHERE stage = 'Seed';


-- 6. Founding year of the oldest company
SELECT MIN(founded) AS oldest_founded_year
FROM startups;


-- ---------------------------------------------------------------------
-- Valuations across sectors
-- ---------------------------------------------------------------------

-- 7. Average valuation overall
SELECT AVG(valuation) AS avg_valuation
FROM startups;


-- 8. Average valuation in each category
SELECT category,
       AVG(valuation) AS avg_valuation
FROM startups
GROUP BY category;


-- 9. Same, rounded to two decimal places
SELECT category,
       ROUND(AVG(valuation), 2) AS avg_valuation
FROM startups
GROUP BY category;


-- 10. Same, ordered from highest to lowest average
--     (column positions in GROUP BY / ORDER BY: 1 = category, 2 = average)
SELECT category,
       ROUND(AVG(valuation), 2) AS avg_valuation
FROM startups
GROUP BY 1
ORDER BY 2 DESC;


-- ---------------------------------------------------------------------
-- The most competitive markets
-- ---------------------------------------------------------------------

-- 11. Number of companies in each category
SELECT category,
       COUNT(*) AS num_companies
FROM startups
GROUP BY category
ORDER BY num_companies DESC;


-- 12. Only categories with more than three companies.
--     HAVING filters groups after aggregation (WHERE filters rows before).
SELECT category,
       COUNT(*) AS num_companies
FROM startups
GROUP BY category
HAVING COUNT(*) > 3
ORDER BY num_companies DESC;


-- ---------------------------------------------------------------------
-- Startup size by location
-- ---------------------------------------------------------------------

-- 13. Average number of employees in each location
SELECT location,
       ROUND(AVG(employees), 0) AS avg_employees
FROM startups
GROUP BY location
ORDER BY avg_employees DESC;


-- 14. Only locations where the average size is above 500 employees
SELECT location,
       ROUND(AVG(employees), 0) AS avg_employees
FROM startups
GROUP BY location
HAVING AVG(employees) > 500
ORDER BY avg_employees DESC;
