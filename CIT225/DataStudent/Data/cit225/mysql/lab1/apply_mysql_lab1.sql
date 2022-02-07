-- ------------------------------------------------------------------
--  Program Name:   apply_mysql_lab1.sql
--  Lab Assignment: N/A
--  Program Author: Michael McLaughlin
--  Creation Date:  10-Sep-2019
-- ------------------------------------------------------------------
--  Change Log:
-- ------------------------------------------------------------------
--  Change Date    Change Reason
-- -------------  ---------------------------------------------------
--  13-Feb-2013    Revised model for 51 versus 21 items.
--  08-Jun-2014    Update lab for weekly deliverables.
-- ------------------------------------------------------------------
-- This creates tables, sequences, indexes, and constraints necessary
-- to begin lesson #3. Demonstrates proper process and syntax.
-- ------------------------------------------------------------------
-- Instructions:
-- ----------------------------------------------------------------------
-- You first connect to the Oracle database with this syntax:
--
--   mysql -ustudent -p -Dstudentdb
--
--  or, you can fully qualify the port with this syntax:
--
--   mysql -ustudent -pstudent -P3306 -Dstudentdb
--
-- Then, you call this script with the following syntax:
--
--   mysql> \. apply_mysql_lab1.sql
--
--  or, the more verbose syntax:
--
--   mysql> source apply_mysql_lab1.sql
--
-- ----------------------------------------------------------------------

-- This script calls all required setup scripts.
\. /home/student/Data/cit225/mysql/lib/configure_mysql_web.sql

SELECT m.member_id
,      m.account_number
,      m.credit_card_number
,      m.credit_card_type
,      c.member_id
,      c.first_name
,      c.middle_name
,      c.last_name
FROM   contact c join member m on m.member_id = c.member_id
WHERE  c.first_name = 'Harry'
AND    c.middle_name = 'James'
AND    c.last_name = 'Potter'\G

-- ----------------------------------------------------------------------
