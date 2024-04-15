WITH ItemCounts AS (
    SELECT
        item,
        COUNT(*) AS frequency
    FROM
        item_bought
    GROUP BY
        item
)
SELECT
    item
FROM
    ItemCounts
WHERE
    frequency = (SELECT MAX(frequency) FROM ItemCounts)
    OR
    frequency = (SELECT MIN(frequency) FROM ItemCounts)

