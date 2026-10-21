-- =====================================================================
-- Project 06: Analyze Hacker News Trends
-- Author:  Dayadevi Kovananthal Raman
-- Goal:    Explore stories posted to Hacker News since 2007: the most
--          popular stories, whether a few power users dominate, which
--          websites feed the site, and the best time of day to post.
--
-- Table: hacker_news
--   title      story title
--   user       user who submitted it
--   score      points the story received
--   timestamp  time posted, e.g. 2018-05-08T12:30:00Z
--   url        link the story points to
-- =====================================================================


-- ---------------------------------------------------------------------
-- Understanding the dataset
-- ---------------------------------------------------------------------

-- 1. Top five stories by score
SELECT title,
       score
FROM hacker_news
ORDER BY score DESC
LIMIT 5;


-- ---------------------------------------------------------------------
-- Do a few users dominate? (the 1-9-90 rule)
-- ---------------------------------------------------------------------

-- 2. Total score of all stories
SELECT SUM(score) AS total_score
FROM hacker_news;


-- 3. Power users: combined score of more than 200
SELECT user,
       SUM(score) AS combined_score
FROM hacker_news
GROUP BY user
HAVING SUM(score) > 200
ORDER BY combined_score DESC;


-- 4. Share of all points earned by those power users.
--    The lab adds the scores by hand. Using subqueries instead keeps
--    the answer correct if the data changes.
SELECT ROUND(
         100.0 * (SELECT SUM(combined_score)
                  FROM (SELECT SUM(score) AS combined_score
                        FROM hacker_news
                        GROUP BY user
                        HAVING SUM(score) > 200) AS power_users)
         / (SELECT SUM(score) FROM hacker_news),
       2) AS power_user_pct;


-- 5. Rickrolling: how many times each user posted the prank link
SELECT user,
       COUNT(*) AS rickroll_posts
FROM hacker_news
WHERE url LIKE '%watch?v=dQw4w9WgXcQ%'
GROUP BY user
ORDER BY rickroll_posts DESC;


-- ---------------------------------------------------------------------
-- Which sites feed Hacker News?
-- ---------------------------------------------------------------------

-- 6. Label each story by its source website
SELECT CASE
         WHEN url LIKE '%github.com%'  THEN 'GitHub'
         WHEN url LIKE '%medium.com%'  THEN 'Medium'
         WHEN url LIKE '%nytimes.com%' THEN 'New York Times'
         ELSE 'Other'
       END AS source
FROM hacker_news;


-- 7. Number of stories from each source
SELECT CASE
         WHEN url LIKE '%github.com%'  THEN 'GitHub'
         WHEN url LIKE '%medium.com%'  THEN 'Medium'
         WHEN url LIKE '%nytimes.com%' THEN 'New York Times'
         ELSE 'Other'
       END AS source,
       COUNT(*) AS num_stories
FROM hacker_news
GROUP BY 1
ORDER BY num_stories DESC;


-- ---------------------------------------------------------------------
-- What's the best time to post a story?
-- ---------------------------------------------------------------------

-- 8. Look at the timestamp format
SELECT timestamp
FROM hacker_news
LIMIT 10;


-- 9. strftime('%H', …) extracts the hour (00-23) from a timestamp
SELECT timestamp,
       strftime('%H', timestamp) AS hour
FROM hacker_news
GROUP BY 1
LIMIT 20;


-- 10. Average score and number of stories for each hour
SELECT strftime('%H', timestamp),
       AVG(score),
       COUNT(*)
FROM hacker_news
GROUP BY 1;


-- 11. Cleaned up: rounded, renamed, NULL timestamps removed,
--     and sorted so the best hours appear first
SELECT strftime('%H', timestamp) AS hour,
       ROUND(AVG(score), 1)       AS avg_score,
       COUNT(*)                   AS num_stories
FROM hacker_news
WHERE timestamp IS NOT NULL
GROUP BY 1
ORDER BY avg_score DESC;
