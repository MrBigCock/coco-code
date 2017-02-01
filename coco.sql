-- 1. MySQL索引
-- https://www.phpsong.com/586.html
-- http://www.jb51.net/article/49346.htm
-- 1.1 建表
DROP TABLE IF EXISTS users;
CREATE TABLE `users` (
`userID` int(11) NOT NULL AUTO_INCREMENT,
`userName` varchar(20) NOT NULL,
`password` varchar(20) NOT NULL,
`address` varchar(20) NOT NULL,
PRIMARY KEY (`userID`)
)

-- 1.2 数据
drop PROCEDURE IF EXISTS genUsers;

delimiter $
create procedure genUsers()
begin
declare i int default 0;
while i < 10000000 do
set i = i + 1;
insert into users(userID,userName,password,address) values(i,concat('username',i),concat('password',i),concat('address',i));
end while;
end 
$
delimiter ;

call genUsers();

CREATE TABLE users2 SELECT * FROM users;

select * from users where userName like 'username65%' and password like 'password65%'; 
EXPLAIN select * from users where userName like 'username65%' and password like 'password65%';

alter table users add index index_userName(userName);
alter table users add index index_password(password);
alter table users add index index_address(address);

select * from users where userName like 'username65%' and password like 'password65%' and address like 'address65%'; 
EXPLAIN select * from users where userName < 'username65' AND userName > 'username50';

alter table users2 add index index_union(userName,password,address);

select * from users2 where userName like 'username65%' and password like 'password65%' and address like 'address65%';
EXPLAIN select * from users2 where userName like 'username65%' and password like 'password65%' and address like 'address65%';
EXPLAIN select * from users2 where userName like 'username65%' and password like 'password65%' and address like 'address65%'; 

TRUNCATE users;
TRUNCATE users2;






