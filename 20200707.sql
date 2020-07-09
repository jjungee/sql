CROSS JOIN : 테이블 간 조인 조건을 기술하지 않은 형태로 두 테이블의 행간 모든 가능한 조합으로 조인이 되는 형태
크로스 조인의 조회 결과를 필요로 하는 메뉴는 거의 없음
* SQL의 중간 단계에서 필요한 경우는 존재
ORQCLE SQL은 WHERE절에 조인 조건을 기술하지 않으면 CROSS JOIN이 됨. 
ANSISQL은 ON절에 조건을 기술하지 않으면 에러남


CROSS JOIN 실습1

ORACLE
SELECT *
FROM customer, product;

ANSI
SELECT *
FROM customer CROSS JOIN product;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          

SUBQUERY : SQL내부에서 사용된 SQL(Main쿼리에서 사용된 쿼리)
사용 위치에 따른 분류
1. SELECT절 : scalar(단일의) subquery
2. FROM 절 : INLINE-VIEW
3. WHERE 절 : subquery

반환하는 행, 컬럼 수에 따른 분류
1. 단일행, 단일 컬럼
2. 단일행, 복수 컬럼
3. 다중행, 단일 컬럼
4. 다중행, 복수 컬럼

smith사원이 속한 부서에 속하는 사원들은 누가 있을까?

2번의 쿼리가 필요
1. smith가 속한 부서의 번호를 확인하는 쿼리
2. 1번에서 확인한 부서번호로 해당 부서에 속하는 사원들을 조회하는 쿼리

SELECT *
FROM emp
WHERE ename = 'SMITH';

SELECT *
FROM emp
WHERE deptno = 20;

SMITH가 현재 상황에서 속한 부서는 20번인데 나중에 30번 부서로 부서전배가 이루어지면 2번에서 작성한 쿼리가 수정이 되어야한다.
WHERE deptno = 20 => WHERE deptno = 30

우리가 원하는 것은 고정된 부서번호로 사원 정보를 조회하는 것이 아니라
SMITH가 속한 부서를 통해 데이터를 조회 => SMITH가 속한 부서가 바뀌더라도 쿼리를 수정하지 않도록 하는 것

SELECT *
FROM emp
WHERE ename = 'SMITH'

외부 쿼리 : 메인 쿼리, 괄호 안쪽 : 서브쿼리
    => SMITH의 부서번호가 변경되더라도 우리가 원하는 데이터 셋을 쿼리의 수정 없이 조회할 수 있다.(코드 변경이 필요없다 => 유지보수가 편하다)
SELECT *
FROM emp
WHERE deptno = (SELECT deptno
                FROM emp
                WHERE ename = 'SMITH');  => 비상호 연관 서브쿼리

1. 스칼라 서브쿼리 : SELECT 절에서 사용된 서브쿼리
* 제약사항 : 반드시 서브쿼리가 하나의 행, 하나의 컬럼을 반환해야된다.
스칼라 서브쿼리가 단일행 복수컬럼을 리턴하는 경우 (x)
SELECT empno, (SELECT deptno, dname FROM dept WEHRE deptno = 10)
FROM emp;

스칼라 서브쿼리가 단일행, 단일 컬럼을 리턴하는 경우(O)
SELECT empno, ename, (SELECT deptno FROM dept WHERE deptno = 10) depno, 
                     (SELECT dname FROM dept WHERE deptno = 10) dname
FROM emp;

메인쿼리의 컬럼을 사용하는 스칼라 서브쿼리
SELECT empno, ename, deptno, (SELECT dname FROM dept WHERE deptno = emp.deptno) dname                     
FROM emp;                                                           위의 emp는 메인쿼리에서 가져오는 것

SELECT empno, ename, deptno, (SELECT dname FROM dept WHERE dept.deptno = emp.deptno) dname                     
FROM emp;

SELECT empno, ename, dname, dname                     
FROM emp;


서브쿼리에서 메인쿼리의 컬럼을 사용 유무에 따른 분류
1. 서브쿼리에서 메인쿼리의 컬럼을 사용 : corerelated subquery => 상호 연관 서브쿼리
        ==> 서브 쿼리를 단독으로 실행하는 것이 불가능
2. 서브쿼리에서 메인쿼리의 컬럼 미사용 : non correlated subquery => 비상호 연관 서브쿼리
        ==> 서브쿼리를 단독으로 실행하는 것이 가능

IN-LINE VIEW : 그동안 많이 사용

SUBQUERY : WHERE절에서 사용된 것
WEHRE절에서 사용 시 주의 점 : 연산자와 서브쿼리의 반환 행 수 주의. (연산자를 사용 시 서브쿼리에서 여러개 행(값)을 리턴하면 논리적으로 맞지 않다
IN연산자를 사용 시 서브쿼리에서 리턴하는 여러개 행(값)과 비교가 가능
SMITH가 속한 부서에 속하는 사원들을 조회

SELECT *
FROM emp
WHERE deptno = (SELECT deptno
                FROM emp
                WHERE ename = 'SMITH');
               
SELECT *
FROM emp
WHERE deptno IN (SELECT deptno
                 FROM emp
                 WHERE ename IN( 'SMITH', 'ALLEN'));  => 2행 조회됨
                 
                 
평균 급여보다 높은 급여를 받는 직원의 수
SELECT COUNT(*) 
FROM emp
WHERE sal > (SELECT AVG(sal)
             FROM emp);


SELECT *
FROM emp
WHERE sal > (SELECT AVG(sal)
             FROM emp);