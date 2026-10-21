# 05 · Trends in Startups

Playing the role of a tech reporter researching trends in the startup world: using **aggregate functions** to summarise a portfolio of well-known startups by funding, valuation, sector and location.

## Dataset

A single table, `startups`, with 10 columns:

| Column | Description |
|---|---|
| `name` | Company name |
| `location` | City where the company is based |
| `category` | Industry / sector |
| `employees` | Number of employees (company size) |
| `raised` | Total funding raised |
| `valuation` | Company valuation |
| `founded` | Year founded |
| `stage` | Funding stage (e.g. Seed, Series A, IPO) |
| `ceo` | Chief executive |
| `info` | Short description |

## Questions answered

| # | Question | SQL used |
|---|---|---|
| 1 | What does the table contain? | `SELECT *` |
| 2 | How many companies are there? | `COUNT()` |
| 3 | What are all the companies worth in total? | `SUM()` |
| 4 | What is the most money any startup has raised? | `MAX()` |
| 5 | What is the most raised at the Seed stage? | `MAX()` with `WHERE` |
| 6 | When was the oldest company founded? | `MIN()` |
| 7 | What is the average valuation? | `AVG()` |
| 8–10 | What is the average valuation per sector, ranked? | `GROUP BY`, `ROUND()`, `ORDER BY` |
| 11 | How many companies are in each sector? | `COUNT()` with `GROUP BY` |
| 12 | Which sectors are most crowded (more than three companies)? | `HAVING` |
| 13 | How big is the average startup in each city? | `AVG()` with `GROUP BY` |
| 14 | Which cities have startups averaging more than 500 employees? | `HAVING` |

All queries are in [`queries.sql`](queries.sql).

## Key takeaways

- **`WHERE` filters rows before grouping; `HAVING` filters groups after aggregation.** To keep only sectors with more than three companies, the condition depends on `COUNT(*)`, which only exists after grouping, so it has to go in `HAVING`.
- **Build aggregate queries in steps** (Q8 → Q9 → Q10): get the grouping right first, then round, then sort. This makes errors easy to spot.
- **Averages can be skewed.** A single very large company can lift a whole sector's or city's average, so it's worth checking the count behind each average (Q11) before drawing conclusions.
- `GROUP BY 1` and `ORDER BY 2` refer to column positions in the `SELECT` list, a handy shortcut for longer expressions.

## Skills demonstrated

`COUNT()` · `SUM()` · `MAX()` · `MIN()` · `AVG()` · `ROUND()` · `GROUP BY` · `HAVING` · `ORDER BY`
