SELECT ROWNUM, empno, ename
FROM emp;

WHERE절에서 사용할 수 있는 형태
SELECT ROWNUM, empno, ename
FROM emp
WHERE ROWNUM <= 10;

WHERE절에서 사용할 수 있는 형태
SELECT ROWNUM, empno, ename
FROM emp
WHERE ROWNUM >= 10;

SELECT ROWNUM, empno, ename
FROM emp
ORDER BY ename;

SELECT ROWNUM,empno, ename
FROM (SELECT empno, ename
      FROM emp
      ORDER BY ename);
      
SELECT 절에 *만 단독으로 사용하지 않고 ,를 통해 다른 임의 컬럼이나 expression을 표기한 경우 *앞에 어떤 테이블(뷰)에서 온 것인지 한정자(테이블 이름, vies 이름)를 붙여줘야 한다.  
table, view 별칭 : table이나 view에도 SELECT절의 컬럼처럼 별칭을 부여할 수 있다.
                    단 SELECT 절처럼 AS  키워드는 사용하지 않는다.
                    EX : FROM emp e
                         FROM (SELECT  empno, ename
                               from emp
                               ORDER BY ENMME 

SELECT emp.*
FROM emp;

SELECT ROWNUM, empno, ename
SELECT ROWNUM, a.*
FROM (SELECT empno, ename
      FROM emp
      ORDER BY ename) a;      
      
요구사항 : 1페이지당 10건의 사원 리스트가 보여야된다
1 PAGE : 1~ 10
2 PAGE : 11~ 20
.
.
.
n PATGE :  (n - 1) * 10 + 1 ~ n * 10 / n*1 - 9 ~ n * 10 

ROWNUM의 값을 별칭을 통해 새로운 컬럼으로 만들고 해당  SELECT SQL을 in-line wiew로 만들어 외부에서 ROWNUM에 부여한 별칭을 통해 페이징처리를 한다.
페이징 처리 쿼리 : 1 page : 1 ~ 10
SELECT ROWNUM, a.*
FROM (SELECT empno, ename
      FROM emp
      ORDER BY ename) a
WHERE ROWNUM BETWEEN 1 AND 10;

페이징 처리 쿼리 : 1 page : 1 ~ 10
SELECT ROWNUM, a.*
FROM (SELECT empno, ename
      FROM emp
      ORDER BY ename) a
WHERE ROWNUM BETWEEN 11 AND 20;  > ROWNUM의 특성으로 1번부터 읽지 않는 형태이기 때문에 정상적으로 동작하지 않는다.

SELECT *
FROM(SELECT ROWNUM rn, a.*
FROM (SELECT empno, ename
      FROM emp
      ORDER BY ename) a)
WHERE rn BETWEEN 11 AND 20;

바인딩 변수 적용
SELECT *
FROM(SELECT ROWNUM rn, a.*
FROM (SELECT empno, ename
      FROM emp
      ORDER BY ename) a)
WHERE rn BETWEEN (:page - 1) * :pageSize + 1 AND :page * :pageSize;





LANGTH 함수 테스트 함수는 WHERE절에서도 사용 가능
SELECT LENGTH('TEST')
FROM dual;

SELECT LENGTH('TEST'), emp.*
FROM emp;

SELECT CONCAT('Hello', CONCAT(',','World')) concat,
       SUBSTR('Hello, World', 1, 5) substr,
       LENGTH('Hello, World') length,
       INSTR('Hello, World', 'o') instr,
       INSTR('Hello, World', 'o', INSTR('Hello, World', 'o')+1) instr,
       LPAD('Hello, World' , 15, ' ') lpad,
       RPAD('Hello, World', 15, ' ') rpad,
       REPLACE('Hello, World', 'o', 'p') replace,
       TRIM(' Hello, World ') trim,
       TRIM('d' FROM ' Hello, World') trim,
       LOWER( 'Hello, World') lower,
       UPPER('Hello, World') upper,
       INITCAP('hello, world') initcap
FROM dual;

사원 이름이 SMITH인 사람
SELECT *
FROM emp
WHERE ename = UPPER('smith');

SELECT *
FROM emp
WHERE LOWER(ename) = 'smith'; > 하지 말아야 할 형태(좌변을 가공하는 형태, 좌변 - 테이블 컬럼을 의미)

오라클 숫자 관련 함수
ROUND(숫자, 반올림 기준자리) : 반올림 함수
TRUNK(숫자, 내림 기준자리) : 내림 함수
MOD(피제수, 제수) : 나머지 값을 구하는 함수

SELECT ROUND(105.54,1) round,
       ROUND(105.55,1) round2,
       ROUND(105.50,0) round3,
       ROUND(105.55,-1) round4
FROM dual;


SELECT TRUNC(105.54,1) round,
       TRUNC(105.55,1) round2,
       TRUNC(105.50,0) round3,
       TRUNC(105.50) round3,
       TRUNC(105.55,-1) round4
FROM dual;

sal을 1000으로 나눴을 때의 나머지 => mod함수, 별도의 연산자는 없다
몫 : qoutient
나머지 : reminder
SELECT ename, sal, TRUNC(sal/1000) qoutient, MOD(sal, 1000) reminder
FROM emp;


날짜 관련 함수
SYSDATE 
    오라클에서 제공해주는 특수함수
    1. 인자가 없음
    2. 오르클이 설치된 서버의 현재 년, 월, 일, 시, 분, 초 정보를 반환해주는 함수
    
SELECT SYSDATE
FROM dual;

SELECT *
FROM nls_session_parameters;

날짜타입 +- 정수 : 정수를 일자 취급, 정수만큼 미래, 혹은 과거 날짜의 데이트 값을 반환
ex : 오늘 날짜에서 하루 더한 미래 날짜 값은?
SELECT SYSDATE + 1
FROM dual;

ex : 현재 날짜에서 3시간 뒤 데이트를 구하려면?
데이트 + 정수(하루)
하루 = 24시간
1시간 > 1/24
3시간 > 3/24
SELECT SYSDATE + (1/24)*3
FROM dual;

1분: 1/24/60
SELECT SYSDATE + (1/24/60)*30
FROM dual;

데이트 표현하는 방법
1. 데이트 리터럴 : NSL_SESSION_PARATER
2. TO_DATE 문자열을 날짜로 변경해주는 함수

SELECT TO_DATE('20191231','YYYYMMDD') lasday,
       TO_DATE('20191231','YYYYMMDD')-5 lasday_before5,
       SYSDATE now, SYSDATE -3 now_befoer3
FROM dual;

SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY-MM-DD'),
        TO_CHAR(SYSDATE, 'D'), TO_CHAR(SYSDATE, 'IW')
FROM dual;


SELECT  ename, hiredate,TO_CHAR(hiredate, 'YYYY/MM/DD HH24:MI:SS') h1,
        TO_CHAR(hiredate +1, 'YYYY/MM/DD HH24:MI:SS') h2,
        TO_CHAR(hiredate + 1/24, 'YYYY/MM/DD HH24:MI:SS') h3
FROM emp;

SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') dt_dash,
       TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') dt_dash_with_time,
       TO_CHAR(SYSDATE, 'DD-MM-YYYY') dt_dd_mm_yyyy
FROM dual;