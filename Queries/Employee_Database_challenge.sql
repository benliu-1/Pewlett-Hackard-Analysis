CREATE TABLE employees (
	emp_no INT NOT NULL,
	birth_date DATE NOT NULL,
	first_name VARCHAR NOT NULL,
	last_name VARCHAR NOT NULL,
	gender VARCHAR NOT NULL,
	hire_date DATE NOT NULL,
	PRIMARY KEY (emp_no)
);

DROP TABLE titles;

CREATE TABLE titles (
	emp_no INT NOT NULL,
	title VARCHAR NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);

DROP TABLE retirement_info;

SELECT employees.emp_no, employees.first_name, employees.last_name, titles.title, titles.from_date, titles.to_date
INTO retirement_titles
FROM employees
LEFT JOIN titles ON employees.emp_no = titles.emp_no
WHERE employees.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY emp_no, to_date, from_date;

SELECT * FROM retirement_titles;

SELECT DISTINCT ON (emp_no) emp_no, first_name, last_name, title
INTO unique_titles
FROM retirement_info
WHERE to_date = '9999-01-01'
ORDER BY emp_no, to_date DESC;

SELECT * FROM unique_titles;

SELECT COUNT(emp_no) AS emp_count, title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY emp_count DESC;

SELECT * FROM retiring_titles;

CREATE TABLE dept_emp (
	emp_no INT NOT NULL,
	dept_no VARCHAR NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);

SELECT * FROM dept_emp;

SELECT DISTINCT ON (employees.emp_no) employees.emp_no, employees.first_name, employees.last_name, employees.birth_date, dept_emp.from_date, dept_emp.to_date, titles.title
INTO mentorship_eligibility
FROM employees
LEFT JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
LEFT JOIN titles ON employees.emp_no = titles.emp_no
WHERE dept_emp.to_date = '9999-01-01' AND employees.birth_date BETWEEN '1965-01-01' AND '1965-12-31'
ORDER BY employees.emp_no;

SELECT * FROM mentorship_eligibility;