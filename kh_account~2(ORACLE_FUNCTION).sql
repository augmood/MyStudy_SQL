-- 오라클 함수
-- 문자 처리 함수, 숫자 처리 함수, 날짜 처리 함수, 선택 함수
-- 1.문자 처리 함수
-- 문자의 길이 LENGTH / 문자의 크기 LENTHB
SELECT LENGTH(EMP_NAME), LENGTHB(EMP_NAME)
FROM EMPLOYEE; 

SELECT EMAIL ,LENGTH(EMAIL) ,LENGTHB(EMAIL)
FROM EMPLOYEE;

--INSTR, INSTRB => 특정 문자의 위치를 반환
--> (문자열, 문자, 위치시작, 몇번째꺼)
--> -1 오른쪽부터 시작, 왼쪽부터 카운트
SELECT INSTR('YELENA BELOVA', 'E', 1, 3) 
        --> 9
    , INSTR('YELENA BELOVA', 'E', -1, 2) 
        --> 4
FROM DUAL; 

-- <간단실습>
-- EMPLOYEE 테이블에서 EMAIL의 컬럼의 문자열 중 "@"의 위치를 구하시오.
SELECT EMAIL, INSTR(EMAIL, '@', 1, 1), INSTRB (EMAIL, '@', 1, 1)
FROM EMPLOYEE;

-- LPAD, RPAD 문자처리함수
-- 주어진 컬럼, 문자열에 임의의 문자열을 덧붙여 길이 N의 문자열을 반환하는 함수
SELECT LPAD(EMAIL, 20, '#') --> 문자열을 20으로, 빈 공간은 #으로 
FROM EMPLOYEE;

SELECT RPAD(EMAIL, 20, '#') 
FROM EMPLOYEE;

SELECT LPAD(EMAIL, 20) 
FROM EMPLOYEE;

-- LTRIM, RTRIM 문자처리함수
-- 주어진 컬럼, 문자열의 지정한 문자열에 포함된 문자를 제거하고 나머지를 반환함.
-- 공백을 없애는 경우 사용함
SELECT LTRIM('    KH') FROM DUAL;
SELECT RTRIM('KH    ') FROM DUAL;
SELECT LTRIM('000123', '0') FROM DUAL;

SELECT LTRIM('123123KH123', '123') FROM DUAL;
SELECT LTRIM('231312KH123', '123') FROM DUAL;
---> KH 왼쪽의 모든 1,2,3을 지운다
SELECT RTRIM('123123KH1321', '123') FROM DUAL;
--> KH 오른족의 모든 1,2,3을 지운다

-- TRIM 문자처리 함수
-- 주어진 컬럼, 문자열의 모든 방향에 있는 지정한 문자를 제거한 나머지를 리턴
SELECT TRIM ('Z' FROM 'ZZKHZZZ') FROM DUAL;
SELECT TRIM (LEADING 'Z' FROM 'ZZZ123456ZZZ') FROM DUAL;
--> 왼쪽만 제거
SELECT TRIM (TRAILING 'Z' FROM 'ZZZ123456ZZZ') FROM DUAL;
--> 오른쪽만 제거
SELECT TRIM (BOTH 'Z' FROM 'ZZZ123456ZZZ') FROM DUAL;
--> 모두 제거

-- <종합 실습 문제>
-- 실습 문제 1
-- Hello KH Java 문자열을 Hello KH 가 출력되게 하여라.
SELECT RTRIM ('Hello KH Java','Java') FROM DUAL;

-- 실습 문제 2
-- Hello KH Java 문자열을 KH Java 가 출력되게 하여라.
SELECT LTRIM ('Hello KH Java','Hello') FROM DUAL;

-- 실습 문제 3 (TRIM으로 해보세요)
-- DEPARTMENT 테이블에서 DEPT_TITLE을 출력하여라
-- 이때, 마지막 부 글자를 빼고 출력되도록 하여라 / ex)회계관리부 -> 회계관리
SELECT DEPT_TITLE FROM DEPARTMENT;
SELECT TRIM (TRAILING '부' FROM DEPT_TITLE) 
FROM DEPARTMENT;

-- 실습 문제 4 - 생각 못했음
-- 다음문자열에서 앞뒤 모든 숫자를 제거하세요.
-- '982341678934509hello89798739273402'
SELECT LTRIM (RTRIM ('982341678934509hello89798739273402','1234567890'), '1234567890') FROM DUAL;

-- SUBSTR 문자 처리 함수
-- 주어진 컬럼이나 문자열에서 지정한 위치부터 지정한 개수의 문자열을 잘라내어 리턴하는 함수
SELECT 'BLACKWIDOW' FROM DUAL;
SELECT SUBSTR('BLACKWIDOW', 5, 2) FROM DUAL;
SELECT SUBSTR('BLACKWIDOW', 6) FROM DUAL;
SELECT SUBSTR('BLACKWIDOW', -5, 5) FROM DUAL; 
--> WIDOW , 오른쪽에서 5번째에서 부터 5개 출력

-- <어려워 둘다>
--@ 실습문제1
---- 사원명에서 성만 중복없이 사전순으로 출력하세요.
SELECT DISTINCT SUBSTR(EMP_NAME, 1, 1) 
FROM EMPLOYEE
ORDER BY 1;

-- @ 실습문제2
-- employee 테이블에서 남자만 사원번호, 사원명, 주민번호, 연봉을 나타내세요.
-- 주민번호의 뒷6자리는 *처리하세요.
SELECT EMP_ID, EMP_NAME, RPAD(SUBSTR(EMP_NO,1,8),14,'*'), SALARY*12
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) = 1;

-- LOWER / UPPER / INITCAP
-- 컬럼의 문자 혹은 문자열을 소문자 / 대문자 / 첫글자만 대문자로 변환하여 리턴하는 함수
SELECT LOWER('Natasha Romanoff') FROM DUAL; -- natacha romanoff
SELECT UPPER('Natasha Romanoff') FROM DUAL; -- NATASHA ROMANOFF
SELECT INITCAP('Natasha Romanoff') FROM DUAL; -- Natasha Romanoff

-- CONCAT 문자 처리 함수
-- 컬럼의 문자/문자열 두개를 전달받아 하나로 합친 후 리턴하는 함수
SELECT CONCAT('가나다라', 'ABCD') FROM DUAL; --가나다라ABCD
SELECT '가나다라'||'ABCD' FROM DUAL; --가나다라ABCD

-- REPLACE 문자 처리 함수
SELECT 'ALEXEI GOOD FATHER' FROM DUAL;
SELECT REPLACE('ALEXEI GOOD FATHER' , 'GOOD', 'BAD') FROM DUAL; -- ALEXEI BAD FATHER 

-- <실습문제>
-- EMPLOYEE 테이블의 모든 직원의 이름,주민번호,Email을 출력하시오
-- 단, 출력시 Email은 kh.or.kr에서 iei.or.kr 로 변경하여 출력되게 하시오
SELECT EMP_NAME, EMP_NO, REPLACE(EMAIL, 'kh.or.kr', 'iei.or.kr') 
FROM EMPLOYEE;


-- 2. 숫자 처리 함수
-- ABS, MOD, ROUND, FLOOR, TRUNC, CEIL

-- ABS : 절대 값을 구하는 함수
SELECT 10 FROM DUAL;
SELECT ABS(-10) FROM DUAL; --> 10

-- MOD : 나머지를 구하는 함수
SELECT MOD(10,3) FROM DUAL; --> 1
SELECT MOD(10,2) FROM DUAL; --> 2

-- ROUND : 반올림하여 값을 리턴하는 함수
-- ROUND(대상,반올림하는 위치)
SELECT ROUND(123.456,3) FROM DUAL; --> 123.456
SELECT ROUND(123.456,2) FROM DUAL; --> 123.46
SELECT ROUND(123.456,1) FROM DUAL; --> 123.5
SELECT ROUND(123.456,0) FROM DUAL; --> 123
SELECT ROUND(123.456,-1) FROM DUAL; --> 120
SELECT ROUND(123.456,-2) FROM DUAL; --> 100

-- FLOOR : 소수점 자리를 버리는 함수 (제일 자주 쓴다)
SELECT FLOOR(SYSDATE-HIRE_DATE) FROM EMPLOYEE;

--TRUNC : 지정한 위치 이후 소수점 자리를 버리는 함수
SELECT TRUNC (123.456, 1) FROM DUAL; --> 123.4
SELECT TRUNC (123.456, 2) FROM DUAL; --> 123.45
SELECT TRUNC (123.456, 0) FROM DUAL; --> 123
SELECT TRUNC (123.456, -1) FROM DUAL; --> 120

-- CEIL : 올림하는 함수
SELECT CEIL (123.456) FROM DUAL; --> 124

-- 오라클 함수
-- 문자 처리 함수, 숫자 처리 함수, 날짜 처리 함수, 형변환 함수, NULL 처리함수, 선택함수
-- NULL 처리 함수
-- EMPLOYEE 테이블에서 보너스가 NULL인 사원의 이름, 전화변호, 급여, 보너스를 출력하세요

SELECT EMP_NAME, PHONE, SALARY, NVL(BONUS, 0),SALARY + SALARY * NVL(BONUS, 0)
FROM EMPLOYEE;

-- 날짜 처리 함수
-- SYSDATE, MONTHS_BETWEEN, ADD_MONTHS, NEXT_DAY, EXTRACT
-- SYSDATE : 현재 날짜 반환 함수
SELECT SYSDATE FROM DUAL;

-- MONTHS_BETWEEN : 두 날짜를 전달받아, 개월 수의 차이를 숫자로 리턴하는 함수
SELECT MONTHS_BETWEEN ('19/07/20', '18/07/20') FROM DUAL;

-- EMLPOYEE 테이블에서 오늘까지의 근속개월수를 구하라
SELECT MONTHS_BETWEEN (SYSDATE, HIRE_DATE) FROM EMPLOYEE;

-- ADD_MONTHS : 일자로 전달받은 날짜에 일자로 전달받은 숫자만큼 개월 수를 더하여
-- 특정 날짜를 리턴하는 함수
SELECT ADD_MONTHS(SYSDATE, 4) FROM DUAL;
SELECT ADD_MONTHS('21/06/18', 5) FROM DUAL;

-- EMPLOYEE 테이블에서 입사이후 3개월째 되는 날이 언제였는지 출력
SELECT EMP_NAME, ADD_MONTHS(HIRE_DATE, 3) FROM EMPLOYEE;

-- <실습문제>
-- 오늘 입대하는 사람이 있습니다.
-- 군복무 기간은 1년 6개월이라고 합니다.
-- 첫번째, 이 사람의 전역일은 언제 입니까?
-- 두번째, 이 사람이 전역까지 먹어야 하는 식사의 수는 몇회입니까? -> 틀림
-- (단 , 1일은 총 3번의 식사 시간이 있다고 가정합니다.)

SELECT SYSDATE AS "입대일",
        ADD_MONTHS(SYSDATE, 18) AS "전역일" FROM DUAL; --> 23년 1월 20일
SELECT (ADD_MONTHS(SYSDATE, 18)-SYSDATE)*3 AS "식사의 수" FROM DUAL; --> 1647끼

-- NEXT_DAY : 전달받은 날짜와 전달받은 요일 중 가장 가까운 다음 요일의 날짜를 리턴하는 함수
-- 요일과 관련된 함수

SELECT SYSDATE, NEXT_DAY(SYSDATE, '화요일') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, 2) FROM DUAL; --> 2는 월요일
SELECT SYSDATE, NEXT_DAY(SYSDATE, 1) FROM DUAL; --> 1은 일요일
SELECT SYSDATE, NEXT_DAY(SYSDATE, '수') FROM DUAL; --> 수요일

-- **LAST_DAY : 전달받은 날짜가 속한 달의 마지막 날짜를 구하여 리턴하는 함수
SELECT SYSDATE, LAST_DAY(SYSDATE) FROM DUAL;
SELECT SYSDATE, LAST_DAY('19/02/01') FROM DUAL; --> 19년 2월

-- EMPLOYEE 테이블에서 사원의 입사월, 입사월의 마지막 날짜를 구하시오
SELECT HIRE_DATE, LAST_DAY(HIRE_DATE) FROM EMPLOYEE;

-- 다음달의 마지막 날 구하기
SELECT LAST_DAY(ADD_MONTHS(SYSDATE,1)) FROM DUAL;

-- 1월 31일을 기준으로 다음달의 마지막 날 구하기는 어떤 날짜가 나올 것인가?
-- 1월 31일 -> 2월 28일 -> 3월 31일
SELECT LAST_DAY(ADD_MONTHS('21/01/31', 1)) FROM DUAL;


--<최종 실습 문제>

-- 문제1. 
-- 입사일이 5년 이상, 10년 이하인 직원의 이름,주민번호,급여,입사일을 검색하여라

SELECT EMP_NAME AS "이름", EMP_NO AS "주민번호", 
        SALARY AS "급여 ", HIRE_DATE AS "입사일" 
FROM EMPLOYEE
WHERE (SYSDATE-HIRE_DATE) /365 BETWEEN 5 AND 10;

-- 문제2.
-- 재직중이 아닌 직원의 이름,부서코드, 고용일, 근무기간, 퇴직일을 검색하여라 (퇴사 여부 : ENT_YN)
SELECT EMP_NAME, DEPT_CODE, HIRE_DATE, ENT_DATE-HIRE_DATE || '일', ENT_DATE
FROM EMPLOYEE
WHERE ENT_YN = 'Y';

-- 문제3.
-- 근속년수가 10년 이상인 직원들을 검색하여
-- 출력 결과는 이름,급여,근속년수(소수점X)를 근속년수가 오름차순으로 정렬하여 출력하여라
-- 단, 급여는 50% 인상된 급여로 출력되도록 하여라.

SELECT EMP_NAME AS "이름 ", SALARY+(SALARY*0.5) AS "급여", FLOOR((SYSDATE-HIRE_DATE)/365) AS "근속년수"
FROM EMPLOYEE
WHERE (SYSDATE-HIRE_DATE) / 365 >= 10
ORDER BY 3 ASC; --> 3 = FLOOR(SYSDATE-HIRE_DATE) 

 
-- 문제4.
-- 입사일이 99/01/01 ~ 10/01/01 인 사람 중에서 급여가 2000000 원 이하인 사람의
-- 이름,주민번호,이메일,폰번호,급여를 검색 하시오
SELECT EMP_NAME AS "이름", EMP_NO AS "주민번호", EMAIL AS "이메일",
        PHONE AS "폰번호", SALARY AS "급여"
FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN '99/01/01' AND '10/01/01' AND SALARY <= 2000000;


-- 문제5.
-- 급여가 2000000원 ~ 3000000원 인 여직원 중에서 4월 생일자를 검색하여 
-- 이름,주민번호,급여,부서코드를 주민번호 순으로(내림차순) 출력하여라
-- 단, 부서코드가 null인 사람은 부서코드가 '없음' 으로 출력 하여라. --> NULL표기 몰라

SELECT EMP_NAME AS "이름" , EMP_NO AS "주민번호", SALARY AS "급여" ,
        NVL(DEPT_CODE,'없음') AS "부서코드"
FROM EMPLOYEE
WHERE SALARY BETWEEN '2000000' AND '3000000' 
        AND EMP_NO LIKE '___4__-2%'
        -- AND SUBSTR(EMP_NO,8,1) = 2 AND SUBSTR(EMP_NO,4,1) = 4
ORDER BY 1 ASC;

-- 문제6.
-- 남자 사원 중 보너스가 없는 사원의 오늘까지 근무일을 측정하여 
-- 1000일 마다(소수점 제외) --> ??
-- 급여의 10% 보너스를 계산하여 이름,특별 보너스 (계산 금액) 결과를 출력하여라.
-- 단, 이름 순으로 오름 차순 정렬하여 출력하여라.

SELECT EMP_NAME AS "이름" 
        ,(FLOOR(SYSDATE-HIRE_DATE)/1000)*(SALARY*0.1) AS "특별 보너스"
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) = 1 AND BONUS IS NULL
ORDER BY 1 ASC;

