SELECT
    incident,
    COUNT(*) AS logged_records,
    COUNT(*) FILTER (WHERE min_delay > 0) AS positive_delay_records,
    SUM(min_delay) AS recorded_delay_minutes,
    ROUND(
        AVG(min_delay) FILTER (WHERE min_delay > 0),
        1
    ) AS avg_minutes_per_positive_record
FROM bus_delay_incidents
WHERE source_year = 2024
  AND hour = 7
GROUP BY incident
ORDER BY recorded_delay_minutes DESC
LIMIT 10;