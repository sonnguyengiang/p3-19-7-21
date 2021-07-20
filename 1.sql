create database thuhanh1;
use thuhanh1;

create table class(
id_l int primary key,
name_l varchar(10),
startdate datetime,
status int 
);
drop table class;

-- INSERT INTO Student (StudentName, Address, Phone, Status, ClassId)
create table students(
id int primary key,
name varchar(30),
address varchar (40),
phone varchar(10),
status int,
lop int,
foreign key (lop) references class(id_l)
);
drop table students;

create table subject(
subid int primary key,
subname varchar(10),
creadit int,
status int
);
drop table subject;

create table mark(
idmk int primary key,
subid int,
id int,
mark int,
exemtime int,
foreign key (subid) references subject(subid),
foreign key (id) references students(id)
);
drop table mark;


INSERT INTO Class
VALUES (1, 'A1', '2008-12-20', 1);
INSERT INTO Class
VALUES (2, 'A2', '2008-12-22', 1);
INSERT INTO Class
VALUES (3, 'B3', current_date, 0);

INSERT INTO students
VALUES (1,'Hung', 'Ha Noi', '0912113113', 1, 1);
INSERT INTO students
VALUES (2,'Hoa', 'Hai phong','09121113', 1, 1);
INSERT INTO students
VALUES (3,'Manh', 'HCM', '0123123123', 0, 2);

INSERT INTO Subject
VALUES (1, 'CF', 5, 1),
       (2, 'C', 6, 1),
       (3, 'HDJ', 5, 1),
       (4, 'RDBMS', 10, 1);


INSERT INTO Mark (SubId, StudentId, Mark, ExamTimes)
VALUES (1, 1, 8, 1),
       (1, 2, 10, 2),
       (2, 1, 12, 1);
       
       
select * from students;

select * from students join class on students.lop = class.id_l;
select * from students;

SELECT *
FROM Subject
WHERE creadit < 10;