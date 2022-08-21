-- SQL stored procedure that allows you to obtain the average male and female salary per department within a certain salary range. 
DROP PROCEDURE IF EXISTS avg_salary_by_gender_depart;

DELIMITER $$
CREATE PROCEDURE avg_salary_by_gender_depart(IN min_salary FLOAT, IN max_salary FLOAT)
BEGIN
	SELECT e.gender, d.dept_name, AVG(s.salary) as avg_salary
	FROM 
		t_salaries s 
			JOIN 
		t_employees e ON s.emp_no = e.emp_no 
			JOIN 
		t_dept_emp de ON e.emp_no = de.emp_no 
			JOIN 
		t_departments d ON de.dept_no = d.dept_no
	WHERE s.salary BETWEEN min_salary AND max_salary
	GROUP BY d.dept_no, e.gender;
END$$

DELIMITER ;

call employees_mod.avg_salary_by_gender_depart(50000,90000)