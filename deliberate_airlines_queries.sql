/* 
flights ( flight_no from_place, to_place, dist, dept_time, arr_time, price, aircraft_id )
flights ( flight_no from_place, to_place, dist, dept_time, arr_time, price, aircraft_id )

aircraft ( aircraft_id, aircraft_name, cruising_range)

employees ( e_id, e_name, salary ) 

certified ( e_id, aircraft_id )

1- obtain the maximum crusing range of the flight flown by a pilot who has been certified for more than two aircrafts
2. display the aircraft_id which travels maximum distance
3. display the flight number which travels from india to melbourne
4. find all flights between 8am 11am
5. display numnber of flights for which each employee is certified
6- find all employees whose salary > 75000
7. find all aircrafts which travel to multiple places
8. find the aircrafts which has maximum number of employees
9- find aircraft names which starts with letter A
10. find that aircraft which has highest paid employee

*/

-- CREATE TABLE aircraft (
--     aircraft_id INT AUTO_INCREMENT ,
--     aircraft_name TEXT,
--     cruising_range REAL,
--     PRIMARY KEY (aircraft_id)
-- );
-- ALTER TABLE `aircraft` CHANGE `aircraft_id` `aircraft_id` INT(11) NOT NULL AUTO_INCREMENT;
CREATE TABLE aircrafts (
    aircraft_id INT AUTO_INCREMENT ,
    aircraft_name TEXT,
    cruising_range REAL,
    PRIMARY KEY (aircraft_id)
)

CREATE TABLE employees (
    e_id INT AUTO_INCREMENT,
    e_name TEXT,
    salary REAL,
    PRIMARY KEY (e_id)
);

CREATE TABLE flights (
    flight_no INT,
    from_place TEXT,
    to_place TEXT,
    dist REAL,
    dept_time TIMESTAMP,
    arr_time TIMESTAMP,
    price REAL,
    aircraft_id INT,
    PRIMARY KEY (flight_no),
    FOREIGN KEY (aircraft_id) REFERENCES aircrafts(aircraft_id)
);
INSERT INTO `flights` (`flight_no`, `from_place`, `to_place`, `dist`, `dept_time`, `arr_time`, `price`, `aircraft_id`) VALUES (NULL, 'India', 'Melbourne', '21000', current_timestamp(), '2020-01-09 00:00:00', '51000', '1');

CREATE TABLE certified ( 
    e_id INT,
    aircraft_id INT,
    PRIMARY KEY (e_id, aircraft_id),
    FOREIGN KEY (e_id) REFERENCES employees(e_id),
    FOREIGN KEY (aircraft_id) REFERENCES aircrafts(aircraft_id)
);

SELECT * 
FROM aircrafts
WHERE cruising_range

--  1. get the aircraft id (not required)
--   get the maximum crusing distance
--      select all the aircrafts valid
--           pilot who has been certified for more than two aircrafts
    SELECT e_id, COUNT(aircraft_id) as num_pilots
    FROM certified
    GROUP BY e_id
    HAVING num_pilots > 2

-- could have used NATURAL JOIN together
SELECT MAX(cruising_range)
FROM aircrafts, (
    SELECT aircraft_id
    FROM certified, (
        SELECT e_id, COUNT(aircraft_id) as num_aircrafts
        FROM certified
        GROUP BY e_id
        HAVING num_aircrafts > 2
    ) AS valid_pilots
    WHERE valid_pilots.e_id = certified.e_id
) AS valid_aircrafts
WHERE valid_aircrafts.aircraft_id = aircrafts.aircraft_id

INSERT INTO `certified` (`e_id`, `aircraft_id`) VALUES ('3', '1'), ('3', '2');

-- 2. display the aircraft_id which travels maximum distance
SELECT aircraft_id, SUM(dist)
FROM flights
GROUP BY aircraft_id
HAVING SUM(dist) = (
    SELECT SUM(dist) as tot_dist
    FROM flights
    GROUP BY aircraft_id
    ORDER BY tot_dist DESC
    LIMIT 1
);
 

-- 3. display the flight number which travels from india to melbourne
SELECT flight_no
FROM flights
WHERE from_place = "India" AND to_place = "Melbourne"

-- 4. find all flights between 8am 11am
SELECT *
FROM flights
WHERE HOUR(TIME(dept_time)) >= 8 
    AND HOUR(TIME(dept_time)) <= 11


-- 5. display number of aircrafts for each employee
SELECT e_id, COUNT(a_id)
FROM certified 


-- 6- find all employees whose salary > 75000
SELECT *
FROM employees 
WHERE salary > 75000




-- 7. find all aircrafts which travel to multiple places
SELECT *
FROM flights
GROUP BY aircraft_id
HAVING COUNT(*) > 1

-- 8. find the aircrafts which has maximum number of employees
SELECT aircraft_id
FROM certified
GROUP BY aircraft_id
HAVING COUNT(e_id) = ( 
    SELECT COUNT(e_id)
    FROM certified
    GROUP BY aircraft_id
    ORDER BY COUNT(e_id) DESC
    LIMIT 1
)



-- 9. find aircraft names which starts with letter A
-- another idea substring
SELECT aircraft_name 
FROM aircrafts 
WHERE aircraft_name LIKE "A%" 
OR aircraft_name LIKE "a%"

-- 10. find that aircraft(s) which has highest paid employee
SELECT aircraft_id
FROM certified 
NATURAL JOIN employees
ORDER BY salary DESC
LIMIT 1