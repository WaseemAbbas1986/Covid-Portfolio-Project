use covidportfolio

select * from CovidDeaths

select sum(total_deaths) / SUM(total_cases)* 100 as percentage from CovidDeaths

-- percentage of deaths against total cases

select location, date, total_deaths, total_cases,
(total_deaths / total_cases)*100  as death_percentage
from CovidDeaths
where continent is not null
order by 1,2

-- Total cases vs population
select location, date, population, total_cases,
(total_cases / population)*100  as total_cases_percentage
from CovidDeaths
where continent is not null
order by 1,2

--Which country has highest infection rate compare to population

select location,  population,max(total_cases) as max_cases,
max((total_cases / population)) *100 as percentage
from CovidDeaths
where continent is not null
group by location, population
order by percentage desc

-- showing countries with highest death count per population

select location,max(total_deaths) as max_deaths
from CovidDeaths
where continent is not null
group by location
order by max_deaths desc

-- Death Count by continent

select continent,  max(total_deaths) as Totaldeathcount
from CovidDeaths
where continent is not null
group by  continent
order by Totaldeathcount desc

-- continent withHighest death count per population

Select continent,
max(total_deaths) as TotalDeaths
from CovidDeaths
where continent is not null
group by continent
order by TotalDeaths desc

-- Global numbers by date

select date, sum(new_cases) as new_Cases,
SUM(new_deaths) as newdeaths, sum(new_deaths)/ 
sum(new_cases)* 100 as deathrate 
from CovidDeaths
where continent is not null
group by date
order by newdeaths desc

-- Total Population Vs Vaccination

select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
sum(vac.new_vaccinations) over (partition by dea.location order by dea.location, dea.date)
as Running_Total
from CovidDeaths dea
join CovidVaccinations vac
on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null and vac.new_vaccinations is not null
order by 1,2,3

-- Use CTE for vaccination percentage

with ctetable (continent, location, date, population, new_vaccinations, running_total)
as
(
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
sum(vac.new_vaccinations) over (partition by dea.location order by dea.location, dea.date)
as Running_Total
from CovidDeaths dea
join CovidVaccinations vac
on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null and
vac.new_vaccinations is not null
--order by 1,2,3
)
select *, (running_total / population) *100
from ctetable

--Temp table
drop table if exists #percentagepopulationvaccinated
create table #percentagepopulationvaccinated
(continent varchar(255),
location varchar(255),
date datetime,
population numeric,
new_vaccinations numeric,
running_total numeric
)
insert into #percentagepopulationvaccinated
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
sum(vac.new_vaccinations) over (partition by dea.location order by dea.location, dea.date)
as Running_Total
from CovidDeaths dea
join CovidVaccinations vac
on dea.location = vac.location
and dea.date = vac.date
--where dea.continent is not null and
--vac.new_vaccinations is not null
--order by 1,2,3

select *, (running_total / population) *100
from #percentagepopulationvaccinated


--creating view

create view percentagepopulationvaccinated as 
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
sum(vac.new_vaccinations) over (partition by dea.location order by dea.location, dea.date)
as Running_Total
from CovidDeaths dea
join CovidVaccinations vac
on dea.location = vac.location
and dea.date = vac.date
--where dea.continent is not null and
--vac.new_vaccinations is not null
--order by 1,2,3

select * from percentagepopulationvaccinated