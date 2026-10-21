# 04 · Create a Table

Building a table from scratch and managing its data through the full lifecycle: **create, insert, read, update, alter and delete**. These are the operations behind every application that stores data.

## What the script does

| # | Task | SQL used |
|---|---|---|
| 1 | Create a `friends` table with `id`, `name` and `birthday` | `CREATE TABLE` |
| 2 | Add a first friend, Ororo Munroe | `INSERT INTO … VALUES` |
| 3 | Check the table and the new row | `SELECT *` |
| 4 | Add two more friends in one statement | Multi-row `INSERT` |
| 5 | Ororo changes her name to Storm | `UPDATE … SET … WHERE` |
| 6 | Add an `email` column | `ALTER TABLE … ADD COLUMN` |
| 7 | Fill in everyone's email | `UPDATE` |
| 8 | Storm is fictional, so remove her | `DELETE FROM … WHERE` |
| 9 | Final check | `SELECT *` |

All statements are in [`queries.sql`](queries.sql). The friends in this project are fictional, so no real personal data is published.

## Result

The `friends` table after all nine steps:

| id | name | birthday | email |
|---|---|---|---|
| 2 | Maya Patel | 1992-08-14 | maya.patel@example.com |
| 3 | Liam Carter | 1990-02-03 | liam.carter@example.com |

## Extra: designing the table properly

The lab's table has no rules, so it would happily accept two friends with the same `id`, a friend with no name, or two people sharing an email. I rebuilt it as `friends_v2` with **constraints**, so the database enforces data quality itself:

```sql
CREATE TABLE friends_v2 (
  id       INTEGER PRIMARY KEY,
  name     TEXT    NOT NULL,
  birthday DATE,
  email    TEXT    UNIQUE,
  added_on DATE    DEFAULT CURRENT_DATE
);
```

Tested against bad data, it rejects each problem:

| Attempt | Result |
|---|---|
| Insert a second row with `id = 2` | Rejected: `UNIQUE constraint failed: friends_v2.id` |
| Insert a friend with no name | Rejected: `NOT NULL constraint failed: friends_v2.name` |
| Reuse an existing email | Rejected: `UNIQUE constraint failed: friends_v2.email` |

## Key takeaways

- **Always use `WHERE` with `UPDATE` and `DELETE`.** Without it, the statement changes or removes every row in the table.
- **Update by `id`, not by name.** Names can be duplicated or changed (as Ororo's was), while an `id` is a stable way to target exactly one row.
- **Store dates as `YYYY-MM-DD`.** This format sorts correctly and works with date functions.
- **Constraints catch bad data at the source**, which is cheaper than cleaning it up later in analysis.

## Skills demonstrated

`CREATE TABLE` · `INSERT` · `UPDATE` · `ALTER TABLE` · `DELETE` · data types · constraints (`PRIMARY KEY`, `NOT NULL`, `UNIQUE`, `DEFAULT`) · `INSERT … SELECT`
