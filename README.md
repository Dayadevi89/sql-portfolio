# 01 · New York Restaurants

Exploring a table of New York City restaurants to answer practical "where should we eat tonight?" questions using core SQL filtering and sorting.

## Dataset

A single table, `nomnom`:

| Column | Type | Description |
|---|---|---|
| `name` | TEXT | Restaurant name |
| `neighborhood` | TEXT | NYC neighborhood |
| `cuisine` | TEXT | Type of food |
| `review` | REAL | Average customer rating (0–5) |
| `price` | TEXT | `$` (budget) to `$$$` (premium) |
| `health` | TEXT | Health inspection grade (A/B/C), `NULL` if pending |

## Questions answered

| # | Question | SQL used |
|---|---|---|
| 1 | What does the data look like? | `SELECT *` |
| 2–3 | Which neighborhoods and cuisines are covered? | `DISTINCT` |
| 4 | Where can we get Chinese takeout? | `WHERE =` |
| 5 | Which restaurants are rated 4+? | Comparison operators |
| 6 | Fancy Italian for a date night? | `AND` |
| 7 | Find a place from a half-remembered name | `LIKE` with wildcards |
| 8 | What delivers to Midtown, Downtown or Chinatown? | `OR`, and the shorter equivalent `IN` |
| 9 | Which restaurants have a pending health grade? | `IS NULL` |
| 10 | Top 10 by customer review | `ORDER BY … DESC`, `LIMIT` |
| 11 | Turn numeric ratings into readable labels | `CASE … WHEN` |

All queries are in [`queries.sql`](queries.sql).

## Key takeaways

- Missing values must be checked with `IS NULL`; `= NULL` never matches anything.
- `LIKE '%term%'` is a quick way to search text when you only know part of a value.
- `CASE` turns raw numbers into categories that are easier for non-technical readers to interpret, a common step before reporting.

## Skills demonstrated

`SELECT` · `DISTINCT` · `WHERE` · `AND` / `OR` / `IN` · `LIKE` · `IS NULL` · `ORDER BY` · `LIMIT` · `CASE`
