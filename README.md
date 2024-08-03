# Human Resources Employee Distribution Report

![HR1](https://github.com/user-attachments/assets/be56af8d-598f-4807-bb5f-9382ea1fabfb)
![HR2](https://github.com/user-attachments/assets/62fd3d09-517f-475f-8e3f-1c108ec38fd3)

# Data Used
- Data – HR Data with over 22,000 rows from the year 2000 to 2020
- Data Cleaning & Analysis – MySQL
- Data Visualization – Power BI

# Answered 11 questions:
1. What is the gender breakdown of employees in the company?
2. What is the company's race/ethnicity breakdown of employees?
3. What is the age distribution of employees in the company?
4. How many employees work at headquarters vs. remote locations?
5. What is the average length of employment for employees? Who has been terminated?
6. How does the gender distribution vary across departments and job titles?
7. What is the distribution of job titles across the company?
8. which department has the highest turnover rate?
9. What is the distribution of employees across locations by city and state?
10. How has the company's employee count changed based on hire and term dates?
11. What is the tenure distribution for each department?

# Summary of Findings
-	There are more male employees
-	White race is the most dominant while Native Hawaiian and American Indians are the least dominant.
-	The youngest employee is 20 years old and the oldest is 57 years old.
-	5 age groups were created (18-24, 25-34, 35-44, 45-54, 55-64). A large number of employees were between 25-34 followed by 35-44 while the smallest group was 55-64.
-	A large number of employees work at the headquarters versus remotely.
-	The average length of employment for terminated employees is around 7 years.
-	The gender distribution across departments is fairly balanced but there are generally more male than female employees.
-	The Marketing department has the highest turnover rate followed by Training. The Research and Development, Support and Legal department has the lowest turnover rate.
-	A large number of employees come from the state of Ohio.
-	The net change in employees has increased over the years.
-	The average tenure for each department is about 98 years with Legal and Auditing having the highest and Services, Sales, and Marketing having the lowest.

# Limitations
-	Some records had negative ages, and these were excluded during querying (967 records). The ages used were 18 years and above.
-	Some term dates were far into the future and were not included in the analysis (1599 records). The only term dates used were those less than or equal to the current date.
