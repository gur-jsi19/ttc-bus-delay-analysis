WITH route_totals AS (
    SELECT
        source_year,
        route,
        COUNT(*) FILTER (WHERE has_measured_delay) AS positive_delay_records,
        SUM(min_delay) AS recorded_delay_minutes,
        ROW_NUMBER() OVER (
            PARTITION BY source_year
            ORDER BY SUM(min_delay) DESC
        ) AS route_rank
    FROM bus_delay_incidents
    WHERE has_route
    GROUP BY source_year, route
)
SELECT
    source_year,
    route_rank,
    route,
    positive_delay_records,
    recorded_delay_minutes
FROM route_totals
WHERE route_rank <= 10
ORDER BY source_year, route_rank;