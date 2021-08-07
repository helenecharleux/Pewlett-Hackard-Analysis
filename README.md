# Pewlett-Hackard-Analysis

## 1. Overview of the project

Pewlett-Hackard is a big company with thousands of employees. Among the employees, the company already has baby boomers who are starting to retire. Pewlett-Hackard is looking toward the future to be prepared to face the silver tsunami. We have already extracted the list of the employees who are going to retire in the near future and we have grouped those data by department. 

The company is now asking us to go deeper in our analysis in order to build a strategy to face the future. Pewlett-Hackar is asking us the following information:
- determining the number of retiring employees per title,
- identifying employees who are eligible to participate in a mentorship program.

We will work on SQL and generate csv files to support Pewlett-Hackard in their human ressources strategy for the future.

## 2. Presentation of the results

### 2.1 The silver tsunami: 133.776 employees to be retired in the near future
Pewlett-Hackard has provided us with two databases, one with the list of the employees and the other one with their position in the company. Using the two databases, we were able to identify 133.776 employees born between 1952 and 1955 and who are going to be retired in the next years. The retirement_titles database is a record of the employees's names, title, and experience in their current role. 

![retirement_titles_extract](https://user-images.githubusercontent.com/85641189/128562087-12db6790-5d85-4c8e-afa8-d5f3a03fbe5f.png)

However, we have identified duplicates in this database because some employees had several titles, promotions... Removing the duplicates, the number of employees who are going to retire is 90.398 on a total number of employees of 300.024. The silver tsunami for Pewlett-Hackard is totalizing 30,1% of the total number of employees. It is important for the company to implement a plan to be able to face this challenge.

### 2.2 63,8% of the future retired employees have Senior roles

On the 90.398 employees to be retired, there is a high proportion of senior roles. 63,8% of the employees to be retired have a Senior Engineer or Senior staff position. 

![retirement_titles](https://user-images.githubusercontent.com/85641189/128565700-5a5bc031-94f7-4e14-933e-06592e4347af.png)

The company has to focuse on the following:
  - training the remaining employees on their technical skills in order to be able to face the silver tsunami,
  - training the junior Engineer and the junior Staff to be able to handle the Senior roles when the actual senior employees will be retired. 

### 2.3 A limited number of manager to be retired

We have to highlight that only two Manager positions are going to retire in the near future. Only 2 managers are going to retire in the near future on a total of 90.398 employees. The main issue for the company will be to prepare to technical employees to evolve to new roles once the silver tsunami is over.

### 2.4 1.549 employees are eligible to the mentorship program

To anticipate the silver tsunami, Pewlett-Hackard is working on mentorship program design for the employees born in 1965. Thanks to our analysis, we have found 1.549 employees elible to the mentorship program. 

## 3. Summary

### 3.1 More than 90.000 roles to be filled with the silver tsunami

The employees who are going to retire in the next few years are born between 1952 and 1955. We have identified a total of 90.398 employees. 

![retirement_titles_year](https://user-images.githubusercontent.com/85641189/128609122-a45001f5-0435-4228-8614-55efc56e01d0.png)

If the company will have an average of 22.000 employees retired per year for the four following years, the peak will be in two years. In two years, more than 23.000 employees, born between 1954 and 1955, will leave annually the company. 

In order to have a relevent mentorship program, we are completing our analysis with  new tables. We retrieve the list of employees with their title AND their department. It is now possible to highlight the departments with the strongest needs. Working department by department, the mentorship program should be focused on the competencies the most impacted by the silver tsunami. We completed the above analysis with the code below:

``` -- Retrieve the emp_no, and dept_no columns from the dept_emp table.
-- Join departments and dept_emp tables on the primary key for the employees with their actual position.
SELECT de.emp_no,
	de.dept_no,
	de.to_date,
	d.dept_name
INTO employee_dept_name
FROM dept_emp as de
INNER JOIN departments as d
ON (de.dept_no = d.dept_no)
WHERE de.to_date = ('9999-01-01');

-- Retrieve the department AND title for employees born between 1952 and 1955 for their actual position.
SELECT rt.emp_no,
	rt.first_name,
	rt.last_name,
	rt.birth_date,
	rt.title,
	rt.from_date,
	rt.to_date,
	edn.dept_name
-- INTO retirement_titles
FROM retirement_titles as rt
INNER JOIN employee_dept_name as edn
ON (rt.emp_no = edn.emp_no)
WHERE (rt.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
	AND (rt.to_date = ('9999-01-01'))
ORDER BY edn.dept_name ASC;

-- Create a new table to group by title and department for employee to be retired.
SELECT COUNT (title),
	title,
	dept_name
FROM retirement_titles_dept
GROUP BY (title, dept_name)
ORDER BY dept_name ASC;
```

The tables below present the results grouped by department and by title for each department.

![Titles_dept1](https://user-images.githubusercontent.com/85641189/128611560-107f0a94-9479-4d52-8592-d521d1a6a61f.png)
![Titles_dept2](https://user-images.githubusercontent.com/85641189/128611561-7031fab7-22c5-49ce-a0c3-527d548671b3.png)
![Titles_dept3](https://user-images.githubusercontent.com/85641189/128611562-27a17185-4eb6-4737-b9f5-e4f8e6512fde.png)

### 3.2 1.549 employees ready to mentor the next generation

Our analysis shows that Pewlett-Hackard only has 1.549 employees corresponding to the criteria to participate to the mentorship program. With a total number of 90.398 employees who are going to retire in the next few years, the proportion of employees alocated to the mentorship program is below any expectation. We advice the company to alocate a maximum of 3 persons to each mentor (data to be adjusted with a benchmarking on other companies). Anticipating the impact of the silver tsunami, it could be relevent to alocate around 30.000 employees in order to train the future generation to the senior positions to be filled.

We also advice the company to optimize the mentorship program. Instead of selecting the mentor on their birth date, it could be also relevent to check their current title and their department in order to be aligned with the future needs. 
