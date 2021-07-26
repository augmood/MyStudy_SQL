-- 서브쿼리

SELECT
    EMP_ID,
    EMP_NAME,
    JOB_CODE,
    SALARY
FROM EMPLOYEE
WHERE SALARY > 3500000;

SELECT
    EMP_ID,
    EMP_NAME,
    JOB_CODE,
    SALARY
FROM EMPLOYEE
WHERE SALARY > (SELECT AVG(SALARY)FROM EMPLOYEE);

-- 전지연 직원의 매니저 이름을 출력하시오
SELECT
    EMP_NAME 
FROM EMPLOYEE
WHERE EMP_ID = (SELECT MANAGER_ID FROM EMPLOYEE WHERE EMP_NAME = '전지연');


-- 예시문제
--@ 실습문제 
--1. 윤은해와 급여가 같은 사원들을 검색해서, 사원번호,사원이름, 급여를 출력하라.
--단, 윤은해는 출력 되면 안됨 --> ?

SELECT
    EMP_ID,
    EMP_NAME,
    SALARY
FROM EMPLOYEE
WHERE SALARY = (SELECT SALARY FROM EMPLOYEE WHERE EMP_NAME = '윤은해')
AND EMP_NAME != '윤은해';

--2. employee 테이블에서 기본급여가 제일 많은 사람과 제일 적은 사람의 정보를 
-- 사번, 사원명, 기본급여를 나타내세요.
SELECT
    EMP_ID,
    EMP_NAME,
    SALARY
FROM EMPLOYEE
WHERE SALARY = (SELECT MAX(SALARY) FROM EMPLOYEE) 
        OR SALARY = (SELECT MIN(SALARY) FROM EMPLOYEE);

-- 3. D1, D2부서에 근무하는 사원들 중에서
-- 기본급여가 D5 부서 직원들의 '평균월급' 보다 많은 사람들만 
-- 부서번호, 사원번호, 사원명, 월급을 나타내세요.
SELECT
    DEPT_CODE,
    EMP_ID,
    EMP_NAME,
    SALARY
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D1','D2') 
    AND SALARY > (SELECT AVG(SALARY) FROM EMPLOYEE WHERE DEPT_CODE = 'D5');


-- 다중행 서브쿼리 

SELECT DEPT_CODE FROM EMPLOYEE
WHERE EMP_NAME IN ('송종기', '박나라');

SELECT 
    EMP_ID,
    EMP_NAME,
    SALARY
FROM EMPLOYEE
WHERE DEPT_CODE IN (SELECT DEPT_CODE FROM EMPLOYEE 
WHERE EMP_NAME IN ('송종기','박나라'));

-- 실습문제 
-- 차태연 전지연 사원의 급여등급과 같은 사원의 직급명, 사원명을 출력하시오

SELECT
    JOB_NAME,
    EMP_NAME
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE) --> 이건 뭘까
WHERE SAL_LEVEL IN (SELECT SAL_LEVEL FROM EMPLOYEE 
WHERE EMP_NAME IN ('차태연','전지연'));

-- 인라인 뷰
-- FROM에 테이블 대신 서브쿼리로 테이블을 대신 함
-- 1. 랭킹분석 (TON-N 분석)
-- 2. 페이징 처리 (한 페이지당 보여주는 게시물의 갯수)
SELECT
    EMP_NAME,
    SALARY
FROM (SELECT EMP_ID, EMP_NAME, SALARY FROM EMPLOYEE);

-- 랭킹분석
-- RANK() OVER 
-- EX) 회사의 연봉 순위를 출력하시오
-- 중복 순위 다음은 해당 갯수만큼 건너뛰고 반환
-- 1,2,3,4,5,6,6,6,9,10
SELECT EMP_NAME,  SALARY*12, RANK() OVER(ORDER BY SALARY DESC)
FROM EMPLOYEE;

-- DENSE_RANK() OVER
-- 중복 순위 상관없이 순차적으로 반환
-- 1,2,3,4,5,6,6,7,...
SELECT EMP_NAME,  SALARY*12, DENSE_RANK() OVER(ORDER BY SALARY DESC)
FROM EMPLOYEE;

-- 회사에서 급여가 가장 높은 5명을 출력하시오
SELECT 
    ROWNUM,
    EMP_NAME, 
    SALARY
FROM (SELECT
        EMP_NAME,
        SALARY
FROM EMPLOYEE
ORDER BY SALARY DESC)
WHERE ROWNUM <= 5;

--SELECT 실행순서
-- FROM WHERE GROUP BY HAVING SELECT ORDER BY

-- 스칼라 서브쿼리
-- SELECT 문에서 사용하는 서브쿼리
-- 상호연관 서브쿼리
SELECT 
    (SELECT DEPT_TITLE FROM DEPARTMENT DEPT WHERE EMP.DEPT_CODE = DEPT.DEPT_ID)
    EMP_NAME, 
    SALARY
FROM EMPLOYEE EMP;

-- EMPLOYEE 테이블에서 직급명, 사원명, 서브쿼리를 이용하여 출력하시오
SELECT EMP_NAME,
        PHONE,
        JOB_NAME
FROM EMPLOYEE
INNER JOIN JOB USING(JOB_CODE);

SELECT (SELECT JOB_NAME FROM JOB J WHERE EMP.JOB_CODE = J.JOB_CODE), 
        EMP_NAME "사원명", PHONE "연락처"
FROM EMPLOYEE EMP;


-- <서브쿼리 실습 문제>
--문제1
--기술지원부에 속한 사람들의 사람의 이름,부서코드,급여를 출력하시오
SELECT
    EMP_NAME,
    DEPT_CODE,
    SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_ID FROM DEPARTMENT WHERE DEPT_TITLE = '기술지원부');

--문제2
--기술지원부에 속한 사람들 중 가장 연봉이 높은 사람의 이름,부서코드,급여를 출력하시오

SELECT
    EMP_NAME,
    DEPT_CODE,
    SALARY
FROM (
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_ID FROM DEPARTMENT WHERE DEPT_TITLE = '기술지원부')
ORDER BY SALARY DESC)
WHERE ROWNUM =1;

--문제3
--매니저가 있는 사원중에 월급이 전체사원 평균을 넘고 
--사번,이름,매니저 이름,월급(만원단위부터)을 구하시오
 --* 단, JOIN을 이용하시오
SELECT 
    EMP.EMP_ID, EMP.EMP_NAME, MNG.EMP_NAME, TRUNC(EMP.SALARY, -4)
FROM EMPLOYEE EMP
JOIN EMPLOYEE MNG
ON (EMP.MANAGER_ID = MNG.EMP_ID)
WHERE EMP.MANAGER_ID IS NOT NULL
AND EMP.SALARY > (SELECT AVG(SALARY) FROM EMPLOYEE);

--문제4
--부서 별 각 직급마다 급여 등급이 가장 높은 직원의 이름, 직급코드, 급여, 급여등급 조회

SELECT MAX(SAL_LEVEL) FROM EMPLOYEE;
SELECT
    EMP_NAME, JOB_CODE, SALARY, SAL_LEVEL
FROM EMPLOYEE E1
WHERE SAL_LEVEL = (SELECT MIN (SAL_LEVEL) FROM EMPLOYEE E2 WHERE E1.JOB_CODE  = E2.JOB_CODE)
ORDER BY 4;

--문제5
--부서별 평균 급여가 2200000 이상인 부서명, 평균 급여 조회
--단, 평균 급여는 소수점 버림

SELECT DEPT_CODE, "평균" ,DEPT_TITLE
FROM
(SELECT
    DEPT_CODE,
    FLOOR(AVG(SALARY)) "평균"
FROM EMPLOYEE 
GROUP BY DEPT_CODE
HAVING FLOOR(AVG(SALARY)) >= 220000)
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
    
--문제6
--직급의 연봉 평균보다 적게 받는 여자사원의
--사원명,직급코드,부서코드,연봉을 이름 오름차순으로 조회하시오
--연봉 계산 => (급여+(급여*보너스))*12    
-- 사원명,직급명,부서명,연봉은 EMPLOYEE 테이블을 통해 출력이 가능함 
-- 직급별 연봉
SELECT 
    EMP_NAME, DEPT_CODE, (SALARY*12)
FROM EMPLOYEE E1
WHERE SUBSTR(EMP_NO,8,1)= 2 
AND (SALARY*12) < 
(SELECT AVG(SALARY*12) FROM EMPLOYEE E2 WHERE E1.JOB_CODE = E2.JOB_CODE);
