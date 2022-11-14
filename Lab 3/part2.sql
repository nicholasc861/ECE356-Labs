#
# ECE356 - Lab 3
# Fall 2020

# Modify this file to achieve the requirements listed in Part 2 of the Lab 3
# specifications.

DROP PROCEDURE IF EXISTS sp_pay_raise_kitchener;

CREATE PROCEDURE sp_pay_raise_kitchener()
BEGIN
	
	START TRANSACTION;
    SAVEPOINT BeforeRaise;
    
    UPDATE Employee
    LEFT JOIN Department
    ON Employee.deptID = Department.deptID
    LEFT JOIN Location
    ON Department.locID = Location.locID
    SET salary = salary * 1.03
    WHERE Location.cityName = "Kitchener";
    
    SELECT 0 AS StatusCode;
    IF EXISTS (
      SELECT *
      FROM Employee
      LEFT JOIN Department
      ON Employee.deptID = Department.deptID
      LEFT JOIN Location
      ON Department.locID = Location.locID
      WHERE Location.cityName = "Kitchener"
      AND Employee.salary > 50000
    ) THEN
    BEGIN
        ROLLBACK TO SAVEPOINT BeforeRaise;
        SELECT 1 AS StatusCode;
    END;
    END IF;
    
    COMMIT;
END
