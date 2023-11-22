create database hr
use hr

--import all the tables
select * from employee_survey_data
select * from general_data
select * from manager_survey_data

--Retrieve the total number of employees in the dataset.
SELECT count(EmployeeID) AS total_employees 
from general_data
#total number of employees are 4382

--List all unique job roles in the dataset.
SELECT DISTINCT(jobRole) 
AS unique_jobrole from 
general_data

--Find the average age of employees.
SELECT AVG(age) 
AS avg_employee_age 
from general_data

--Retrieve the names and ages of employees who have worked at the company for more than 5 years.
SELECT EmployeeID,Age 
from general_data 
where TotalWorkingYears > 5

--Get a count of employees grouped by their department.
SELECT Department, COUNT(*) AS Employee_Count
FROM general_data
GROUP BY Department

--List of employee having high job satisfaction.
SELECT EmployeeID,JobSatisfaction 
FROM employee_survey_data
WHERE JobSatisfaction=4

--Find the highest Monthly Income in the dataset.
SELECT MAX(MonthlyIncome) 
AS Highest_monthly_income
FROM general_data

--List employees who have 'Travel_Rarely' as their BusinessTravel type.
SELECT EmployeeID, BusinessTravel 
FROM general_data 
where BusinessTravel='Travel_Rarely'

--Retrieve the distinct MaritalStatus categories in the dataset.
SELECT DISTINCT(MaritalStatus) 
FROM general_data

--Get a list of employees with more than 2 years of work experience but less than 4 years in their current role.
SELECT * FROM general_data
WHERE TotalWorkingYears > 2 AND TotalWorkingYears < 4
AND YearsWithCurrManager >= 2 AND YearsWithCurrManager < 4

--List employees who have changed their job roles within the company (JobLevel and JobRole differ from their previous job).
SELECT x.EmployeeID, x.JobRole AS current_job_role, y.JobRole as Previous_job_role,
x.JobLevel as current_job_level,y.JobLevel as previous_job_level
from general_data x JOIN general_data y on x.EmployeeID=y.EmployeeID 
where x.JobRole!=y.JobRole and x.JobLevel!=y.JobLevel

--Find the average distance from home for employees in each department.
SELECT Department, AVG(DistanceFromHome) AS avg_distance
 FROM general_data GROUP BY Department
 
 --Retrieve the top 5 employees with the highest MonthlyIncome.
 SELECT * FROM general_data 
 ORDER BY MonthlyIncome DESC LIMIT 5
 
 --Calculate the percentage of employees who have had a promotion in the last year.
SELECT count(*) as Total_employees, 
SUM(CASE WHEN YearsSinceLastPromotion=1 THEN 1 ELSE 0 END) AS promoted_last_year , 
(sum(case when YearsSinceLastPromotion=1 then 1 else 0 end)/count(*)) * 100 
as promotion_percentage from general_data

--List the employees with the highest and lowest EnvironmentSatisfaction.
SELECT EmployeeID,EnvironmentSatisfaction 
AS low_environment_satisfaction 
FROM employee_survey_data   
where EnvironmentSatisfaction=1

SELECT EmployeeID,EnvironmentSatisfaction 
AS High_environment_satisfaction 
FROM employee_survey_data   
where EnvironmentSatisfaction=4

--Find the employees who have the same JobRole and MaritalStatus.
select a.EmployeeID, a.JobRole,b.JobRole,a.MaritalStatus,b.MaritalStatus from general_data a JOIN general_data b on a.EmployeeID=b.EmployeeID
where a.JobRole=b.JobRole and a.MaritalStatus=b.MaritalStatus

--List the employees with the highest TotalWorkingYears who also have a PerformanceRating of 4.
select a.EmployeeID,a.Department,a.TotalWorkingYears,b.PerformanceRating from general_data a 
join manager_survey_data b on a.EmployeeID=b.EmployeeID where 
TotalWorkingYears = (select max(TotalWorkingYears) from general_data) and PerformanceRating=4

--Calculate the average Age and JobSatisfaction for each BusinessTravel type
select a.BusinessTravel,avg(a.age) as AVG_age,avg(b.Jobsatisfaction) as AVG_job_satisfaction 
from general_data a join employee_survey_data b on 
a.EmployeeID=b.EmployeeID group by a.BusinessTravel

--Retrieve the most common EducationField among employees.
select EducationField,count(*) as fieldcounts from general_data group by EducationField order by count(*) desc limit 1 offset 0

--List the employees who have worked for the company the longest but have not had a promotion.
SELECT * from general_data where 
YearsAtCompany=(select max(YearsAtCompany) from general_data) and YearsSinceLastPromotion=0

