/*
------------------------------------------------------------------
 Program Name:   cquery.cql
 Lab Assignment: N/A
 Program Author: Michael McLaughlin
 Creation Date:  31-Aug-2019
------------------------------------------------------------------
 Change Log:
------------------------------------------------------------------
 Change Date    Change Reason
-------------  ---------------------------------------------------
 
------------------------------------------------------------------
 This creates the Cassandra student keyspace.
------------------------------------------------------------------
*/

/* Use the keyspace or connect to the database. */
USE student;
 
/* Select all columns from the member table. */
SELECT * FROM member;

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

