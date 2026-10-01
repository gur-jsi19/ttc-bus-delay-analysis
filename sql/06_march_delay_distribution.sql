SELECT
    source_year,
    COUNT(*) FILTER (WHERE min_delay > 0) AS positive_delay_records,
    ROUND(AVG(min_delay) FILTER (WHERE min_delay > 0), 1) AS average_minutes,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY min_delay)
        FILTER (WHERE min_delay > 0) AS median_minutes,
    MAX(min_delay) AS largest_recorded_delay,
    COUNT(*) FILTER (WHERE min_delay >= 120) AS records_at_least_120_minutes
FROM bus_delay_incidents
WHERE month = 3
GROUP BY source_year
ORDER BY source_year;
