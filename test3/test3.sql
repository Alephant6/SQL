.mode column
.header on
pragma foreign_keys=on;

-- 1.1. 建立商品表
create table commodity
(
    cno char(8) primary key,
    cname char(16) not null ,
    price float check ( price > 0 ),
    class char(8),
    vendor char(8)
);

-- 1.2. 建立顾客表
create table shopper
(
    sno char(8) primary key,
    sname char(16) not null ,
    sex char(1) check ( sex = 'm' or sex = 'f'),
    address char(16)
);

-- 1.3. 建立购买表
create table purchase
(
    sno char(8) primary key,
    cno char(8) not null ,
    num int check ( num >= 0 and num <=20 ),
    foreign key (sno) references shopper(sno),
    foreign key (cno) references commodity(cno)
);

-- 1.4. 插入基础数据
insert into commodity values
                          ('M01', '佳洁士', 8.00, '牙膏', '宝洁'),
                          ('M02', '高露洁', 6.50, '牙膏', '高露洁'),
                          ('M03', '洁诺', 5.00, '牙膏', '联合利华'),
                          ('M04', '舒肤佳', 3.00, '香皂', '宝洁'),
                          ('M05', '夏士莲', 5.00, '香皂', '联合利华'),
                          ('M06',' 雕牌', 2.50, '洗衣粉', '纳爱斯'),
                          ('M07', '中华', 3.50, '牙膏', '联合利华'),
                           ('M08', '汰渍', 3.00, '洗衣粉', '宝洁'),
                           ('M09', '碧浪', 4.00, '洗衣粉', '宝洁');

insert into shopper values
                           ('C01', 'Dennis', 'f', '海淀'),
                           ('C02', 'John', 'f', '浦东'),
                           ('C03', 'Tom', 'f', '越秀'),
                           ('C04', 'Jenny', 'm', '南山'),
                           ('C05', 'Rick', 'f', '玄武');








