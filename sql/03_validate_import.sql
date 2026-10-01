SELECT
    source_year,
    COUNT(*) AS total_records,
    COUNT(*) FILTER (WHERE has_measured_delay) AS measured_delay_records,
    COUNT(*) FILTER (WHERE NOT has_route) AS missing_route_records
FROM bus_delay_incidents
GROUP BY source_year
ORDER BY source_year;