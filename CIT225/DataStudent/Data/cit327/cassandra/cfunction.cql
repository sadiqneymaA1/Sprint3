/*
------------------------------------------------------------------
 Program Name:   cfunction.cql
 Lab Assignment: N/A
 Program Author: Michael McLaughlin
 Creation Date:  31-Aug-2019
------------------------------------------------------------------
 Change Log:
------------------------------------------------------------------
 Change Date    Change Reason
-------------  ---------------------------------------------------
 
------------------------------------------------------------------
 This creates the Cassandra concatenate function.
------------------------------------------------------------------
*/

/* Use the keyspace or connect to the database. */
USE student;

/* Drop the concatenate function because a replace disallows changing a
   RETURNS NULL ON NULL INPUT with a CALLED ON NULL INPUT without raising
   an "89: InvalidRequest" exception. */
/* DROP FUNCTION concatenate; */
 
/* Create a user-defined function to concatenate names. */
CREATE OR REPLACE FUNCTION student.concatenate (first_name VARCHAR, middle_name VARCHAR, last_name VARCHAR)
CALLED ON NULL INPUT
RETURNS VARCHAR
LANGUAGE java
AS $$
  /* Concatenate first and last names when middle name is null, and
     first, middle, and last names when middle name is not null. */
  String name;
 
  /* Check for null middle name. */
  if (middle_name == null) {
    name = first_name + " " + last_name; }
  else {
    name = first_name + " " + middle_name + " " + last_name; }
 
  return name;
$$;

/* Query the contact information. */
SELECT member_number
,      contact_number
,      contact_type
,      concatenate(first_name, middle_name, last_name) AS full_name
FROM   contact;

/* Query the contact information and return in a JSON format. */
SELECT JSON
       contact_number
,      contact_type
,      concatenate(first_name, middle_name, last_name) AS full_name
FROM   contact;
 
