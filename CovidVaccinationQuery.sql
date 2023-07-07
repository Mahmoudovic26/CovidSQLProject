--Joining Vacc with death 
select *
from PortfolioProject..CovidDeaths death
join PortfolioProject..CovidVaccinations vacc
	on death.location = vacc.location
	and death.date = vacc.date
where death.continent is not null and vacc.continent is not null
-- Total population to vaccination ratio per day 
select death.continent,death.location,death.date,population,vacc.new_vaccinations
from PortfolioProject..CovidDeaths death
join PortfolioProject..CovidVaccinations vacc
	on death.location = vacc.location
	and death.date = vacc.date
where death.continent is not null and vacc.continent is not null
-- Total population to vaccination 
select death.continent,death.location,death.date,population,vacc.new_vaccinations
,SUM(convert(int,vacc.new_vaccinations)) over (partition by death.location order by death.location,
death.date) as UpdatedVacc
from PortfolioProject..CovidDeaths death
join PortfolioProject..CovidVaccinations vacc
	on death.location = vacc.location
	and death.date = vacc.date
where death.continent is not null and vacc.continent is not null

--CTE for popvsvac
with VaccinatedRatio (continent,location,date,population,new_vaccinations,UpdatedVacc)
as
(
select death.continent,death.location,death.date,population,vacc.new_vaccinations
,SUM(convert(int,vacc.new_vaccinations)) over (partition by death.location order by death.location,
death.date) as UpdatedVacc
from PortfolioProject..CovidDeaths death
join PortfolioProject..CovidVaccinations vacc
	on death.location = vacc.location
	and death.date = vacc.date
where death.continent is not null and vacc.continent is not null
)
select *,(UpdatedVacc/population)*100 as vaccntaedperecnt
from VaccinatedRatio
--creating view
create view ViewData as 
select death.continent,death.location,death.date,population,vacc.new_vaccinations
,SUM(convert(int,vacc.new_vaccinations)) over (partition by death.location order by death.location,
death.date) as UpdatedVacc
from PortfolioProject..CovidDeaths death
join PortfolioProject..CovidVaccinations vacc
	on death.location = vacc.location
	and death.date = vacc.date
where death.continent is not null and vacc.continent is not null
