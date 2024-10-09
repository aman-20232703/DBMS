create database dbms;
use dbms;
create table STUDENT(
ROLL_NO char(6) PRIMARY KEY,
StudentName varchar(20),
Course varchar(	10),
DOB DATE NOT NULL);

create table SOCIETY(
SocID char(6) PRIMARY KEY,
SocName varchar(20),
MentorName varchar(15),
TotalSeats int Unsigned);
drop table society;
CREATE TABLE ENROLLEMENT (
Roll_No char(6),
SID	char(6) ,
DateOfEnrollement Date,
foreign key (Roll_No) references STUDENT (Roll_No),
foreign key (SID) references SOCIETY(SocID),
constraint enid primary key(Roll_No,SID));

-- #1. Retrieve names of students enrolled in any society.
select StudentName
from student
inner join enrollement
on student.roll_no=enrollement.roll_no
group by student.roll_no;

-- #2. Retrieve all society names.
select SocName from society;

-- 3. Retrieve students' names starting with letter ‘A’.
select studentname from student where studentname like 'A%';

-- #4. Retrieve students' details studying in courses ‘computer science’ or ‘chemistry’.
 INSERT into STUDENT
(ROLL_NO, StudentName,course,DOB)
VALUES
(21,"rishu","B.VOC",'2003-08-15'),
(22,"aditya", "CS",'2007-06-03'),
(23,"raj",'BBA','2004-07-23');
select * from student where course like 'BBA%' or course like 'cs%';

-- #5. Retrieve students’ names whose roll no either starts with ‘X’ or ‘Z’ and ends with ‘9’
select  * from student where (roll_no like 'x%' or roll_no like 'z%') and roll_no like '9%';

-- #6. Find society details with more than N TotalSeats where N is to be input by the user
SELECT * FROM SOCIETY WHERE TotalSeats > 35;

-- #7. Update society table for mentor name of a specific society
update society
set MentorNmae = 'himanshu'
where socid = '10';
select * from society;

-- #8. Find society names in which more than five students have enrolled
select socName
from society s
inner join enrollement e
where s.socID = e.SID
group by socName
having count(e.SID)>5;

-- #9. Find the name of youngest student enrolled in society ‘NSS’
select StudentName
from student
where roll_no in (
select roll-no
from enrollement
where SID = 'NSS'
order by DOB asc
limit 1
);

-- #10. Find the name of most popular society (on the basis of enrolled students)
select socName
from society s
join enrollement e
where s.socID = e.SID
group by s.socName
order by count(e.SID) desc
limit 1;

-- #11. Find the name of two least popular societies (on the basis of enrolled students)
select socname
from society s
join enrollement e
where s.socID = e.SID
group by s.socname
order by count(e.SID)
limit 2;

-- #12. Find the student names who are not enrolled in any society
select studentname
from student
where roll_no not in(select roll_no from enrollement);

-- #13. Find the student names enrolled in at least two societies
select studentName
from student s,
enrollement e
where s.roll_no = e.roll_no
group by s.studentname
having count(e.roll_no)>=2;

-- #14. Find society names in which maximum students are enrolled
select socname
from society s
join enrollement e
where s.socID = e.SID
group by s.socname
order by count(e.SID) desc
limit 1;

-- #15. Find names of all students who have enrolled in any society and society names in which at least one student has enrolled
 select s.StudentName, s.SocName
 from student s
 left join enrollement e
 on s.Roll_No = e.Roll_No
 left join society sty
 on sty.socID = e.SID;

select StudentName
from student s
inner join enrollement e
on s.roll_no=e.roll_no
group by s.studentname;

select socname
from society s
join enrollement e
on e.SID = s.socID
group by s.socname
having count(e.SID)>=1;

-- #16. find name of students who are enrolled in any of three societies 'Debating', 'Dance', and 'Sashakt'
update society
set SocName = "Debating"
where SocName = "jazba";

update society
set SocName = "Dance"
where SocName = "DNA";

update society
set SocName = "Sashakt"
where SocName = "girlup";

-- #16. Find names of students who are enrolled in any of the three societies ‘Debating’, ‘Dance’ and ‘Sashakt'
select distinct StudentName
from student s
join enrollement e
on s.roll_no = e.roll_no
join society sot
on e.SID = sot.socID
where socname in ('Debating', 'Dance', 'Sashakt');

-- #17. Find society names such that its mentor has a name with ‘Gupta’ in it.
select SocName from society where MentorNmae like 'Gupta%';

-- #18. Find the society names in which the number of enrolled students is only 10% of its capacity.
select socname
from society s
join enrollement e
on s.socID = e.SID
group by socname,
TotalSeats having count(e.SID) = 0.1 * TotalSeats;

-- #19. Display the vacant seats for each society.
select socname,
TotalSeats - count(enrollement.SID)
from society s
join enrollement e
where s.socID = e.SID
group by socname,TotalSeats;

-- #20. Increment Total Seats of each society by 10%
update society
set totalseats = totalseats+0.1*totalseats;
select * from society

-- #21. Add enrollment fees paid (‘yes’/’No’) field in the enrollment table.
alter table enrollement
add enrollementfeepaid enum('yes', 'no');

-- #22. Update date of enrollment of society id ‘s1’ to ‘2018-01-15’, ‘s2’ to current date and ‘s3’ to ‘2018-01-02’.
update enrollement
set dateofenrollement = '2018-01-15'
where dateofenrollement = (select dateofenrollement where SID = '1');

update enrollement
set dateofenrollement = current_date()
where dateofenrollement = (select dateofenrollement where SID = '2');

update enrollement
set dateofenrollement = '2018-01-02'
where dateofenrollement = (select dateofenrollement where SID = '3');

-- #23. Create a view to keep track of society names with the total number of students enrolled in it
create view  society_track as
select socname, count(e.SID)
from society s
join enrollement e
where s.socID = e.SID
group by socname;

-- #24. Find student names enrolled in all the societies.
select studentname
from student s
join enrollement e
on s.roll_no = e.roll_no
where SID = '1' and '2' and '3' and '4' and '5' and '6' and '7' and '8' and '9';
#group by studentname
#having count(e.roll_no) = (select count(socID) from society)
#where SID = '1' and '2' and '3' and '4' and '5' and '6' and '7' and '8' and '9'

-- #25. Count number of societies with more than 5 student enrolled in it
select distinct socName
from society s
inner join enrollement e
where s.socID = e.SID
group by SID
having count(roll_no)>5;


-- #26. Add column Mobile number in student table with default value ‘9999999999
alter table student
add mobile_number varchar(11) default '9999999999';

-- #27. Find the total number of students whose age is > 20 years.
select count(studentname) from student where year(curdate()) - year(DOB) > 20;


-- #que 28) find the names of students who are born in 2000 and enrolled in atleast one society.
select Student_Name from Student, enrollment where Student.Roll_No = Enrollment.Roll_No and DOB like '2000%' group by Student.Student_Name having count(enrollment.Roll_No)>=1;
-- #que 29) count all the societies whose name start with 's' and with ends with 't' and at least 5 students are enrolled in the societiy.
select count(distinct Soc_Name) from Society,enrollment where Enrollment.Socl_ID=Society.Socl_ID and Soc_Name like 'S%t' group by Soc_Name, Enrollment.Socl_ID having count(Enrollment.Socl_ID)>=5;