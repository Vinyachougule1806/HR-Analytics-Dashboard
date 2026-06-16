
create database HR;
use HR;


CREATE TABLE IF NOT EXISTS HR_1 (
    Age INT,
    Attrition VARCHAR(5),
    BusinessTravel VARCHAR(50),
    DailyRate INT,
    Department VARCHAR(50),
    DistanceFromHome INT,
    Education INT,
    EducationField VARCHAR(50),
    EmployeeCount INT,
    EmployeeNumber INT,
    EnvironmentSatisfaction INT,
    Gender VARCHAR(10),
    HourlyRate INT,
    JobInvolvement INT,
    JobLevel INT,
    JobRole VARCHAR(50),
    JobSatisfaction INT,
    MaritalStatus VARCHAR(20)
);

select * from HR_1;

CREATE TABLE HR_2 (
    EmployeeID        INT,
    MonthlyIncome     INT,
    MonthlyRate       INT,
    NumCompaniesWorked INT,
    Over18            VARCHAR(5),
    OverTime          VARCHAR(5),
    PercentSalaryHike INT,
    PerformanceRating INT,
    RelationshipSatisfaction INT,
    StandardHours     INT,
    StockOptionLevel  INT,
    TotalWorkingYears INT,
    TrainingTimesLastYear INT,
    WorkLifeBalance   INT,
    YearsAtCompany    INT,
    YearsInCurrentRole INT,
    YearsSinceLastPromotion INT,
    YearsWithCurrManager INT
);

select * from HR_2;
select * from HR_1;

-- HUMAN RESOURCE ATTRITION ---

## KPI ##

-- Total_Employees --
select count(EmployeeNumber) as Total_Employees
from HR_1;

-- Active Employees --
select concat(count(attrition), " K ") as Attrition_value
from HR_1
where attrition = "No";

-- Attrition employee  --
select concat(count(attrition), " K ") as Attrition_value 
from HR_1
where attrition = "Yes";


-- Attrition rate --
with a as
(
select count(attrition) as Leavers from HR_1
where attrition = "Yes" 
) 
select count(attrition) as Total_attrition,
 a.leavers,
concat(round((a.leavers / count(attrition)) * 100 ,2),"%") as Attrition_rate
from HR_1 , a
group by a.leavers; 

-- Average Age --
select round(avg(age), 0) as Average_Age from Hr_1;

-- Average Monthly Income --
select round(avg(MonthlyIncome), 2) as Monthly_Income from Hr_2;

-- Average Total Working Years --
select round(avg(TotalWorkingYears), 1) as Average_Total_Working_years from Hr_2;


-- Department wise Attrition rate --
SELECT Department,
    COUNT(*) AS Total_employees,
    COUNT(CASE WHEN attrition = 'Yes' THEN 1 END) AS Attrition_count,
    concat(ROUND(COUNT(CASE WHEN attrition = 'Yes' THEN 1 END) / COUNT(*) * 100, 2), "%") AS Attrition_rate
FROM HR_1
GROUP BY Department;


-- Average Hourly rate of Male Research Scientist --
Select  Gender, JobRole,
round(avg(HourlyRate),2) as Average_Hourly_rate
from HR_1
where JobRole = "Research Scientist"
AND Gender = "Male";


-- Average Working years for each Department --
select hr1. Department,
round(avg(TotalWorkingYears),1) as Average_Working_Yrs
from HR_2 as hr2
join HR_1 as hr1 on hr2.EmployeeID = hr1.EmployeeNumber
Group by hr1. Department;


-- JobRole v/s Work Life Balance --
select distinct(JobRole) from HR_1;
select WorkLifeBalance from HR_2;

Select hr1.JobRole,
round(avg(hr2.WorkLifeBalance),2) as Avg_WorkLife_Balance
from hr_1 as hr1
join hr_2 as hr2 on hr1.EmployeeNumber = hr2.EmployeeID
Group by hr1.JobRole
order by Avg_WorkLife_Balance desc;


-- Attrition rate v/s Monthly Income Stats --
select Attrition,
round(avg(MonthlyIncome),2)as Monthly_Income
from Hr_1 as hr1
join hr_2 as hr2 on hr1.EmployeeNumber = hr2.EmployeeID
group by Attrition;

-- Gender wise Attrition rate --
select Gender, 
	COUNT(*) AS Total_employees,
    COUNT(CASE WHEN attrition = 'Yes' THEN 1 END) AS Attrition_count,
	concat(ROUND(COUNT(CASE WHEN attrition = 'Yes' THEN 1 END) / COUNT(*) * 100, 2) ," % ") AS Attrition_rate
from Hr_1 as hr1
join Hr_2 as hr2 on hr1.EmployeeNumber = hr2.EmployeeID
group by Gender;

-- Attrition rate v/s Years Since Last Promotion --
select YearsSinceLastpromotion,
concat(round(avg(Case when h1.Attrition='Yes' then 1 else 0 end)*100,2 ), " % ") As Attrition_Rate 
from hr_1 as h1 
join hr_2 as h2 on h1.EmployeeNumber=h2.Employeeid 
group by YearsSincelastpromotion 
order by Attrition_rate desc;

