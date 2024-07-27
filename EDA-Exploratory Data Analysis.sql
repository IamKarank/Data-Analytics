show databases;
use data_analytics;

use layoff_schema;
select * from layoff_stages2;

-- finding maximun of laid off in a day
select max(total_laid_off) as maximum_people_laid_off_in_a_day from layoff_stages2;

-- finding sum of total layoffs by company and its location
select company,sum(total_laid_off) as sum,location from layoff_stages2
group by company,location 
order by sum desc;

-- finding sum of total layoffs by industry
select industry, sum(total_laid_off) as sum,location from layoff_stages2
group by industry,location
order by sum desc;

-- finding the sum of total layoffs by the country
select country, sum(total_laid_off) as total_sum from layoff_stages2
group by country
order by total_sum desc;

-- finding the sum of total layoffs by company in a year with help of date column
select company, max(total_laid_off) as max_layoffInYear from layoff_stages2
group by company,`date`
having `date`> '2022-01-01' and `date`< '2023-01-01'
order by `date`desc ;

-- finding the sum of total layoffs by a company in year using year function of mysql
select company, year(`date`) as year,sum(total_laid_off) as total_layoff_in_world 
from layoff_stages2
group by company, year(`date`)
order by total_layoff_in_world desc;

 -- finding the sum of total layoffs in a year with help of year function
select year(`date`) as Yearly , sum(total_laid_off) as total_layoff_in_world
from layoff_stages2
group by year(`date`)
order by total_layoff_in_world desc;

-- finding sum of total layoff by stages
select stage, sum(total_laid_off) as total_layoff_by_stage_of_the_company
from layoff_stages2
group by stage
order by total_layoff_by_stage_of_the_company desc;

-- finding sum of total layoff by stages by the list of companies
select company,stage, sum(total_laid_off) as total_layoff_by_company
from layoff_stages2
group by company,stage
order by total_layoff_by_company desc;

-- findig the sum of total layoffs by month
select substring(`date`,6,2) as `month`, sum(total_laid_off) as total_layoffs_by_month
from layoff_stages2
group by `month`
order by `month` desc;

-- finding the sum of total layoffs my year
select substring(`date`,1,4)  as `year`, sum(total_laid_off) as Total_By_Year
from layoff_stages2
group by `year`
order by Total_By_Year desc;

-- finding sum of total layoffs by month of year
select substring(`date`,1,7) as month_and_year , sum(total_laid_off) as total_layoff_by_month_year
from layoff_stages2
group by month_and_year
order by month_and_year;

-- finding the rolling total of layoffs of total layoffs column with help of cte
with rollcte as 
(
select substring(`date`,1,7) as year_and_month, sum(total_laid_off) as total_layoff
from layoff_stages2
group by year_and_month
order by total_layoff desc
)
select year_and_month, total_layoff as monthly_layoff,
sum(total_layoff) over(order by year_and_month) as rolling_sum
from rollcte;

-- finding the sum of total layoffs by company and year with cte
with scte as 
(
select company, year(`date`) as year1 , sum(total_laid_off) as total_layoff
from layoff_stages2
group by company,year1
order by year1
)
select * from scte
where year1 is not null;