set heading off
set feedback off
set echo off
set verify off

prompt
prompt ****** SUPPLIER MONTHLY REPORT ******
prompt


column SNUM heading 'Supplier|Number' format a8

column SN heading 'Supplier|Name' format a12

column OM heading 'Order|Month' format a7
column NO heading 'No. of|Orders' format 999,999
column TU heading 'Total|Units' format 999,999
column TA heading 'Total|Amount' format $999,999

set heading on
set linesize 150


select Purch_Orders.Sup_Num SNUM, initcap(Sup_Name) SN, to_char (Date_Ordered,'MM-YYYY') OM, count(PO_Num) NO, sum(Order_Qty) TU, sum(Unit_Price*Order_Qty) TA 
	from Purch_Orders, Price_List, Products, Suppliers, Dual	
	where Purch_Orders.Prod_Num=Products.Prod_Num
	and Purch_Orders.Sup_Num=Suppliers.Sup_Num
	and Purch_Orders.Prod_Num=Price_List.Prod_Num
	and Purch_Orders.Sup_Num=Price_List.Sup_Num
	group by Purch_Orders.Sup_Num, Sup_Name, to_char (Date_Ordered,'MM-YYYY');