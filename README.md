# PL-SQL

I created this inventory tracking system as my final project in an Introductory SQL course.

The system consists of 7 programs:
	1) Setup.sql: Creates the six tables needed to update or query inventory data as an employee
	2) createPO.sql: Allows users to place an order for new inventory from listed suppliers
	3) receivePO.sql: Allows users to update listed inventory based on received shipments
	4) QueryPO.sql: Allows users to access information for placed orders
	5) Aging.sql: Populates an aging report given a user-specifed time-frame as input
	6) ShortShip.sql: Populates all completed orders where units received is less than units ordered
	7) SupplierMonthly.sql: Populates a comprehensive summary report of all Supplier-based transactions by month

Together these programs serve as a basic inventory tracking system, allowing front-end users to order new inventory, update inventory, and pull data from past transactions.
