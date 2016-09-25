set heading off
set feedback off
set echo off
set verify off

prompt
prompt ****** R E C E I V E   O R D E R ******
prompt

select 'Today''s Date: ', sysdate from dual;

prompt

accept vEmp_Num prompt 'Enter the Employee Number: ';

select '	Employee Name: ', initcap(ltrim(rtrim(Emp_LName)))||', '||initcap(ltrim(rtrim(Emp_FName)))
		from Employees 
		where (Emp_Num)=upper('&vEmp_Num');

Select '	Employee Job Title: ', initcap(ltrim(rtrim(Emp_title)))
		from Employees
		where (Emp_Num)=upper('&vEmp_Num');
prompt
accept vPO_Num prompt 'Enter the Purchase Order Number:  ';

select 'Order Number: ', PO_Num
	from Purch_Orders
	where (PO_Num)=(&vPO_Num);

select 'Item Number: ', Prod_Num
	from Purch_Orders
	where (PO_Num)=(&vPO_Num);

select '	Item Description: ', initcap(Prod_Desc)
	from Products, Purch_Orders
	where (PO_Num)=(&vPO_Num)
	and (Products.Prod_Num)=(Purch_Orders.Prod_Num);

select 'Supplier Number: ', initcap(Sup_Num)
	from Purch_Orders
	where (PO_Num)=(&vPO_Num);
	
select '	Supplier Name: ', Sup_Name
	from Suppliers, Purch_Orders
	where (PO_Num)=(&vPO_Num)
	and (Suppliers.Sup_Num)=(Purch_Orders.Sup_Num);

select 'Date Ordered: ', Date_Ordered
	from Purch_Orders
	where (PO_Num)=(&vPO_Num);
	
select 'Today''s Date: ', sysdate 
	from dual;

select 'Quantity Ordered: ', Order_Qty
	from Purch_Orders
	where (PO_Num)=(&vPO_Num);

select 'Unit Price: ', Unit_Price
	from Price_List, Purch_Orders
	where (PO_Num)=(&vPO_Num)
	and (Price_List.Prod_Num)=(Purch_Orders.Prod_Num)
	and (Price_List.Sup_Num)=(Purch_Orders.Sup_Num);

column AO format $99999.99

select 'Amount Ordered: ', (Unit_Price*Order_Qty) AO
	from Price_List, Purch_Orders
	where (PO_Num)=(&vPO_Num)
	and (Price_List.Prod_Num)=(Purch_Orders.Prod_Num)
	and (Price_List.Sup_Num)=(Purch_Orders.Sup_Num);

prompt	

accept vReceive_Qty prompt 'Enter quantity received: ';

Update Purch_Orders set Date_Rec = sysdate where PO_Num = &vPO_Num;
Update Purch_Orders set Receive_Qty = &vReceive_Qty where PO_Num = &vPO_Num;
Update Purch_Orders set Emp_Rec = upper('&vEmp_Num') where PO_Num = &vPO_Num;

column AD format $99999.99

select 'Amount Due: ', (&vReceive_Qty*Unit_Price) AD
	from Price_List, Purch_Orders
	where (PO_Num)=(&vPO_Num)
	and (Price_List.Prod_Num)=(Purch_Orders.Prod_Num)
	and (Price_List.Sup_Num)=(Purch_Orders.Sup_Num);

Update Products set (Prod_Inv) = (Prod_Inv+&vReceive_Qty) 
	where (Prod_Num=(select Prod_Num
	from Purch_Orders where PO_Num = &vPO_Num ));

select 'Inventory Level: ', Prod_Inv
	from Products, Purch_Orders
	where (PO_Num)=(&vPO_Num)
	and (Products.Prod_Num)=(Purch_Orders.Prod_Num);

commit;

prompt
prompt ************************************

Update Purch_Orders set Order_Status='C'
	where PO_Num=&vPO_Num;

prompt Order is now ---> Closed 
Select 'Date Closed: ', sysdate from dual;

commit;