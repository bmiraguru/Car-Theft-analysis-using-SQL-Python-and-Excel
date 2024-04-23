use vehicles;
#Joining tables and creating a temp table for better analysis#

CREATE TEMPORARY TABLE tempsv
SELECT 
    sv.*,
    l.location_name,
    md.make_name
FROM
    vehicles.stolen_vehicles sv
        JOIN
    locations l ON l.location_id = sv.location_id
        JOIN
    make_details md ON md.make_id = sv.make_id;

#Querying from the temp table#
SELECT * FROM tempsv;

#Stolen vehicles count by make type#
SELECT make_type,
    COUNT(*) AS totalcount
FROM
    tempsv
GROUP BY make_type;

#Stolen vehicles count by model year and top 5 years with the highest theft#
SELECT model_year,
    COUNT(*) AS totalcount
FROM
    tempsv
GROUP BY model_year order by totalcount desc limit 5;

#Stolen vehicles count by model year and bottom 5 years with the lowest theft#
SELECT model_year,
    COUNT(*) AS totalcount
FROM
    tempsv
GROUP BY model_year order by totalcount asc limit 5;


#Stolen vehicles count by region and top 5 regions with the highest theft#
SELECT region,
    COUNT(*) AS totalcount
FROM
    tempsv
GROUP BY region order by totalcount desc limit 5;


#Stolen vehicles count by region and bottom 5 regions with the lowest theft#
SELECT region,
    COUNT(*) AS totalcount
FROM
    tempsv
GROUP BY region order by totalcount asc limit 5;


#Stolen vehicles count by vehicle type and top 5 vehicle type with the highest theft#
SELECT vehicle_type,
    COUNT(*) AS totalcount
FROM
    tempsv
GROUP BY vehicle_type order by totalcount desc limit 5;

#Stolen vehicles count by vehicle type and bottom  5 vehicle type with the lowest theft#
SELECT vehicle_type,
    COUNT(*) AS totalcount
FROM
    tempsv
GROUP BY vehicle_type order by totalcount asc;

SELECT 
    YEAR(date_stolen) AS yearstolen, COUNT(*) AS totalstolen
FROM
    tempsv
GROUP BY yearstolen order by totalstolen desc;



SELECT vehicle_type,
    COUNT(*) AS totalcount
FROM
    tempsv
GROUP BY vehicle_type order by totalcount desc;


#Stolen vehicles count by colour and bottom 5 with the highest theft#
SELECT color,
    COUNT(*) AS totalcount
FROM
    tempsv
GROUP BY color order by totalcount desc limit 5;

#Altering the table structure by adding a new column indicating the day the cars were stolen#

ALTER TABLE tempsv
ADD COLUMN day_name VARCHAR(20);
UPDATE tempsv
SET day_name = DAYNAME(date_stolen);
DESCRIBE tempsv;

#Analysing the days which had the highest theft count#
SELECT 
    day_name, COUNT(*) AS cars_stolen
FROM
    tempsv
GROUP BY day_name
ORDER BY cars_stolen DESC;


#Comparing population density and the count of stolen cars#
SELECT 
    density, COUNT(*) AS totalstolen
FROM
    tempsv
GROUP BY density
ORDER BY totalstolen DESC;



select * from tempsv;
ALTER TABLE tempsv
DROP COLUMN stolenyear;
select * from tempsv;


#Avg population by region top 5#
SELECT 
    region, round(avg(population),0) AS avgpopulation
FROM
    tempsv
GROUP BY region
ORDER BY avgpopulation DESC limit 5;


#Avg population by region bottom 5 #
SELECT 
    region, round(avg(population),0) AS avgpopulation
FROM
    tempsv
GROUP BY region
ORDER BY avgpopulation limit 5;


SELECT 
    region, COUNT(*) AS totalstolencars
FROM
    tempsv
GROUP BY region
ORDER BY totalstolencars DESC;



alter table tempsv
DROP COLUMN stolenyear;
describe tempsv;
alter table tempsv
DROP COLUMN yearofstolendate;
select * from tempsv;

