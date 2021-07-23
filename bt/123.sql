create database qlbh;
drop database qlbh;
use qlbh;

create table customer(
cID int primary key,
cname varchar(30),
cage int
);
drop table customer;

create table dongia(
oID int primary key,
cId int,
odate date,
ototalprice int,
foreign key (cID) references customer(cID)
);
drop table dongia;

create table product(
pID int primary key,
pname varchar(30),
pprice int
);
drop table product;

create table orderdetail(
oID int,
pID int,
odQTY int primary key,
foreign key (oID) references dongia(oID),
foreign key (pID) references product(pID)
);
drop table orderdetail;


select * from dongia;

select customer.cname, product.pname from customer
inner join dongia on customer.cID = dongia.cID
inner join orderdetail on orderdetail.oID = dongia.oID
inner join product on product.pID = orderdetail.pID
where customer.cID in (dongia.cId);

select customer.cname from customer
where customer.cID not in (select dongia.cId from dongia, customer where customer.cID = dongia.cID);


