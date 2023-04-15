/*
Covid 19 Data Exploration 

Skills used: Joins, CTE's, Temp Tables, Windows Functions, Aggregate Functions, Creating Views, Converting Data Types

*/

-- SELECTING THE DATA WE'RE GOING TO BE USING --

SELECT location, date, total_cases, new_cases, total_deaths, population
FROM pfcovid..coviddeaths$
ORDER BY 1,2
;



-- Looking at Total Cases vs Total Deaths globally
-- Displays the percentage of mortality upon contracting COVID-19 in your nation.

SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS DeathPercentage
FROM pfcovid..coviddeaths$
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
GROUP BY location, population
ORDER BY PercentPopulationInfected DESC
;
