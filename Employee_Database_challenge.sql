-- Retrieve the emp_no, first_name, and last_name columns from the Employees table.
SELECT emp_no,
	first_name,
	last_name
FROM employees;

-- Retrieve the title, from_date, and to_date columns from the Titles table.
SELECT title,
	from_date,
	to_date
	FROM titles;
	
-- Create a new table using the INTO clause.
-- Join both tables on the primary key.
-- Filter the data on the birth_date column to retrieve the employees who were born between 1952 and 1955.
-- Then, order by the employee number.
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
INTO retirement_titles
FROM employees as e
INNER JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no ASC;

-- Retrieve the employee number, first and last name, and title columns from the Retirement Titles table.
SELECT DISTINCT ON (emp_no) first_name,
	last_name,
	title
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no ASC,
		to_date DESC;

-- Retrieve the number of titles from the Unique Titles table.
SELECT COUNT (title)
FROM unique_titles;

-- Then, create a Retiring Titles table to hold the required information.
-- Group the table by title, then sort the count column in descending order.
SELECT COUNT (title), title
INTO retiring_titles
FROM unique_titles
GROUP BY (title)
ORDER BY COUNT(title) DESC;

-- Retrieve the emp_no, first_name, last_name, and birth_date columns from the Employees table.
-- Retrieve the from_date and to_date columns from the Department Employee table.
-- Retrieve the title column from the Titles table.
-- Use a DISTINCT ON statement to retrieve the first occurrence of the employee number
-- for each set of rows defined by the ON () clause.
-- Filter the data on the to_date column to all the current employees, 
-- then filter the data on the birth_date columns to get all the employees whose birth dates are between 
-- January 1, 1965 and December 31, 1965.
-- Order the table by the employee number.
SELECT DISTINCT ON (e.emp_no) e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title
INTO mentorship_eligibility
FROM employees as e
INNER JOIN dept_emp as de
ON e.emp_no = de.emp_no
INNER JOIN titles as t
ON e.emp_no = t.emp_no
WHERE de.to_date = ('9999-01-01')
	AND (birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY (e.emp_no);

