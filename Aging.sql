set heading off
set feedback off
set echo off
set verify off

prompt
prompt ****** PURCHASE ORDER AGING REPORT ******
prompt

select 'Today''s Date: ', sysdate from dual;

prompt

accept vQdays prompt 'Please enter number of days to query: '



column PO_Num heading 'PO|Number' format 9999

column Order_Status heading 'PO|Stat' format a4

column Date_Ordered heading 'Date|Open' format a10

column Prod_Num heading 'Prod|Num' format a4

column PD heading 'Product|Description' format a12

column Order_Qty heading 'Order|Qty' format 999999

column Unit_Price heading 'Unit|Price' format $999.99

column OA heading 'Order|Amount' format $99999.99

column Sup_Num heading 'Sup|Num' format a3

column SN heading 'Supplier|Name' format a12

column DO heading 'Days|Open' format 999

set heading on
set linesize 150


select PO_Num, Order_Status, Date_Ordered, Products.Prod_Num, initcap(Prod_Desc) PD, Order_Qty, Unit_Price, Order_Qty*Unit_Price OA, Suppliers.Sup_Num, initcap(Sup_Name) SN, trunc(sysdate-Date_Ordered) +1 DO
	from Purch_Orders, Suppliers, Products, Price_List, dual
	where (trunc(sysdate-Date_Ordered) +1 >= &vQdays)
	and Order_Status='O'
	and Purch_Orders.Prod_Num=Products.Prod_Num
	and Purch_Orders.Sup_Num=Suppliers.Sup_Num
	and Purch_Orders.Prod_Num=Price_List.Prod_Num
	and Purch_Orders.Sup_Num=Price_List.Sup_Num
	order by DO desc;