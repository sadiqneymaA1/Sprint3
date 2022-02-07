-- --------------------------------------------------------------------------------
--  Program Name:  oracle_tables.sql
--  Author:        Michael McLaughlin
--  Date:          15 Sep 2019
-- --------------------------------------------------------------------------------
--  Open a log file with the archaic spool tape_name for a tape drive; you replace
--  tape_name with file name and you must provide a file extension.
-- --------------------------------------------------------------------------------
SPOOL oracle_tables.txt

-- --------------------------------------------------------------------------------
--  Conditionally drop table and sequence.
-- --------------------------------------------------------------------------------
BEGIN
  FOR i IN (SELECT object_name
	    ,      object_type
	    FROM   user_objects
	    WHERE  REGEXP_LIKE(object_name,'^new_hire.*$','i')
            AND    object_type IN ('TABLE','SEQUENCE')) LOOP
    EXECUTE IMMEDIATE 'DROP '|| i.object_type || ' ' || i.object_name;
  END LOOP;
END;
/
LIST
SHOW ERRORS

-- --------------------------------------------------------------------------------
--  Create a new_hire table.
-- --------------------------------------------------------------------------------
CREATE TABLE new_hire
( new_hire_id  NUMBER        CONSTRAINT new_hire_pk  PRIMARY KEY
, first_name   VARCHAR2(20)  CONSTRAINT new_hire_nn1 NOT NULL
, middle_name  VARCHAR2(20)
, last_name    VARCHAR2(20)  CONSTRAINT new_hire_nn2 NOT NULL
, hire_date    DATE          CONSTRAINT new_hire_nn3 NOT NULL
, CONSTRAINT   new_hire_nk   UNIQUE (first_name, middle_name, hire_date));

-- --------------------------------------------------------------------------------
--  Create a new_hire table.
-- --------------------------------------------------------------------------------
CREATE SEQUENCE new_hire_s;

-- --------------------------------------------------------------------------------
--  Insert a row into a new_hire table.
-- --------------------------------------------------------------------------------
INSERT INTO new_hire
( new_hire_id
, first_name
, middle_name
, last_name
, hire_date )
VALUES
( new_hire_s.NEXTVAL
,'Malcolm'
,'Jacob'
,'Lewis'
,'14-FEB-2018');

-- --------------------------------------------------------------------------------
--  Insert a row into a new_hire table.
-- --------------------------------------------------------------------------------
INSERT INTO new_hire
( new_hire_id
, first_name
, last_name
, hire_date )
VALUES
( new_hire_s.NEXTVAL
,'Henry'
,'Chabot'
,'31-JUL-1990' );

-- --------------------------------------------------------------------------------
--  Query the rows from the new_hire table.
-- --------------------------------------------------------------------------------

-- Set null values to display as <Null>
SET NULL '<Null>'

-- Set the column formatting values.
COLUMN new_hire_id  FORMAT 9999  HEADING "New|Hire|ID #"
COLUMN first_name   FORMAT A10   HEADING "First|Name"
COLUMN middle_name  FORMAT A10   HEADING "Middle|Name"
COLUMN last_name    FORMAT A10   HEADING "Last|Name"
COLUMN hire_date    FORMAT A10   HEADING "Hire|Date"

-- Query results from the new_hire table.
SELECT *
FROM   new_hire;

-- --------------------------------------------------------------------------------
--  Close a log file with the archaic spool off for a tape drive.
-- --------------------------------------------------------------------------------
SPOOL OFF
