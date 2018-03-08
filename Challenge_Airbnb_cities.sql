--What's the most expensive listing? What else can you tell me about the listing?
SELECT 
	MAX(price)
FROM 
	seattle_listings;

SELECT 
	* 
FROM 
	seattle_listings
ORDER BY 
	price DESC
LIMIT 1;

--The details are follows for the most expensive listings
/*
name = Cute Basement Apartment
host_name= Christina
neighbourhood= Roosevelt
number of reviews = 1
*/

--What neighborhoods seem to be the most popular?
-- popularity based on average number_of_reviews
SELECT 
	neighbourhood, AVG(number_of_reviews)
FROM 
	seattle_listings
GROUP BY
	neighbourhood
ORDER BY 2 DESC
LIMIT 1;
-- "International District" is the most popular neighbourhood with average 83.4 reviews.
SELECT 
	neighbourhood_group, 
	neighbourhood, 
	AVG(number_of_reviews)
FROM 
	seattle_listings
GROUP BY
	neighbourhood_group, 
	neighbourhood
ORDER BY 3 DESC
LIMIT 1;
--"Downtown" group	"International District"	"83.4117647058823"

--popularity based on availability
--41 neighbourhood have 0 availability - so may be highly popular
SELECT 
	neighbourhood
FROM
	seattle_listings
WHERE availability_365 = 
(
SELECT 
	min(availability_365) min_avail
FROM 
	seattle_listings
)
GROUP BY neighbourhood



-- add month
ALTER TABLE 
	seattle_listings 
RENAME TO 
	seattle_listings_2

CREATE TABLE 
	seattle_listings 
AS  
SELECT 
	id	,
	name,	
	host_id,	
	host_name	,
	neighbourhood_group	,
	neighbourhood,	
	latitude,	
	longitude,
	room_type,	
	price	,
	minimum_nights	,
	number_of_reviews,	
	last_review	,
	reviews_per_month,	
	calculated_host_listings_count,	
	availability_365,
	strftime('%Y', last_review) review_year, 
	strftime('%m', last_review) review_month 
FROM seattle_listings_2

DROP TABLE seattle_listings_2;
--What time of year is the cheapest time to go to your city? 
-- DECEMBER month is the cheapest.
SELECT 
	review_month, 
	AVG(price) 
FROM 
	seattle_listings 
WHERE 
	review_month IS NOT NULL 
GROUP BY 
	review_month
ORDER BY 2 
LIMIT 1

--What about the busiest? 
--JULY month prices are the highest.
SELECT 
	review_month, 
	AVG(price) 
FROM 
	seattle_listings 
WHERE 
	review_month IS NOT NULL 
GROUP BY 
	review_month
ORDER BY 2 DESC
LIMIT 1
