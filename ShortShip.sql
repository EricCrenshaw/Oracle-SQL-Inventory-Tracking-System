set heading off
set feedback off
set echo off
set verify off

prompt
prompt ****** SUPPLIER MONTHLY REPORT ******
prompt
select 'Today''s Date: ', sysdate from dual;

column PO_Num heading 'PO|Number' format 9999

column Order_Status heading 'PO|Stat' format a4

column Date_Ordered heading 'Date|Open' format a10

column Prod_Num heading 'Prod|Num' format a4

column PD heading 'Product|Description' format a12

column Order_Qty heading 'Order|Qty' format 999,999

column Receive_Qty heading 'Receive|Qty' format 999,999

column SQ heading 'Short|Qty' format 99,999

column Sup_Num heading 'Sup|Num' format a3

column SN heading 'Supplier|Name' format a12


set heading on
set linesize 150


select PO_Num, Order_Status, Date_Ordered, Products.Prod_Num, initcap(Prod_Desc) PD, Order_Qty, Receive_Qty, Order_Qty-Receive_Qty SQ, Suppliers.Sup_Num, initcap(Sup_Name) SN
	from Purch_Orders, Suppliers, Products
	where Order_Status='C'
	and Order_Qty-Receive_Qty > 0
	and Purch_Orders.Prod_Num=Products.Prod_Num
	and Purch_Orders.Sup_Num=Suppliers.Sup_Num;


