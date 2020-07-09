OUTER JOIN <=> INNTER JOIN

INNER JOIN : 조인 조건을 만족하는 (조인에 성공하는) 데이터만 조회
OUTER JOIN : 조인 조건을 만족하지 않더라도(조인에 실패하더라도) 기준이 되는 테이블 쪽의 데이터(컬럼)은 조회가 되도록 하는 조인 방식

OUTER JOIN : 
    LEFT OUTER JOIN : 조인 키워드의 왼쪽에 위치하는 케이블을 기준삼아 UOTER JOIN 시행
    RIGHT OUTER JOIN : 조인 키워드의 오른쪽에 위치하는 케이블을 기준삼아 UOTER JOIN 시행
    FULL OUTER JOIN : LEFT OUTER + RIGHT OUTER - 중복되는 것 제외
    
ANSI-SQL
FROM 테이블 1 LEFT OUTER JOIN 테이블 2 ON (조인 조건)

OURCLE-SQL : 데이터가 없는데 나와야하는 테이블의 컬럼
FROM 테이블1, 테이블2
WHERE 테이블1.컬럼 = 테이블2.컬럼(+) (+) : OUTER JOIN 기호, 데이터가 없는데(NULL인데) 나와야하는 쪽에 붙여야함

ANSI-SQL OUTER
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e LEFT OUTER JOIN emp m ON (e.mgr = m.empno);

ORACLE-SQL OUTER   
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e, emp m 
WHERE e.mgr = m.empno(+);

OUTER JONI시 조인 조건(ON절에 기술)과 일반 조건(WHERE절에 기술)적용 시 주의사항
> OUTER JOIN을 사용하는데 WHERE절에 별도의 다른 조건을 기술할 경우 원하는 결과가 안 나올 수 있다.
   => OUTER JOIN의 결과가 무시됨
   
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e LEFT OUTER JOIN emp m ON (e.mgr = m.empno AND m.deptno = 10);

OURCLE-SQL
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e, emp m 
WHERE e.mgr = m.empno(+) AND m.deptno(+) = 10;

조인 조건을 WHERE절로 변경한 경우
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e LEFT OUTER JOIN emp m ON (e.mgr = m.empno) 
WHERE m.deptno = 10; > 일반적으로 WHERE절에 조건을 기술하지 않음.

위의 쿼리는 OUTER JOIN을 적용하지 않은 아래 쿼리와 동일한 결과를 나타낸다.

SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e JOIN emp m ON (e.mgr = m.empno) 
WHERE m.deptno = 10;

RIGHT OUTER JOIN : 기준 테이블이 오른쪽
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e RIGHT OUTER JOIN emp m ON (e.mgr = m.empno);

FROM emp e LEFT OUTER JOIN emp m ON (e.mgr = m.empno); : 14건
FROM emp e RIGHT OUTER JOIN emp m ON (e.mgr = m.empno); : 21건

FULL OUTER JOIN : LEFT OUTER + RIGHT OUTER - 중복 제거

SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e FULL OUTER JOIN emp m ON (e.mgr = m.empno);

ORACLE SQL에서는 FULL OUTER문법을 제공하지 않음
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e, emp m 
WHERE e.mgr(+) = m.empno(+);