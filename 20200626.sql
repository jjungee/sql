SELECT *
FROM emp
WHERE ename LIKE 'S%';

SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE '신%';

SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE '%이%';

UPDATE member set mem_name = '쁜이'
WHERE mem_id = 'b001';

UPDATE member set mem_name = '신이환'
WHERE mem_id = 'c001';
-----------------------------------------------------------------

comm 컬럼의 값이 null인 사원들만 조회
SELECT empno, ename, comm
FROM emp
WHERE  comm = NULL;

NULL값에 대한 비교는 =이 아니라 IS연산자를 사용한다.
SELECT empno, ename, comm
FROM emp
WHERE  comm IS NULL;

emp테이블에서 comm 값이 NULL이 아닌 데이터를 조회
SELECT *
FROM emp
WHERE  comm IS NOT NULL;
-----------------------------------------------------------------

emp테이블에서 mgr컬럼이 7698이면서 sal컬럼의 값이 1000보다 큰 사원 조회
SELECT *
FROM emp
WHERE mgr = 7698 OR sal > 1000;

emp테이블에서 mgr가 7698, 7839가 아닌 사원 조회
SELECT *
FROM emp
WHERE mgr NOT IN(7698, 7839);

mgr 사번이 7698이 아니고, 7839가 아니고, NULL이 아닌 직원 조회
SELECT *
FROM emp
WHERE mgr NOT IN(7698, 7839, NULL);  > 데이터 안 나옴
=> mgr != 7698 AND MGR != 7839 AND mgr!= NULL
                    ↓ in 연산자로 바꾸기
 mgr = 7698 OR MGR = 7839 OR mgr = NULL

mgr NOT IN(7698, 7839)
!(mgr = 7698 OR mgr = 7839) = 'mgr != 7698 AND mgr =! 7839'
*** mgr 컬럼에 NULL값이 있을 경우 비교연산으로 NULL비교가 불가하기 때문에 NULL을 갖는 행은 무시가 된다.

SELECT  *
FROM emp;
WHERE mgr != 7698 AND mgr != 7839;

SELECT *
FROM emp
WHERE job = 'SALESMAN' AND hiredate >= TO_DATE('1981/06/01', 'YYYY/MM/DD');

emp테이블에서 부서번호가 10번이 아니고 입사일자가 1981년 6월 1일 이후인 직원의 정보 조회(IN, NOT IN연산자 사용 금지)
SELECT *
FROM emp
WHERE deptno != 10 
  AND hiredate >= TO_DATE('1981/06/01', 'YYYY/MM/DD');
  
emp테이블에서 부서번호가 10번이 아니고 입사일자가 1981년 6월 1일 이후인 직원의 정보 조회(IN NOT IN연산자 사용)
SELECT *
FROM emp
WHERE deptno NOT IN (10) 
  AND hiredate >= TO_DATE('1981/06/01', 'YYYY/MM/DD');

emp테이블에서 부서번호가 10번이 아니고 입사일자가 1981년 6월 1일 이후인 직원의 정보 조회
(IN연산자 사용 단, 부서는 10, 20, 30만 있다고 가정)
SELECT *
FROM emp
WHERE deptno IN (20, 30) 
  AND hiredate >= TO_DATE('1981/06/01', 'YYYY/MM/DD');
  
emp테이블에서 job이 SALESMAN이거나 입사일자가 1981년 6월 1일 이후인 직원의 정보 조회
SELECT *
FROM emp
WHERE job = 'SALESMAN'
  OR hiredate >= TO_DATE('1981/06/01', 'YYYY/MM/DD');
  
emp테이블에서 job이 SALESMAN이거나 사원번호가 78로 시작하는 직원의 정보 조회  
SELECT *
FROM emp
WHERE job = 'SALESMAN'
  OR empno LIKE '78%';  > 형변환 : 명시적 변환, (묵시적 변환)
  
emp테이블에서 job이 SALESMAN이거나 사원번호가 78로 시작하는 직원의 정보 조회(LIKE사용 X)  
SELECT *
FROM emp
WHERE job = 'SALESMAN'
  OR empno between 7800 AND 7899;

emp테이블에서 job이 SALESMAN이거나 사원번호가 78로 시작하면서 입사일자가 1981년 6월 1일 이후인 직원의 정보 조회
SELECT *
FROM emp
WHERE job = 'SALESMAN' 
   OR (empno LIKE '78%' AND hiredate >= TO_DATE('1981/06/01','yyyy/mm/dd'));
-----------------------------------------------------------------
SELECT *
FROM emp
ORDER BY ename;

SELECT empno, ename, sal, sal*12 salary
FROM emp
ORDER BY sal;

SELECT 절에 기술된 컬럼순서(인덱스)로 정렬
SELECT empno, ename, sal, sal*12 salary
FROM emp
ORDER BY 4;

dept테이블의 모든 정보를 부서이름으로 오름차순 정렬하여 조회
SELECT *
FROM dept
ORDER BY dname;

dept테이블의 모든 정보를 부서위치로 오름차순 정렬하여 조회
SELECT *
FROM dept
ORDER BY loc DESC;

emp테이블에서 상여 정보가 있는 사람들만 조회(상여가 0일 경우 상여가 없는 것으로 간주)
상여를 많이 받는 사람 먼저 조회되도록 , 같을 경우 사번으로 내림차순 정렬
SELECT *
FROM emp
WHERE comm > 0
ORDER BY comm DESC, empno DESC;