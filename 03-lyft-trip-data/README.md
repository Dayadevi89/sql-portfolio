# 03 · Lyft Trip Data

Acting as a data analyst at a ride-sharing company: combining trip, rider and car data with **joins and unions**, then answering operational and marketing questions with aggregates.

## Dataset

Four related tables:

| Table | Columns | Description |
|---|---|---|
| `trips` | `id`, `date`, `pickup`, `dropoff`, `rider_id`, `car_id`, `type`, `cost` | One row per trip |
| `riders` | `id`, `first`, `last`, `username`, `rating`, `total_trips`, `referred` | Existing users |
| `riders2` | same as `riders` | New users who joined this month |
| `cars` | `id`, `model`, `OS`, `status`, `trips_completed` | Autonomous car fleet |

### How the tables connect

```
riders.id  ◄──  trips.rider_id
cars.id    ◄──  trips.car_id
```

Each table's primary key is its `id` column. `trips` links the other two through the foreign keys `rider_id` and `car_id`.

## Questions answered

| # | Question | SQL used |
|---|---|---|
| 1 | What do the three tables contain? | `SELECT *` |
| 2 | What is each table's primary key? | Primary and foreign keys |
| 3 | What happens if we pair every rider with every car? | `CROSS JOIN` |
| 4 | Build a trip log showing who took each trip | `LEFT JOIN` |
| 5 | Link each trip to the car that was used | `INNER JOIN` |
| 6 | Combine existing and new riders into one list | `UNION` |
| 7 | What does an average trip cost? | `AVG()`, `ROUND()` |
| 8 | Which riders have used the service fewer than 500 times (for an email campaign)? | `UNION` in a subquery, `WHERE` |
| 9 | How many cars are active? | `COUNT()`, `WHERE` |
| 10 | Which two cars have completed the most trips (for a safety recall)? | `ORDER BY … DESC`, `LIMIT` |

All queries are in [`queries.sql`](queries.sql).

## Key takeaways

- **Choosing the right join changes the result.** A `LEFT JOIN` keeps every trip even if the rider record is missing, while an `INNER JOIN` silently drops trips that have no matching car. For a trip log, losing rows without noticing is a real risk, so the join type should be a deliberate choice.
- **A `CROSS JOIN` is rarely useful on its own.** It returns every possible rider–car combination (riders × cars rows), most of which never happened.
- **`UNION` needs matching columns** and removes duplicates. `UNION ALL` keeps duplicates and is faster when duplicates are impossible.
- **Combining tables before filtering avoids missing people.** The email campaign query includes this month's new riders, who would otherwise be left out.

## Skills demonstrated

`CROSS JOIN` · `LEFT JOIN` · `INNER JOIN` · `UNION` · primary and foreign keys · subqueries · `AVG()` · `COUNT()` · `ORDER BY` · `LIMIT`
