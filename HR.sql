SELECT * FROM HR.EMPLOYEES;

WITH emp AS(
SELECT E.EMPLOYEE_ID,E.FIRST_NAME EMPLOYEES_NAME, E.MANAGER_ID FROM HR.EMPLOYEES E)
SELECT emp.*,m.First_name MANAGER_NAME FROM emp, hr.employees m
Where emp.manager_id = m.employee_id
order by emp.employee_id;
