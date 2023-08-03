create database SQLproject
Select * from SQLproject.dbo.Cia_Birthrate

alter table SQLproject.dbo.Cia_Birthrate
drop column F5

--Which country has the highest population?
select Top 5 country, population
from SQLproject.dbo.cia_Population
order by population desc

-- Find average population from top highest populated countries (inner subquery)
SELECT AVG(population) AS average_population
FROM (
    SELECT TOP 5 population
    FROM SQLproject.dbo.cia_Population
    ORDER BY population DESC
) AS top_5_countries;

--find country where population is above average (inner subquery)

SELECT country, population
FROM SQLproject.dbo.cia_Population
WHERE population > (
    SELECT AVG(population) AS average_population
    FROM (
        SELECT TOP 5 population
        FROM SQLproject.dbo.cia_Population
        ORDER BY population DESC
    ) AS top_5_countries
);


--Which country has the least number of people?
select Top 1 country, population
from SQLproject.dbo.cia_Population
Where population is not Null 
order by population 

--Which top 5 countries are witnessing the highest population growth?

Select Top 5 country, population_growth_rate
from SQLproject.dbo.cia_Population
order by population_growth_rate desc

--Find population grownth of Canada
Select country, population_growth_rate
From SQLproject.dbo.cia_Population
Where country = 'Canada'

-- find country with lowest internet users

Select Top 1 country, internet_users
from SQLproject.dbo.cia_Population
Where internet_users is not Null
order by internet_users 

--Top 5 most densely populated country in the world.
-- In this query, the CASE statement checks if "land_area" is zero. 
--If it is, it returns NULL; otherwise, it performs the division. 
--We also include WHERE land_area IS NOT NULL AND land_area > 0 to filter out any NULL or zero values in the "land_area" column.

SELECT TOP 5 country, population, area,
       CASE WHEN area = 0 THEN NULL
            ELSE population * 1.0 / area END AS population_density
FROM SQLproject.dbo.cia_Population
WHERE area IS NOT NULL AND area > 0
ORDER BY population_density DESC;

--Find top 5 countries with highest birthrate
Select Top 5 country, birth_rate
from SQLproject.dbo.Cia_Birthrate
order by birth_rate desc

--find top 5 country with lowest birthrate
Select Top 5 country, birth_rate
from SQLproject.dbo.Cia_Birthrate
where birth_rate is not Null
order by birth_rate 

--Find top 5 countries with highest maternal mortality rate
Select Top 5 country, maternal_mortality_rate
from SQLproject.dbo.Cia_Birthrate
order by maternal_mortality_rate desc

-- Average maternal mortality rate of top 5 countries with highest mortality rate
select AVG(maternal_mortality_rate) as mortalityrate
from (Select Top 5 country, maternal_mortality_rate
      from SQLproject.dbo.Cia_Birthrate
       order by maternal_mortality_rate desc) As Top_5_countries
	-- join 
SELECT p.country, population, birth_rate, maternal_mortality_rate
FROM SQLproject.dbo.cia_Population p
INNER JOIN SQLproject.dbo.Cia_Birthrate b ON p.country = b.country;