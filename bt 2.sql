create database test;
drop database test;
use test;

create table nhacungcap(
idncc int primary key,
tenncc varchar(30),
address varchar(30),
sdt int,
idthue int,
foreign key (idthue) references thue(idthue)
);
drop table nhacungcap;

create table dichvu(
iddv int primary key,
tendv varchar(30)
);
drop table dichvu;

create table mucphi(
idmp int primary key,
dongia int,
mota varchar(30)
);
drop table mucphi;

create table donxe(
idxe int primary key,
hangxe varchar(30),
sochongoi int
);
drop table donxe;

create table dangki(
iddk int primary key,
idncc int,
iddv int,
idxe int,
idmp int,
ngaybatdau date,
ngayketthuc date,
soluong int,
foreign key (idncc) references nhacungcap(idncc),
foreign key (iddv) references  dichvu(iddv),
foreign key (idmp) references mucphi(idmp),
foreign key (idxe) references donxe(idxe)
);
drop table dangki;

create table thue(
idthue int primary key,
sothue int
);
drop table thue;

-- thue
insert thue value (1,12);
insert thue value (2,23);
insert thue value (3,45);
insert thue value (4,50);

-- nha cung cap
insert nhacungcap value (1,"huy","hanoi",1234567899,1);
insert nhacungcap value (2,"honda","hanoi",1234321899,2);
insert nhacungcap value (3,"asdbc","quanninh",12343218299,3);
insert nhacungcap value (4,"asdasd","quangbinh",1234567899,4);

-- dich vu
insert dichvu value (1,"rua xe");
insert dichvu value (2,"sua xe");
insert dichvu value (3,"doi moi");

-- muc phi
insert mucphi value (1,234,"1123");
insert mucphi value (2,412,"321");
insert mucphi value (3,412,"123");
insert mucphi value (4,112,"3211");

-- don xe
insert donxe value (1,"honda",4);
insert donxe value (2,"asd",4);
insert donxe value (3,"vin",6);
insert donxe value (4,"yamaha",6);

-- dang ki
INSERT dangki  VALUES ('3', '2', '3', '1', '3', '2006-05-21', '2006-09-21', '4');
INSERT dangki  VALUES ('4', '3', '3', '2', '2', '2006-05-21', '2006-09-21', '1');
INSERT dangki  VALUES ('5', '3', '3', '3', '3', '2006-05-21', '2006-09-21', '1');

-- liet ke xe tren 5 ch ngoi
select donxe.idxe,donxe.hangxe from donxe 
where donxe.sochongoi > 5;

-- leit ke danh sach xe lon hown 30
select donxe.idxe,donxe.hangxe, mucphi.dongia from donxe
inner join dangki on dangki.idxe = donxe.idxe
inner join mucphi on mucphi.idmp = dangki.idmp
where donxe.hangxe like "honda" and mucphi.dongia > 300;

-- 



