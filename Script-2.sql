select * from employees where SALARY between 3000 and 5000;

select DATABASE();
/*
!=
<>
not
not in
*/

select first_name, salary, commission_pct from employees where COMMISSION_PCT is null;
select first_name, salary, commission_pct from employees where COMMISSION_PCT is  not null;

# % 아무거나
select first_name, salary, commission_pct from employees where FIRST_NAME like '%der%';

# _ 임의 문자 하나
select first_name, salary, commission_pct from employees where FIRST_NAME like 'A_exander%';

select first_name, salary, JOB_ID from employees order by JOB_ID DESC;
select first_name, salary, JOB_ID from employees order by JOB_ID ASC;

select first_name, salary, HIRE_DATE from employees order by HIRE_DATE desc,SALARY asc;


select UPPER('korea');
select UCASE('korea');

select lower('KOREA');
select lcase('KOREA');


select CHAR_LENGTH('korea'); -- 5
select LENGTH('korea'); -- 5
select BIT_LENGTH('korea'); -- 48


 
/*====================================================================
일반함수
ifnull(컬럼, 대체값) : 첫번째 인자값이 null이면 0으로 대체해서 출력한다.
if(컬럼, 대체1, 대체2) : 컬럼의 값이 null아니면 대체1로, null이면 대체2로 출력한다. 
nullif(표현식1, 표현식2 ) : 표현식1과 표현식2가 같으면 NULL, 다르면 표현식1로 출력한다.

--대체할 값이 숫자이면 두번째 인자값에 숫자를 지정한다.
--대체할 값이 문자이면 두번째 인자값에 문자를 지정한다.
--대체할 값이 날짜이면 두번째 인자값에 날짜를 지정한다. 
=======================================================================*/
select COMMISSION_PCT,IFNULL(COMMISSION_PCT ,0) from employees;
select FIRST_NAME, MANAGER_ID ,ifnull(CAST(manager_id as char(3)),'CEO');
select COMMISSION_PCT,IF(COMMISSION_PCT ,1,0) from employees;
select COMMISSION_PCT,NULLIF(COMMISSION_PCT ,0.4) from employees;


/*================================
case when 조건1 then 결과1
     when 조건2 then 결과2
     when 조건3 then 결과3
     else 결과n
end AS alias;
자바에서 if-else와 비슷한 의미
==================================*/
-- department_id이 10이면 'ACCOUNTING', 20이면 'RESEARCH', 
--                30이면 'SALES', 40이면 'OPERATIONS', 'OTHERS'



-- 입사일을 이용해서 한글로 요일을 출력하시오.


-- dayofweek
-- 입사일 기준 한글로 요일을 출력
select first_name,hire_date,
case DAYOFWEEK(hire_date)
	when 1 then '일'
	when 2 then '월'
	when 3 then '화'
	when 4 then '수'
	when 5 then '목'
	when 6 then '금'
	when 7 then '토'
end as '요일'
from employees;

-- 직급이 'PR_REP' 인 사원은 5%, 'SA_MAN'인 사원은 10%, 
-- 'AC_MGR'인 사원은 15%, 'PU_CLERK' 인 사원은 20% 를 인상

select JOB_ID,salary,
case JOB_ID 
when 'PR_REP' then salary * 1.05
when 'SA_MAN' then salary * 1.1
when 'AC_MGR' then salary * 1.15
when 'PU_CLERK' then salary * 1.2
end as SALARY
from employees;



-- 입사일에서 월이 1-3이면 '1사분기', 4-6이면 '2사분기', 
--              7-9이면 '3사분기', 10-12이면 '4사분기'
-- 로 처리를 하고 사원명(first_name), 
-- 입사일(hire_date), 분기로 출력하시오.

select hire_date,
case
	when MONTH(hire_date) <=3 then '1사분기'
	when MONTH(hire_date) <=6 then '2사분기'
	when MONTH(hire_date) <=9 then '3사분기'
	when MONTH(hire_date) <=12 then '4사분기'
end as '분기'
from employees;


/*=================================================
집계함수(Aggregate Function), 그룹함수(Group Function)
https://dev.mysql.com/doc/refman/8.0/en/aggregate-functions.html#function_max
===================================================*/

-- max(컬럼) : 최대값
SELECT max(salary)
FROM employees;

-- min(컬럼) : 최소값
SELECT min(salary)
FROM employees;
-- count(컬럼) null값이 아닌 값만 리턴
SELECT count(salary)
FROM employees;
-- sum(컬럼) 합계
-- avg(컬럼) 평균

-- 집계함수를 단순컬럼하고 같이 사용할고 싶으면 단순컬럼을 group by로 그룹화 해야 한다.

-- 50이하인 부서에 대해서 null이 아닌 부서별의 직원수를 출력하시오.
select DEPARTMENT_ID ,count(EMPLOYEE_ID) from employees where DEPARTMENT_ID <= 50 
group by DEPARTMENT_ID ;

-- 업무별 급여 합계를 출력하라
select job_id,sum(SALARY) from employees group by JOB_ID;


-- 부서별 최소급여, 최대급여가 같지 않을때만  부서, 부서최소급여, 부서최대급여을 부서별 오름차순으로 출력하시오.
select DEPARTMENT_ID,sum(SALARY),MIN(SALARY),MAX(SALARY) from employees group by DEPARTMENT_ID having min(SALARY)!=max(SALARY) order by DEPARTMENT_ID ASC;



/*--------------------------
시스템 함수
----------------------------*/
 -- 현재 사용자와 현재 선택된 데이터베이스
 -- user() = current_user() = dsession_user()
 -- datebase() = schema()
SELECT user(), database();  -- root@localhost	myxedb

select * from employees;
select FOUND_ROWS();


 -- 바로 앞의 INSERT, UPDATE, DELETE문에서 입력, 수정, 삭제된 행의 갯수를 구함
 -- CREATE, DROP문은 0을 반환하고, SELECT문은 -1을 반환한다.
 -- row_count()
 select VERSION();
 
/*cross join*/
select e.DEPARTMENT_ID ,d.DEPARTMENT_ID ,e.FIRST_NAME  from employees e cross join departments d 
 
/*inner join*/
/*
 * 가장많이 사용되는 조인 방법으로 조인 대상이 되는 두 테이블에서 공통적으로 존재하는 컬럼의 값 과 일치하는 행을 연결하여 결과를 생성하는 방법이다.
 */

select e.DEPARTMENT_ID ,e.FIRST_NAME ,e.JOB_ID ,j.JOB_TITLE  from employees e inner join jobs j on e.JOB_ID = j.JOB_ID;
select e.DEPARTMENT_ID ,e.FIRST_NAME ,e.JOB_ID ,j.JOB_TITLE  from employees e , jobs j where e.JOB_ID = j.JOB_ID;


-- employees와 departments테이블에서 사원번호(employee_id),
-- 부서번호(department_id), 부서명(department_name)을 검색하시오.
select e.EMPLOYEE_ID  ,d.DEPARTMENT_ID , d.DEPARTMENT_NAME  from employees e , departments d  where e.DEPARTMENT_ID  = d.DEPARTMENT_ID ;

-- 20번 부서의 이름과 그 부서에 근무하는 사원의 이름을 출력하시오.
select d.DEPARTMENT_NAME ,e.FIRST_NAME  from employees e ,departments d 
where e.DEPARTMENT_ID =d.DEPARTMENT_ID and d.DEPARTMENT_ID = 20;


-- 1400 1500 번 위치의 도시이름과 그곳에 있는 부서의 이름을 출력
select l.location_id, l.city, d.DEPARTMENT_NAME  from locations l, departments d where l.LOCATION_ID in(1400,1500) and d.LOCATION_ID = l.LOCATION_ID;

/*=================================================================
3. outer join
  한 테이블에는 데이터가 있고 다른 반대쪽에는 데이터가 없는 경우에
  데이터가 있는 테이블의 내용을 모두 가져오는 조건이다.
  ===============================================================*/

select e.FIRST_NAME ,e.SALARY ,d.DEPARTMENT_NAME  from employees e left outer join departments d on e.DEPARTMENT_ID = d.DEPARTMENT_ID;


select e.FIRST_NAME ,e.SALARY ,d.DEPARTMENT_NAME  from employees e right outer join departments d on e.DEPARTMENT_ID = d.DEPARTMENT_ID;


/*=================================================
4. self join
 하나의 테이블을 두개의 테이블로 설정해서 사용하는 조인방법이다.
 하나의 테이블에 같은데이터가 두개의 컬럼에 다른 목적으로 저장되여 있는 경우
 employees, employee_id, manager_id
====================================================*/ 
select e.EMPLOYEE_ID ,e.FIRST_NAME ,e.MANAGER_ID  from employees e  where e.EMPLOYEE_ID =200;
select e.EMPLOYEE_ID ,e.FIRST_NAME ,e.MANAGER_ID  from employees e  where e.EMPLOYEE_ID =101;
select e.EMPLOYEE_ID ,e.FIRST_NAME ,e.MANAGER_ID  from employees e  where e.EMPLOYEE_ID =100;


select e.EMPLOYEE_ID as "사원번호",e.FIRST_NAME as "사원명",e.MANAGER_ID as "관리자번호",e2.FIRST_NAME as "관리자명" 
from employees e inner join employees e2 on e.MANAGER_ID  = e2.EMPLOYEE_ID or e2.MANAGER_ID is null;



/*-----------------------------------------------------------------------------------------
서브쿼리(subquery)
 하나의 SQL문안에 포함되어 있는 또 다른 SQL문을 말한다.
 서브쿼리는 알려지지 않은 기준을 이용한 검색을 위해 사용한다.
 서브쿼리는 메인쿼리가 서브쿼리를 포함하는 종속적인 관계이다.
 서브쿼리는 메인쿼리의 컬럼을 모두 사용할 수 있지만 메인쿼리는 서브쿼리의 컬럼을 사용할 수 없다. 
 질의 결과에 서브쿼리 컬럼을 표시해야 한다면 조인방식으로 
    변환하거나 함수, 스칼라 서브쿼리(scarar subquery)등을 사용해야 한다. 
 조인은 집합간의 곱(Product)의 관계이다. 
 
외부 쿼리 (메인쿼리)
 :일반 쿼리를 의미합니다.
스칼라 서브쿼리
 :SELECT 절에 쿼리가 사용되는 경우로, 함수처럼 레코드당 정확히 하나의 값만을 반환하는 서브쿼리입니다.
인라인 뷰
 :FROM 절에 사용되는 쿼리로, 원하는 데이터를 조회하여 가상의 집합을 만들어 조인을 수행하거나 가상의 집합을 다시 조회할 때 사용합니다.



서브쿼리를 사용할 때 다음 사항에 주의
  서브쿼리를 괄호로 감싸서 사용한다. 
  서브쿼리는 단일 행(Single Row) 또는 복수 행(Multiple Row) 비교 연산자와 함께 사용 가능하다. 
  단일 행 비교 연산자는 서브쿼리의 결과가 반드시 1건 이하이어야 하고 복수 행 비교 연산자는 서브쿼리의 결과 건수와 상관 없다. 
  서브쿼리에서는 ORDER BY를 사용하지 못한다. 
  ORDER BY절은 SELECT절에서 오직 한 개만 올 수 있기 때문에 ORDER BY절은 메인쿼리의 마지막 문장에 위치해야 한다.
  

서브 쿼리 사용가능한 위치
SELECT, FROM, WHERE, HAVING,ORDER BY 
INSERT문의 VALUES,
UPDATE문의 SET, 
CREATE문

서브쿼리의 종류는 동작하는 방식이나 반환되는 데이터의 형태에 따라 분류할 수 있다.
1 동작하는 방식에 따른 서브쿼리 분류
  Un-Correlated(비연관) : 서브쿼리가 메인쿼리 컬럼을 가지고 있지 않는 형태의 서브쿼리이다.
          메인쿼리에 값(서브쿼리가 실행된 결과)를 제공하기 위한 목적으로  주로 사용한다.
  Correlated(연관) : 서브쿼리가 메인쿼리 칼럼을 가지고 있는 형태의 서브쿼리이다.
          일반적으로 메인쿼리가 먼저 수행되어 읽혀진 데이터를 서브쿼리에서 조건이 맞는지 확인
	  하고자 할 때 주로 사용된다.  (EXISTS서브쿼리는 항상 연관 서브쿼리로 사용된다. 조건을 만족하는 1건만 찾으면
	  추가 검색을 하지 않는다.)
2 반환되는 데이터의 형태에 따른 서브쿼리 종류
  Single Row(단일행 서브쿼리) : 서브쿼리의 실행결과가 항상 1건 이하인 서브쿼리를 의미한다. 
          단일행 서브쿼리는 단일 행 비교 연산자와 함께 사용된다.
	  단일 행 비교 연산자는 =, <, <=, >, >=, <>이 있다.
  Multi Row(다중행 서브쿼리) : 서브쿼리의 실행 결과가 여러 건인 서브쿼리를 의미한다. 
          다중 행 서브쿼리는 다중 행 비교 연산자와 함께 사용된다. 
	  다중 행 비교 연산자에는 in, all, any, some, exists가 있다.
	      in : 메인쿼리의 비교조건('='연산자로 비교할 경우)이 서브쿼리의 결과 중에서
               하나라도 일치하면 참이다.
           any,some : 메인 쿼리의 비교 조건이 서브 쿼리의 검색 결과와 하나 이상이 일치하면
                참이다.
           all : 메인 쿼리의 비교 조건이 서브 쿼리의 검색 결과와 모든 값이 일치하면 참이다.
           exists : 메인 쿼리의 비교 조건이 서브 쿼리의 결과 중에서 만족하는 값이 하나라도
               존재하면 참이다.
  Multi Column(다중칼럼 서브쿼리) : 서브쿼리의 실행 결과로 여러 컬럼을 반환한다.
          메인쿼리의 조건절에 여러 컬럼을 동시에 비교할 수 있다. 
	  서브쿼리와 메인쿼리에서 비교하고자 하는 컬럼 갯수와 컬럼의 위치가 동일해야 한다.
--------------------------------------------------------------------------------- */   
 -- 90 번 부서에 근무하는 Lex의 부서명을 출력하시오.  



 -- 'Lex'와 동일한 업무(job_id)를 가진 사원의 이름(first_name), 
 -- 업무명(job_title), 입사일(hire_date)을 출력하시오.


-- 'IT'에 근무하는 사원이름(first_name), 부서번호을 출력하시오.
select e.FIRST_NAME ,e.DEPARTMENT_ID  from employees e ,(select * from departments where DEPARTMENT_NAME = 'IT' ) as d where e.DEPARTMENT_ID  = d.DEPARTMENT_ID;

-- 'Bruce'보다 급여를 많이 받은 사원이름(first_name), 부서명, 급여를 출력하시오.
select e.FIRST_NAME, e.SALARY  from employees e inner join departments d 
on d.DEPARTMENT_ID = e.DEPARTMENT_ID 
where e.SALARY > (select SALARY from employees where FIRST_NAME = "Bruce"); 



-- Steven와 같은 부서에서 근무하는 사원의 이름, 급여, 입사일을 출력하시오.(in)
select e.FIRST_NAME,e.SALARY,e.HIRE_DATE  from employees e where  e.DEPARTMENT_ID in ( select d.DEPARTMENT_ID  from departments d  where e.FIRST_NAME ='Steven'); 


-- 부서별로 가장 급여를 많이 받는 사원이름, 부서번호, 급여를 출력하시오.(in)
select first_name,e.DEPARTMENT_ID ,e.SALARY  from employees e where (e.DEPARTMENT_ID ,e.SALARY ) in (select e.DEPARTMENT_ID,MAX(e.SALARY) from employees group by department_id)


-- 30소속된 사원들 중에서 급여를 가장 받은 사원보다 더 많은 급여를 받는
-- 사원이름, 급여, 입사일을 출력하시오. (ALL)
-- (서브쿼리에서 max()함수를 사용하지 않는다);


select first_name,salary,hire_date from employees e where
e.SALARY > ALL(select SALARY from employees where DEPARTMENT_ID = 30);



select first_name,salary,hire_date from employees e where
e.SALARY > ANY(select SALARY from employees where DEPARTMENT_ID = 30)


-- 사원이 있는 부서만
select distinct DEPARTMENT_ID  from employees;

select department_id,department_name from departments where DEPARTMENT_ID in(select distinct DEPARTMENT_ID from employees);

/*-----------------------------------------------------
 상관관계 서브쿼리
 : 서브쿼리에서 메인쿼리의 컬럼을 참조한다.(메인쿼리를 먼저수행한다.)
   서브쿼리는 메인쿼리 각각의 행에 대해서 순서적으로 한번씩 실행한다.
 <아래 쿼리 처리순서>
 1st : 바깥쪽 쿼리의 첫째 row에 대하여 
 2nd : 안쪽 쿼리에서 자신의 속해있는 부서의 MAX salary과
       비교하여 true 이면 바깥의 컬럼값을 반환하고 , 
       false 이면 값을 버린다. 
 3rd : 바깥쪽 쿼리의 두 번째 row에 대하여 마찬가지로 실행하며, 
       이렇게 바깥쪽 쿼리의 마지막 row까지 실행한다. 
	   
https://www.w3resource.com/sql/subqueries/correlated-subqueries-using-aliases.php	   
----------------------------------------------------*/                    
-- 부서별 최고 급여를 받는 사원을 출력하시오.
select department_id, max(salary), from employees group by DEPARTMENT_ID;


select DEPARTMENT_ID ,SALARY ,FIRST_NAME ,HIRE_DATE from employees where 
(DEPARTMENT_ID,SALARY) in 
(select DEPARTMENT_ID ,max(salary) from employees group by DEPARTMENT_ID )
order by DEPARTMENT_ID ASC;



-- 관리자가 있는 사원의 정보

select * from employees e where exists ( select 1 from employees e2
where  e.MANAGER_ID is not null)



-- 관리자가 없는 사원의 정보

select * from employees e where not exists ( select 1 from employees e2
where  e.MANAGER_ID is not null)



/*==========================================================
 WITH ROLLUP
 총합 또는 중간 합계가 필요할때 GROUP by 절과 함께 WITH ROLLUP문을 사용한다.
 ===========================================================*/
select department_id,job_id,count(*) as count 
from employees group by DEPARTMENT_ID ,JOB_ID with ROLLUP
order by DEPARTMENT_ID DESC,JOB_ID DESC;


/*=================================================================================
 그룹내 순위관련함수
 RANK( ) OVER( ) : 특정 컬럼에 대한 순위를 구하는 함수로 동일한 값에 대해서는 동일한 순위를 준다. 
 DENSE_RANK( ) OVER( ) : 동일한 순위를 하나의 건수로 취급한다.
 ROW_NUMBER( ) OVER( ) : 동일한 값이라도 고유한 순위를 부여한다.
 ===================================================================================*/
 /*    RANK        DENSE_RANK       ROW_NUMBER
  90    1              1                1 
  90    1              1                2 
  85    3              2                3
  80    4              3                4  

 */

SELECT job_id, first_name, salary, RANK() OVER(ORDER BY salary DESC)
 FROM employees;
 
 SELECT job_id, first_name, salary, DENSE_RANK() OVER(ORDER BY salary DESC)
 FROM employees;

 
 
 
select row_number() over() as rownum, first_name, SALARY from employees order by salary desc limit 3;
 
 

select row_number() over() as rownum, first_name, SALARY from employees order by salary desc 
limit 0,1;/*시작번호, 개수*/

select row_number() over(order by SALARY desc) as rownum, first_name, SALARY from employees order by salary desc 
limit 0,5;/*시작번호, 개수*/


select DENSE_RANK() over(order by COUNT(*) DESC) as rownumber, e.HIRE_DATE,COUNT(*) from employees e 
group by HIRE_DATE; 

select MONTH(hire_date) as 월,count(*) as 입자사수
from employees group by MONTH(hire_date)
order by count(*) desc limit 3;


/*================================================================================
 WITH 절과 CTE
 
 WITH절은 CTE(Common Table Expression)를 표현하기 위한 구문으로 MySQL8.0부터  사용할 수 있다.
 CTE는 기존의 뷰, 파생테이블, 임시 테이블 등으로 사용되던 것을 대신할 수 있다.
 CTE는 ANSI-SQL99 표준에서 나온 것이다. 기존의 SQL ANSI-SQL92를 기준으로 한다.
 최근의 DBMS(DataBase Management System)는 대개 ANSI-SQL99와 호환되므로  다른 DBMS에서도 같거나
 비슷한 방식으로 응용한다.
 CTE는 비재귀적(Non-Recursive) CTE와 재귀적(Recursive) CTE두 가지가 있다.
 
 <비재귀적(Non-Recursive) CTE>
 WITH CTE_테이블이름(열이름)
 AS
 (
   쿼리문;
 )
 SELECT 열이름 FROM CTE_테이블이름;
 ===================================================================================*/

#정보처리기사는 프로젝트 끝나고


 WITH  deptcnt(id, total)
AS
(SELECT department_id, count(*)
FROM employees
GROUP BY department_id)
SELECT id, total FROM deptcnt;

