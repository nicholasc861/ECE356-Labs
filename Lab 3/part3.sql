SELECT user_id, review_count
FROM User_data
WHERE name = 'Shelia';

SELECT business_id, name, review_count
FROM Business
ORDER BY review_count DESC
LIMIT 1;

SELECT AVG(review_count)
FROM User_data;

SELECT average_stars, computed_avg
FROM User_data AS ud INNER JOIN
	(SELECT user_id, AVG(stars) as computed_avg
     FROM Review GROUP BY user_id) as r
     ON r.user_id=ud.user_id
WHERE ABS(average_stars-computed_avg)>0.5;

SELECT COUNT(*)/(SELECT COUNT(*) FROM User_data) as fraction_with_gt_10_reviews
FROM User_data
WHERE review_count>10;

SELECT AVG(LENGTH(text))
FROM (
	SELECT user_id
    FROM User_data
    WHERE review_count > 10) as ud
    INNER JOIN (
      	SELECT user_id, text
      	FROM Review )AS r 
    ON r.user_id=ud.user_id;
    