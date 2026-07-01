CREATE TABLE clean_events (
    timestamp BIGINT,
    visitorid BIGINT,
    event VARCHAR(20),
    itemid BIGINT,
    transactionid BIGINT,
    datetime TIMESTAMP,
    date DATE,
    year INT,
    month INT,
    month_name VARCHAR(20),
    day INT,
    weekday VARCHAR(20),
    hour INT,
    is_weekend BOOLEAN
);