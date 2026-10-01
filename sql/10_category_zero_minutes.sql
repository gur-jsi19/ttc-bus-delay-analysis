SELECT
    source_year,
    incident,
    COUNT(*) AS logged_records,
    COUNT(*) FILTER (WHERE min_delay = 0) AS zero_minute_records,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE min_delay = 0) / COUNT(*),
        1
    ) AS zero_minute_percent,
    SUM(min_delay) AS recorded_delay_minutes
FROM bus_delay_incidents
WHERE incident IN ('General Delay', 'Diversion')
GROUP BY source_year, incident
ORDER BY incident, source_year;