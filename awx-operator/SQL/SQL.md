# SQL 
* STRUCTURE QUERY LANAGUAGE 
* It is a language that we use to interact with data. 

## DATABASE 
* Database is the collection of tables.
* The tables have relationships 



## RDMS (RELATIONAL DATABASE MANAGEMENT SYSTEM)
* Its is a tool/software that stores data in related tables . 
* It also allows you to use SQL to manage that data efficiently and safely.
* Data is stored in tables, and relationships are defined using keys (Primary and Foreign Keys).

## TYPES OF RDMS SOFTWARE 
1. Oracle
2. Microsoft SQL
3. Postgres SQL
4. MySQL
5. SQLite


## Install Micirosft SQL in a Docker container 


docker cp KCC\ Customer\ and\ Orders\ DB.csv <azuresqledge>:/var/opt/mssql/data/file.csv

BULK INSERT dbo.kcc
FROM '/var/opt/mssql/data/kcc.csv' -- Path inside the container
WITH
(
    FIRSTROW = 2,         -- Skip header row if any
    FORMAT= 'CSV'
);
GO