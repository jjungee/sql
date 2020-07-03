SELECT lprod_gu, lprod_nm, prod_id, prod_name
FROM prod, lprod
WHERE prod.prod_lgu = lprod.lprod_gu;

ansi-SQL 두 테이블의 연결 컬럼이 다르기 때문에 NATURAL JOIN, JOIN with 사용불가
SELECT lprod_gu, lprod_nm, prod_id, prod_name
FROM prod JOIN lprod ON (prod.prod_lgu = lprod.lprod_gu);

SELECT buyer_id, buyer_id, prod_id, prod_name
FROM prod, buyer
WHERE prod.prod_buyer = buyer.buyer_id;

SELECT *
FROM buyer;

SELECT *
FROM prod;

SELECT *
FROM member;

SELECT *
FROM cart;

데이터 결합(실습 join3) 222P
ORACLE
SELECT mem_id, mem_name, prod_id, prod_name, cart_qty
FROM prod, member, cart
WHERE prod.prod_id = cart.cart_prod AND member.mem_id = cart.cart_member;

ANSI
SELECT mem_id, mem_name, prod_id, prod_name, cart_qty
FROM prod JOIN cart ON (prod.prod_id = cart.cart_prod) JOIN member ON (member.mem_id = cart.cart_member);


실습 - 모델링 224P~
SELECT *
FROM customer;

SELECT *
FROM cycle;

SELECT *
FROM product;

SELECT cycle.cid, cnm, pid, day, cnt
FROM customer, cycle
WHERE customer.cid = cycle.cid 
  AND cnm IN ('brown', 'sally');

SELECT cycle.cid, cnm, cycle.pid, day, cnt
FROM customer, cycle, product
WHERE customer.cid = cycle.cid AND cycle.pid = product.pid 
  AND cnm IN ('brown', 'sally');

SELECT cycle.cid, cnm, cycle.pid, sum(cnt) cnt
FROM customer, cycle, product
WHERE customer.cid = cycle.cid AND cycle.pid = product.pid
GROUP BY cycle.cid, cycle.pid, cnm;

SELECT cycle.pid, pnm, sum(cnt)
FROM cycle, product
WHERE cycle.pid = product.pid
GROUP BY cycle.pid, pnm;
group by절과 select절에 같은 한정자를 붙여줘야 한다.


조인 성공 여부로 데이터 조회를 결정하는 구분방법
INNER JOIN : 조인에 성공하는 데이터만 조회하는 조인방법
OUTTER JOIN : 조인에 실패하더라도, 개발자가 지정한 기준이 되는 테이블의 데이터는 나오도록 하는 조인

OUTTER <==> INTTER JOIN 

복습 - 사원의 관리자 이름을 알고싶음.
조회 컬럼 : 사원의 사번, 사원의 이름, 사원의 관리자의 사번, 사원의 관리자의 이름

동일한 테이블끼리 조인이 됨 : SELF-JOIN
조인 조건을 만족하는 데이터만 조회됨 : INTTER-JOIN
SELECT e.empno, e.ename, e.mgr, m.ename
FROM emp e, emp m
WHERE e.mgr = m.empno;

KING의 경우 PRESIDENT이기 때문에 MGR 컬럼의 값이 NULL => 조인에 실패
=> KING의 데이터는 조회되지 않음( 총 14건 데이터 중 13건의 데이터만 조인 성공)

OUTER조인을 이용하여 조인 테이블 중 기준이 되는 테이블을 선택하면 조인에 실패하더라도 기준 테이블의 데이터는 조회도록 할 수 있다.
LEFT / RIGHT OUTER

ANSI-SQL
테이블1 JOIN 테이블2 ON (.....)
테이블1 LEFT OUTER JOIN 테이블2 ON (.....)
위 쿼리는 아래와 동일
테이블2 RIGHT OUTER JOIN 테이블1 ON (.....)

SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e LEFT OUTER JOIN emp m ON (e.mgr = m.empno);
