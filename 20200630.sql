SELECT ename, TO_CHAR(hiredate, 'YYYY-MM-DD') hiredate,
       MONTHS_BETWEEN(SYSDATE, hiredate)
FROM emp;

ADD_MONTHS;
SYSDATE : 2020/06/30 => 2020/11/30, 2020/11,30 => 

SELECT ADD_MONTHS(SYSDATE, 5) aft5, ADD_MONTHS(SYSDATE, -5) bef5
FROM dual;

SYSDATE : 2020/06/30이후에 등장하는 첫번째 토요일(7)

SELECT NEXT_DAY(SYSDATE, 7)
FROM dual;

SYSDATE : 2020/06/30 실습 당일의 날짜가 월의 마지막이라 SYSDATE대신 임의의 날짜 문자열로 테스트 2020/06/05

SELECT LAST_DAY(TO_DATE('2020/06/05', 'YYYY/MM/DD'))
FROM dual;

FIRST_DAY구현((20200630 => 20200601)
1. SYSDATE를 문자로 변경하는데 포멧은 YYYYMM
2. 1번의 결과에다가 문자열 결합을 통해 01을 문자 뒤에 붙여준다.
    YYYYMMDD
3. 2번의 결과를 날짜 타입으로 변경

SELECT TO_DATE(TO_CHAR(SYSDATE, 'YYYYMM') || '01','YYYYMMDD') first_date
FROM dual;

SELECT TO_CHAR(TO_DATE(:lday, 'YYYYMM'),'YYYYMM') param, TO_CHAR(LAST_DAY(TO_DATE(:lday,'YYYYMM')), 'DD') dt
FROM dual;

SELECT :lday param, TO_CHAR(LAST_DAY(TO_DATE(:lday,'YYYYMM')), 'DD') dt
FROM dual;

1. 실행계획 생성
EXPLAIN PLAN FOR
    
2. 실행계획 보기
SELECT *
FROM TABLE(dbms_xplan.display);

empno컬럼은 NUMBER타입이지만 형변환이 어떻게 일어났는지 확인하기 위해서 의도적으로 문자열 상수 비교를 진행
EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = '7369';

SELECT *
FROM TABLE(dbms_xplan.display);

실행 계획 읽는 방법
1. 위에서 아래로
2. 단 자식 노드가 있으면 자식 노드부터 읽는다.
   자식노드 : 들여쓰기가 된 노드
   
EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE TO_CHAR(empno) = '7369';

SELECT *
FROM TABLE(dbms_xplan.display);  >>    1 - filter(TO_CHAR("EMPNO")='7369') 14행을 모두 비교하고 문자로 바꿔 불필요한 과정을 거침

6,000,000 <==> 6000000
국제화 : il8n
 날짜- 국가별로 형식이 다르다
    한국 : yyyy-mm-dd
    미국 : mm-dd-yyyy
    
숫자
    한국 : 9,000,00.00
    독일 : 9.000.000,00

sal(NUMBER) 컬럼의 값을 문자열 포멧팅 적용    
SELECT ename, sal, TO_CHAR(sal, 'L9,999.00')
FROM emp;

null과 관련된 함수 : NULL값을 다른 값으로 치환하거나, 혹은 강제로 NULL을 만드는 것
                                java
1. NVL(expr1, expr2)    = if(expr1 == null)
                             expr2를 반환   
                          else
                             expr1을 반환;
                             
SELECT empno, sal, comm, NVL(comm, 0), 
       sal + comm, sal + NVL(comm, 0)
FROM emp;

                                                          
2. NVL2(expr1, expr2, expr3)     = if(expr1 != null)
                                    expr2를 반환
                                  else
                                    expr3을 반환
                                    
SELECT empno, sal, comm, NVL2(comm, comm, 0), 
       sal + comm, sal + NVL2(comm, comm, 0), sal + comm, sal + NVL2(comm, comm+sal, sal)
FROM emp;                                    

3. NULLIF(expr1, expr2)  = if(expr1 == expr2)
                             null을 반환
                           else
                             expr1을 반환
                             
SELECT ename, sal, comm, NULLIF(sal, 3000)                             
FROM emp;

4. COALESCE(exprl, expr2,...............)       == if(expr1 != null)
                                                    expr1을 반환
                                                    else
                                                       COALESCE(expr, ...........)                                                       
                                            
인자 중게 가장 처음으로 null값이 아닌 값을 갖는 인자를 반환
COALESECE(NULL, NULL, 30, NULL) => 30


NULL처리 실습
emp테이블에 14명의 사원이 존재, 한명을 추가(INSKRT)

INSERT INTO emp(empno, ename, hiredate) values(9999, 'brown', NULL);
SELECT *
FROM emp;

조회컬럼 : ename, mgr, mgr컬럼 값이 NULL이면 111로 치환한 값 - NULL이 아니면 mgr 컬럼값, hiredate, hiredate가 NULL이면 SYSDATE로 효기 -NULL이 아니면 hiredate 컬럼값

SELECT ename, mgr, NVL(mgr,111), hiredate, NVL(hiredate, SYSDATE)
FROM emp;

SELECT empno, ename, mgr, NVL(mgr, 9999) mgr_n, NVL2(mgr, mgr, 9999) mgr_n_1, COALESCE(mgr, 9999) mgr_n_2
FROM emp;


SELECT userid, usernm, reg_dt,NVL(reg_dt, SYSDATE) n_reg_dt
FROM users
WHERE userid != 'brown';

SELECT ROUND(6/28 * 100,2) || '%'
FROM dual;

SQL조건문
CASE
    WHEN 조건문(참 거짓을 판단할 수 있는 문장) THEN 반환할 값INSERT INTO emp(empno, ename, hiredate) values(9999, 'brown', NULL);
    WHEN 조건문(참 거짓을 판단할 수 있는 문장) THEN 반환할 값INSERT INTO emp(empno, ename, hiredate) values(9999, 'brown', NULL);
    ELSE 모든 WHEN절을 맍고시키지 못할 때 반환할 기본 값
END => 하나의 컬럼으로 취급    

emp테이블에 저장된 job 컬럼의 값을 기준으로 급여(sal)를 인상시키려고 한다.
sal컬럼과 함께 인상된 sal컬럼의 값을 비교 하고 싶은 상황

급여 인상 기준
job이 SALSEMAN : sal * 1.05
job이 MANAGER : sal * 1.10
job이 PRESIDENT : sal * 1.20
나머지 기타 직군은 sal로 유지

SELECT ename, job, sal,
       CASE
         WHEN job = 'SALESEMAN' THEN sal * 1.05
         WHEN job = 'MANAGER' THEN sal * 1.10
         WHEN job = 'PRESIDENT' THEN sal * 1.20
         ELSE sal
       END inc_sal
FROM emp;       

SELECT empno, ename, 
       CASE
         WHEN deptno = 10 THEN 'ACCOUTING'
         WHEN deptno = 20 THEN 'RESEARCH'
         WHEN deptno = 30 THEN 'SALES'
         WHEN deptno = 40 THEN 'OPERATIONS' 
         ELSE 'DDIT'
       END dname
FROM emp;       


DECODE
SELECT ename, job, sal,
       DECODE(job, 'SALESEMAN', sal * 1.05,
                    'MANAGER', sal * 1.10,
                    'PRESIDENT', sal * 1.20,
                    sal * 1 ) bonus 
FROM emp;       