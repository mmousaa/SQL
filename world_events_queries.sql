-- World Events Database SQL Queries
-- Author: Mahmoud Mousa

-- 1. Number of events recorded per country
SELECT   
    C.[CountryName],
    COUNT(E.[EventID]) AS [Number of Events]
FROM [WorldEvents].[dbo].[tblEvent] E
JOIN [WorldEvents].[dbo].[tblCountry] C
    ON E.[CountryID] = C.[CountryID]
GROUP BY C.[CountryName]
ORDER BY [Number of Events] DESC;

-- 2. Group events by both category and country
SELECT 
    CA.[CategoryName],
    C.[CountryName],
    COUNT(E.[EventID]) AS [Number of Events]
FROM [WorldEvents].[dbo].[tblEvent] E
JOIN [WorldEvents].[dbo].[tblCountry] C
    ON E.[CountryID] = C.[CountryID]
JOIN [WorldEvents].[dbo].[tblCategory] CA
    ON CA.[CategoryID] = E.[CategoryID]
GROUP BY C.[CountryName], CA.[CategoryName];

-- 3. Find all events that contain the word 'War' (case-insensitive)
SELECT 
    [EventName]
FROM [WorldEvents].[dbo].[tblEvent]
WHERE [EventName] LIKE '%war%';

-- 4. Events timeline per historical period
SELECT 
    [EventName],
    CASE 
        WHEN [EventDate] BETWEEN '1770' AND '1815' THEN 'Age of Revolutions (1776-1815)'
        WHEN [EventDate] BETWEEN '1816' AND '1914' THEN 'Industrial Expansion (1815-1914)'
        WHEN [EventDate] BETWEEN '1915' AND '1945' THEN 'World Wars (1914-1945)'
        WHEN [EventDate] BETWEEN '1946' AND '1991' THEN 'Cold War (1945-1991)'
        ELSE 'Digital Age (1991-2007)'
    END AS [Period]
FROM [WorldEvents].[dbo].[tblEvent];

-- 5. Event count per continent
SELECT 
    [ContinentName],
    COUNT([EventID]) AS [Event Count]
FROM [WorldEvents].[dbo].[tblContinent] CON
JOIN [WorldEvents].[dbo].[tblCountry] COU
    ON CON.[ContinentID] = COU.[ContinentID]
JOIN [WorldEvents].[dbo].[tblEvent] EV
    ON EV.[CountryID] = COU.[CountryID]
GROUP BY [ContinentName];

-- 6. Top 10 events with longest descriptions
SELECT TOP (10)  
    [EventName],
    CONCAT(LEN([EventDetails]), ' Letters') AS [Length of description]
FROM [WorldEvents].[dbo].[tblEvent]
GROUP BY [EventName], LEN([EventDetails])
ORDER BY [Length of description] DESC;

-- 7. World War II events (1939-1945)
SELECT 
    [EventName],
    [EventDate],
    [CountryName]
FROM [WorldEvents].[dbo].[tblEvent] ev
JOIN [WorldEvents].[dbo].[tblCountry] cou
    ON ev.[CountryID] = cou.[CountryID]
WHERE YEAR([EventDate]) BETWEEN '1939' AND '1945'
ORDER BY [EventDate] ASC;

-- 8. Categories with no events
SELECT 
    [CategoryName]
FROM [WorldEvents].[dbo].[tblCategory] CA
LEFT JOIN [WorldEvents].[dbo].[tblEvent] EV
    ON CA.[CategoryID] = EV.[CategoryID]
WHERE [EventName] IS NULL;

-- 9. Event count by year in UK
SELECT  
    YEAR([EventDate]) AS [Year],
    COUNT([EventID]) AS [Events count]
FROM [WorldEvents].[dbo].[tblCountry] COU
JOIN [WorldEvents].[dbo].[tblEvent] EV
    ON ev.[CountryID] = cou.[CountryID]
WHERE [CountryName] = 'United Kingdom'
GROUP BY YEAR([EventDate])
ORDER BY [Year];

-- 10. Events mentioning 'nuclear' in details
SELECT 
    [EventName],
    [EventDetails]
FROM [WorldEvents].[dbo].[tblEvent]
WHERE [EventDetails] LIKE '%nuclear%';
