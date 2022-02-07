-- ------------------------------------------------------------------
--  Program Name:   seed_mysql_store_ri3.sql
--  Lab Assignment: N/A
--  Program Author: Michael McLaughlin
--  Creation Date:  10-Mar-2010
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

-- Open a database.
USE studentdb;


-- Call the basic seeding scripts, this scripts TEE their own log
-- files. That means this script can only start a TEE after they run.
\. /home/student/Data/cit225/mysql/lib/cleanup_mysql.sql
\. /home/student/Data/cit225/mysql/lib/create_mysql_store_ri2.sql
\. /home/student/Data/cit225/mysql/lib/seed_mysql_store_ri2.sql

-- Open log file.
TEE /home/student/Data/cit225/mysql/lib/log/configure_mysql_web.txt

-- --------------------------------------------------------------------------------
--  Step #1 : Query joins between two tables with the USING subclause:
-- --------------------------------------------------------------------------------

-- --------------------------------------------------------------------------------
-- 1a. MEMBER and CONTACT table on MEMBER_ID.
-- --------------------------------------------------------------------------------
SELECT   member_id
FROM     member m INNER JOIN contact c USING(member_id);

-- --------------------------------------------------------------------------------
-- 1b. CONTACT and ADDRESS table.
-- --------------------------------------------------------------------------------
SELECT   contact_id
FROM     contact c INNER JOIN address a USING(contact_id);

-- --------------------------------------------------------------------------------
-- 1c. ADDRESS and STREET_ADDRESS table.
-- --------------------------------------------------------------------------------
SELECT   address_id
FROM     address a INNER JOIN street_address sa USING(address_id);

-- --------------------------------------------------------------------------------
-- 1d. CONTACT and TELEPHONE table.
-- --------------------------------------------------------------------------------
SELECT   contact_id
FROM     contact c INNER JOIN telephone t USING(contact_id);

-- --------------------------------------------------------------------------------
--  Step #2 : Query joins between two tables with the ON subclause:
-- --------------------------------------------------------------------------------

-- --------------------------------------------------------------------------------
-- 2a. CONTACT and SYSTEM_USER table on CONTACT.CREATED_BY column.
-- --------------------------------------------------------------------------------
SELECT   contact_id, system_user_id
FROM     contact c INNER JOIN system_user su
ON       c.created_by = su.system_user_id;

-- --------------------------------------------------------------------------------
-- 2b. CONTACT and SYSTEM_USER table on CONTACT.LAST_UPDATED_BY column.
-- --------------------------------------------------------------------------------
SELECT   contact_id, system_user_id
FROM     contact c INNER JOIN system_user su
ON       c.last_updated_by = su.system_user_id;

-- --------------------------------------------------------------------------------
--  Step #3 : Query joins between two tables with the ON subclause:
-- --------------------------------------------------------------------------------

-- --------------------------------------------------------------------------------
-- 3a. SYSTEM_USER and SYSTEM_USER on SYSTEM_USER_ID and CREATED_BY columns.
-- --------------------------------------------------------------------------------
SELECT   su1.system_user_id, su1.created_by
FROM     system_user su1 INNER JOIN system_user su2
ON       su1.created_by = su2.system_user_id;

-- --------------------------------------------------------------------------------
-- 3b. SYSTEM_USER and SYSTEM_USER on SYSTEM_USER_ID and LAST_UPDATED_BY columns.
-- --------------------------------------------------------------------------------
SELECT   su1.system_user_id, su1.last_updated_by
FROM     system_user su1 INNER JOIN system_user su2
ON       su1.last_updated_by = su2.system_user_id;

-- --------------------------------------------------------------------------------
--  Step #4 : Query joins between three tables with the ON subclause:
-- --------------------------------------------------------------------------------

SELECT   r.rental_id, i.item_id
FROM     rental r INNER JOIN rental_item ri
ON       r.rental_id = ri.rental_id INNER JOIN item i
ON       ri.item_id = i.item_id;

-- --------------------------------------------------------------------------------
--  Step #5 : Ensure the ADDRESS_ID column is nullable in the TELEPHONE table.
-- --------------------------------------------------------------------------------

DESCRIBE telephone;

-- --------------------------------------------------------------------------------
--  Step #6 : Remove the NOT NULL constraint from the RETURN_DATE column in the
--            RENTAL table.
-- --------------------------------------------------------------------------------

-- --------------------------------------------------------------------------------
--  Step #5 : Ensure the ADDRESS_ID column is nullable in the TELEPHONE table.
-- --------------------------------------------------------------------------------

DESCRIBE rental;

-- --------------------------------------------------------------------------------
--  Step #6 : Remove the NOT NULL constraint from the RETURN_DATE column in the
--            RENTAL table.
-- --------------------------------------------------------------------------------

SELECT 'ALTER TABLE rental DROP CONSTRAINT' AS "Statement";
ALTER TABLE rental MODIFY COLUMN return_date DATE;
DESCRIBE rental;

-- ------------------------------------------------------------------
--  Program Name:   apply_mysql_lab6.sql
--  Lab Assignment: N/A
--  Program Author: Michael McLaughlin
--  Creation Date:  10-Mar-2010
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
-- The two scripts contain spooling commands, which is why there
-- isn't a spooling command in this script. When you run this file
-- you first connect to the Oracle database with this syntax:
--
--   mysql -ustudent -pstudent
--
--  or, you can fully qualify the port with this syntax:
--
--   mysql -ustudent -pstudent -P3306
--
-- Then, you call this script with the following syntax:
--
--   mysql> \. apply_mysql_lab6.sql
--
--  or, the more verbose syntax:
--
--   mysql> source apply_mysql_lab6.sql
--
-- ----------------------------------------------------------------------

-- This enables dropping tables with foreign key dependencies.
-- It is specific to the InnoDB Engine.
SET FOREIGN_KEY_CHECKS = 0; 

-- ----------------------------------------------------------------------
--  Step #1 : Add two columns to the RENTAL_ITEM table.
-- ----------------------------------------------------------------------
SELECT  'Step #1' AS "Step Number" FROM dual;

-- ----------------------------------------------------------------------
--  Objective #1: Add the RENTAL_ITEM_PRICE and RENTAL_ITEM_TYPE columns 
--                to the RENTAL_ITEM table. Both columns should use a
--                NUMBER data type in Oracle, and an int unsigned data
--                type.
-- ----------------------------------------------------------------------
ALTER TABLE rental_item
  ADD (rental_item_type   int unsigned)
, ADD (rental_item_price  int unsigned);

-- ----------------------------------------------------------------------
--  Verification #1: Verify the table structure. 
-- ----------------------------------------------------------------------
SELECT   table_name
,        ordinal_position
,        column_name
,        CASE
           WHEN is_nullable = 'NO' THEN 'NOT NULL'
           ELSE ''
         END AS nullable
,        column_type
FROM     information_schema.columns
WHERE    table_name = 'rental_item'
ORDER BY 2;

-- ----------------------------------------------
-- Step #2 : Create the PRICE table.
-- ----------------------------------------------

-- Conditionally drop table.
SELECT 'DROP TABLE price' AS "Statement";
DROP TABLE IF EXISTS price;

-- Create PRICE table.
SELECT 'CREATE TABLE price' AS "Statement";
CREATE TABLE price
( price_id              INT UNSIGNED  PRIMARY KEY AUTO_INCREMENT
, item_id               INT UNSIGNED  NOT NULL
, price_type            INT UNSIGNED
, active_flag           ENUM('Y','N') NOT NULL
, start_date            DATE          NOT NULL
, end_date              DATE
, amount                DOUBLE(10,2)  NOT NULL
, created_by            INT UNSIGNED  NOT NULL
, creation_date         DATE          NOT NULL
, last_updated_by       INT UNSIGNED  NOT NULL
, last_updated_date     DATE          NOT NULL
, CONSTRAINT pk_price_1 FOREIGN KEY(item_id) REFERENCES item(item_id)
, CONSTRAINT fk_price_1 FOREIGN KEY(price_type) REFERENCES common_lookup(common_lookup_id)
, CONSTRAINT fk_price_2 FOREIGN KEY(created_by) REFERENCES system_user(system_user_id)  
, CONSTRAINT fk_price_3 FOREIGN KEY(last_updated_by) REFERENCES system_user(system_user_id)  
) ENGINE=INNODB CHARSET=latin1;

-- ----------------------------------------------------------------------
--  Verification #2: Verify the table structure. 
-- ----------------------------------------------------------------------
SELECT   table_name
,        ordinal_position
,        column_name
,        CASE
           WHEN is_nullable = 'NO' THEN 'NOT NULL'
           ELSE ''
         END AS nullable
,        column_type
FROM     information_schema.columns
WHERE    table_name = 'price'
ORDER BY 2;

-- ----------------------------------------------------------------------
--  Step #3 : Insert new data into the model.
-- ----------------------------------------------------------------------
SELECT  'Step #3' AS "Step Number" FROM dual;

-- ----------------------------------------------------------------------
--  Objective #3: Rename ITEM_RELEASE_DATE column to RELEASE_DATE column,
--                insert three new DVD releases into the ITEM table,
--                insert three new rows in the MEMBER, CONTACT, ADDRESS,
--                STREET_ADDRESS, and TELEPHONE tables, and insert
--                three new RENTAL and RENTAL_ITEM table rows.
-- ----------------------------------------------------------------------

-- ----------------------------------------------------------------------
--  Step #3a: Rename ITEM_RELEASE_DATE Column.
-- ----------------------------------------------------------------------
SELECT 'RENAME COLUMN item_release_date TO release_date' AS "Statement";
ALTER TABLE item CHANGE COLUMN item_release_date release_date DATE;

-- ----------------------------------------------------------------------
--  Verification #3a: Verify the column name change. 
-- ----------------------------------------------------------------------
SELECT   table_name
,        ordinal_position
,        column_name
,        CASE
           WHEN is_nullable = 'NO' THEN 'NOT NULL'
           ELSE ''
         END AS nullable
,        column_type
FROM     information_schema.columns
WHERE    table_name = 'item'
ORDER BY 2;

-- ----------------------------------------------
--  Step #3b: Insert three new items.
-- ----------------------------------------------
SELECT 'INSERT INTO item #1' AS "Statement";
INSERT INTO item VALUES
( null
, '786936161878'
, (SELECT common_lookup_id 
   FROM common_lookup 
   WHERE common_lookup_type = 'DVD_WIDE_SCREEN')
, 'Tron'
, '20th Anniversary Collectors Edition'
,(SELECT   rating_agency_id
  FROM     rating_agency
  WHERE    rating = 'PG'
  AND      rating_agency = 'MPAA')
, DATE_SUB(UTC_DATE(), INTERVAL 3 DAY)
, 3, UTC_DATE(), 3, UTC_DATE());

SELECT 'INSERT INTO item #2' AS "Statement";
INSERT INTO item VALUES
( null
, '4101-10422'
, (SELECT common_lookup_id 
   FROM common_lookup 
   WHERE common_lookup_type = 'DVD_WIDE_SCREEN')
, 'The Avengers' , ''
,(SELECT   rating_agency_id
  FROM     rating_agency
  WHERE    rating = 'PG-13'
  AND      rating_agency = 'MPAA')
, DATE_SUB(UTC_DATE(), INTERVAL 3 DAY)
, 3, UTC_DATE(), 3, UTC_DATE());

SELECT 'INSERT INTO item #3' AS "Statement";
INSERT INTO item VALUES
( null
, '5918-1040'
, (SELECT common_lookup_id 
   FROM common_lookup 
   WHERE common_lookup_type = 'DVD_WIDE_SCREEN')
, 'Thor: The Dark World'
, ''
,(SELECT   rating_agency_id
  FROM     rating_agency
  WHERE    rating = 'G'
  AND      rating_agency = 'MPAA')
, DATE_SUB(UTC_DATE(), INTERVAL 3 DAY)
, 3, UTC_DATE(), 3, UTC_DATE());

-- ----------------------------------------------------------------------
--  Verification #3b: Verify the column name change. 
-- ----------------------------------------------------------------------
SELECT   i.item_title
,        UTC_DATE() AS today
,        i.release_date
FROM     item i
WHERE    DATEDIFF(UTC_DATE(),i.release_date) < 31;

-- ----------------------------------------------
--  Step #3c: Insert a member with three contacts.
-- ----------------------------------------------
SELECT 'INSERT INTO member #1' AS "Statement";
INSERT INTO member
( member_type
, account_number
, credit_card_number
, credit_card_type
, created_by
, creation_date
, last_updated_by
, last_update_date )
VALUES
((SELECT   common_lookup_id
  FROM     common_lookup
  WHERE    common_lookup_context = 'MEMBER'
  AND      common_lookup_type = 'GROUP')
, 'US00011'
, '6011 0000 0000 0078'
,(SELECT   common_lookup_id
  FROM     common_lookup
  WHERE    common_lookup_type = 'DISCOVER_CARD')
, 1001
, UTC_DATE()
, 1001
, UTC_DATE());

SET @member_id = last_insert_id();

SELECT 'INSERT INTO contact #1' AS "Statement";
INSERT INTO contact VALUES
( null
, @member_id
,(SELECT   common_lookup_id
  FROM     common_lookup
  WHERE    common_lookup_context = 'CONTACT'
  AND      common_lookup_type = 'CUSTOMER')
,'Harry'
,'James'
,'Potter'
, 1002
, UTC_DATE()
, 1002
, UTC_DATE());

SET @contact_id = last_insert_id();

INSERT INTO address VALUES
( null
, @contact_id
,(SELECT   common_lookup_id
  FROM     common_lookup
  WHERE    common_lookup_type = 'HOME')
,'Provo'
,'Utah'
,'84604'
, 2
, UTC_DATE()
, 2
, UTC_DATE());

SET @address_id = last_insert_id();

INSERT INTO street_address VALUES
( null
, @address_id
,'900 E, 300 N'
, 1002
, UTC_DATE()
, 1002
, UTC_DATE());

INSERT INTO telephone VALUES
( null
, @address_id
, @contact_id
,(SELECT   common_lookup_id
  FROM     common_lookup
  WHERE    common_lookup_type = 'HOME')
,'USA'
,'801'
,'333-3333'
, 1002
, UTC_DATE()
, 1002
, UTC_DATE());

SELECT 'INSERT INTO contact #1' AS "Statement";
INSERT INTO contact VALUES
( null
, @member_id
,(SELECT   common_lookup_id
  FROM     common_lookup
  WHERE    common_lookup_context = 'CONTACT'
  AND      common_lookup_type = 'CUSTOMER')
,'Ginny'
, null
,'Potter'
, 1002
, UTC_DATE()
, 1002
, UTC_DATE());

SET @contact_id = last_insert_id();

INSERT INTO address VALUES
( null
, @contact_id
,(SELECT   common_lookup_id
  FROM     common_lookup
  WHERE    common_lookup_type = 'HOME')
,'Provo'
,'Utah'
,'84604'
, 1002
, UTC_DATE()
, 1002
, UTC_DATE());

SET @address_id = last_insert_id();

INSERT INTO street_address VALUES
( null
, @address_id
,'900 E, 300 N'
, 1002
, UTC_DATE()
, 1002
, UTC_DATE());

INSERT INTO telephone VALUES
( null
, @address_id
, @contact_id
,(SELECT   common_lookup_id
  FROM     common_lookup
  WHERE    common_lookup_type = 'HOME')
,'USA'
,'801'
,'333-3333'
, 1002
, UTC_DATE()
, 1002
, UTC_DATE());

SELECT 'INSERT INTO contact #2' AS "Statement";
INSERT INTO contact VALUES
( null
, @member_id
,(SELECT   common_lookup_id
  FROM     common_lookup
  WHERE    common_lookup_context = 'CONTACT'
  AND      common_lookup_type = 'CUSTOMER')
,'Lily'
,'Luna'
,'Potter'
, 1002
, UTC_DATE()
, 1002
, UTC_DATE());

SET @contact_id = last_insert_id();

INSERT INTO address VALUES
( null
, @contact_id
,(SELECT   common_lookup_id
  FROM     common_lookup
  WHERE    common_lookup_type = 'HOME')
,'Provo'
,'Utah'
,'84604'
, 1002
, UTC_DATE()
, 1002
, UTC_DATE());

SET @address_id = last_insert_id();

INSERT INTO street_address VALUES
( null
, @address_id
,'900 E, 300 N'
, 1002
, UTC_DATE()
, 1002
, UTC_DATE());

INSERT INTO telephone VALUES
( null
, @address_id
, @contact_id
,(SELECT   common_lookup_id
  FROM     common_lookup
  WHERE    common_lookup_type = 'HOME')
,'USA'
,'801'
,'333-3333'
, 1002
, UTC_DATE()
, 1002
, UTC_DATE());

-- ----------------------------------------------------------------------
--  Verification #3c: Verify the column name change. 
-- ----------------------------------------------------------------------
SELECT   CONCAT(c.last_name,', ',c.first_name,' ',IFNULL(c.middle_name,'')) AS full_name
,        a.city
,        a.state_province AS state
FROM     member m INNER JOIN contact c
ON       m.member_id = c.member_id INNER JOIN address a
ON       c.contact_id = a.contact_id INNER JOIN street_address sa
ON       a.address_id = sa.address_id INNER JOIN telephone t
ON       c.contact_id = t.contact_id
WHERE    c.last_name = 'Potter';

-- ----------------------------------------------
--  Step #3d: Insert three new rentals.
-- ----------------------------------------------
SELECT 'INSERT INTO rental #1' AS "Statement";
INSERT INTO rental VALUES
( null
,(SELECT   contact_id
  FROM     contact
  WHERE    last_name = 'Potter'
  AND      first_name = 'Harry')
, UTC_DATE()
, DATE_ADD(UTC_DATE(), INTERVAL 1 DAY)
, 1003
, UTC_DATE()
, 1003
, UTC_DATE());

SET @rental_id = last_insert_id();

SELECT 'INSERT INTO rental_item #1a' AS "Statement";
INSERT INTO rental_item
( rental_item_id
, rental_id
, item_id
, created_by
, creation_date
, last_updated_by
, last_update_date)
VALUES
( null
, @rental_id
,(SELECT   d.item_id
  FROM     item d
  ,        common_lookup cl
  WHERE    d.item_title = 'Tron'
  AND      d.item_subtitle = '20th Anniversary Collectors Edition'
  AND      d.item_type = cl.common_lookup_id
  AND      cl.common_lookup_type = 'DVD_WIDE_SCREEN')
, 1003
, UTC_DATE()
, 1003
, UTC_DATE());

SELECT 'INSERT INTO rental_item #1b' AS "Statement";
INSERT INTO rental_item
( rental_item_id
, rental_id
, item_id
, created_by
, creation_date
, last_updated_by
, last_update_date)
VALUES
( null
, @rental_id
,(SELECT   d.item_id
  FROM     item d
  ,        common_lookup cl
  WHERE    d.item_title = 'Brave Heart'
  AND      d.item_subtitle IS NULL
  AND      d.item_type = cl.common_lookup_id
  AND      cl.common_lookup_type = 'DVD_WIDE_SCREEN')
, 1003
, UTC_DATE()
, 1003
, UTC_DATE());

SELECT 'INSERT INTO rental #2' AS "Statement";
INSERT INTO rental VALUES
( null
,(SELECT   contact_id
  FROM     contact
  WHERE    last_name = 'Potter'
  AND      first_name = 'Harry')
, UTC_DATE()
, DATE_ADD(UTC_DATE(), INTERVAL 3 DAY)
, 1003
, UTC_DATE()
, 1003
, UTC_DATE());

SET @rental_id = last_insert_id();

SELECT 'INSERT INTO rental_item #2' AS "Statement";
INSERT INTO rental_item
( rental_item_id
, rental_id
, item_id
, created_by
, creation_date
, last_updated_by
, last_update_date)
VALUES
( null
, @rental_id
,(SELECT   d.item_id
  FROM     item d
  ,        common_lookup cl
  WHERE    d.item_title = 'The Avengers'
  AND      d.item_type = cl.common_lookup_id
  AND      cl.common_lookup_type = 'DVD_WIDE_SCREEN')
, 1003
, UTC_DATE()
, 1003
, UTC_DATE());

SELECT 'INSERT INTO rental #1' AS "Statement";
INSERT INTO rental VALUES
( null
,(SELECT   contact_id
  FROM     contact
  WHERE    last_name = 'Potter'
  AND      first_name = 'Harry')
, UTC_DATE()
, DATE_ADD(UTC_DATE(), INTERVAL 5 DAY)
, 1003
, UTC_DATE()
, 1003
, UTC_DATE());

SET @rental_id = last_insert_id();

SELECT 'INSERT INTO rental_item #1' AS "Statement";
INSERT INTO rental_item
( rental_item_id
, rental_id
, item_id
, created_by
, creation_date
, last_updated_by
, last_update_date)
VALUES
( null
, @rental_id
,(SELECT   d.item_id
  FROM     item d
  ,        common_lookup cl
  WHERE    d.item_title = 'Thor: The Dark World'
  AND      d.item_type = cl.common_lookup_id
  AND      cl.common_lookup_type = 'DVD_WIDE_SCREEN')
, 1003
, UTC_DATE()
, 1003
, UTC_DATE());

-- ----------------------------------------------------------------------
--  Verification #3d: Verify the column name change. 
-- ----------------------------------------------------------------------
SELECT   CONCAT(c.last_name,', ',c.first_name,' ',IFNULL(c.middle_name,'')) AS full_name
,        r.rental_id
,        DATEDIFF(r.return_date,r.check_out_date) || '-DAY RENTAL' AS rental_days
,        COUNT(DISTINCT r.rental_id) AS rentals
,        COUNT(ri.rental_item_id) AS items
FROM     rental r INNER JOIN rental_item ri
ON       r.rental_id = ri.rental_id INNER JOIN contact c
ON       r.customer_id = c.contact_id
WHERE    DATEDIFF(UTC_DATE(),r.check_out_date) < 15
AND      c.last_name = 'Potter'
GROUP BY CONCAT(c.last_name,', ',c.first_name,' ',c.middle_name)
,        r.rental_id
,        DATEDIFF(r.return_date,r.check_out_date) || '-DAY RENTAL'
ORDER BY 2;

-- ----------------------------------------------------------------------
--  Objective #4: Modify the design of the COMMON_LOOKUP table, insert
--                new data into the model, and update old non-compliant
--                design data in the model.
-- ----------------------------------------------------------------------

-- ----------------------------------------------------------------------
--  Step #4a: Drop Indexes.
-- ----------------------------------------------------------------------
SELECT 'ALTER TABLE common_lookup DROP INDEX' AS "Statement";
ALTER TABLE common_lookup DROP INDEX common_lookup_u1;

-- ----------------------------------------------------------------------
--  Verification #4a: Verify the unique indexes are dropped. 
-- ----------------------------------------------------------------------
SELECT   table_name
,        constraint_name
,        constraint_type
FROM     information_schema.table_constraints
WHERE    table_name = 'common_lookup';

-- ----------------------------------------------------------------------
--  Step #4b: Add three new columns.
-- ----------------------------------------------------------------------
SELECT 'ALTER TABLE common_lookup ADD COLUMNS' AS "Statement";
ALTER TABLE common_lookup
  ADD COLUMN (common_lookup_table  VARCHAR(30))
, ADD COLUMN (common_lookup_column VARCHAR(30))
, ADD COLUMN (common_lookup_code   VARCHAR(30));

-- ----------------------------------------------------------------------
--  Verification #4b: Verify the unique indexes are dropped. 
-- ----------------------------------------------------------------------
SELECT   table_name
,        ordinal_position
,        column_name
,        CASE
           WHEN is_nullable = 'NO' THEN 'NOT NULL'
           ELSE ''
         END AS nullable
,        column_type
FROM     information_schema.columns
WHERE    table_name = 'common_lookup'
ORDER BY 2;

-- ----------------------------------------------------------------------
--  Step #4c: Migrate data in COMMON_LOOKUP table.
-- ----------------------------------------------------------------------
SELECT 'Migrate Data with 9 Updates' AS "Statement";
UPDATE   common_lookup
SET      common_lookup_table = 'SYSTEM_USER'
,        common_lookup_column = 'SYSTEM_USER_ID'
WHERE    common_lookup_context = 'SYSTEM_USER';
  
UPDATE   common_lookup
SET      common_lookup_table = 'CONTACT'
,        common_lookup_column = 'CONTACT_TYPE'
WHERE    common_lookup_context = 'CONTACT'; 

UPDATE   common_lookup
SET      common_lookup_table = 'MEMBER'
,        common_lookup_column = 'MEMBER_TYPE'
WHERE    common_lookup_context = 'MEMBER'
AND      common_lookup_type = 'INDIVIDUAL';   

UPDATE   common_lookup
SET      common_lookup_table = 'MEMBER'
,        common_lookup_column = 'MEMBER_TYPE'
WHERE    common_lookup_context = 'MEMBER'
AND      common_lookup_type = 'GROUP'; 

UPDATE   common_lookup
SET      common_lookup_table = 'MEMBER'
,        common_lookup_column = 'CREDIT_CARD_TYPE'
WHERE    common_lookup_context = 'MEMBER'
AND      common_lookup_type = 'DISCOVER_CARD'; 

UPDATE   common_lookup
SET      common_lookup_table = 'MEMBER'
,        common_lookup_column = 'CREDIT_CARD_TYPE'
WHERE    common_lookup_context = 'MEMBER'
AND      common_lookup_type = 'MASTER_CARD'; 

UPDATE   common_lookup
SET      common_lookup_table = 'MEMBER'
,        common_lookup_column = 'CREDIT_CARD_TYPE'
WHERE    common_lookup_context = 'MEMBER'
AND      common_lookup_type = 'VISA_CARD'; 

UPDATE   common_lookup
SET      common_lookup_table = 'ADDRESS'
,        common_lookup_column = 'ADDRESS_TYPE'
WHERE    common_lookup_context = 'MULTIPLE';

UPDATE   common_lookup
SET      common_lookup_table = 'ITEM'
,        common_lookup_column = 'ITEM_TYPE'
WHERE    common_lookup_context = 'ITEM';

-- ----------------------------------------------------------------------
--  Step #4c: Insert data in COMMON_LOOKUP table.
-- ----------------------------------------------------------------------
SELECT 'INSERT INTO common_lookup 2 rows' AS "Statement";
INSERT INTO common_lookup VALUES
( null,'TELEPHONE','HOME','Home', 1001, UTC_DATE(), 1001, UTC_DATE(),'TELEPHONE','TELEPHONE_TYPE','');

INSERT INTO common_lookup VALUES
( null,'TELEPHONE','WORK','Work', 1001, UTC_DATE(), 1001, UTC_DATE(),'TELEPHONE','TELEPHONE_TYPE','');

-- ----------------------------------------------------------------------
--  Step #4c: Fix obsoleted FOREIGN KEY values.
-- ----------------------------------------------------------------------
SELECT 'UPDATE telephone twice' AS "Statement";
UPDATE   telephone
SET      telephone_type = 
         (SELECT common_lookup_id
          FROM common_lookup
          WHERE common_lookup_table = 'TELEPHONE'
          AND common_lookup_type = 'HOME')
WHERE    telephone_type = 
         (SELECT common_lookup_id
          FROM common_lookup
          WHERE common_lookup_table = 'ADDRESS'
          AND common_lookup_type = 'HOME');

UPDATE   telephone
SET      telephone_type = 
         (SELECT common_lookup_id
          FROM common_lookup
          WHERE common_lookup_table = 'TELEPHONE'
          AND common_lookup_type = 'WORK')
WHERE    telephone_type = 
         (SELECT common_lookup_id
          FROM common_lookup
          WHERE common_lookup_table = 'ADDRESS'
          AND common_lookup_type = 'WORK');


-- ----------------------------------------------------------------------
--  Verification #4c: Verify the common_lookup changes. 
-- ----------------------------------------------------------------------
SELECT   table_name
,        ordinal_position
,        column_name
,        CASE
           WHEN is_nullable = 'NO' THEN 'NOT NULL'
           ELSE ''
         END AS nullable
,        column_type
FROM     information_schema.columns
WHERE    table_name = 'common_lookup'
ORDER BY 2;

-- ----------------------------------------------------------------------
--  Verification #4c: Verify the common_lookup data. 
-- ----------------------------------------------------------------------
SELECT   common_lookup_table
,        common_lookup_column
,        common_lookup_type
FROM     common_lookup
ORDER BY 1, 2, 3;

-- ----------------------------------------------------------------------
--  Step #4d: Add NOT NULL constraints.
-- ----------------------------------------------------------------------
SELECT 'ALTER TABLE common_lookup CHANGE' AS "Statement";
ALTER TABLE common_lookup CHANGE common_lookup_table common_lookup_table VARCHAR(30) NOT NULL;
ALTER TABLE common_lookup CHANGE common_lookup_column common_lookup_column VARCHAR(30) NOT NULL;
           
-- ----------------------------------------------------------------------
--  Step #4e: Add UNIQUE index.
-- ----------------------------------------------------------------------
SELECT 'ALTER TABLE common_lookup ADD INDEX' AS "Statement";         
ALTER TABLE common_lookup ADD CONSTRAINT common_lookup_u1 UNIQUE INDEX 
  common_lookup(common_lookup_table,common_lookup_type);

-- ----------------------------------------------------------------------
--  Step #4f: Drop the obsoleted column.
-- ----------------------------------------------------------------------
SELECT 'ALTER TABLE common_lookup DROP COLUMN' AS "Statement";         
ALTER TABLE common_lookup DROP COLUMN common_lookup_context;

-- ----------------------------------------------------------------------
--  Verification #4d-f: Verify the common_lookup changes. 
-- ----------------------------------------------------------------------
SELECT   table_name
,        ordinal_position
,        column_name
,        CASE
           WHEN is_nullable = 'NO' THEN 'NOT NULL'
           ELSE ''
         END AS nullable
,        column_type
FROM     information_schema.columns
WHERE    table_name = 'common_lookup'
ORDER BY 2;

-- --------------------------------------------------------------------------------
--  Step #1 : Insert new rows to support the PRICE table.
-- --------------------------------------------------------------------------------
SELECT 'INSERT INTO common_lookup Flag Values' AS "Statement";         
INSERT INTO common_lookup VALUES
( null
, 'YES'
, 'Yes'
, 1001, UTC_DATE(), 1001, UTC_DATE()
, 'PRICE'
, 'ACTIVE_FLAG'
, 'Y');

INSERT INTO common_lookup VALUES
( null
, 'NO'
, 'NO'
, 1001, UTC_DATE(), 1001, UTC_DATE()
, 'PRICE'
, 'ACTIVE_FLAG'
, 'N');

-- --------------------------------------------------------------------------------
--  Verify #1 : Insert new rows to support the PRICE table.
-- --------------------------------------------------------------------------------
SELECT   common_lookup_table
,        common_lookup_column
,        common_lookup_type
FROM     common_lookup
WHERE    common_lookup_table = 'PRICE'
AND      common_lookup_column = 'ACTIVE_FLAG'
ORDER BY 1, 2, 3 DESC;

-- ----------------------------------------------
--  Step #2 : Insert new rows to support RENTAL_ITEM table.
-- ----------------------------------------------
SELECT 'INSERT INTO common_lookup n-Day Rental' AS "Statement";         
INSERT INTO common_lookup VALUES
( null
, '1-DAY RENTAL'
, '1 Day Rental'
, 1001, UTC_DATE(), 1001, UTC_DATE()
, 'PRICE'
, 'PRICE_TYPE'
, '1');

INSERT INTO common_lookup VALUES
( null
, '3-DAY RENTAL'
, '3 Day Rental'
, 1001, UTC_DATE(), 1001, UTC_DATE()
, 'PRICE'
, 'PRICE_TYPE'
, '3');

INSERT INTO common_lookup VALUES
( null
, '5-DAY RENTAL'
, '5 Day Rental'
, 1001, UTC_DATE(), 1001, UTC_DATE()
, 'PRICE'
, 'PRICE_TYPE'
, '5');

SELECT 'INSERT INTO common_lookup n-Day Rental' AS "Statement";         
INSERT INTO common_lookup VALUES
( null
, '1-DAY RENTAL'
, '1 Day Rental'
, 1001, UTC_DATE(), 1001, UTC_DATE()
, 'RENTAL_ITEM'
, 'RENTAL_ITEM_TYPE'
, '1');

INSERT INTO common_lookup VALUES
( null
, '3-DAY RENTAL'
, '3 Day Rental'
, 1001, UTC_DATE(), 1001, UTC_DATE()
, 'RENTAL_ITEM'
, 'RENTAL_ITEM_TYPE'
, '3');

INSERT INTO common_lookup VALUES
( null
, '5-DAY RENTAL'
, '5 Day Rental'
, 1001, UTC_DATE(), 1001, UTC_DATE()
, 'RENTAL_ITEM'
, 'RENTAL_ITEM_TYPE'
, '5');

-- --------------------------------------------------------------------------------
--  Verify #2 : Insert new rows to support the PRICE table.
-- --------------------------------------------------------------------------------
SELECT   common_lookup_table
,        common_lookup_column
,        common_lookup_type
FROM     common_lookup
WHERE    common_lookup_table = 'PRICE'
AND      common_lookup_column = 'ACTIVE_FLAG'
ORDER BY 1, 2, 3 DESC;

-- --------------------------------------------------------------------------------
--  Step #3 : Update the RENTAL_ITEM_TYPE column with valid values.
-- --------------------------------------------------------------------------------

-- --------------------------------------------------------------------------------
--  Verify #3a : Update the RENTAL_ITEM_TYPE column with valid values.
-- --------------------------------------------------------------------------------

-- Verify the structure of the table before the change.
SELECT   table_name
,        ordinal_position
,        column_name
,        CASE
           WHEN is_nullable = 'NO' THEN 'NOT NULL'
           ELSE ''
         END AS nullable
,        column_type
FROM     information_schema.columns
WHERE    table_name = 'rental_item'
ORDER BY 2;

-- Update the RENTAL_ITEM_TYPE value through a correlated subquery.
SELECT 'UPDATE rental_item' AS "Statement";
UPDATE   rental_item ri
SET      rental_item_type =
           (SELECT   cl.common_lookup_id
            FROM     common_lookup cl
            WHERE    cl.common_lookup_code =
              (SELECT  CAST(DATEDIFF(r.return_date, r.check_out_date) AS CHAR)
               FROM    rental r
                     WHERE   r.rental_id = ri.rental_id));

-- --------------------------------------------------------------------------------
--  Verify #3b : Change the RENTAL_ITEM_TYPE column of the RENTAL_ITEM column
--               from a null allowed column to a not null constrained column.
-- --------------------------------------------------------------------------------

-- Add FOREIGN KEY constraint to RENTAL_ITEM_TYPE column.
SELECT 'ALTER TABLE rental_item ADD CONSTRAINT' AS "Statement";
ALTER TABLE rental_item ADD CONSTRAINT fk_rental_item_7 FOREIGN KEY(rental_item_type)
  REFERENCES common_lookup(common_lookup_id);

-- Add NOT NULL constraint to RENTAL_ITEM_TYPE column.
ALTER TABLE rental_item CHANGE rental_item_type rental_item_type int unsigned NOT NULL;

-- Query the results from the columns table.
SELECT   table_name
,        ordinal_position
,        column_name
,        CASE
           WHEN is_nullable = 'NO' THEN 'NOT NULL'
           ELSE 'NULLABLE'
         END AS nullable
,        column_type
FROM     information_schema.columns
WHERE    table_name = 'rental_item'
AND      column_name = 'rental_item_type';
    
-- Query result set.
SELECT   CONCAT(tc.table_schema,'.',tc.table_name,'.',tc.constraint_name) AS "Constraint"
,        CONCAT(kcu.table_schema,'.',kcu.table_name,'.',kcu.column_name) AS "Foreign Key"
,        CONCAT(kcu.referenced_table_schema,'.',kcu.referenced_table_name,'.',kcu.referenced_column_name) AS "Primary Key"
FROM     information_schema.table_constraints tc JOIN information_schema.key_column_usage kcu
ON       tc.constraint_name = kcu.constraint_name
WHERE    tc.table_name = 'RENTAL_ITEM'
AND      kcu.column_name = 'RENTAL_ITEM_TYPE'
AND      tc.constraint_type = 'FOREIGN KEY'
ORDER BY tc.table_name
,        kcu.column_name\G

-- --------------------------------------------------------------------------------
--  Step #4 : Query the result from your SELECT statement that you'll use to 
--            insert rows into the PRICE table.
-- --------------------------------------------------------------------------------

-- Query the results prior to writing a PRICE table.
SELECT   i.item_id
,        af.active_flag
,        cl.common_lookup_id AS price_type
,        CASE
           WHEN DATEDIFF(UTC_DATE(),i.release_date) > 30 AND af.active_flag = 'N' THEN
             i.release_date
           ELSE
             DATE_ADD(i.release_date, INTERVAL 31 DAY)
         END AS start_date
,        CASE
           WHEN DATEDIFF(UTC_DATE(),i.release_date) > 30 AND af.active_flag = 'N' THEN
             DATE_ADD(i.release_date, INTERVAL 30 DAY)
         END AS end_date
,        CASE
           WHEN DATEDIFF(UTC_DATE(),i.release_date) <= 30 THEN
             CASE
               WHEN dr.rental_days = 1 THEN 3
               WHEN dr.rental_days = 3 THEN 10
               WHEN dr.rental_days = 5 THEN 15
             END
           WHEN DATEDIFF(UTC_DATE(),i.release_date) > 30 AND af.active_flag = 'N' THEN
             CASE
               WHEN dr.rental_days = 1 THEN 3
               WHEN dr.rental_days = 3 THEN 10
               WHEN dr.rental_days = 5 THEN 15
             END
           ELSE
             CASE
               WHEN dr.rental_days = 1 THEN 1
               WHEN dr.rental_days = 3 THEN 3
               WHEN dr.rental_days = 5 THEN 5
             END
         END AS amount
FROM     item i CROSS JOIN
        (SELECT 'Y' AS active_flag FROM dual
         UNION ALL
         SELECT 'N' AS active_flag FROM dual) af CROSS JOIN
        (SELECT '1' AS rental_days FROM dual
         UNION ALL
         SELECT '3' AS rental_days FROM dual
         UNION ALL
         SELECT '5' AS rental_days FROM dual) dr INNER JOIN
         common_lookup cl ON dr.rental_days = SUBSTR(cl.common_lookup_type,1,1)
WHERE
NOT     (af.active_flag = 'N' AND DATE_SUB(UTC_DATE(), INTERVAL 30 DAY) < i.release_date)
ORDER BY 1, 2, 3;

-- Echo to screen statement message.
SELECT 'ALTER TABLE item' AS "Statement";
ALTER TABLE item
ADD (item_desc TEXT, item_blob MEDIUMBLOB);

-- Show the tables.
show tables;

-- Close log file.
NOTEE

