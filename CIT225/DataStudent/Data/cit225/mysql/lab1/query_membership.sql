-- ------------------------------------------------------------
--  Name: query_membership.sql
--  Date: 2019-09-15
-- ------------------------------------------------------------

SELECT *
FROM   member m JOIN contact c ON m.member_id = c.member_id
WHERE  m.account_number = 'US00011'
AND    c.first_name = 'Harry'\G
