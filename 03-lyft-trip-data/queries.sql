-- =====================================================================
-- Project 03: Lyft Trip Data
-- Author:  Dayadevi Kovananthal Raman
-- Goal:    As a data analyst at a ride-sharing company, combine trip,
--          rider and car data using joins and unions, then answer
--          business questions with aggregates.
--
-- Tables:
--   trips   (id, date, pickup, dropoff, rider_id, car_id, type, cost)
--   riders  (id, first, last, username, rating, total_trips, referred)
--   riders2 (same columns as riders: new users this month)
--   cars    (id, model, OS, status, trips_completed)
--
-- Relationships:
--   trips.rider_id -> riders.id
--   trips.car_id   -> cars.id
-- =====================================================================


-- ---------------------------------------------------------------------
-- Explore the tables
-- ---------------------------------------------------------------------

-- 1. Preview each table
SELECT * FROM trips;

SELECT * FROM riders;

SELECT * FROM cars;


-- 2. Primary keys
--    trips.id, riders.id and cars.id each uniquely identify a row.
--    trips.rider_id and trips.car_id are foreign keys pointing to
--    riders.id and cars.id.


-- ---------------------------------------------------------------------
-- Joins and unions
-- ---------------------------------------------------------------------

-- 3. Cross join: every rider paired with every car.
--    Not useful on its own: it creates combinations that never
--    happened (rows = riders x cars), with no link to real trips.
SELECT riders.first,
       riders.last,
       cars.model
FROM riders
CROSS JOIN cars;


-- 4. Trip log: every trip with the rider who took it.
--    LEFT JOIN keeps all trips, even if a rider record is missing.
SELECT trips.id      AS trip_id,
       trips.date,
       trips.pickup,
       trips.dropoff,
       trips.type,
       trips.cost,
       riders.first,
       riders.last,
       riders.username
FROM trips
LEFT JOIN riders
  ON trips.rider_id = riders.id;


-- 5. Link each trip to the car used.
--    INNER JOIN keeps only trips that match a car in the cars table.
SELECT trips.id      AS trip_id,
       trips.date,
       trips.pickup,
       trips.dropoff,
       cars.model,
       cars.OS,
       cars.status
FROM trips
JOIN cars
  ON trips.car_id = cars.id;


-- 6. Stack this month's new riders onto the existing riders table.
--    UNION removes duplicate rows. Both tables must have the same columns.
SELECT *
FROM riders
UNION
SELECT *
FROM riders2;


-- ---------------------------------------------------------------------
-- Bonus: queries and aggregates
-- ---------------------------------------------------------------------

-- 7. Average cost of a trip
SELECT ROUND(AVG(cost), 2) AS avg_trip_cost
FROM trips;


-- 8. Irregular users for an email campaign: fewer than 500 trips.
--    Includes the new riders so nobody is missed.
SELECT first,
       last,
       username,
       total_trips
FROM (
  SELECT * FROM riders
  UNION
  SELECT * FROM riders2
) AS all_riders
WHERE total_trips < 500
ORDER BY total_trips;


-- 9. Number of active cars
SELECT COUNT(*) AS active_cars
FROM cars
WHERE status = 'active';


-- 10. Safety recall: the two cars with the most completed trips
SELECT *
FROM cars
ORDER BY trips_completed DESC
LIMIT 2;
