.mode column
.header on

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
    sno char(8),
    cno char(8),
    num int check ( num >= 0 and num <=20 ),
    foreign key (sno) references shopper(sno),
    foreign key (cno) references commodity(cno)
);


-- 2. 插入数据
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
                           ('C01', 'Dennis', 'm', '海淀'),
                           ('C02', 'John', 'm', '浦东'),
                           ('C03', 'Tom', 'm', '越秀'),
                           ('C04', 'Jenny', 'f', '南山'),
                           ('C05', 'Rick', 'm', '玄武');

insert into purchase values
                           ('C01', 'M01', 3),
                           ('C01', 'M05', 2),
                           ('C01', 'M08', 2),
                           ('C02', 'M02', 5),
                           ('C02', 'M06', 4),
                           ('C03', 'M01', 1),
                           ('C03', 'M05', 1),
                           ('C03', 'M06', 3),
                           ('C03', 'M08', 1),
                           ('C04', 'M03', 7),
                           ('C04', 'M04', 3),
                           ('C05', 'M06', 2),
                           ('C05', 'M07', 8);


-- 3.1 记录自己购买了两块舒肤佳肥皂
insert into shopper values
                           ('C06', 'Qiang', 'm', '江北');

insert into purchase values
                           ('C06', 'M04', 2);

select * from shopper;
select * from purchase;


-- 3.2 求购买了供应商"宝洁"产品的所有顾客的姓名
select distinct sname, vendor from commodity, shopper, purchase
where vendor = '宝洁' and commodity.cno = purchase.cno 
    and shopper.sno = purchase.sno;


-- 3.3 求购买的商品包括了顾客"Dennis"所购买商品的顾客（姓名）；
select distinct sname from commodity, shopper, purchase
where commodity.cno = purchase.cno and shopper.sno = purchase.sno
    and commodity.cno in (select cno from shopper, purchase 
        where shopper.sno = purchase.sno and sname = "Dennis");


-- 3.4 求女性顾客购买的商品类别；
select class from commodity, shopper, purchase
where commodity.cno = purchase.cno and shopper.sno = purchase.sno
    and sex = 'f';


-- 3.5 牙膏卖出数量最多的供应商。
-- 3.5.1 建立牙膏供应商销售总数视图
create view toothpaste_vendor as       
select sum(num) totalNum, vendor from commodity, purchase 
where class = '牙膏' and commodity.cno = purchase.cno
group by vendor;

-- 3.5.2 找出牙膏卖出数量最多的供应商
select vendor from toothpaste_vendor
where totalNum = (select max(toltalNum) from toothpaste_vendor);


-- 4.将所有的牙膏商品单价增加10%。 
update commodity set price = price * 1.1
where class = '牙膏';
select * from commodity;


-- 5.删除从未被购买的商品记录。
delete from commodity where cno not in 
(select cno from purchase);

select * from commodity;


-- 6.怎样计算顾客"Tom"的购物总金额
select sname, sum(price*num) from purchase, shopper, commodity
where sname = 'Tom' and purchase.sno = shopper.sno 
    and commodity.cno = purchase.cno;


