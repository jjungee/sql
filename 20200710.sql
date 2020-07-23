UPDATE : 상수값으로 업데이트 => 서브쿼리 사용가능

INSERT INTO emp (empno, ename, job) VALUES(9999, 'brown', 'RANGER');

SELECT *
FROM emp;

쿼리 1]
방금 입력한 9999번 사번을 갖는 사원의 deptno와 job컬럼의 값을 SMITH사원의 job값으로 업데이트
UPDATE emp SET deptno = (SELECT deptno FROM emp WHERE ename = 'SMITH'),
               job = (SELECT job FROM emp WHERE ename = 'SMITH')
WHERE empno = 9999;

UPDATE쿼리 1 실행할 때 안쪽 SELECT쿼리 2개가 포함됨 => 비효율적
고정된 값은 업데이트 하는게 아니라 다른 테이블에 있는 값을 통해서 업데이트할 때 비효율이 존재
 => MURGE구문을 통해 보다 효울적으로 업데이트 가능
 
DELETE : 테이블의 행을 삭제할 때 사용하는 SQL
         특정 컬럼만 삭제하는 건 UPDATE
         DELETE구문은 행 자체를 삭제.
1. 어떤 테이블에서 삭제할지
2. 테이블의 어떤 행을 삭제할지

문법 DELETE [FROM] 테이블명
WHERE 삭제할 행을 선택하는 조건;

UPDATE쿼리 실습 시 9999번 사원을 등록함. 해당 사원을 삭제하는 쿼리 작성
DELETE emp
WHERE empno = 9999;

DELETE쿼리도 SELECT쿼리 작성시 사용한 WHERE절과 동일
서브쿼리 사용 가능.

사원 중에 mgr가 4698인 사원들만 삭제
DELETE emp
WHERE mgr IN (SELECT enono
              FROM emp
              WHERE mgr = 7698);
              
ROLLBACK;

DBMS : 데이터의 복구를 위해서 DML 구문을 실행할 때 마다 로그를 생성
       대량의 데이터를 지울 때는 로그 기록도 부하가 되기 때문에
       개발환경에서는 테이블의 모든 데이터를 지우는 경우에 한해서 TRUNCATE TABLE 테이블명; 명령을 통해 로그를 남기지 않고 빠르게 삭제가 가능하다.
       단, 로그가 없기 때문에 복구가 불가능하다.
       
emp테이블을 이용해서 새로운 테이블을 생성(중복되는 이름으로는 다시 생성 불가능)
CREATE TABLE emp_copy AS
SELECT *
FROM emp;

SELECT *
FROM emp_copy;

DELETE emp_copy;
TRUNCATE TABLE emp_copy;

TRANSACTION;

SELECT *
FROM dept;

DML(Date Maniqulation(조작) Language) : 데이터를 다루(조작하는)는 SQL
SELECT, INSERT, UPDATE, DELETE

DDL(Date Definition(정의) Language) : 데이터를 정의하는 SQL
DDL은 자동 커밋, ROLLBACK 불가
ex) 테이블 생성 DDL실행 => 롤백이 불가능함 => 테이블 삭제 DDL실행

데이터가 들어갈 공간(table) 생성, 삭제
컬럼 추가
각종 객체 생성, 수정, 삭제

테이블 삭제
문법
DROP 객체 종류 객체 이름;
삭제한 테이블과 관련된 데이터는 삭제
나중에 배울 내용
제약조건 같은 것들도 다같이 삭제
테이블과 관련된 내용은 삭제;

DML문과 DDL문을 혼합해서 사용할 경우 발생할 수 있는 문제점
 => 의도와 다르게 DML문에 대해서 COMMIT이 발생할 수 있다.


DROP TABLE emp_copy;

삭제된 테이블이기 때문에 에러남.
SELECT *
FROM emp;

INSERT INTO emp (empno, ename) VALUES(9999, 'brown');

SELECT COUNT(*)
FROM emp;

DROP TABLE batch;

ROLLBACK;
(COMMIT)

SELECT COUNT(*)
FROM emp;

테이블 생성
문법
CREATE RABLE 테이블명 {
    컬럼명1 컬럼1타입,
    컬럼명2 컬럼2타입,
    컬럼명3 컬럼3타입 DEFAULT 기본값
};

ranger라는 이름의 테이블 생성
CREATE TABLE ranger (
    ranger_no NUMBER,
    ranger_nm VARCHAR2(50),
    reg_dt DATE DEFAULT SYSDATE
);    

SELECT *
FROM ranger;

INSERT INTO ranger (ranger_no, ranger_nm) VALUES(100 ,'brown');

데이터 무결성 : 잘못된 데이터가 들어가는 것을 방지하는 성격
 ex) 1. 사원 테이블에 중복된 사원번호가 등록되는 것을 방지
     2. 반드시 입력되어야하는 컬럼의 값을 확인 => 파일시스템이 갖을 수 없는 성격
     
오라클에서 제공하는 데이터 무결성을 지키기 위해 제공하는 제약조건 5가지(4가지)
    (1. NOT NULL
        해당 컬럼에 값이 NULL이 들어오는 것을 제약, 방지
        ex) emp테이블의 empno(사원번호)컬럼) => CHECK제약 조건에 포함되는 조건.
    2. UNIQUE
        전체 행중에 해당 컬럼의 값이 중복이 되면 안된다.
          ex) emp테이블에서 empno 컬럼이 중복이 되면 안된다.
        단. NULL에 대한 중복은 허용한다.
    3. PRIMARY KEY = UNIQUE + NOT NULL
       
    4. FOREIGN KEY
        연관된 테이블에 해당 데이터가 존재해야만 입력이 가능
        emp테이블과 dept테이블은 deptno컬럼으로 연결이 되어있음
        emp테이블에 데이터를 입력할 때 dept테이블에 존재하지 않는 deptno값을 입력하는 것을 방지
    5. CHECK 제약 조건
        컬럼에 들어오는 값을 정해진 로직에 따라 제어
        ex) 어떤 테이블에 성별 컬럼이 존재한다고 가정.
            남성 = M, 여성 = F
            M, F 두 가지 값만 저장할 수 있도록 제어
            C성별을 입력하면?? 시스템 요구사항을 정의할 때 정의하지 않은 값이기 때문에 추후 문제가 될 수도 있다.
            
제약조건 생성 방법
    1. 테이블 생성 시, 컬럼 옆에 기술하는 경우
        *상대적으로 세세하게 제어하는 것은 불가능
    2. 테이블 생성 시, 모든 컬럼을 기술하고나서 제약 조건만 별도로 기술.
        > 1번 방법보다 세세하게 제어하는게 가능함.
    3. 객체 수정 명령을 통해 제약조건을 추가
    
 방법1. PRIMARY KEY 생성
    dept테이블과 동일한 컬럼명, 타입으로 dept_test라는 테이블 이름 생성
        1. dept 테이블 컬럼의 구성정보 확인
         DESC dept;
        
        CREATE TABLE dept_test (
        DEPTNO    NUMBER(2) PRIMARY KEY,   -- > 제약조건에 이름을 붙여주지 않아서 오라클에서 임의로 이름을 붙임
        DNAME     VARCHAR2(14) ,
        LOC       VARCHAR2(13) 
        );
        
        
        SELECT *
        FROM dept_test;
        
        PRIMARY KEY 제약조건 확인
        UNIQUE + NOT NULL
        
        1. NULL값 입력 테스트
        PRIMARY KEY 제약조건에 의해 deptno컬럼에는 null값이 들어갈 수 없다
        INSERT INTO dept_test VALUES (null, 'ddit', 'daejeon');
        
        2. 값 중복 테스트
        INSERT INTO dept_test VALUES(99, 'ddit', 'daejeon');
        deptno컬럼의 값이 99번인 데이터가 이미 존재하기 때문에 중복 테이터로 입력이 불가능하다.
        INSERT INTO dept_test VALUES(99, 'ddit2', '대전');
        
        현 시점에서 dept테이블 deptno컬럼에는 PRIMARY KEY제약이 걸려있지 않은 상황 > 중복된 데이터가 들어갈 수 있음
        
        SELECT *
        FROM dept;
        이미 존재하는 10번 부서 추가로 등록
        
        INSERT INTO dept VALUES (10, 'ddit', 'daejeon');
        
        테이블 생성 시 제약조건 명을 설정한 경우
        DROP TABLE dept_test;
        문법 : 컬럼명 컬럼타입 CONSTRAINT 제약조건 이름 제약조건 타입(PRIMARY KEY)
        PRIMARY KEY  제약조건 명명규칙 : PK_테이블명
        
        CREATE TABLE dept_test (
            DEPTNO    NUMBER(2) CONSTRAINT pk_dept_test PRIMARY KEY,   
            DNAME     VARCHAR2(14) ,
            LOC       VARCHAR2(13) 
        );
        
        INSERT INTO dept_test VALUES(99, 'ddit', 'daejeon');
        INSERT INTO dept_test VALUES(99, 'ddit2', '대전');