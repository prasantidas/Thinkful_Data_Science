--What was the hottest day in our data set? Where was that?
SELECT
	MAX(MaxTemperatureF)
FROM 
	weather;

--How many trips started at each station?
SELECT
	start_station,
	COUNT(1)
FROM
	trips
GROUP BY
	start_station
ORDER BY 2;

--What's the shortest trip that happened?
SELECT
	*
FROM 
	trips
WHERE 
	duration = (
				SELECT
					min(duration)
				FROM 
					trips);

--What is the average trip duration, by end station?
SELECT
	end_station,
	AVG(duration)
FROM
	trips
GROUP BY
	end_station;