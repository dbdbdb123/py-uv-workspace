
/*==========================================================
SQL의 분류

1 DML(Data Manipulation Language 데이터 조작어) : 
  데이터는 검색, 추가, 수정, 삭제,병합해주는 명령어들이다.
  (select, insert, update, delete,merge)
2 DDL(Data Definition Language 데이터 정의어 ) : 
  테이블의 구조를 정의, 변경해주는 명령어들이다.
  (create, drop, alter, truncate)
3 DCL(Data Control Language 데이터 제어어) : 
  사용자의 권한을 부여,제거해주는 명령어들이다.(grant ,revoke)
4 TCL(Transaction Control Language 트랜잭션 처리어) : 
  트랜잭션 설정,취소을 처리해주는 명령어들이다
  (commit, rollback, savepoint)
==========================================================*/


/*===============================
https://dev.mysql.com/doc/refman/8.4/en/data-types.html
테이블 구조 정의
CREATE TABLE table_name(
  column_name datatype,
  column_name datatype
);

테이블 구조 정의
CREATE TABLE table_name(
  column_name datatype,
  column_name datatype
);

자료형(datatype)
varchar - 가변길이 문자를 저장
char - 고정길이 문자를 저장
int-정수저장
decimal(m,n)- 실수저장
date - 날짜 저장
===============================*/

CREATE TABLE student(
  name varchar(20),
  age int,
  avg decimal(5,2),
  hire date
);

select * from member;

-- 테이블 구조 확인
desc student;

insert into student(name,age,avg,hire) values('홍길동',30,97.85,CURDATE());
insert into student() values('김민재',28,80.2,SYSDATE());
insert into student values('이수리',18,75.3,CURDATE());
insert into student(name,age) values ('세기등',10);
insert into student(name,age,avg,hire) values ('세기등',10,null,null);

-- 소수점 길이 제한은 그범위를 넘으면 넘은걸 반올림해서 들어간다
INSERT INTO student(name, age, avg, hire)VALUES('차영주', 25, 352.9825, curdate());

-- 에러 길이 제한
INSERT INTO student(name, age, avg, hire) VALUES('박차고 나온 세상에abcdefghijklmnopqww', 30, 97.2, curdate());
INSERT INTO student(name, age, avg, hire)VALUES('이정재', 20, 1525.98, curdate());

/*====================================
ALTER 
 객체(테이블)의 구조를 변경해주는 명령어이다.
======================================*/
-- 생성 : CREATE TABLE,  CREATE VIEW, CREATE INDEX
-- 수정 : ALTER TABLE, ALTER VIEW, ALTER INDEX, ALTER USER
alter table student
add loc varchar(30);

-- 테이블의 컬럼명을 수정
alter table student rename column avg to jumsu; -- 기존컬럼명 to 새로운 컬럼명
alter table student modify name varchar(10); --타입수정 가능

alter table student rename to member; --테이블 이름 변경


/*=======================================
테이블의 내용을 수정하는 명령어이다.
UPDATE 테이블명 
SET 컬럼1=값1, 컬럼2=값2 
WHERE 컬럼=값;
=========================================*/

update member set age=50 where name = "홍길동";

/*=============================================
테이블의 내용을 삭제하는 명령어이다.
DELETE
DELETE FROM table_name WHERE column_name = value;
===============================================*/
delete from member where name = '횐둥이';


/*===============================================
무결성 제약조건
   무결성이 데이터베이스 내에 있는 데이터의 정확성 유지를 의미한다면
   제약조건은 바람직하지 않는 데이터가 저장되는 것을 방지하는 것을 말한다.
   무결성 제약조건 6종류 : not null, unique, primary key, foreign key, check, default
    not null : null를 허용하지 않는다.
    unique : 중복된 값을 허용하지 않는다. 항상 유일한값이다.
    primary key : not null + unique
    foreign key : 참조되는 테이블의 컬럼의 값이 존재하면 허용된다.
    check : 저장 가능한 데이터값의 범위나 조건을 지정하여 설정한 값만을 허용한다.
	default : 기본값을 설정한다.
    =====================================================*/


create table dept1(
	code varchar(10) primary key
) 

create table emp1(
id varchar(10) primary key,
name varchar(20) not null,
loc varchar(10),
salary int default 3000
);
show tables;



 -- myxedb 데이터베이스에 생성된 table 확인
   SELECT * FROM information_schema.tables
   WHERE table_schema='myxedb';

 -- myxedb 데이터베이스에 생성된 제약조건 확인
   SELECT * FROM information_schema.TABLE_CONSTRAINTS
   WHERE table_schema='myxedb';

 insert into emp1 values('a001','홍길동','지역',5000);
 
 
 select * from emp1;