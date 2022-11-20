#
# ECE356 - Lab 3
# Fall 2020

# Modify this file to achieve the requirements listed in Part 4-2 of the Lab 3
# specifications.

# use yelp_db_small;
# ...
# DROP INDEX IF EXISTS ...
# CREATE INDEX ...
# ...
DROP PROCEDURE IF EXISTS drop_idx_if_exists;

DELIMITER //
CREATE PROCEDURE drop_idx_if_exists()
BEGIN
	IF EXISTS (
      		SELECT *
            FROM INFORMATION_SCHEMA.STATISTICS
            WHERE TABLE_NAME = 'Review'
            AND INDEX_NAME = 'review_user_id'
            AND INDEX_SCHEMA='yelp_db_small'
        ) THEN
        BEGIN
			DROP INDEX review_user_id on Review;
        END;
	END IF;
END//
DELIMITER ;

CALL drop_idx_if_exists();

EXPLAIN SELECT ud.name, r.review_id, b.name as business_name
FROM User_data as ud
	INNER JOIN (
		Business as b RIGHT JOIN Review as r ON r.business_id = b.business_id
    ) ON r.user_id = ud.user_id
WHERE r.user_id='KGYM_D6JOkjwnzslWO0QHg';

SELECT ud.name, r.review_id, b.name as business_name
FROM User_data as ud
	INNER JOIN (
		Business as b RIGHT JOIN Review as r ON r.business_id = b.business_id
    ) ON r.user_id = ud.user_id
WHERE r.user_id='KGYM_D6JOkjwnzslWO0QHg';

CREATE INDEX review_user_id ON Review (user_id);

EXPLAIN SELECT ud.name, r.review_id, b.name as business_name
FROM User_data as ud
	INNER JOIN (
		Business as b RIGHT JOIN Review as r ON r.business_id = b.business_id
    ) ON r.user_id = ud.user_id
WHERE r.user_id='KGYM_D6JOkjwnzslWO0QHg';

SELECT ud.name, r.review_id, b.name as business_name
FROM User_data as ud
	INNER JOIN (
		Business as b RIGHT JOIN Review as r ON r.business_id = b.business_id
    ) ON r.user_id = ud.user_id
WHERE r.user_id='KGYM_D6JOkjwnzslWO0QHg';