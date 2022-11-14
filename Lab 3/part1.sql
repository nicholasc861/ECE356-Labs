#
# ECE356 - Lab 3
# Fall 2022

# Modify this file to achieve the requirements listed in Part 1 of the Lab 3
# specifications.

DROP PROCEDURE IF EXISTS sp_pay_raise;

CREATE PROCEDURE sp_pay_raise (IN inEmpID int, IN inPercentageRaise FLOAT(4,2), OUT errorCode INT)
BEGIN 
    SET errorCode = 0;
    IF inPercentageRaise > 0.1 AND inEmpID NOT IN (SELECT empID FROM Employee) THEN
        SET errorCode = -3;
    ELSEIF inPercentageRaise <= 0.1 AND inPercentageRaise > 0 AND inEmpID NOT IN (SELECT empID FROM Employee) THEN
        SET errorCode = -2;
    ELSEIF inPercentageRaise > 0.1 AND inEmpID IN (SELECT empID FROM Employee) THEN
        SET errorCode = -1;
    ELSE
        UPDATE Employee  
        SET salary = salary * (1+inPercentageRaise)
        WHERE empID = inEmpID;
    END IF;
END;
