操作步骤：
1.软件安装
bash auto_install.sh
2.安装postgits扩展
登录数据库
su - postgres
psql -U postgres
安装扩展
create extension postgis
查询结果
select * from pg_available_extensions where name like 'postgis%';