/*
Covid 19 Data Exploration 

Skills used: Joins, CTE's, Temp Tables, Windows Functions, Aggregate Functions, Creating Views, Converting Data Types

*/

-- SELECTING THE DATA WE'RE GOING TO BE USING --
-- Continent can not be NULL, will return continent values for location.

SELECT location, date, total_cases, new_cases, total_deaths, population
FROM pfcovid..coviddeaths$
WHERE continent IS NOT NULL
ORDER BY 1,2
;



-- Looking at Total Cases vs Total Deaths globally
-- Displays the percentage of mortality upon contracting COVID-19 in your nation.

SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS DeathPercentage
FROM pfcovid..coviddeaths$
WHERE continent IS NOT NULL
ORDER BY 1,2
;




-- Looking at Total Cases vs Total Deaths in US.
-- Death percentage increased significantly from the end of March - April.

SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS DeathPercentage
FROM pfcovid..coviddeaths$
WHERE location LIKE 'United States'
ORDER BY 1,2
;



-- Looking at the Total Cases vs Population in US.
-- Displays percentage of population who conctracted COVID-19.

SELECT location, date, population, total_cases, (total_cases/population)*100 AS PercentPopulationInfected
FROM pfcovid..coviddeaths$
WHERE location LIKE 'United States'
ORDER BY 1,2
;



-- Examining the Country with the Highest Infection Rate in relation to its Population

SELECT location, population, MAX(total_cases) AS HighestInfectionCount, MAX((total_cases/population))*100
AS PercentPopulationInfected
FROM pfcovid..coviddeaths$
WHERE continent IS NOT NULL
GROUP BY location, population
ORDER BY PercentPopulationInfected DESC
;



-- Showing Countries with Highest Death Count 

SELECT location, MAX(CAST(total_deaths AS INT)) AS TotalDeathCount
FROM pfcovid..coviddeaths$
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY TotalDeathCount DESC
;



-- Showing the Continents with Highest Death Count

SELECT continent, MAX(CAST(total_deaths AS INT)) AS TotalDeathCount
FROM pfcovid..coviddeaths$
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY TotalDeathCount DESC
;



-- GLOBAL NUMBERS

SELECT date, SUM(new_cases) AS total_cases, SUM(CAST(new_deaths AS INT)) AS total_deaths, SUM(CAST(new_deaths AS INT))/
SUM(new_cases)*100 AS DeathPercentage
FROM pfcovid..coviddeaths$
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY 1,2
;
