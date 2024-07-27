show databases;
use newschema;

show tables;
select * from student_performance_data;

select StudentID,Gender,GPA,avg(Age) as Average_Age from student_performance_data 
group by StudentID,Gender,GPA
having GPA > 3;


select GradeClass,sum(Absences) as Total_Absentees
from student_performance_data
group by GradeClass;

select GradeClass,avg(GPA) as Average_GPA
from student_performance_data
group by  GradeClass
order by GradeClass DESC;

-- students having perfect attendance record
select * from student_performance_data
where Absences = 0;

-- counting that number 
select count(Absences) as Count_of_Absent_Students
from student_performance_data
where Absences = 0;

-- total students enrolled in a school
select  count(StudentID) as Total_students
from student_performance_data;

-- students with age>17 and Study Time > 15 hrs
select * from student_performance_data
where Age > 17 and StudyTimeWeekly > 15;

-- we do counting of such students 
select count(StudentID) as Total_Students_Condition 
from student_performance_data
where Age>17 and StudyTimeWeekly>15;

create table New_student_data like student_performance_data;

insert into New_student_data
select * from student_performance_data;




select * from New_student_data;