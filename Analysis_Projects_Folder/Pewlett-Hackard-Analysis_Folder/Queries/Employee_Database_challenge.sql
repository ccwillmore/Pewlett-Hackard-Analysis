-- Retrieve from employees table
SELECT emp_no, first_name, last_name
FROM employees;
-- Retrieve from titles table
SELECT title, from_date, to_date
FROM titles;
-- Create a new table 
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
INTO retirement_titles
FROM employees AS e
FULL OUTER JOIN titles AS t
ON (e.emp_no = t.emp_no)
WHERE e.birth_date between '1952-01-01' AND '1955-12-31'
ORDER BY e.emp_no;


-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title

INTO retirement_titles_current
FROM retirement_titles
ORDER BY emp_no, to_date DESC;

-- Group the employees ready to retire by most recent job title
SELECT COUNT(emp_no),
	title
INTO retiring_titles
FROM retirement_titles_current
GROUP BY title
ORDER BY count DESC;

-- retrieve data from employees table
SELECT emp_no, first_name, last_name, birth_date
FROM employees;
-- retrieve data from department employee table
SELECT from_date, to_date 
FROM dept_emp;
-- retrieve data from titles table
SELECT title
FROM titles;
-- Get the current title for each employee
SELECT DISTINCT ON (emp_no)
	emp_no,
	title
INTO employee_current_title_all
FROM titles
ORDER BY emp_no,to_date DESC;

-- Use joins and WHERE filtering to get a table of employees for the mentorship program
SELECT * FROM employees;
SELECT e.emp_no, 
	e.first_name, 
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	ect.title
INTO mentorship_eligibility
FROM employees AS e
LEFT JOIN dept_emp AS de
ON e.emp_no = de.emp_no
LEFT JOIN employee_current_title_all AS ect
ON e.emp_no = ect.emp_no
WHERE (de.to_date = '9999-01-01') AND (e.birth_date between '1965-01-01' AND '1965-12-31')
;