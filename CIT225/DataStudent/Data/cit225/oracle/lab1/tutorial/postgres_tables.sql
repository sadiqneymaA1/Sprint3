-- --------------------------------------------------------------------------------
--  Program Name:  mysql_tables.sql
--  Author:        Michael McLaughlin
--  Date:          15 Sep 2019
-- --------------------------------------------------------------------------------
--  Postgres does not support an interactive logging mechanism that you can put
--  in your files. You must call it from the command line and use redirection
--  at the command line. You have the following options for logging:
--
--    -a, --echo-all       echo all input from script
--    -b, --echo-errors    echo failed commands
--    -e, --echo-queries   echo commands sent to the server
-- --------------------------------------------------------------------------------
--
--  psql -d videodb -U student -W -f script_name.sql -a &> postgres_tables.txt
--
-- --------------------------------------------------------------------------------
--  Create a new_hire table.
-- --------------------------------------------------------------------------------

--  This conditionally drops the table.
DROP TABLE IF EXISTS new_hire;

-- --------------------------------------------------------------------------------
--  This creates the table and sets:
-- ----------------------------------------
--  1. A primary key that auto increments through a hidden sequence value.
--  2. A unique constraint across the first, middle, and last name columns.
-- --------------------------------------------------------------------------------

CREATE TABLE new_hire
( new_hire_id  SERIAL        CONSTRAINT new_hire_pk PRIMARY KEY
, first_name   VARCHAR(20)   NOT NULL
, middle_name  VARCHAR(20)
, last_name    VARCHAR(20)   NOT NULL
, hire_date    DATE          NOT NULL
, UNIQUE(first_name, middle_name, hire_date)
);

-- --------------------------------------------------------------------------------
--  Identify the sequence name automatically linked to the table.
-- --------------------------------------------------------------------------------
SELECT pg_get_serial_sequence('new_hire','new_hire_id');

-- --------------------------------------------------------------------------------
--  Alter the sequence to start at 1001.
-- --------------------------------------------------------------------------------
ALTER SEQUENCE new_hire_new_hire_id_seq RESTART WITH 1001;

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
