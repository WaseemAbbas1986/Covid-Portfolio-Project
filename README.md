# Covid Portfolio Project (SQL and Power BI)
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
---
### Microsoft SQL Data Analysis
- Percenatge of total deaths against total cases
```sql
select location, date, total_deaths, total_cases,
(total_deaths / total_cases)*100  as death_percentage
from CovidDeaths
where continent is not null
order by 1,2
```
![Capture](https://github.com/WaseemAbbas1986/Covid-Portfolio-Project/assets/168902203/f02f917a-d14f-45ab-9c81-c80557390bce)

---
- Total cases vs population
```sql
select location, date, population, total_cases,
(total_cases / population)*100  as total_cases_percentage
from CovidDeaths
where continent is not null
order by 1,2
```
![2](https://github.com/WaseemAbbas1986/Covid-Portfolio-Project/assets/168902203/d1d15caf-440f-49f4-a055-d37d3b85688f)

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
![3](https://github.com/WaseemAbbas1986/Covid-Portfolio-Project/assets/168902203/133e3214-f0ad-43bc-903b-bc9e04f6fc71)

---
- Countries with highest death count per population
```sql
select location,max(total_deaths) as max_deaths
from CovidDeaths
where continent is not null
group by location
order by max_deaths desc
```
![4](https://github.com/WaseemAbbas1986/Covid-Portfolio-Project/assets/168902203/bc2cca26-3de2-4a78-87d0-248e2b84814f)

---

- Death Count by continent
```sql
select continent,  max(total_deaths) as Totaldeathcount
from CovidDeaths
where continent is not null
group by  continent
order by Totaldeathcount desc
```
![5](https://github.com/WaseemAbbas1986/Covid-Portfolio-Project/assets/168902203/2a47af91-3841-4d46-9abe-9e350f039d49)

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
![6](https://github.com/WaseemAbbas1986/Covid-Portfolio-Project/assets/168902203/e14910d7-2565-4dc0-a67b-f3eda3a2e9b3)

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
![7](https://github.com/WaseemAbbas1986/Covid-Portfolio-Project/assets/168902203/5dd102e7-291b-4882-aa5e-43744af10d30)

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
![8](https://github.com/WaseemAbbas1986/Covid-Portfolio-Project/assets/168902203/520fac38-9f26-4c3d-b7e7-a0ea83f1755e)

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
![9](https://github.com/WaseemAbbas1986/Covid-Portfolio-Project/assets/168902203/ab163d67-46e9-4b2f-9dae-fdff40c72828)

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
![10](https://github.com/WaseemAbbas1986/Covid-Portfolio-Project/assets/168902203/7842970f-c84b-46f2-809d-12ff50d42f89)

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
![11](https://github.com/WaseemAbbas1986/Covid-Portfolio-Project/assets/168902203/fe5c6128-0c50-4948-b093-7ed45cf24ee5)

---
