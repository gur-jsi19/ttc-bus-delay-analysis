SELECT
    date,
    COUNT(*) AS positive_diversion_records,
    SUM(min_delay) AS recorded_delay_minutes,
    ROUND(AVG(min_delay), 1) AS avg_minutes_per_record,
    MAX(min_delay) AS largest_recorded_delay
FROM bus_delay_incidents
WHERE source_year = 2024
  AND hour = 7
  AND incident = 'Diversion'
  AND min_delay > 0
GROUP BY date
ORDER BY recorded_delay_minutes DESC
LIMIT 10;