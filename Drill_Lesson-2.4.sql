--What are the three longest trips on rainy days?
WITH rain_weather AS
(
	SELECT 
		DISTINCT events,
				date 
	FROM 
		weather 
	WHERE 
		events= 'Rain' 
)
SELECT 
	t.*
FROM 
	trips t , 
	rain_weather w
WHERE 
	date(t.start_date) = w.date
ORDER BY 
	t.duration desc 
LIMIT 3;

--Which station is full most often?
SELECT
	stations.name,
	COUNT(CASE WHEN docks_available=0 then 1 END) empty_count
FROM 
	status JOIN 
	stations
	ON stations.station_id = status.station_id
GROUP BY 1
ORDER BY 
	empty_count DESC;

--Return a list of stations with a count of number of trips starting at that station but ordered by dock count.
SELECT 
	s.name,
	COUNT(t.trip_id) trip_no
FROM 
	stations s,
	trips t
WHERE 
	s.name= t.start_station
GROUP BY 
	s.name
ORDER BY 
	s.dockcount;

	
--(Challenge) What's the length of the longest trip for each day it rains anywhere?
WITH rain_weather AS
(
	SELECT 
		DISTINCT events,
				date 
	FROM 
		weather 
	WHERE 
		events= 'Rain' 
)
SELECT 
	date(t.start_date), 
	MAX(t.duration)
FROM 
	trips t , 
	rain_weather w
WHERE 
	date(t.start_date) = w.date
GROUP BY 
	date(t.start_date)
ORDER BY 1



