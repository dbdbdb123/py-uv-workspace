/*
 * dd
 * 데이터 베이스를 운영하기 위한 정보들을 모두 특정한 곳에 모아두고 관리 하는데 이것을 데이터 딕셔너리라고 한다.
 * 데이터 딕셔너리라고 한다.
 *
 * dd는 메모리 구조랑 각 오브젝트의 정보 ,제약조건 정보,
 * 사용자에 대한 정보, 권한등에 대한 정보를 관리 한다.
 * 
 * 
 * */


show VARIABLES;

show VARIABLES where variable_name like '%cons%';
show databases;
use information_schema;

show tables;

select * from TABLES;