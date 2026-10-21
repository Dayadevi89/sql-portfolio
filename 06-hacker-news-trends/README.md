# 06 · Analyze Hacker News Trends

Exploring stories posted to [Hacker News](https://news.ycombinator.com/), a popular tech community site, to find the most popular stories, test whether a small group of power users dominates the site, see which websites feed it most, and work out the best time of day to post.

## Dataset

A single table, `hacker_news`, with stories posted since the site launched in 2007. The data is publicly available under the MIT licence.

| Column | Description |
|---|---|
| `title` | Story title |
| `user` | User who submitted the story |
| `score` | Points the story received |
| `timestamp` | When it was posted, e.g. `2018-05-08T12:30:00Z` (UTC) |
| `url` | Link the story points to |

## Questions answered

| # | Question | SQL used |
|---|---|---|
| 1 | What are the five highest-scoring stories? | `ORDER BY … DESC`, `LIMIT` |
| 2 | What is the total score of all stories? | `SUM()` |
| 3 | Which users have a combined score above 200? | `GROUP BY`, `HAVING` |
| 4 | What share of all points do those power users hold? | Nested subqueries, percentage calculation |
| 5 | Who posted the "rickroll" prank link, and how often? | `LIKE`, `COUNT()`, `GROUP BY` |
| 6–7 | Do GitHub, Medium or the New York Times feed the site most? | `CASE` with `LIKE`, `GROUP BY` on a `CASE` |
| 8–9 | How are timestamps stored, and how can we extract the hour? | `strftime('%H', …)` |
| 10–11 | Which hour of the day gets the highest average score? | `strftime()`, `AVG()`, `ROUND()`, `IS NOT NULL` |

All queries are in [`queries.sql`](queries.sql).

## Key takeaways

- **Calculate percentages from the data, not by hand.** The lab suggests typing the power users' scores into a sum. Using subqueries instead (Q4) gives the same answer but stays correct if the data changes, and avoids copy errors.
- **`CASE` can create new categories from messy text.** Grouping URLs into sources turns thousands of different links into a simple comparison.
- **`GROUP BY` can use a `CASE` expression**, referenced by its position (`GROUP BY 1`), so there's no need to repeat the whole expression.
- **Clean before you conclude.** Without `WHERE timestamp IS NOT NULL`, a NULL "hour" group appears in the results and distorts the comparison.
- **Watch the sample size and the time zone.** An hour with only a few stories can have an unusually high average by chance, so the story count should be read alongside the score. Timestamps are in UTC, so the "best hour" needs converting to the audience's local time.

## Skills demonstrated

`SUM()` · `COUNT()` · `AVG()` · `ROUND()` · `GROUP BY` · `HAVING` · subqueries · `CASE` · `LIKE` · `strftime()` date functions · `IS NOT NULL`
