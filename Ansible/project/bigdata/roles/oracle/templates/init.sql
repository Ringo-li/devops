create tablespace test datafile '/data/oracle/oracle11g/oracle/oradata/test/test.dbf' size 100m autoextend on next 50m maxsize 3G;
alter tablespace test add datafile '/data/oracle/oracle11g/oracle/oradata/test/test2.dbf' size 100m autoextend on next 50m maxsize 3G;
create directory dmp as '/data/oracle/oracle11g/oracle/dmp';
create user test identified by test default tablespace test temporary tablespace temp;
grant connect,resource,dba to test;
grant all on directory dmp to test;
select * from dba_profiles where profile = 'DEFAULT' and resource_name = 'PASSWORD_LIFE_TIME';
alter profile default limit password_life_time unlimited;