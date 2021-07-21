-- 오라클 함수
-- 문자처리 함수, 숫자처리 함수, 날짜처리 함수, NULL처리 함수, 형변환함수, 선택함수
-- 형변환 함수
-- EXTRACT : 추출해서 리턴하는 함수
SELECT SYSDATE FROM DUAL;
SELECT
    EXTRACT(YEAR FROM SYSDATE),
    EXTRACT(MONTH FROM SYSDATE),
    EXTRACT(DAY FROM SYSDATE)
FROM DUAL;

-- EMPLOYEE 테이블에서 추출해보자, 어떤 컬럼에서 추출할 수 있을까
SELECT EXTRACT(YEAR FROM HIRE_DATE) 
FROM EMPLOYEE
ORDER BY 1;

-- <실습 문제>
-- @ 실습문제 1
-- EMPLOYEE 테이블에서 사원의 이름,입사일,년차를 출력하여라. 
-- 단, 입사일은 YYYY년M월D일로 출력하도록 하여라.
-- 년차 출력은 소수점 일경우 올림으로 하여 출력하여라. (28.144 -> 29년차)
-- (출력시 정렬은 입사일 기준으로 오름차순)
SELECT EMP_NAME, 
        EXTRACT(YEAR FROM HIRE_DATE) ||'년'||
        EXTRACT(MONTH FROM HIRE_DATE)||'월'||
        EXTRACT(DAY FROM HIRE_DATE)|| '일' AS "입사일", 
        CEIL((SYSDATE-HIRE_DATE)/365) AS "년차"
FROM EMPLOYEE
ORDER BY 2 ASC;

-- @ 실습문제 2
-- 특별 보너스를 지급하기 위하여 자료가 필요하다
-- 입사일을 기점으로 다음달 1일 부터 6개월을 계산하여 
-- 출력하시오 (이름,입사일,기준일,기준일+6,기준달(월))
-- ex) 90년2월6일 입사 -> 90년3월1일 부터 계산
-- ex) 90년2월26일 입사 -> 90년3월1일 부터 계산
-- ex) 97년12월1일 입사 -> 98년1월1일 부터 계산
-- 출력시 입사일 기준으로 정렬하시오
-- 첫째 날을 어케 구한다는 말임

SELECT EMP_NAME AS "이름",
        HIRE_DATE AS "입사일",
        LAST_DAY(HIRE_DATE)+1 AS "기준일",
        ADD_MONTHS(LAST_DAY(HIRE_DATE)+1,6) AS "기준일+6",
        EXTRACT (MONTH FROM HIRE_DATE) || '월' AS "기준달(월)"
FROM EMPLOYEE
ORDER BY 2 ASC;

-- 형변환 함수
-- Integer.parseInt("33") -> 33, String.valueof(33) -> "33"
-- TO.CHAR(문자형으로 바꿈), TO_DATE(날짜형으로 바꿈), TO_NUMBER(숫자형으로 바꿈)
SELECT SYSDATE FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD')FROM DUAL; 
--> SimpleDateFormat, hh:mm:ss
SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD')FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD PM HH12:MI:SS')FROM DUAL;
--> HH24 24시간 기준 표기, 오전 오후 PMHH12
SELECT TO_CHAR(SYSDATE, 'FM YYYY-MM-DD PMHH12:MI:SS')FROM DUAL;
--> FM 월 일 시 분 초 앞의 0을 제거해줌

SELECT EMP_NAME,
        TO_CHAR(HIRE_DATE, 'YY/MM/DD') AS "HIRE_DATE",
        TO_CHAR(HIRE_DATE, 'YYYY-MM-DD') AS "입사일"
FROM EMPLOYEE;

-- 사원 테이블에서 사원명, 고용일 (1990/02/06(화))로 출력하세요
SELECT EMP_NAME,
        TO_CHAR(HIRE_DATE, 'YYYY/MM/DD(DY)') AS "고용일"
FROM EMPLOYEE;

-- TO_CHAR : 날짜형 -> 문자형, 숫자형 (NUMBER) -> 문자형
SELECT
    SALARY,
    TO_CHAR(SALARY, '999,999,999') "급여1", --> 8,000,000
    TO_CHAR(SALARY, 'L999,999,999') "급여2", --> ￦8,000,000
    TO_CHAR(SALARY, '000,000,000') "급여3" --> 008,000,000
FROM EMPLOYEE;

-- TO_DATE : 숫자형 데이터를 날짜 데이터로 변환하거나 문자형 데이터를 날짜형 데이터로 변환
-- 날짜를 표현하는데 숫자로 표현하거나 날짜로 표현한 데이터를 날짜형으로 바꾸는 것
-- 날짜형으로 바꾸면 날짜 관련 연산이 쉬워지기 때문에 바꿔줌

SELECT 20210618 FROM DUAL;
SELECT TO_DATE(20210618) FROM DUAL;
--> 20210618 / 21/06/18
SELECT '20211124' FROM DUAL;
SELECT TO_DATE('20211124') FROM DUAL;
--> 20211124 -> 21/11/24
SELECT TO_DATE(TO_DATE(20210618), 'YYYY/MM/DD') 
FROM DUAL;

-- EMPLOYEE 테이블에서 2010년도 이후에 입사한 사원의 사번, 이름, 입사일을 조회하시오
SELECT EMP_NAME, EMP_ID, HIRE_DATE
FROM EMPLOYEE
--WHERE HIRE_DATE > TO_DATE(20100101);
WHERE HIRE_DATE > '20100101';

--TO_NUMBER : 문자형 데이터를 숫자형으로 변환 (날짜형은 변환 불가)
SELECT SYSDATE FROM DUAL;
SELECT TO_NUMBER('2000') FROM DUAL;

-- '2000'+'3000' -> 2000+3000 = 5000
SELECT TO_NUMBER('2000') + TO_NUMBER('3000') FROM DUAL;
SELECT '2000'+'3000' FROM DUAL;

-- 유효한 숫자로 된 문자데이터인 경우에만 형변환이 가능하다.
SELECT TO_NUMBER('1000a') FROM DUAL;  --> 불가능

-- 문자처리 함수, 숫자처리 함수, 날짜처림 함수, NULL처리 함수, 형변환 함수, 선택함수
-- 선택함수
-- DECODE 선택함수 : 여러가지 경우에 선택을 할 수 있는 기능 제공하는 함수
-- 작성법 
-- DECODE(표현식, 조건1, 결과1, 조건2, 결과2, 조건3, 결과3 , ....) 
-- DEFAULT : 모든 조건이 불일치 시 리턴할 값

SELECT DECODE('B', 'A', 'true', 'B', 'false') FROM DUAL;
--> FALSE

-- EMPLOYEE 테이블에서 남자사원은 남, 여자사원은 여로 표시하여
-- 사번 이름 주민번호를 출력하시오
SELECT 
    EMP_ID,
    EMP_NAME,
    EMP_NO,
    DECODE(SUBSTR(EMP_NO,8,1), '2', '여', '1', '남', '4', '여', '3', '남') "성별"
FROM EMPLOYEE;

-- CASE WHEN ~ THEN END
-- CASE
--      WHEN 조건1 THEN 결과1
--      WHEN 조건2 THEN 결과2
--      ELSE 결과 N
-- END

SELECT 
    EMP_ID,
    EMP_NAME,
    EMP_NO,
    CASE
    WHEN SUBSTR(EMP_NO,8,1) = '2' THEN '여'
    WHEN SUBSTR(EMP_NO,8,1) = '4' THEN '여'
    ELSE '남'
    END AS "성별"
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 출생년도 기준 60년대 생 직원에 대하여 
-- 65년이전 출생자는 60년생 초반, 65년 이후 출생자는 60년생 후반이라고 출력하시오

SELECT
    EMP_NAME,
    EMP_NO,
    CASE
    WHEN SUBSTR(EMP_NO,1,2) < '65' THEN '60년생 초반'
    WHEN SUBSTR(EMP_NO,1,2) >= '65' THEN '60년생 후반'
    END AS "나이"
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,1,2) BETWEEN '60' AND '69';

-- 그룹함수
-- SUM, AVG, COUNT, MAX/MIN
-- SUM
-- EMPLOYEE 테이블에서 남자 사원의 급여 총합을 계산
SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) = 1;

-- EMPLOYEE 테이블에서 부서코드가 D5인 직원의 보너스 포함 연봉의 합을 구하시오
SELECT SUM(SALARY*12 + SALARY*NVL(BONUS, 0))
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

--AVG : 평균 구하는 그룹함수
SELECT FLOOR(AVG(SALARY))
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) = 1;

-- EMPLOYEE 테이블에서 부서코드가 D5인 직원의 보너스 포함 연봉의 합을 구하시오
SELECT FLOOR(AVG(SALARY*12 + SALARY*NVL(BONUS, 0)))
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

-- COUNT
SELECT COUNT(EMP_ID)
FROM EMPLOYEE;

SELECT COUNT(*)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) = 2;

-- MAX/MIN
SELECT MAX(SALARY), MIN(SALARY)
FROM EMPLOYEE;

SELECT MAX(HIRE_DATE), MIN(HIRE_DATE)
FROM EMPLOYEE;
--> MAX 최근, MIN 오래된 날짜

-- <최종 연습 문제>

--1. 직원명과 이메일 , 이메일 길이를 출력하시오
--		  이름	    이메일		이메일길이
--	ex) 	홍길동 , hong@kh.or.kr   	  13

SELECT EMP_NAME "직원명", EMAIL "이메일", LENGTH(EMAIL) "이메일 길이"
FROM EMPLOYEE;

--2. 직원의 이름과 이메일 주소중 아이디 부분만 출력하시오 --아이디?
--	ex) 노옹철	no_hc
--	ex) 정중하	jung_jh
SELECT EMP_NAME "이름 ", 
        SUBSTR(EMAIL, 1, (INSTR(EMP_EMAIL, '@', 1, 1)-1)) "아이디"
FROM EMPLOYEE;

--3. 60년생의 직원명과 년생, 보너스 값을 출력하시오 
--	그때 보너스 값이 null인 경우에는 0 이라고 출력 되게 만드시오
--	    직원명    년생      보너스
--	ex) 선동일	62	0.3
--	ex) 송은희	63  	0
SELECT 
    EMP_NAME "이름",
    SUBSTR(EMP_NO,1,2) "년생",
    NVL(BONUS,0) "보너스"
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,1,2) BETWEEN 60 AND 69;

--4. '010' 핸드폰 번호를 쓰지 않는 사람의 수를 출력하시오 (뒤에 단위는 명을 붙이시오)
--	   인원
--	ex) 3명

SELECT 
    COUNT(PHONE) || '명'
FROM EMPLOYEE
WHERE (SUBSTR(PHONE, 1,3) NOT LIKE '010');
    
--5. 직원명과 입사년월을 출력하시오 
--	단, 아래와 같이 출력되도록 만들어 보시오
--	    직원명		입사년월
--	ex) 전형돈		2012년12월
--	ex) 전지연		1997년 3월
SELECT 
    EMP_NAME "직원명",
    EXTRACT(YEAR FROM HIRE_DATE)||'년'||
    EXTRACT(MONTH FROM HIRE_DATE)||'월' AS "입사연월"
FROM EMPLOYEE
ORDER BY 2;

--6. 직원명과 주민번호를 조회하시오
--	단, 주민번호 9번째 자리부터 끝까지는 '*' 문자로 채워서출력 하시오
--	ex) 홍길동 771120-1******
SELECT EMP_NAME "직원명", 
        RPAD(SUBSTR(EMP_NO,1,8),14,'*') "주민번호"
FROM EMPLOYEE;


--7. 직원명, 직급코드, 연봉(원) 조회
--  단, 연봉은 ￦57,000,000 으로 표시되게 함
--     연봉은 보너스포인트가 적용된 1년치 급여임
SELECT EMP_NAME,
        JOB_CODE,
        TO_CHAR((SALARY+(SALARY*NVL(BONUS,0)))*12, 'L999,999,999')
FROM EMPLOYEE;

--8. 부서코드가 D5, D9인 직원들 중에서 2004년도에 입사한 직원의 
--   수 조회함.
--   사번 사원명 부서코드 입사일
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D5','D9') 
        AND SUBSTR(HIRE_DATE, 1,2) = '04';

--9. 직원명, 입사일, 오늘까지의 근무일수 조회 
--	* 주말도 포함 , 소수점 아래는 버림
SELECT EMP_NAME, HIRE_DATE,
        FLOOR((SYSDATE-HIRE_DATE))
FROM EMPLOYEE;

--10. 모든 직원의 나이 중 가장 많은 나이와 가장 적은 나이를 출력 하여라. (나이만 출력)
SELECT MAX(EXTRACT (YEAR FROM SYSDATE) - (1900+SUBSTR(EMP_NO,1,2))) "최대",
        MIN(EXTRACT (YEAR FROM SYSDATE) - (1900+SUBSTR(EMP_NO,1,2))) "최소"
FROM EMPLOYEE;


--11.  회사에서 야근을 해야 되는 부서를 발표하여야 한다.
-- 부서코드가 D5,D6,D9  야근, 그외는 야근없음 으로 출력되도록 하여라. 
-- 출력 값은 이름,부서코드,야근유무 (부서코드 기준 오름차순 정렬함.)
--   (부서코드가 null인 사람도 야근없음 임)
SELECT 
    EMP_NAME, 
    DEPT_CODE,
    CASE
    WHEN DEPT_CODE IN ('D5','D6','D9') THEN '야근'
    ELSE '야근없음'
    END AS "야근유무"
FROM EMPLOYEE
ORDER BY 2 ASC;
        