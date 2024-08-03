use portfolio_projects;
select * from human_resources;

ALTER TABLE human_resources
change column ï»¿id emp_id varchar(20) null;

desc human_resources;

select birthdate from human_resources;

UPDATE human_resources  -- USing UPDATE function corrected the birthdate column date format.
SET birthdate = 
    CASE
        WHEN birthdate LIKE '%-%-%' THEN STR_TO_DATE(birthdate, '%d-%m-%Y')
        WHEN birthdate LIKE '%/%/%' THEN STR_TO_DATE(birthdate, '%m/%d/%Y')
        ELSE STR_TO_DATE(birthdate, '%Y-%m-%d')
    END;

ALTER TABLE human_resources  -- Using ALTER TABLE function date column type change text to date.
MODIFY COLUMN birthdate DATE;

select birthdate from human_resources;

UPDATE human_resources  -- USing UPDATE function corrected the hire_date column date format.
SET hire_date = 
    CASE
        WHEN hire_date LIKE '%-%-%' THEN STR_TO_DATE(hire_date, '%d-%m-%Y')
        WHEN hire_date LIKE '%/%/%' THEN STR_TO_DATE(hire_date, '%m/%d/%Y')
        ELSE STR_TO_DATE(hire_date, '%Y-%m-%d')
    END;
    
select hire_date from human_resources;

UPDATE human_resources
SET termdate = IF(termdate IS NOT NULL AND termdate != '', date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC')), '0000-00-00')
WHERE true;

SELECT termdate from human_resources;

SET sql_mode = 'ALLOW_INVALID_DATES';

ALTER TABLE human_resources
MODIFY COLUMN termdate DATE;

select termdate from human_resources;

ALTER TABLE human_resources
MODIFY COLUMN termdate DATE;

ALTER TABLE human_resources
MODIFY COLUMN hire_date DATE;

desc human_resources;

ALTER TABLE human_resources
add column age int;

select * from human_resources;

UPDATE human_resources
set age = timestampdiff(YEAR, birthdate, curdate());

select birthdate, age from human_resources;

select 
 MIN(age) AS youngest,
 MAX(age) As oldest
FROM human_resources;

SELECT count(*) FROM human_resources WHERE age < 18;

-- 1. What is the gender breakdown of employees in the company?
SELECT gender, count(*) AS count
from human_resources
where age >= 18 AND termdate = '0000-00-00'
group by gender;

-- 2. What is the race/ethnicity breakdown of employees in the company?
select race, count(*) As count
from human_resources
where age >= 18 AND termdate = '0000-00-00'
group by race
order by count(*) desc;

-- 3. What is the age distribution of employees in the company?
select
 min(age) As youngest,
 max(age) As oldest
from human_resources
where age >= 18 AND termdate = '0000-00-00';

select 
 case
  when age >= 18 and age <= 24 then '18-24'
  when age >= 25 and age <= 34 then '25-34'
  when age >= 35 and age <= 44 then '35-44'
  when age >= 45 and age <= 54 then '45-54'
  when age >= 55 and age <= 64 then '55-64'
  else '65+'
end as age_group,
count(*) As count
from human_resources
where age >= 18 AND termdate = '0000-00-00'
group by age_group
order by age_group;

select 
 case
  when age >= 18 and age <= 24 then '18-24'
  when age >= 25 and age <= 34 then '25-34'
  when age >= 35 and age <= 44 then '35-44'
  when age >= 45 and age <= 54 then '45-54'
  when age >= 55 and age <= 64 then '55-64'
  else '65+'
end as age_group, gender,
count(*) As count
from human_resources
where age >= 18 AND termdate = '0000-00-00'
group by age_group, gender
order by age_group, gender;

-- 4. How many employees work at headquaters vs. remote locations?
select location, count(*) As count
from human_resources
where age >= 18 AND termdate = '0000-00-00'
group by location;

-- 5. What is the average length of employmnet for emplyoess. Who have been terminated?
select
 round(avg(datediff(termdate, hire_date))/365, 0) As avg_length_employmnet
from human_resources
where termdate <= curdate() and termdate <> '0000-00-00' and age >= 18;

 -- 6. How does the gender distribution vary across department and job titles?
 select department, gender, count(*) As count
 from human_resources
 where age >= 18 AND termdate = '0000-00-00' 
 group by department, gender
 order by department;
 
 -- 7. What is the distribution of job titles across the company?
 select jobtitle, count(*) as count
 from human_resources
 where age >= 18 AND termdate = '0000-00-00'
 group by jobtitle
 order by jobtitle;
 
-- 8. which department has the highest turnover rate?
select department,
 total_count,
 terminated_count,
 terminated_count/total_count as termination_rate
from(
 select department,
 count(*) As total_count,
 sum(case when termdate <> '0000-00-00' and termdate <= curdate() then 1 else 0 end) as terminated_count
 from human_resources
 where age >= 18
 group by department
 ) as subquery
order by termination_rate desc;

-- 9. What is the distribution of employees across locations by city and state?
select location_state, count(*) as count
from human_resources
where age >= 18 AND termdate = '0000-00-00'
group by location_state
order by count desc;

-- 10. How has the company's employee count changed over time based on hire and term dates?
select 
 year,
 hires,
 terminations,
 hires - terminations as net_change,
 round((hires - terminations)/hires * 100, 2) as net_change_percent
from(
 select 
  year(hire_date) as year,
  count(*) as hires,
  sum(case when termdate <> '0000-00-00' and termdate <= curdate() then 1 else 0 end) as terminations
  from human_resources
  where age >= 18
  group by year(hire_date)
  ) as subquery
order by year asc;

-- 11. What is the tenure distribution for each department?
select department, round(avg(datediff(termdate, hire_date)/365),0) as avg_tenure
from human_resources
where termdate <= curdate() and termdate <> "0000-00-00" and age >= 18
group by department;