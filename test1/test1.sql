.mode column
.header on
pragma foreign_keys=on;

-- 1. 建立学生表
create table student
(
    sno char(8) primary key,
    sname char(16) unique,
    sage int
);

-- 2. 插入基础数据
insert into student values
                        ('s1','zhao',19),
                        ('s2','qian',23),
                        ('s3','sun',34),
                        ('s4','li',31),
                        ('s5','zhou',23),
                        ('s6','wu',12),
                        ('s7','zheng',20),
                        ('s8','wang',21);

-- 查询全体学生的所有信息
select * from student;

-- 插入自己的信息
insert into student values
    ('s9','qiangshengzhou',20);

-- 3. 查询全体学生的所有信息
select * from student;

-- 4. 计算所有人出生年份，以姓名升序排列
select sno, sname, 2021-sage
from student
order by sname;

-- 5. 找出年龄最大的学生姓名及年龄
select sname, sage
from student
where sage >= (select max(sage) from student);

-- 6. 查询年龄不超过30的学生学号及年龄
select sno, sname
from student
where sage <= 30;

-- 7. 显示姓名中出现"i"字母的学生姓名及年龄
select sname, sage
from student
where sname like '%i%';