
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

자료형(datatype)
varchar - 가변길이 문자를 저장
char - 고정길이 문자를 저장
int-정수저장
decimal(m,n)- 실수저장
date - 날짜 저장
===============================*/
