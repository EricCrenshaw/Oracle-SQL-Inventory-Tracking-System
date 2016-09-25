set heading off
set feedback off
set echo off
set verify off

prompt
prompt ****** Q U E R Y  O R D E R ******
prompt

accept vPO_Num prompt 'Please enter the Purchase Order Number: ';

select 'Purchase Order Number: ', PO_Num
	from Purch_Orders
	where (PO_Num)=(&vPO_Num);

select 'Item Number: ', Prod_Num
	from Purch_Orders
	where (PO_num)=(&vPO_Num);
		
Select 'Item Description: ', initcap(Prod_Desc)
	from Purch_Orders, Products
	where Purch_Orders.Prod_Num= Products.Prod_Num
	and (Purch_Orders.PO_Num)=(&vPO_Num);
		
Select 'Current Inventory Level: ', Prod_Inv
	from Purch_Orders, Products
	where Purch_orders.Prod_Num= Products.Prod_Num
	and (Purch_Orders.PO_Num)=(&vPO_Num);

select 'Supplier Number: ', Sup_Num
	from Purch_Orders
	where (PO_Num)=(&vPO_Num);
		
select 'Supplier Name: ', Sup_Name
	from Purch_Orders, Suppliers
	where Purch_Orders.Sup_Num= Suppliers.Sup_Num
	and (Purch_Orders.PO_Num)=(&vPO_Num);
			
select 'Date Ordered: ', Date_Ordered
		from Purch_Orders
		where (PO_Num)=(&vPO_Num);

select 'Quantity Ordered ', Order_Qty
		from Purch_Orders
		where (PO_Num)=(&vPO_Num);

select 'Date Received: ', Date_Rec
		from Purch_Orders
		where (PO_Num)=(&vPO_Num);

select 'Quantity Received: ', Receive_Qty
		from Purch_Orders
		where (PO_Num)=(&vPO_Num);

select 'Unit Price ', Unit_Price
		from Price_List, Purch_Orders
		where (PO_Num)=(&vPO_Num)
		and (Purch_Orders.Prod_Num)=(Price_List.Prod_Num)
		and (Purch_Orders.Sup_Num)=(Price_List.Sup_Num);

select 'Amount Ordered ', Order_Qty*Unit_Price
		from Purch_Orders, Price_List
		where (PO_Num)=(&vPO_Num)
		and (Purch_Orders.Prod_Num)=(Price_List.Prod_Num)
		and (Purch_Orders.Sup_Num)=(Price_List.Sup_Num);

select 'Amount Due ', Receive_Qty*Unit_Price
		from Purch_Orders, Price_List
		where (PO_Num)=(&vPO_Num)
		and (Purch_Orders.Prod_Num)=(Price_List.Prod_Num)
		and (Purch_Orders.Sup_Num)=(Price_List.Sup_Num);
		
select 'Order Status: ', case 
	when Order_Status='O' then 'Open'
	when Order_Status='C' then 'Closed' end
	from Purch_Orders
	where (PO_Num)=(&vPO_Num);