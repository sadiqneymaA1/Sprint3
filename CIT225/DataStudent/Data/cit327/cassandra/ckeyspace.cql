/*
------------------------------------------------------------------
 Program Name:   ckeyspace.cql
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

/* Create a keyspace in Cassandra, which is like a database
   in MySQL or a schema in Oracle. */
CREATE KEYSPACE IF NOT EXISTS student
  WITH REPLICATION = {
     'class':'SimpleStrategy'
    ,'replication_factor': 1 }
  AND DURABLE_WRITES = true;



