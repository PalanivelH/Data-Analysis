---- Accident Data Analysis-----------

Use Data_Analysis;

select * from dbo.vehicle;

select * from dbo.accident;

----- Question 1 : How many acccidents  have occurred in urban versus Rural Areas? -------

SELECT  
Area, count(Area) as Total_Accidents 
FROM accident 
GROUP BY Area;


-----Same solution in a different way of representation ----

SELECT 
SUM(CASE WHEN Area ='Urban' THEN 1 ELSE 0 END) AS URBAN_ACCIDENTS,
SUM (CASE WHEN Area='Rural' THEN 1 ELSE 0 END) AS RURAL_ACCIDENTS
from accident;


--------Question 2 : Which day of the month more accidents happened from highest to least ?--------- 

SELECT 
datename(dw,DATE) AS DAY_NAME,
count(*) AS TOTAL_ACCIDENTS
FROM accident
GROUP BY datename(dw,DATE)
ORDER BY TOTAL_ACCIDENTS DESC;


----- Question 3 : What is the average age of vehicles invloved in accidents based on their type? -------

SELECT 
vehicleType,
COUNT(vehicleID) as Total_Accidents,
AVG(Agevehicle) as Average_vehicle_Age
FROM vehicle
WHERE Agevehicle IS NOT NULL ---- here I have excluded vehicles with no age values
GROUP BY vehicleType
ORDER BY Total_Accidents DESC;



---- Question 4 : Is there any Trend in accidents based on the Age of the vehicle ? --------

SELECT 
Age_Group,
COUNT(AccidentIndex) as Total_Accidents,
AVG(AgeVehicle) as Average_Year
FROM 
(SELECT 
AccidentIndex, 
AgeVehicle,
CASE 
WHEN AgeVehicle BETWEEN 0 AND 5 THEN 'New'
WHEN AgeVehicle BETWEEN 6 AND 10 THEN 'Regular'
ELSE 'Old' END as Age_Group
FROM 
Vehicle) AS Vehicle_Details
GROUP BY Age_Group ;


---- Question 5 : Are there any specific weather condition for severe accidents ? --------

DECLARE @Severity varchar(100);
SET @Severity='Fatal';

SELECT 
WeatherConditions, 
COUNT(AccidentIndex) as Total_Accidents
FROM accident
WHERE Severity= @Severity
GROUP BY WeatherConditions
ORDER BY Total_Accidents DESC;

---- Question 6 : Do accidents often involve impact on the left hand side of vehicles? ----

SELECT 
LeftHand, 
COUNT(AccidentIndex) as Total_Accidents
FROM vehicle
WHERE LeftHand is not null
GROUP BY LeftHand;


---- Question 7 : Are there any relationship between journey purposes and severity of the accident ----

SELECT 
v.JourneyPurpose,
COUNT(a.Severity) as Total_Accidents, 
CASE
WHEN COUNT(a.Severity) between 1 and 1000 THEN 'Low'
WHEN COUNT(a.Severity) between 10001 and 100000 THEN 'Moderate'
WHEN COUNT(a.Severity) between 100001 and 200000 THEN 'High'
ELSE 'Very High'
END AS 'Severity_Level'
FROM vehicle v
JOIN accident a
ON a.AccidentIndex=v.AccidentIndex
GROUP BY v.JourneyPurpose
ORDER BY Total_Accidents DESC;

---- Question 8 : Calculate the average age of vehicles invloved in accidents, considering Day light and point of Impact

SELECT 
V.PointImpact, 
A.LightConditions,
AVG(V.AgeVehicle) AS Average_Year
FROM vehicle V
JOIN accident A
ON A.AccidentIndex=V.AccidentIndex
GROUP BY V.PointImpact,A.LightConditions;

---if we want specific combinations of the values 

DECLARE @Light varchar(100); 
DECLARE @Impact varchar(100); 

SET @Light='Daylight';-- here we can modify based on our requiremnts
SET @Impact='Front';

SELECT 
V.PointImpact, 
A.LightConditions,
AVG(V.AgeVehicle) AS Average_Year
FROM vehicle V
JOIN accident A
ON A.AccidentIndex=V.AccidentIndex
GROUP BY V.PointImpact,A.LightConditions
HAVING V.PointImpact=@Impact 
AND A.LightConditions=@Light;