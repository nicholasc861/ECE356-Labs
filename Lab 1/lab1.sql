---- 1b
SELECT job, COUNT(*) as count FROM Employee GROUP BY job ORDER BY job asc;

---- 1e
SELECT deptID FROM Employee
  WHERE job = "engineer"
  GROUP BY deptID
  HAVING count(*) = (SELECT MAX(a.count) FROM (SELECT count(*) as count
  FROM Employee
  WHERE job = "engineer"
  GROUP BY deptID) a);

---- 1g
SELECT Employee.empID
FROM Employee 
WHERE Employee.salary = (
  SELECT MAX(e.salary) FROM 
	(SELECT * FROM
	Employee
	WHERE salary < (SELECT MAX(salary)
	FROM Employee)) 
  e)


---- 2a
SELECT empName, Employee.empID
FROM Employee LEFT JOIN Assigned
ON Employee.empID = Assigned.empID
WHERE Assigned.projID IS NULL;

---- 2e
SELECT projID, SUM(salary) as projectSalary
FROM Employee 
LEFT JOIN Assigned
ON Employee.empID = Assigned.empID
GROUP BY projID;

---- 3a
UPDATE Employee
LEFT JOIN Assigned a
ON a.empID = Employee.empID
LEFT JOIN Project p
ON p.projID = a.projID
SET salary = salary * 1.10
WHERE p.title = "compiler"


---- 3b
/*
Stephen
*/


---- 3c
/*
Ernest
*/


---- 3d
/*
Nick
*/