.mode column
.header on
pragma foreign_keys=on;

-- 0.1. 创建各表
create table student
(
    sno char(8) primary key,
    sname char(16) unique,
    sage int
);

create table course
(
    cno char(8) primary key,
    cname char(16) unique,
    credit float
);

create table sc
(
    sno char(8) ,
    cno char(8),
    scores float,
    foreign key(sno) references student(sno),
    foreign key(cno) references course(cno)
);

-- 0.2. 插入基础数据
insert into student values
                        ('s1','zhao',19),
                        ('s2','qian',23),
                        ('s3','sun',34),
                        ('s4','li',31),
                        ('s5','zhou',23),
                        ('s6','wu',12),
                        ('s7','zheng',20),
                        ('s8','wang',21);

insert into course values
                        ('c1','math',6),
                        ('c2','physics',4),
                        ('c3','english',4),
                        ('c4','DB',2),
                        ('c5','law',3);

insert into sc values
                   ('s1','c1',70),
                   ('s1','c3',65),
                   ('s1','c4',null),
                   ('s2','c1',54),
                   ('s2','c2',67),
                   ('s2','c5',80),
                   ('s3','c2',88),
                   ('s3','c4',92),
                   ('s4','c5',24),
                   ('s4','c2',80),
                   ('s5','c1',75),
                   ('s5','c2',null),
                   ('s5','c1',65),
                   ('s7','c2',54),
                   ('s8','c1',90),
                   ('s8','c5',87);

-- 0.3. 插入自己的完整信息
insert into student values
    ('s9','qiangshengzhou',20);

-- 1. 查询选修math的总人数
select count(cno) count_math from sc
where cno = (select cno from course where cname = 'math');

-- 2. 计算math的平均分
select avg(scores) avg_math from sc
where cno = (select cno from course where cname = 'math');

-- 3. 查询选修了“zhao同学所选课程”之外课程的学生姓名及课程名
select sname, cname from student, course, sc
where student.sno = sc.sno and course.cno = sc.cno and
      cname not in(select cname from sc, student, course 
      where student.sno = sc.sno and course.cno = sc.cno and sname = 'zhao') ;

-- 4. 统计每人(学号)的未及格课程门数
select sno, count(cno) fail_num from  sc
where scores < 60
group by sno;

-- 5. 统计每科（课号）的未及格人数
select cno, count(cno) fail_num from  sc
where scores < 60
group by cno;

-- 6. 统计每科（课号）的未及格人数
select sno, avg(scores) from sc
group by sno
having avg(scores) > 80;

-- 7. 查找每科的最高分同学及分数,返回学号、课号与成绩三个属性
select sno, cno, max(scores) from sc
group by cno;

-- 8. 查找每科的最高分同学及分数,返回姓名、课名与成绩三个属性(注:排除空值记录)
select sno, cno, max(scores) from sc
where scores is not null
group by cno;

-- 补充：计算学生的加权平均成绩
-- 建立权重视图
create view course_weight as
select cno, credit/(select sum(credit) from course) weight
from course;

-- 计算加权平均值
select sno, sum(scores*weight) wavg from sc, course_weight
where sc.cno = course_weight.cno
group by sno;

