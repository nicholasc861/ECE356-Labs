#
# ECE356 - Lab 3
# Fall 2020

# Modify this file to achieve the requirements listed in Part 4-1 of the Lab 3
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
            AND INDEX_NAME = 'review_date_idx'
            AND INDEX_SCHEMA='yelp_db_small'
        ) THEN
        BEGIN
		    DROP INDEX review_date_idx on Review;
        END;
	END IF;
END//
DELIMITER ;

CALL drop_idx_if_exists();

EXPLAIN SELECT COUNT(*) as count
FROM Review
WHERE MONTH(date) = '5' AND YEAR(date)='2014';

SELECT COUNT(*) as count
FROM Review
WHERE MONTH(date) = '5' AND YEAR(date)='2014';

CREATE INDEX review_date_idx ON Review(date);

EXPLAIN SELECT COUNT(*) as count
FROM Review
WHERE MONTH(date) = '5' AND YEAR(date)='2014';

SELECT COUNT(*) as count
FROM Review
WHERE MONTH(date) = '5' AND YEAR(date)='2014';