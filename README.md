# profitable_Uber_rides

## Problem Statement

A profit ride for a Uber driver is considered when the start location and start time of a ride exactly match with the previous ride's end location and end time. Write an SQL query to calculate the total number of rides and total profit rides by each driver.

## Schema

The schema consists of a table named `drivers` with the following columns:

- `id`: VARCHAR(10) - Primary key, represents the driver's ID.
- `start_time`: TIME - Represents the start time of the ride.
- `end_time`: TIME - Represents the end time of the ride.
- `start_loc`: VARCHAR(1) - Represents the start location of the ride.
- `end_loc`: VARCHAR(1) - Represents the end location of the ride.

![daysql](https://github.com/bhumikadata/profitable_Uber_rides/assets/131578649/bc96a8a5-26a2-4d1f-a311-277fb3c8b702)


## SQL Query

```sql
WITH cte1 AS (
    SELECT
        id,
        COUNT(*) AS total_rides
    FROM
        drivers
    GROUP BY
        id
),
cte2 AS (
    SELECT
        d1.id AS id,
        COUNT(*) AS profit_rides
    FROM
        drivers d1
    LEFT JOIN
        drivers d2 ON d1.end_loc = d2.start_loc AND d1.end_time = d2.start_time
    GROUP BY
        d1.id
)
SELECT
    c1.id,
    c1.total_rides,
    COALESCE(c2.profit_rides, 0) AS profit_rides
FROM
    cte1 c1
LEFT JOIN
    cte2 c2 ON c1.id = c2.id;


