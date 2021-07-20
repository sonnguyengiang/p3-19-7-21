create database qlsp;
drop  database qlsp;
use qlsp;


create table khachhang(
idkh int primary key,
name nvarchar(30),
address nvarchar(30)
);
drop table khachhang;

create table sanpham(
idsp int primary key,
tensp nvarchar(30),
gia double,
made varchar(30)
);
drop table sanpham;

create table hoadon(
idhd int primary key,
date date,
tonggia double,
idkh int,
foreign key (idkh) references khachhang(idkh)
);
drop table hoadon;

create table hodonchitiet(
idhdct int primary key,
idsp int,
soluong int,
idhd int,
foreign key (idhd) references hoadon(idhd),
foreign key (idsp) references sanpham(idsp)
);
drop table hodonchitiet;

-- 6 in ra hóa đơn bán trong ngày ....
SELECT hoadon.idhd, hoadon.tonggia FROM hoadon where date between '1998-03-01' and '2006-07-19';

-- 7 in ra hóa đơn trong ngày và sắp xếp theo ngày và trị giá của hóa đơn
select idhd, date, tonggia ,name
from hoadon, khachhang where date like '1998-03-01' and name like "%chung%" 
order by date, tonggia desc;

-- 8 in ra ma khach khang và ten 
select khachhang.idkh, khachhang.name FROM khachhang, hoadon 
where hoadon.idkh = khachhang.idkh and hoadon.date like '1998-03-01';

-- 10 in ra sản phẩm khi có tên và ngày mua


select sanpham.idsp, sanpham.tensp from sanpham
inner join hoadonchitiet on sanpham.idsp = hoadonchitiet.idsp
inner join hoadon on hoadon.idhd = hoadonchitiet.idhd
inner join khachhang on hoadon.idkh = khachhang.idkh
where khachhang.name like "%chung%" and date like '1998-03-01';

select sanpham.idsp, sanpham.tensp from (((khachhang
inner join hoadon on khachhang.idkh = hoadon.idkh)
inner join hoadonchitiet on hoadon.idhd = hoadonchitiet.idhd)
inner join sanpham on sanpham.idsp = hoadonchitiet.idsp)
where khachhang.name like "%chung%" and hoadon.date like '1998-03-01';

select khachhang.name from khachhang inner join hoadon on khachhang.idkh = hoadon.idkh
where tonggia = (select max(tonggia) as 'tong' from qlsp.hoadon) and hoadon.date like "2006%";

-- 11
select * from qlsp.sanpham 
inner join hodonchitiet on hodonchitiet.idsp = sanpham.idsp
inner join hoadon on hoadon.idhd = hodonchitiet.idhd
where tensp like "%tv%";

-- 12


-- 15 in ra sp ko ban duoc
select sanpham.idsp, sanpham.tensp
from sanpham
where sanpham.idsp not in (select hodonchitiet.idsp from hodonchitiet);

-- 16 in ra sp khong ban dc trong nam 2006
select sanpham.idsp , sanpham.tensp from sanpham
inner join hodonchitiet on sanpham.idsp = hodonchitiet.idsp
inner join hoadon on hoadon.idhd = hodonchitiet.idhd
where sanpham.idsp 
not in (select hodonchitiet.idsp from hodonchitiet, hoadon where hoadon.idhd = hodonchitiet.idhd and year(hoadon.date) = '2006' );

select sanpham.idsp, sanpham.tensp from sanpham
inner join hodonchitiet on  sanpham.idsp =  hodonchitiet.idsp
inner join hoadon on  hodonchitiet.idhd = hoadon.idhd
where sanpham.idsp
not in (select hodonchitiet.idsp from hodonchitiet, hoadon where hoadon.idhd = hodonchitiet.idhd and date like "2006%");

-- 17 in ra san pham co gia ban tren 300 va duoc san xuat trong 2006
select sanpham.idsp, sanpham.tensp from sanpham
inner join hodonchitiet on  sanpham.idsp =  hodonchitiet.idsp
inner join hoadon on  hodonchitiet.idhd = hoadon.idhd
where sanpham.idsp
in (select hodonchitiet.idsp from hodonchitiet, hoadon where hoadon.idhd = hodonchitiet.idhd and date like "2006%")
and gia > 300;

-- 21 có bn sản phẩm khác nhau được bá ra trong năm 2006
select sanpham.idsp,sanpham.tensp,count(hodonchitiet.idsp) as 'so luong'  from sanpham 
inner join hodonchitiet on hodonchitiet.idsp = sanpham.idsp
where sanpham.idsp in (select hodonchitiet.idsp from hodonchitiet, hoadon 
where hoadon.idhd = hodonchitiet.idhd and date like "2006%")
group by idsp;

-- 22 tìm hóa đơn cao nhất và thấp nhất
-- max
select * from hoadon
where tonggia = (select max(tonggia) as 'tong' from hoadon);

-- min
select * from hoadon
where tonggia = (select min(tonggia) as 'tong' from hoadon);

-- 23 tính giá trị trung bình của hóa đơn
select hoadon.idkh, avg(tonggia) as 'gia tri trung binh'
from hoadon where hoadon.date like "2006%"
group by idkh;

-- 24 tính doanh thu hàng bán trong năm 2006
select hoadon.idkh, sum(tonggia) as 'tong'
from hoadon where hoadon.date like "2006%"
group by idkh;

-- 25 tim hoa don co gia trin cao nhat nam 2006
select * from hoadon
where tonggia = (select max(tonggia) from hoadon);

-- 26 in ra ten khach hang co don gia cao nhat trong nam 2006
select khachhang.name from khachhang 
inner join hoadon on hoadon.idkh = khachhang.idkh
where hoadon.tonggia = (select max(tonggia) from hoadon where hoadon.date like "2006%");

-- 27 in ra danh sach 3 khach hang mua hang nhieu nhat
select khachhang.name from khachhang
inner join hoadon on hoadon.idkh = khachhang.idkh
inner join hodonchitiet on hodonchitiet.idhd = hoadon.idhd
inner join sanpham on sanpham.idsp = hodonchitiet.idsp
order by soluong desc limit 2; 

-- 28 in ra san pham co muc gia cao nhat
select * from sanpham
inner join hodonchitiet on hodonchitiet.idsp = sanpham.idsp
inner join hoadon on hoadon.idhd = hodonchitiet.idhd
where tonggia between (select tonggia from (select tonggia from sanpham order by tonggia desc limit 3) as min order by min.tonggia limit 1)
and (select tonggia from (select tonggia from sanpham order by tonggia desc limit 3) as max limit 1); 

-- 32 tính tổng số san phẩm có giá < 300
select hodonchitiet.idhd,sum(soluong) from hodonchitiet
inner join hoadon on hoadon.idhd = hodonchitiet.idhd
where hoadon.tonggia > 300
group by idhd;

-- 33 tính tổng sản phẩm theo từng giá
select hodonchitiet.idhd,sum(soluong) from hodonchitiet
inner join hoadon on hoadon.idhd = hodonchitiet.idhd
where hoadon.tonggia < 300
group by idhd;

select
count(case when hoadon.tonggia > 300 then 1 else null end) as "hon 300",
count(case when hoadon.tonggia < 300 and hoadon.tonggia > 100 then 1 else null end) as "tu 300 - 100",
count(case when hoadon.tonggia < 100 then 1 else null end) as "duoi 100"
from hoadon;


-- 34 tinh theo caonhat that nhat theo m
SELECT TenSP, MAX(gia) AS 'cao nhất', MIN(Gia) AS 'thấp nhất', AVG(Gia) AS 'trung bình'
FROM sanpham
where TenSP like 'a%'
GROUP BY gia;     

select tensp,max(gia) from sanpham
where tensp like "M%";
select tensp,min(gia) from sanpham
where tensp like "M%";
select avg(gia) as "giá trung bình sp bắt đầu băng M" from sanpham
where tensp like "M%";    


-- 35  
select date,sum(tonggia) as 'doanhthu' from hoadon
group by date;

-- 36
