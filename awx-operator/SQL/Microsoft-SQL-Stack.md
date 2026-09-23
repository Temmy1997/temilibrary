# Microsoft SQL Server
* It is a set of tools and technologies built around Microsoft SQL Server, which is a popular relational database system used by many businesses worldwide to store, manage, and analyze data.

## It mainly consists of:

1. T-SQL (Transact-SQL)
2. SSIS (SQL Server Integration Services)
3. SSRS (SQL Server Reporting Services)

## T-SQL (Transact-SQL)
* T-SQL is an extension of SQL (Structured Query Language) made by Microsoft.
* It adds extra programming features like variables, loops, and error handling to standard SQL.

* It lets you interat with the database like (create tables, inssert tables, update records, delete record, run complex queries)

## SSIS (SQL Server Integration Services)
* SSIS helps gather and prepare that data efficiently for reporting and analysis.
* SSIS is a tool to build data workflows and pipelines.
* This process is called ETL (Extract, Transform, Load).
* It’s mainly used to extract data from different sources, transform it (clean, change format, combine, etc.), and load it into a database or data warehouse.
* pulling sales data from an Excel file, cleaning it, and loading it into a SQL Server database.

* Example use cases:

Importing CSV files into SQL Server.

Migrating data from old systems to new systems.

Automating daily data refreshes.

## SSRS (SQL Server Reporting Services)
* SSRS is a tool for creating reports based on data stored in SQL Server or other databases.
* What it does:
Lets you design reports (like invoices, dashboards, summaries), publish them on a web portal, and schedule them to run automatically.

* Example:
A monthly sales report showing totals by region, with charts and tables, which updates automatically every month.

## How do these work together?
T-SQL to write queries and manipulate data inside the database.

SSIS to move and transform data between sources and databases.

SSRS to build reports that visualize the data for users.