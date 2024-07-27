create database Population;
use population;
show tables;

select * from world_population;

create table new_world like world_population;

insert into new_world 
select * from world_population;

select * from new_world;

WITH new_cte AS (
    SELECT *,
           ROW_NUMBER() OVER(
               PARTITION BY `Rank`, `CCA3`, `Country/Territory`, `Capital`, `Continent`, 
                            `2022 Population`, `2020 Population`, `2015 Population`, 
                            `2010 Population`, `2000 Population`, `1990 Population`, 
                            `1980 Population`, `1970 Population`, `Area (kmÂ²)`, 
                            `Density (per kmÂ²)`, `Growth Rate`, `World Population Percentage`
           ) AS row_num
    FROM new_world
)
select * from new_cte;

CREATE TABLE `new_world2` (
  `Rank` int DEFAULT NULL,
  `CCA3` text,
  `Country/Territory` text,
  `Capital` text,
  `Continent` text,
  `2022 Population` int DEFAULT NULL,
  `2020 Population` int DEFAULT NULL,
  `2015 Population` int DEFAULT NULL,
  `2010 Population` int DEFAULT NULL,
  `2000 Population` int DEFAULT NULL,
  `1990 Population` int DEFAULT NULL,
  `1980 Population` int DEFAULT NULL,
  `1970 Population` int DEFAULT NULL,
  `Area (kmÂ²)` int DEFAULT NULL,
  `Density (per kmÂ²)` double DEFAULT NULL,
  `Growth Rate` double DEFAULT NULL,
  `World Population Percentage` double DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

insert into new_world2
 SELECT *,
           ROW_NUMBER() OVER(
               PARTITION BY `Rank`, `CCA3`, `Country/Territory`, `Capital`, `Continent`, 
                            `2022 Population`, `2020 Population`, `2015 Population`, 
                            `2010 Population`, `2000 Population`, `1990 Population`, 
                            `1980 Population`, `1970 Population`, `Area (kmÂ²)`, 
                            `Density (per kmÂ²)`, `Growth Rate`, `World Population Percentage`
           ) AS row_num
    FROM new_world ;
    
select * from new_world2;

delete from new_world2 
where row_num > 1 ;

select * from new_world2;

alter table new_world2
drop row_num;

Alter table new_world2
rename column `Country/Territory` to Country;

Alter table new_world2
rename column `Area (kmÂ²)` to `Area`;

Alter table new_world2
rename column `Density (per kmÂ²)` to Density;

-- country having highest population in respective years
select `Rank`,Country,max(`World Population Percentage`) as maximum_population 
from new_world2
group by `Rank`,Country
order by maximum_population desc;

-- country having least population  in 2022
select `Rank`,Country, min(`2022 Population`) as minimum_population_in_2022
from new_world2
group by `Rank`,Country
order by minimum_population_in_2022;

-- highest population growth
select `Rank`,country,max(`Growth Rate`) as maximum_growth_rate
from new_world2
group by `Rank`,country
order by maximum_growth_rate desc;

select * from new_world2;

alter table new_world2
rename column `2022 Population` to Population2022;

select `Rank`,Country,Capital,
case
when Population2022 > 218541212 then "Extraordiory"
when Population2022 < 218541212 then "Average"
else "ordinary"
end as new_population
from new_world2
order by new_population;

select * from new_world2;

-- most populated country in the world
select Country,max(`Population2022`) as maximum_population,`World Population Percentage`
from new_world
group by Country,`World Population Percentage`
limit 1;

describe new_world2;


