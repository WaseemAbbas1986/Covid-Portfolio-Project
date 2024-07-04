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

## covid 19 Data analysis
- Percenatge of total deaths against total cases
``SQL
select sum(total_deaths) / SUM(total_cases)* 100 as percentage from CovidDeaths





  










# Car sales Report

---
### Project Overview
in this project we are focusing on
- Sales Overview
- Average Price Analysis
- Car Sold Matrix


---
### Problem Statement

- KPIs requirement
  - YTD Total Sales
  - MTD Total Sales
  - YoY growth in Total Sales
  - Diffrence between YTD sales and previous year-to-date (PYTD) Sales
- Average Price Analysis
  - YTD Average Price
  - MTD Average Price
  - YoY Growth in average price
  - Diffrence between YTD average price and PYTD average price
- Cars Sold Matrix
  - YTD Car Sold
  - MTD Car Sold
  - YoY Growth in car sold
  - Diffrence between YTD Car Sold and PYTD Car Sold 
- Charts Requirements
  - YTD sales Weekly Trend: Display a line chart illustrating the weekly trand of YTD sales. the X-Axis should represnt weeks and y-Axis should show the total sales amount
  - YTD Total Sales By Body Style: Visualize the distribution of YTD Total sales across diffrent car body style using a pie chart
  - YTD Total Sales By Color: Present the distribution of various car colors to the YTD Total sales through a pie chart
  - YTD Car Sold by dealer region: Show case YTD sales data based on diffrent dealer regions using a map chart to vusualize sales distribution geographicaly
  - Comopnay wise sales trand in Grid form: Provide a tabular grid that display the sales trand of each company. The grid should showcase the company name along with YTD Sales figure
  - details Grid showing all cars sales information : Create a detail Grid that present all relevent information for each car sale, including car model, body style, color, sales amount, dealer region, date etc
  - create and grod view dashboard displaying a table of all car details in power BI. This should allow a user to export the grid of varius filter applied

 ---
### About Data and Data Source 
In this report we have used "Car sales.csv" file. which contains 24000 rows and 16 columns
![Car sales](https://github.com/WaseemAbbas1986/Car-sales-Report-PowerBI/assets/168902203/6fea0c58-8460-4c80-88e7-27ec21cd0ae5)


---
### Tools
- MS Excel - Data Source
- Power BI - Creating Report and Dashboard


---
### car sales report with all relevent KPI and Charts

![Car Sales Dashboard](https://github.com/WaseemAbbas1986/Car-sales-Report-PowerBI/assets/168902203/12c316d4-657b-407c-80ec-4ffea6bcb14d)

 
 ---
 ### Car sales with all details

 ![Car Sales Details](https://github.com/WaseemAbbas1986/Car-sales-Report-PowerBI/assets/168902203/d97241ee-175f-4faa-a3d5-faab61699610)



