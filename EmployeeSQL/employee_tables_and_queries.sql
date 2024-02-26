CREATE TABLE Titles(
	title_id VARCHAR(10) NOT NULL PRIMARY KEY,
	title VARCHAR(30) NOT NULL
)
;

CREATE TABLE Employees (
	emp_no INT NOT NULL PRIMARY KEY,
	emp_title_id VARCHAR(10) NOT NULL,
	birth_date VARCHAR (20) NOT NULL,
	first_name VARCHAR(30) NOT NULL,
	last_name VARCHAR(30) NOT NULL,
	sex VARCHAR(2) NOT NULL,
	hire_date VARCHAR (20) NOT NULL,
	FOREIGN KEY (emp_title_id) REFERENCES Titles(title_id)
)
;


CREATE TABLE Salaries(
	emp_no INT NOT NULL,
	salary INT NOT NULL,
	PRIMARY KEY (emp_no, salary),
	FOREIGN KEY (emp_no) REFERENCES Employees (emp_no)
)
;

CREATE TABLE Departments(
	dept_no VARCHAR(10) NOT NULL PRIMARY KEY,
	dept_name VARCHAR(30) NOT NULL
)
;

CREATE TABLE Dept_manager(
	dept_no VARCHAR(10) NOT NULL,
	emp_no INT NOT NULL,
	PRIMARY KEY(dept_no, emp_no),
	FOREIGN KEY (dept_no) REFERENCES Departments(dept_no),
	FOREIGN KEY (emp_no) REFERENCES Employees(emp_no)
)
;

CREATE TABLE Dept_emp(
	emp_no INT NOT NULL,
	dept_no VARCHAR(10) NOT NULL,
	PRIMARY KEY (emp_no, dept_no),
	FOREIGN KEY (emp_no) REFERENCES Employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES Departments(dept_no)
)
;

SELECT * FROM Employees
SELECT * FROM Titles
SELECT * FROM Departments
SELECT * FROM Dept_manager
SELECT * FROM Salaries
SELECT * FROM Dept_emp

-- List the employee number, last name, first name, sex, and salary of each employee
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM Employees e 
LEFT JOIN Salaries s
ON e.emp_no = s.emp_no
;

-- List the first name, last name, and hire date for the employees who were hired in 1986
SELECT first_name, last_name, hire_date
FROM Employees
WHERE SPLIT_PART(hire_date, '/', 3) = '1986'
;

-- List the manager of each department along with their department number, department name, employee number, last name, and first name 
SELECT e.first_name, e.last_name, e.emp_no, d.dept_no, d.dept_name
FROM Dept_manager dm
INNER JOIN Employees e
ON e.emp_no = dm.emp_no
INNER JOIN Departments d
ON dm.dept_no = d.dept_no
;

-- List the department number for each employee along with that employee’s employee number, last name, first name, and department name 
SELECT de.emp_no, de.dept_no, e.last_name, e.first_name, d.dept_name
FROM Dept_emp de
LEFT JOIN Employees e
ON  de.emp_no = e.emp_no
LEFT JOIN Departments d
ON de.dept_no = d.dept_no
;

-- List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B
SELECT first_name, last_name, sex
FROM Employees
WHERE first_name = 'Hercules'
AND last_name LIKE 'B%'
;

-- List each employee in the Sales department, including their employee number, last name, and first name 
SELECT e.emp_no, e.last_name, e.first_name
FROM Dept_emp de
LEFT JOIN Employees e
ON de.emp_no = e.emp_no
LEFT JOIN Departments d
ON de.dept_no = d.dept_no
WHERE dept_name = 'Sales'
;

-- List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM Dept_emp de
LEFT JOIN Employees e
ON de.emp_no = e.emp_no
LEFT JOIN Departments d
ON de.dept_no = d.dept_no
WHERE dept_name = 'Sales' OR dept_name = 'Development'
;

-- List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name)
SELECT last_name, COUNT(last_name) AS "Last Name Frequency"
FROM Employees
GROUP BY last_name
ORDER BY "Last Name Frequency" DESC
;
