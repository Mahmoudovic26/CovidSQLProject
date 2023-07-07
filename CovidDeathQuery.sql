select *
from PortfolioProject..CovidDeaths
where continent is not Null
------------------------------------------
select Location,date, total_cases,new_cases,total_deaths,(total_deaths/total_cases)*100 as DeathToCasePercentage
from PortfolioProject..CovidDeaths
where continent is not null 
order by 1,2
-- Total cases vs population 
select Location,date,population,total_cases,(total_cases/population)*100 as CasesToPopPercentage
from PortfolioProject..CovidDeaths
order by 1,2
-- Higheest Infected Country rate compared to population
select Location,population, max(total_cases) as HighestInfCount,max((total_cases/population))*100 as highestCountry
from PortfolioProject..CovidDeaths
where continent is not null 
group by location,population
order by highestCountry desc
 -- Higheest death count Country rate compared to population
select Location,population, max(total_deaths) as HighestDeathCount
from PortfolioProject..CovidDeaths
where continent is not null 
group by location,population
order by HighestDeathCount desc
-- showing the total death  by Continent 
select Location,max(total_deaths) as TotDeathCont
from PortfolioProject..CovidDeaths
where continent is null
group by location
order by TotDeathCont desc
-- Global numbers according to date 
select date,sum(new_cases) as TotalNewCases,SUM(new_deaths) as TotalDeaths ,(SUM(new_deaths)/sum(new_cases))*100 as Percen
from PortfolioProject..CovidDeaths
where continent is not null 
group by date 
order by 1,2
--Over all global numbers
select sum(new_cases) as TotalNewCases,SUM(new_deaths) as TotalDeaths ,(SUM(new_deaths)/sum(new_cases))*100 as Percen
from PortfolioProject..CovidDeaths
where continent is not null 
order by 1,2
