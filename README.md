# SQL Portfolio

Hands-on SQL projects completed as part of my data analytics training. Each project answers a set of business-style questions against a real-world-style dataset, with the queries, explanations and results included.

## Projects

| # | Project | What it covers |
|---|---|---|
| 01 | [New York Restaurants](01-new-york-restaurants/) | Filtering, pattern matching, NULL handling, sorting and categorising with `CASE` |
| 02 | [Climate Change](02-climate-change/) | Window functions on 125 years of US state temperatures: trends, year-on-year change, rankings, quartiles, with real findings and charts |
| 03 | [Lyft Trip Data](03-lyft-trip-data/) | Joining trip, rider and car tables, combining tables with `UNION`, and answering business questions with aggregates |
| 04 | [Create a Table](04-create-a-table/) | Creating and managing a table end to end (`CREATE`, `INSERT`, `UPDATE`, `ALTER`, `DELETE`) and enforcing data quality with constraints |
| 05 | [Trends in Startups](05-trends-in-startups/) | Aggregate functions to compare startup funding, valuation by sector, crowded markets and company size by city |
| 06 | [Hacker News Trends](06-hacker-news-trends/) | Testing whether power users dominate, categorising traffic sources with `CASE`, and finding the best time to post with date functions |

*More projects being added.*

## SQL skills

- **Creating & managing data:** `CREATE TABLE`, `INSERT`, `UPDATE`, `ALTER TABLE`, `DELETE`, constraints (`PRIMARY KEY`, `NOT NULL`, `UNIQUE`)
- **Querying & filtering:** `SELECT`, `DISTINCT`, `WHERE`, `AND`/`OR`, `IN`, `LIKE`, `IS NULL`
- **Sorting & limiting:** `ORDER BY`, `LIMIT`
- **Conditional logic:** `CASE … WHEN`
- **Window functions:** `OVER`, `PARTITION BY`, running averages, `FIRST_VALUE()`, `LAG()`, `RANK()`, `NTILE()`
- **Joins & unions:** `INNER JOIN`, `LEFT JOIN`, `CROSS JOIN`, `UNION`, primary and foreign keys
- **Aggregates & grouping:** `COUNT()`, `SUM()`, `AVG()`, `MIN()`, `MAX()`, `ROUND()`, `GROUP BY`, `HAVING`
- **Subqueries:** filtering on calculated columns, percentage-of-total calculations
- **Dates & text:** `strftime()`, `LIKE` pattern matching inside `CASE`

## How to run

The queries use standard SQL and run in SQLite, PostgreSQL or MySQL. Open any project's `queries.sql` in a SQL client such as [DB Browser for SQLite](https://sqlitebrowser.org/) or an online editor like [sqliteonline.com](https://sqliteonline.com/).

## About me

Aspiring data analyst building practical SQL, Excel and reporting skills.
<!-- Add your LinkedIn link here -->
