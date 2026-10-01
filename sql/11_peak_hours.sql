WITH hourly_totals AS (
    SELECT
        source_year,
        hour,
        COUNT(*) AS logged_records,
        COUNT(*) FILTER (WHERE min_delay > 0) AS positive_delay_records,
        SUM(min_delay) AS recorded_delay_minutes,
        ROUND(AVG(min_delay) FILTER (WHERE min_delay > 0), 1)
            AS avg_minutes_per_positive_record
    FROM bus_delay_incidents
    GROUP BY source_year, hour
),
ranked_hours AS (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY source_year
            ORDER BY recorded_delay_minutes DESC, hour
        ) AS hour_rank
    FROM hourly_totals
)
SELECT
    source_year,
    hour_rank,
    hour,
    logged_records,
    positive_delay_records,
    recorded_delay_minutes,
    avg_minutes_per_positive_record
FROM ranked_hours
WHERE hour_rank <= 5
ORDER BY source_year, hour_rank;