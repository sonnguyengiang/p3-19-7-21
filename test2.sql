create database qlsv;
drop database qlsv;
use qlsv;

create table students(
idsv int primary key,
namesv varchar(30),
agesv int not null,
emailsv varchar(30)
);
drop table students;

create table classes(
idclass int primary key,
nameclass varchar(30)
);
drop table classes;

create table classstudent(
idcs int primary key,
idsv int,
idclass int,
foreign key (idsv) references students(idsv),
foreign key (idclass) references classes(idclass)
);
drop table classstudent;

create table subjects(
idsubject int primary key,
namesubject varchar(30)
);
drop table subjects;

create table marks(
idmark int primary key,
mark int,
idsubject int,
idsv int,
foreign key (idsv) references students(idsv),
foreign key (idsubject) references subjects(idsubject)
);
drop table marks;

create table diemthi(
iddiem int primary key,
diem int,
idsv int,
foreign key (idsv) references students(idsv)
);
drop table diemthi;

-- show toan bo sinh vien
SELECT * FROM qlsv.students;

-- show toan bo mon hoc
select * from subjects;

-- tinh diem trung binh
select students.idsv,students.namesv,avg(diem) as "diem tb" from students
inner join diemthi on students.idsv = diemthi.idsv
group by idsv,namesv;

-- show hoc sinh co diem cao nhat
select * from students
inner join qlsv.diemthi on diemthi.idsv = students.idsv
where diemthi.diem = (select max(diem) as 'diem' from qlsv.diemthi);

--  show danh sach hoc sinh theo chieu giam 
select * from students
order by idsv desc;

-- thay doi kieu du lieu cua cot subjectname thanh nvarcher(max);
alter table qlsv.subjects
modify column namesubject nvarchar(226);

-- cap nhap them dong chu day la mon hoc vao trc ban ghi tren cot subject name trong basng subject 
update qlsv.subjects
set namesubject = "day la mon hoc sql"
where idsubject = 1;

-- viet check constraint de kiem tra do tuoi nhap vao bang student theo yeu cau age > 15 va age < 50
alter table qlsv.students
add check (agesv > 15 and agesv < 50);

-- loai bo quan he giua cac bang 
alter table qlsv.classstudent
drop foreign key classstudent_ibfk_1,
drop foreign key classstudent_ibfk_2;

alter table qlsv.marks
drop foreign key marks_ibfk_1,
drop foreign key marks_ibfk_2;

alter table qlsv.diemthi
drop foreign key diemthi_ibfk_1;

-- xoa bo hoc vien co id bang 1
delete from students where idsv = 1;

-- alter table students
alter table students
add status bit default 1;

-- alter status thenh 0
update students
set status = 0
where idsv = 1;




