# Covid Portfolio Project
## Project Overview
- in this project we will analyse data of covid 19 pendamic in SQL Server. analyse total cases vs deaths and total vaccination

## Problem Statement
- analyse the total cases vs total vaccination from two diffent tables and join them by join statement in SQL
- Percenatage of total cases vs total deaths
- total cases percentage against total population of the country
- which country has the highest rate of covid cases and deaths
- highest death count per population
- Death Count by continent
- continent with highest death count per population
- Total Population Vs Vaccination
- Use CTE for vaccination percentage
- create Temp table for analyse the data

## Tools used in this project
- Microsost SQL Server (Data analysis)
- MS Excel (Data Source)

## Data Source
- Data Source use in this project excel sheets of covid 19 data from github website. here is data source link
https://ourworldindata.org/covid-deaths

### Microsoft SQL Data Analysis
- Percenatge of total deaths against total cases
```sql
select location, date, total_deaths, total_cases,
(total_deaths / total_cases)*100  as death_percentage
from CovidDeaths
where continent is not null
order by 1,2
```
---
- Total cases vs population
```sql
select location, date, population, total_cases,
(total_cases / population)*100  as total_cases_percentage
from CovidDeaths
where continent is not null
order by 1,2
```
---
- Which country has highest infection rate compare to population
```sql
select location,  population,max(total_cases) as max_cases,
max((total_cases / population)) *100 as percentage
from CovidDeaths
where continent is not null
group by location, population
order by percentage desc
```
---
- Countries with highest death count per population
```sql
select location,max(total_deaths) as max_deaths
from CovidDeaths
where continent is not null
group by location
order by max_deaths desc
```
---

- Death Count by continent
```sql
select continent,  max(total_deaths) as Totaldeathcount
from CovidDeaths
where continent is not null
group by  continent
order by Totaldeathcount desc
```
---  
- Continent with highest death count per population
```sql
Select continent,
max(total_deaths) as TotalDeaths
from CovidDeaths
where continent is not null
group by continent
order by TotalDeaths desc
```
---
- Global Numbers by Date
```sql
select date, sum(new_cases) as new_Cases,
SUM(new_deaths) as newdeaths, sum(new_deaths)/ 
sum(new_cases)* 100 as deathrate 
from CovidDeaths
where continent is not null
group by date
order by newdeaths desc
```
---
- Running Total of new vaccination by location
```sql
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
sum(vac.new_vaccinations) over (partition by dea.location order by dea.location, dea.date)
as Running_Total
from CovidDeaths dea
join CovidVaccinations vac
on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null and vac.new_vaccinations is not null
order by 1,2,3
```
---
- Use CTE for vaccination percentage with running total
```sql
with ctetable (continent, location, date, population, new_vaccinations, running_total)
as
(
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
select *, (running_total / population) *100 as percentage
from ctetable
```
---
- use Temp Table for analysis
```sql
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
```
---
- Create view for data visualization in tableau
```sql
create view percentagepopulationvaccinated as 
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
sum(vac.new_vaccinations) over (partition by dea.location order by dea.location, dea.date)
as Running_Total
from CovidDeaths dea
join CovidVaccinations vac
on dea.location = vac.location
and dea.date = vac.date
```
---
