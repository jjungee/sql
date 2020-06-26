SELECT *
FROM emp;

SELECT sal, sal+500, sal-500, sal/5, sal*50, 500
FROM emp;
-----------------------------------------
SELECT *
FROM dept;
-----------------------------------------
SELECT hiredate, hiredate + 5, hiredate -5
FROM emp;
----------------------------------------
DESC users;

SELECT userid, reg_dt, reg_dt + 5
FROM users;
-----------------------------------------
SELECT empno a, ename, sal s, comm AS "commition", sal+comm AS sal_plus_comm
FROM emp;
-----------------------------------------
SELECT prod_id "id", prod_name "name"
FROM prod;

SELECT lprod_gu gu, lprod_nm AS nm
FROM lprod;

SELECT buyer_id AS "바이어 아이디", buyer_name AS 이름
FROM buyer;
-----------------------------------------
SELECT userid, usernm, userid||usernm id_name, CONCAT(userid,usernm) concat_id_name
FROM users;

SELECT '아이디 : '||userid userid, 500, 'test'
FROM users;

SELECT TABLE_NAME
FROM user_tables;

SELECT 'SELECT * FROM '||TABLE_NAME||';' ouery
FROM user_tables;

SELECT CONCAT(CONCAT('SELECT * FROM ', TABLE_NAME),';') ouery
FROM user_tables;
-----------------------------------------
SELECT *
FROM users
WHERE userid <> 'brown';

SELECT *
FROM emp
WHERE deptno >= 30;
-----------------------------------------
SELECT *
FROM emp
WHERE hiredate >= TO_DATE('1982/01/01','YYYY/MM/DD');

SELECT *
FROM emp
WHERE sal BETWEEN 1000 AND 2000;

SELECT ename, hiredate
FROM emp
WHERE hiredate BETWEEN TO_DATE('1982/01/01','YYYY/MM/DD') AND TO_DATE('1983/01/01','YYYY/MM/DD');

SELECT ename, hiredate
FROM emp
WHERE hiredate >= TO_DATE('1982/01/01','YYYY/MM/DD') AND hiredate <= TO_DATE('1983/01/01','YYYY/MM/DD');
-----------------------------------------
SELECT *
FROM emp
WHERE DEPTNO IN(10, 20);