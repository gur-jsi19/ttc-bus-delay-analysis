SELECT
    date,
    time,
    route,
    location,
    incident,
    min_delay,
    min_gap,
    vehicle
FROM bus_delay_incidents
WHERE date = '2024-04-15'
  AND hour = 7
  AND incident = 'Diversion'
  AND min_delay > 0
ORDER BY min_delay DESC;