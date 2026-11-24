create database zomato_analysis;
use zomato_analysis;
show databases;

#count total restaurants
select count(*)
from Zomato_Restaurant;

#check columns
describe Zomato_Restaurant;

#check first 10 records
select*from Zomato_Restaurant
Limit 10;

# 1 check total locations
select location, count(*) as total_restaurants
from Zomato_Restaurant
group by location
order by total_restaurants DESC;

# 2  highest rated restaurants 10
select name,location,rate,votes
from Zomato_Restaurant
where rate is not null
order by rate DESC, votes DESC
limit 10;

#3 Avg restaurants
select round(avg(rate),2) as avg_rating
from Zomato_Restaurant
where rate is not null;

#4 count restaurant by cuisine
select cuisines, count(*) as total_restaurant
from Zomato_Restaurant
where cuisines is not null
group by cuisines
order by total_restaurant DESC
limit 10;

#5 count restaurant online delivery 
select online_order, count(*) as total_restaurants
from Zomato_Restaurant
group by online_order;

#6 avg cost for two by city
SELECT location,
       ROUND(AVG(
           CAST(REPLACE(`approx_cost(for two people)`, ',', '') AS DECIMAL(10,2))
       ), 2) AS avg_cost
FROM Zomato_Restaurant
WHERE `approx_cost(for two people)` IS NOT NULL
GROUP BY location
ORDER BY avg_cost DESC;

#7 rank restaurant from customer votes
select name,location,votes,rank() over(order by votes DESC) as rest_rank
from Zomato_Restaurant
where votes is not null
limit 20;

#8 rating above 4.5
select name,location,votes,rate
from Zomato_Restaurant
where rate>4.5
order by rate DESC, votes DESC;

#9 count Restaurant by price range
SELECT
    CASE
        WHEN CAST(REPLACE(`approx_cost(for two people)`, ',', '') AS DECIMAL(10,2)) <= 500
            THEN 'Budget'
        WHEN CAST(REPLACE(`approx_cost(for two people)`, ',', '') AS DECIMAL(10,2)) <= 1000
            THEN 'Moderate'
        WHEN CAST(REPLACE(`approx_cost(for two people)`, ',', '') AS DECIMAL(10,2)) <= 2000
            THEN 'Expensive'
        ELSE 'Premium'
    END AS price_range,
    COUNT(*) AS total_restaurants
FROM Zomato_Restaurant
WHERE `approx_cost(for two people)` IS NOT NULL
GROUP BY price_range
ORDER BY total_restaurants DESC;


#10 identify most popular cusines
select cuisines, count(*) as total_restaurant
from Zomato_Restaurant
where cuisines is not null
group by cuisines
order by total_restaurant DESC
limit 5;