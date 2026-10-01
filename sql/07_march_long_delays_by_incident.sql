WITH long_delays AS (
    SELECT
        source_year,
        incident,
        COUNT(*) AS records_120_plus,
        SUM(min_delay) AS minutes_from_120_plus,
        ROW_NUMBER() OVER (
            PARTITION BY source_year
            ORDER BY SUM(min_delay) DESC
        ) AS category_rank
    FROM bus_delay_incidents
    WHERE month = 3
      AND min_delay >= 120
    GROUP BY source_year, incident
)
SELECT
    source_year,
    category_rank,
    incident,
    records_120_plus,
    minutes_from_120_plus
FROM long_delays
WHERE category_rank <= 5
ORDER BY source_year, category_rank;