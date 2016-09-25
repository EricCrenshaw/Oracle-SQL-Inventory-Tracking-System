set heading off
set feedback off
set echo off
set verify off

prompt
prompt *******C R E A T E   O R D E R*******
prompt
select 'Today''s Date: ', sysdate from dual;

prompt

accept vEmp_num prompt 'Enter the Employee Number: ';

select '	Employee Name: ', ltrim(rtrim(initcap(Emp_LName)))||', '||ltrim(rtrim(initcap(Emp_FName)))
		from Employees 
		where (Emp_Num)=upper('&vEmp_Num');

Select '	Employee Job Title: ', ltrim(rtrim(initcap(Emp_title)))
		from Employees
		where (Emp_Num)=upper('vEmp_Num');

prompt

accept vProd_Num prompt 'Enter the Item Number:  ';

select '	Item Description: ', ltrim(rtrim(initcap(Prod_Desc)))
		from Products
		where (Prod_Num)=upper('&vProd_Num');

select '	Current Inventory Level: ', Prod_Inv
		from Products
		where (Prod_Num)=upper('&vProd_Num');

prompt

set heading on

prompt Please select from one of the following Authorized Suppliers:

column Sup_Num heading SNUM format a4
column Sup_Name heading Supplier format a12
column City heading City format a12
column State heading State format a5
column Unit_Price heading Unit|Price format $9,999.99

select Suppliers.Sup_Num, Suppliers.Sup_Name, Suppliers.City, Suppliers.State, Unit_Price
	from Suppliers, Price_List
	where Suppliers.Sup_Num=Price_List.Sup_Num
	and Price_List.Prod_Num=upper('&vProd_Num');

set heading off

prompt	

accept vSup_Num prompt 'Enter the Supplier Number: ';

select '	Supplier Name:  ', initcap(Sup_Name)
		from Suppliers
		where upper(Sup_Num)=upper('&vSup_Num');

select '	Address:  ', initcap(Address)
		from Suppliers
		where upper(Sup_Num)=upper('&vSup_Num');

select '	City, State:  ', rtrim(initcap(City))||', '||upper(State)
		from Suppliers
		where upper(Sup_Num)=upper('&vSup_Num');
select '	Phone:  ', Phone
		from Suppliers
		where upper(Sup_Num)=upper('&vSup_Num');

prompt	

accept vOrder_Qty prompt 'Enter Order Quantity:  ';

column Unit_Price format $9,999.99

select '	Unit Price:  ', Unit_Price
	from Price_List
	where upper(Prod_Num)=upper('&vProd_Num')
	and upper(Sup_Num)=upper('&vSup_Num');

column AO format $9,999,999.99

select '	Amount Ordered: ', (Unit_Price*&vOrder_Qty) AO
	from Price_List
	where upper(Prod_Num)=upper('&vProd_Num')
	and upper(Sup_Num)=upper('&vSup_Num');

insert into Purch_Orders (PO_Num, Order_Status, Date_Ordered, Sup_Num, Prod_Num, Order_Qty, Emp_Create)
select MaxNum,'O', sysdate, upper('&vSup_Num'), upper('&vProd_Num'), &vOrder_Qty, upper('&vEmp_Num') 
	from Counter; 

commit;

	
Select '***** Order Status:  ', replace(Order_Status,'O','Open')
		from Purch_Orders, Counter
		where PO_Num=Maxnum;
		
Select '***** Purchase Order number is -----> ', Maxnum from counter;

update counter set maxnum=maxnum+1;

commit;