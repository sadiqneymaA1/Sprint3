-- --------------------------------------------------------------------------------
--  Program Name:  mysql_tables.sql
--  Author:        Michael McLaughlin
--  Date:          15 Sep 2019
-- --------------------------------------------------------------------------------
--  Open a log file with the TEE command, which splits output to a file and the
--  console or computer screen.
-- --------------------------------------------------------------------------------
TEE mysql_tables.txt

-- --------------------------------------------------------------------------------
--  The SET command lets you assign default values to known environment variables,
--  like the FOREIGN_KEY_CHECKS value. You can also set that in the initialization
--  file for the MySQL database.
-- --------------------------------------------------------------------------------
--  The FOREIGN_KEY_CHECKS environment variable is specific to the InnoDB Engine.
-- --------------------------------------------------------------------------------
SET FOREIGN_KEY_CHECKS = 0;

-- --------------------------------------------------------------------------------
--  Create a new_hire table.
-- --------------------------------------------------------------------------------

--  The query lets you set a value in the log file.
SELECT 'DROP TABLE IF EXISTS new_hire' AS "Statement";

--  This conditionally drops the table.
DROP TABLE IF EXISTS new_hire;

--  The query lets you set a value in the log file.
SELECT 'CREATE TABLE new_hire' AS "Statement";

-- --------------------------------------------------------------------------------
--  This creates the table and sets:
-- ----------------------------------------
--  1. A primary key that auto increments through a hidden sequence value.
--  2. After creating the table you set:
--     a. The database engine, which is InnoDB by default.
--     b. The initial auto incrementing value of the table's sequence.
--     c. The character set for the table, which determines what kind of 
--        text is supported.
-- --------------------------------------------------------------------------------
CREATE TABLE new_hire
( new_hire_id  INT UNSIGNED  PRiMARY KEY AUTO_INCREMENT
, first_name   VARCHAR(20)   NOT NULL
, middle_name  VARCHAR(20)
, last_name    VARCHAR(20)   NOT NULL
, hire_date    DATE          NOT NULL
, CONSTRAINT   new_hire_uq   UNIQUE INDEX (first_name, middle_name, hire_date)
) ENGINE=InnoDB AUTO_INCREMENT=1001 DEFAULT CHARSET=utf8;

-- --------------------------------------------------------------------------------
--  Insert a row into a new_hire table.
-- --------------------------------------------------------------------------------
INSERT INTO new_hire
( first_name
, middle_name
, last_name
, hire_date )
VALUES
( 'Malcolm'
,'Jacob'
,'Lewis'
,'2018-02-14');

-- --------------------------------------------------------------------------------
--  Insert a row into a new_hire table.
-- --------------------------------------------------------------------------------
INSERT INTO new_hire
( first_name
, last_name
, hire_date )
VALUES
( 'Henry'
,'Chabot'
,'1990-07-31' );

-- --------------------------------------------------------------------------------
--  Query the rows from the new_hire table.
-- --------------------------------------------------------------------------------
SELECT *
FROM   new_hire;

-- --------------------------------------------------------------------------------
--  Close a log file by resetting standard out to the console only.
-- --------------------------------------------------------------------------------
NOTEE
