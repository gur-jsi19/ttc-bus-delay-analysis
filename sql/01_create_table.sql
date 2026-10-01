CREATE TABLE IF NOT EXISTS bus_delay_incidents (
    date DATE NOT NULL,
    route TEXT,
    time TIME NOT NULL,
    day TEXT NOT NULL,
    location TEXT NOT NULL,
    incident TEXT NOT NULL,
    min_delay INTEGER NOT NULL,
    min_gap INTEGER NOT NULL,
    direction TEXT,
    vehicle TEXT NOT NULL,
    source_year SMALLINT NOT NULL,
    incident_datetime TIMESTAMP NOT NULL,
    month SMALLINT NOT NULL,
    hour SMALLINT NOT NULL,
    weekday TEXT NOT NULL,
    has_measured_delay BOOLEAN NOT NULL,
    has_route BOOLEAN NOT NULL
);