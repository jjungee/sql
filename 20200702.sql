부서번호별 사원의 sal, comm 컬럼의 총 합 구하기
SELECT deptno, SUM(sal + comm), SUM(sal + NVL(comm,0)), SUM(sal) + SUM(comm)
FROM emp
GROUP BY deptno;

SELECT deptno,  SUM(sal) + NVL(SUM(comm),0),
                SUM(sal) + SUM(NVL(comm,0))
FROM emp
GROUP BY deptno;

칠거지악 - Decode 또는 Case 사용시에 새끼를 증손자 이상 낳지 말아라
전체 행 조회 시 그룹핑X
SELECT deptno,
       MAX(sal) mas_sal, 
       MIN(sal) min_sal, 
       ROUND(AVG(sal),2) avg_sal, 
       SUM(sal) sum_sal, 
       COUNT(sal) count_sal, 
       COUNT(mgr) count_sal, 
       COUNT(*) count_all
FROM emp
GROUP BY deptno;

SELECT deptno,
       MAX(sal) mas_sal, 
       MIN(sal) min_sal, 
       ROUND(AVG(sal),2) avg_sal, 
       SUM(sal) sum_sal, 
       COUNT(sal) count_sal, 
       COUNT(mgr) count_sal, 
       COUNT(*) count_all
FROM emp
GROUP BY deptno;

deptno대신 부서명이 나오도록 하기
SELECT DECODE(deptno, 10, 'ACCOUNTING'
                    , 20, 'RESEARCH'
                    , 30, 'SALES') dname,
       MAX(sal) mas_sal, 
       MIN(sal) min_sal, 
       ROUND(AVG(sal),2) avg_sal, 
       SUM(sal) sum_sal, 
       COUNT(sal) count_sal, 
       COUNT(mgr) count_sal, 
       COUNT(*) count_all
FROM emp
GROUP BY deptno;


SELECT *
FROM emp;

년월별로 직원이 몇명 입사했는지 조회
SELECT TO_CHAR(hiredate, 'YYYYMM') hire_yyyymm, COUNT(*) cnt
FROM emp
GROUP BY TO_CHAR(hiredate, 'YYYYMM');
년도별로 직원이 몇명 입사했는지 조회
SELECT TO_CHAR(hiredate, 'YYYY') hire_yyyymm, COUNT(*) cnt
FROM emp
GROUP BY TO_CHAR(hiredate, 'YYYY');
 
회사에 존재하는 부서의 개수 조회
SELECT *
FROM dept;

SELECT COUNT(*) cnt
FROM dept;

SELECT COUNT(*)
FROM (SELECT deptno
      FROM emp
      GROUP BY deptno);

SELECT COUNT(COUNT(*)) cnt
FROM emp
GROUP BY deptno;

JOIN : 컬럼을 확장하는 방법(데이터를 연결한다)
       다른 테이블의 컬럼을 가져온다
       REBMS가 중복을 최소화하는 구조이기대 문에 하나의 테이블에 데이터를 전부 담지 않고, 목적에 맞게 설계한 테이블에 제이터가 분산이 된다.
       하지만 데이터를 조회할 때 다른 테이블의 데이터를 연결하여 하나행 컬럼을 가져올 수 있다.
       
       ANSI - SQL
       ORACLE - SQL의 차이가 다소 발생
       
ANSI - American National Standard Institue SQL
ORACLE - SQL문법

ANSI - SQL join
NATURAL JOIN : 조인하고자 하는 테이블간 컬럼명이 동일할 경우 해당 컬럼으로 행을 연결
               컬럼 이름 뿐만 아니라 테이터 타입도 동일해야함.
               
문법 : 
SELECT 컬럼..
FROM 테이블1 NATURAL JOIN 테이블2
한정자를 사용해 어떤 테이블에서 가져올지 명시 가능
join조건으로 사용한 컬럼은 테이블 한정자 사용 불가능(에러남)

emp, dept 두 테이블의 공통된 이름을 갖는 컬럼 deptno

SELECT emp.empno, ename, deptno, dname
FROM emp NATURAL JOIN dept;

위의 쿼리를 ORACLE 버젼으로 수정
오라클에서는 조인 조건을 WHERE절에 기술
행을 제한하는 조건, 조인 조건 => WHERE절에 기술

SELECT emp.*, emp.deptno, dname
FROM emp, dept
WHERE emp.deptno = dept.deptno;
SELECT절과 WHERE절에 컬럼명만 쓰면 에러남, 한정자를 통해 테이블명을 명시해줘야함.

SELECT emp.*, emp.deptno, dname
FROM emp, dept
WHERE emp.deptno != dept.deptno; => 다른 조건과 모두 조인함. 14행 > 42행

ANSI-SQL : JOIN WITH USING
조인 테이블간 동일한 이름의 컬럼이 두개 이상인데 이름이 같은 컬럼 중 일부로만 조인하고 싶을 때 사용


SELECT *
FROM emp JOIN dept USING (deptno);

위의 쿼리를 ORACLE 조인으로 변경하면??

SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno;

ANSI-SQL : JOIN WITH ON
위에서 배운 NATURAL JOIN, JOIN with USINT의 경우 조인 테이블의 조인 컬럼의 이름이 같아야한다는 제약 조건이 있음
설계상 두 테이블의 컬럼 이름이 다를 수도 있음. 컬럼 이름이 다를 경우 개발자가 직접 조인 조건을 기술할 수 있도록 제공해주는 문법
컬럼 조건을 개발자가 임의로 설정

SELECT *
FROM emp JOIN dept ON (emp.deptno = dept.deptno);

ORACLE - SQL
SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno;

SELF-JOIN : 동일한 테이블끼리 조인할 때 지칭하는 명칭
            (별도의 키워드가 아님.)
            
SELECT *
FROM emp;

SELECT 사원번호, 사원이름, 사원의 상사 사원번호, 사원의 상사 이름
FROM emp;

ANSI-SQL
SELECT e.empno, e.ename, e.mgr, m.ename
FROM emp e JOIN emp m ON (e.mgr = m.empno);
king은 mgr이 null값이기 때문에 조인에 실패.

사원 중 사원의 번호가 7369-7698인 사원만 대상으로 해당 사원의 사원번호, 이름, 상사의 사원번호, 상사의 이름 조회
SELECT e.empno, e.ename, e.mgr, m.ename
FROM emp e JOIN emp m ON (e.mgr = m.empno)
WHERE e.empno >= 7369 AND e.empno <= 7698;
             = 같은 결과
SELECT empno, ename, mgr, ename
FROM emp
WHERE empno BETWEEN 7369 AND 7698;


NON-EQUI-JOIN : 조인 조건이 =이 아닌 조인(!= 값이 다를 때 연결)
SELECT *
FROM salgrade;

SELECT empno, ename, sal, grade
FROM emp, salgrade
WHERE sal BETWEEN losal AND hisal;

SELECT emp.empno, emp.ename, emp.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno;

SELECT *
FROM emp;

SELECT emp.empno, emp.ename, dept.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
  AND emp.deptno IN (10,30);