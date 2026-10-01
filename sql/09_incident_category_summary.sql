WITH incident_summary AS (
    SELECT
        source_year,
        incident,
        COUNT(*) AS logged_records,
        COUNT(*) FILTER (WHERE has_measured_delay) AS positive_delay_records,
        SUM(min_delay) AS recorded_delay_minutes,
        ROUND(
            AVG(min_delay) FILTER (WHERE has_measured_delay),
            1
        ) AS avg_minutes_per_positive_record,
        ROW_NUMBER() OVER (
            PARTITION BY source_year
            ORDER BY SUM(min_delay) DESC
        ) AS category_rank
    FROM bus_delay_incidents
    GROUP BY source_year, incident
)
SELECT
    source_year,
    category_rank,
    incident,
    logged_records,
    positive_delay_records,
    recorded_delay_minutes,
    avg_minutes_per_positive_record
FROM incident_summary
WHERE category_rank <= 10
ORDER BY source_year, category_rank;