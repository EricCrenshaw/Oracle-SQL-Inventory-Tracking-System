set echo on

spool I:setup.txt

drop table Purch_Orders;
drop table Price_List;
drop table Products;
drop table Suppliers;
drop table Employees;
drop table Counter;

create table Employees (
	Emp_Num varchar2(4),
	Emp_LName varchar2(25),
	Emp_FName varchar2(25),
	Emp_Title varchar2(30),
	primary key (Emp_Num));

insert into Employees values ('E1','Ackman','Avery','Operation Analyst');
insert into Employees values ('E2','Brooks','Beverly','Senior Operator');
insert into Employees values ('E3','Cutter','Charlie','Data Technician');
insert into Employees values ('E4','Davis','Diana','Data Technician');
insert into Employees values ('E5','Et','Emanuel','Operation Analyst');
insert into Employees values ('E6','Fausner','Florence','Data Technician');

create table Suppliers (
	Sup_Num varchar2(4),
	Sup_Name varchar2(20),
	Address varchar2(30),
	City varchar2(30),
	State char(2),
	Zip char(5),
	Phone varchar2(13),
	primary key (Sup_Num));

insert into Suppliers values ('S1','Staples','123 Whereever St','Long Beach','CA','90808','310-111-1111');
insert into Suppliers values ('S2','OfficeMax','124 Somewhere Dr','Long Beach','CA','90815','562-222-2222');
insert into Suppliers values ('S3','Office Depot','125 Thereitis Ln','Long Beach','CA','90815','562-333-3333');
insert into Suppliers values ('S4','Target','126 FarFarAway Ave','Long Beach','CA','90801','714-444-4444');
insert into Suppliers values ('S5','Walmart','127 PrettyFar Blvd','Long Beach','CA','90808','310-555-5555');

create table Products (
	Prod_Num varchar2(8),
	Prod_Desc varchar2(25),
	Prod_Inv number(6),
	primary key (Prod_Num));

insert into Products values ('P1','Pencil',10000);
insert into Products values ('P2','Marker',10000);
insert into Products values ('P3','Paper',10000);
insert into Products values ('P4','Staples',10000);
insert into Products values ('P5','Paperclips',10000);
insert into Products values ('P6','Highlighters',10000);

create table Price_List (
   	Sup_Num varchar2(4),
	Prod_Num varchar2(18),
	Unit_Price number(8,2),
	primary key (Sup_Num, Prod_Num),
	constraint fk1 foreign key (Sup_Num) references Suppliers (Sup_Num),
	constraint fk2 foreign key (Prod_Num) references Products (Prod_Num));

insert into Price_List values ('S1','P1',2.50);
insert into Price_List values ('S1','P2',5.00);
insert into Price_List values ('S2','P3',4.00);
insert into Price_List values ('S2','P4',3.00);
insert into Price_List values ('S3','P5',4.50);
insert into Price_List values ('S3','P6',7.50);
insert into Price_List values ('S4','P1',3.00);
insert into Price_List values ('S4','P2',4.80);
insert into Price_List values ('S5','P3',3.80);
insert into Price_List values ('S5','P4',3.50);

create table Purch_Orders (
	PO_Num number(8),
   	Order_Status varchar2(1),
	Date_Ordered date,
	Date_Rec date,
  	Sup_Num varchar2(4),
	Prod_Num varchar2(8),
	Order_Qty number(6),
	Receive_Qty number(6),
	Emp_Create varchar2(4),
	Emp_Rec varchar2(4),
	primary key (PO_Num),
	constraint fk3 foreign key (Sup_Num) references Suppliers (Sup_Num),
	constraint fk4 foreign key (Prod_Num) references Products (Prod_Num),
	constraint fk5 foreign key (Emp_Create) references Employees (Emp_Num),
	constraint fk6 foreign key (Emp_Rec) references Employees (Emp_Num));

insert into Purch_Orders values ('1001','C','16-Oct-15','25-Oct-15','S1','P2',10,10,'E3','E1');
insert into Purch_Orders values ('1002','C','18-Oct-15','30-Oct-15','S3','P5',30,30,'E2','E1');
insert into Purch_Orders values ('1003','C','21-Oct-15','03-Nov-15','S3','P6',15,15,'E2','E1');
insert into Purch_Orders values ('1004','C','28-Oct-15','16-Nov-15','S4','P2',20,18,'E2','E1');
insert into Purch_Orders values ('1005','C','11-Nov-15','21-Nov-15','S1','P1',25,20,'E1','E3');
insert into Purch_orders values ('1006','O','18-Nov-15',null,'S2','P4', 40, null,'E4',null);

create table Counter (
	maxnum number(5));

insert into counter values (1007);

commit;

set echo off
set heading on
set linesize 150



select * from Employees;
prompt 
select * from Suppliers;
prompt
select * from Products;
prompt
select * from Price_List;
prompt
select * from Purch_Orders;
prompt
select * from Counter;

spool off