-- =====================================================================
-- Project 02: Climate Change (US State Temperatures)
-- Author:  Dayadevi Kovananthal Raman
-- Goal:    Use SQL window functions to analyse how average annual
--          temperatures have changed over time in each US state.
--
-- Table: state_climate
--   state   TEXT     US state name
--   year    INTEGER  year of the reading
--   tempf   REAL     average annual temperature (Fahrenheit)
--   tempc   REAL     average annual temperature (Celsius)
-- =====================================================================


-- ---------------------------------------------------------------------
-- Understanding the data
-- ---------------------------------------------------------------------

-- 1. Preview the table
SELECT *
FROM state_climate;


-- ---------------------------------------------------------------------
-- Aggregate and value window functions
-- ---------------------------------------------------------------------

-- 2. Running average temperature for each state over time
--    PARTITION BY restarts the calculation for every state;
--    ORDER BY year makes the average accumulate year by year.
SELECT state,
       year,
       tempf,
       AVG(tempf) OVER (
         PARTITION BY state
         ORDER BY year
       ) AS running_avg_temp
FROM state_climate;


-- 3. Lowest temperature on record for each state, shown on every row
SELECT state,
       year,
       tempf,
       FIRST_VALUE(tempf) OVER (
         PARTITION BY state
         ORDER BY tempf ASC
       ) AS lowest_temp
FROM state_climate;


-- 4. Highest temperature on record for each state, shown on every row
--    (FIRST_VALUE with a descending sort avoids the frame issue that
--     LAST_VALUE has with the default window frame)
SELECT state,
       year,
       tempf,
       FIRST_VALUE(tempf) OVER (
         PARTITION BY state
         ORDER BY tempf DESC
       ) AS highest_temp
FROM state_climate;


-- 5. Year-on-year change in temperature for each state
--    LAG looks back one row within the state. The first year of each
--    state has no previous year, so it is filtered out to avoid NULLs.
--    Ordered by the size of the change to surface the biggest swings.
SELECT state,
       year,
       tempf,
       change_in_temp
FROM (
  SELECT state,
         year,
         tempf,
         ROUND(tempf - LAG(tempf, 1) OVER (
           PARTITION BY state
           ORDER BY year
         ), 2) AS change_in_temp
  FROM state_climate
) AS yearly_changes
WHERE change_in_temp IS NOT NULL
ORDER BY ABS(change_in_temp) DESC;


-- ---------------------------------------------------------------------
-- Ranking window functions
-- ---------------------------------------------------------------------

-- 6. Coldest years on record across all states and years
SELECT RANK() OVER (ORDER BY tempf ASC) AS coldest_rank,
       year,
       state,
       tempf
FROM state_climate;


-- 7. Warmest years ranked within each state
SELECT RANK() OVER (
         PARTITION BY state
         ORDER BY tempf DESC
       ) AS warmest_rank,
       year,
       state,
       tempf
FROM state_climate;


-- 8. Each state's years split into quartiles (quartile 1 = coldest)
SELECT NTILE(4) OVER (
         PARTITION BY state
         ORDER BY tempf ASC
       ) AS quartile,
       year,
       state,
       tempf
FROM state_climate;


-- 9. All years split into quintiles across the whole country
--    (quintile 1 = coldest overall, not per state)
SELECT NTILE(5) OVER (ORDER BY tempf ASC) AS quintile,
       year,
       state,
       tempf
FROM state_climate;


-- ---------------------------------------------------------------------
-- Extra analysis (beyond the lab tasks)
-- ---------------------------------------------------------------------

-- 10. The year each state recorded its coldest and warmest temperature.
--     ROW_NUMBER keeps exactly one row per state (ties go to the later year).
SELECT state,
       MAX(CASE WHEN cold_rn = 1 THEN year END) AS coldest_year,
       MAX(CASE WHEN warm_rn = 1 THEN year END) AS warmest_year
FROM (
  SELECT state,
         year,
         ROW_NUMBER() OVER (PARTITION BY state ORDER BY tempf ASC,  year DESC) AS cold_rn,
         ROW_NUMBER() OVER (PARTITION BY state ORDER BY tempf DESC, year DESC) AS warm_rn
  FROM state_climate
) AS ranked
GROUP BY state
ORDER BY warmest_year DESC;


-- 11. National average temperature per year with a 10-year rolling average
--     (a window function applied on top of GROUP BY)
SELECT year,
       ROUND(AVG(tempf), 2) AS avg_tempf,
       ROUND(AVG(AVG(tempf)) OVER (
         ORDER BY year
         ROWS BETWEEN 9 PRECEDING AND CURRENT ROW
       ), 2) AS rolling_10yr_avg
FROM state_climate
GROUP BY year
ORDER BY year;


-- 12. Average temperature by era
SELECT CASE
         WHEN year < 1950 THEN '1895-1949'
         WHEN year < 1990 THEN '1950-1989'
         ELSE '1990-2019'
       END AS era,
       ROUND(AVG(tempf), 2) AS avg_tempf
FROM state_climate
GROUP BY era
ORDER BY era;
