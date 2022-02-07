-- ------------------------------------------------------------------
--  Program Name:   apply_oracle_lab2.sql
--  Lab Assignment: N/A
--  Program Author: Michael McLaughlin
--  Creation Date:  17-Jan-2018
-- ------------------------------------------------------------------
--  Change Log:
-- ------------------------------------------------------------------
--  Change Date    Change Reason
-- -------------  ---------------------------------------------------
--  13-Aug-2019    Incorporate diagnostic scripts.
--  
-- ------------------------------------------------------------------
-- This creates tables, sequences, indexes, and constraints necessary
-- to begin lesson #3. Demonstrates proper process and syntax.
-- ------------------------------------------------------------------
-- Instructions:
-- ------------------------------------------------------------------
-- The two scripts contain spooling commands, which is why there
-- isn't a spooling command in this script. When you run this file
-- you first connect to the Oracle database with this syntax:
--
--   sqlplus student/student@xe
--
-- Then, you call this script with the following syntax:
--
--   sql> @apply_oracle_lab2.sql
--
-- ------------------------------------------------------------------

-- Set SQL*Plus environmnet variables.
SET ECHO ON
SET FEEDBACK ON
SET NULL '<Null>'
SET PAGESIZE 999
SET SERVEROUTPUT ON

-- ------------------------------------------------------------------
--  Cleanup prior installations and run previous lab scripts.
-- ------------------------------------------------------------------
@/home/student/Data/cit225/oracle/lab1/apply_oracle_lab1.sql

-- Open log file.
SPOOL apply_oracle_lab2.txt

-- Enter code below.
-- ------------------------------------------------------------------




-- ------------------------------------------------------------------
-- Enter lab code above.

-- Close log file.
SPOOL OFF
