SELECT
    source_year,
    COUNT(*) AS logged_records,
    COUNT(*) FILTER (WHERE has_measured_delay) AS positive_delay_records,
    SUM(min_delay) AS total_recorded_delay_minutes,
    ROUND(
        AVG(min_delay) FILTER (WHERE has_measured_delay),
        1
    ) AS avg_minutes_per_positive_delay_record
FROM bus_delay_incidents
GROUP BY source_year
ORDER BY source_year;