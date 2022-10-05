---- 1b
SELECT job, COUNT(*) as count 
FROM Employee 
GROUP BY job 
ORDER BY job asc;

---- 1e
SELECT deptID 
FROM Employee
WHERE job = "engineer"
GROUP BY deptID
HAVING count(*) = (
  SELECT MAX(a.count) 
  FROM (
    SELECT count(*) as count
    FROM Employee
    WHERE job = "engineer"
    GROUP BY deptID
  ) as a
);


---- 1g
SELECT Employee.empID
FROM Employee 
WHERE Employee.salary = (
  SELECT MAX(e.salary) FROM 
	(SELECT *
  FROM Employee
	WHERE salary < (
    SELECT MAX(salary)
	  FROM Employee
    )
  ) as e
);


---- 2a
SELECT empName, Employee.empID
FROM Employee LEFT JOIN Assigned
ON Employee.empID = Assigned.empID
WHERE Assigned.projID IS NULL;

---- 2e
SELECT a.projID, SUM(a.salary) as projectSalary
FROM (
  (SELECT Assigned.projID, Employee.salary FROM Employee 
  LEFT JOIN Assigned
  ON Employee.empID = Assigned.empID)
  UNION 
  (SELECT NULL as projID, 0 as salary) 
) a
GROUP BY a.projID;

---- 3a
UPDATE Employee
LEFT JOIN Assigned a
ON a.empID = Employee.empID
LEFT JOIN Project p
ON p.projID = a.projID
SET salary = salary * 1.10
WHERE p.title = "compiler";


---- 3b
UPDATE Employee
	LEFT JOIN Department d
    ON d.deptID = Employee.deptID
SET Employee.salary = CASE
	WHEN d.location = "Waterloo" THEN Employee.salary * 1.08
    WHEN Employee.job = "janitor" THEN Employee.salary * 1.05
    ELSE Employee.salary
END;


---- 3c
ALTER TABLE Employee 
ADD shift varchar(5);


---- 3d
UPDATE Employee
  LEFT JOIN Assigned a
  	ON a.empID = Employee.empID
  LEFT JOIN Project p
  	ON p.projID = a.projID
SET Employee.shift = CASE
  WHEN (p.projID IS NULL) then ""
  WHEN (p.projID IS NOT NULL) and (Employee.empID % 2) = 0 THEN "DAY"
  WHEN (p.projID IS NOT NULL) and (Employee.empID % 2) != 0 THEN "NIGHT"
END;