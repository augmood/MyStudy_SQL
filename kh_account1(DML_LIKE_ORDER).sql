-- 비교연산자 (LIKE)
-- 비교하려는 값이 지정한 특정패턴을 만족시키면 TRUE를 리턴하는 연산자
-- '%'와 '_'를 와일드카드로 사용할 수 있음.
-- * 와일드카드 : 아무 문자나 대체해서 사용할 수 있는 것
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE EMP_NAME LIKE '전%'; -- 전%에 전_ _가 포함됨

-- 가운데 글자에 '전'이 있는 사람 검색
SELECT EMP_NAME,SALARY
FROM EMPLOYEE
WHERE EMP_NAME LIKE '_전_';

-- 이름에 '전'이 없는 사람 검색
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE EMP_NAME NOT LIKE '전%';

-- <실습문제>
--1. EMPLOYEE 테이블에서 이름 끝이 연으로 끝나는 사원의 이름을 출력하시오
SELECT EMP_NAME
FROM EMPLOYEE
WHERE EMP_NAME LIKE '__연';

--2. EMPLOYEE 테이블에서 전화번호 처음 3자리가 010이 아닌 사원의 이름, 전화번호를
--출력하시오
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE PHONE NOT LIKE '010%';

--3. EMPLOYEE 테이블에서 메일주소의 's'가 들어가면서, DEPT_CODE가 D9 또는 D6이고
--고용일이 90/01/01 ~ 01/12/01이면서, 월급이 270만원이상인 사원의 전체 정보를 출력하시오

SELECT *
FROM EMPLOYEE
WHERE EMAIL LIKE '%s%' AND (DEPT_CODE = 'D9' OR DEPT_CODE = 'D6') AND
HIRE_DATE BETWEEN '90/01/01' AND '01/12/01' AND (SALARY >= 2700000);

-- <# 도전문제>
-- EMPLOYEE 테이블에서 EMAIL ID 중 @ 앞자리가 5자리인 직원을 조회한다면?
SELECT *
FROM EMPLOYEE
WHERE EMAIL LIKE '_____@%';

-- EMPLOYEE 테이블에서 EMAIL ID 중 '_' 앞자리가 3자리인 직원을 조회한다면?
SELECT EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '___#_%' ESCAPE '#'; --> #을 쓰면 구문을 탈출한다 (#아니어도 됨)

-- <# 도전문제>
-- EMPLOYEE 테이블에서 EMAIL ID 중 @ 앞자리가 5자리인 직원을 조회한다면?
SELECT *
FROM EMPLOYEE
WHERE EMAIL LIKE '_____@%';

-- EMPLOYEE 테이블에서 EMAIL ID 중 '_' 앞자리가 3자리인 직원을 조회한다면?
SELECT *
FROM EMPLOYEE
WHERE EMAIL LIKE '___#_%' ESCAPE '#'; --> #을 쓰면 구문을 탈출한다 (#아니어도 됨)

-- IS NULL / IS NOT NULL -> NULL 값이거나 아니거나를 조회하는 연산자 
SELECT *
FROM EMPLOYEE
WHERE BONUS IS NULL;

SELECT *
FROM EMPLOYEE
WHERE BONUS IS NOT NULL;

-- MANAGER_ID 값이 NULL 인 데이터 검색 
SELECT *
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL;

SELECT EMP_NAME, PHONE, EMAIL
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9' OR DEPT_CODE = 'D6';

-- IN 연산자 --> 비교하려는 값 목록에 일치하는 값이 있으면 TRUE를 반환하는 연산
SELECT EMP_NAME, PHONE, EMAIL
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D9', 'D6', 'D3','D2');

-- ORDER BY 정렬
-- > NULL 값 : ASC 맨 뒤, DESC 맨 앞
-- > DATE 값 : ASC 가장 오래된 날짜, DESC 최근 날짜
-- > ORDER BY 다음에 컬럼을 적어도 되지만 컬럼 순서를 적어도 된다.
SELECT * FROM EMPLOYEE
ORDER BY PHONE ASC;

SELECT * FROM EMPLOYEE
ORDER BY EMP_NAME DESC;

SELECT * FROM EMPLOYEE
ORDER BY 2 DESC; --> 이름을 역순으로 정렬한다.


