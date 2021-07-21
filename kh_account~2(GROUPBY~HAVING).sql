-- GROUP BY & HAVING 
-- GROUP BY
SELECT SUM(SALARY) 
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- EMPLOYEE 테이블에서 부서코드, 그룹별 급여의 합계, 그룹별 급여의 평균(정수처리),
-- 인원수를 조회하고 부서코드 순으로 정렬.

SELECT 
    DEPT_CODE "부서코드",
    COUNT(*),
    SUM (SALARY) "급여합계",
    FLOOR(AVG (SALARY)) "급여 평균"
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING COUNT(*) > 3 
ORDER BY 1 ASC;
 
 -- EMPLOYEE 테이블에서 EMP_NO의 8번째 자리가 1이면 '남', 2이면 '여'로 결과를 조회하고
-- 성별별 급여의 평균(정수처리), 급여의 합계, 인원수를 조회한 뒤 인원수로 내림차순 정렬하시오.

SELECT 
    DECODE(SUBSTR(EMP_NO,8,1), '1', '남', '2', '여') "성별",
    SUM(SALARY),
    FLOOR(AVG(SALARY)),
    COUNT(*)
FROM EMPLOYEE
GROUP BY DECODE(SUBSTR(EMP_NO,8,1), '1', '남', '2', '여')
ORDER BY 1;

-- <실습 문제>
-- @ 실습 문제 1 --> J1제외 어케해
--EMPLOYEE 테이블에서 직급이 J1을 제외하고, 직급,직급별 사원수 및 평균급여를 출력하세요.
SELECT
    JOB_CODE "직급",
    COUNT(*) "인원 수",
    FLOOR(AVG(SALARY)) "연봉평균"
FROM EMPLOYEE
WHERE JOB_CODE != 'J1'
GROUP BY JOB_CODE;


-- @ 실습 문제 2
-- EMPLOYEE테이블에서 직급이 J1을 제외하고,  
-- 입사년도별 인원수를 조회해서, 입사년 기준으로 오름차순 정렬하세요.
SELECT
    EXTRACT(YEAR FROM HIRE_DATE) "입사년도",
    COUNT(*) "인원 수"
FROM EMPLOYEE
WHERE JOB_CODE NOT LIKE 'J1'
GROUP BY EXTRACT(YEAR FROM HIRE_DATE);
    

--@ 실습 문제 3
--부서내 성별 인원수를 구하세요.
-- 다음과 같이 출력 되도록 만드시오
--ex)
--D1	남	2
--D1	여	1

SELECT
    DEPT_CODE "부서코드", 
    DECODE(SUBSTR(EMP_NO,8,1), '1', '남','2','여') "성별",
    COUNT(*) "인원 수"
FROM EMPLOYEE
GROUP BY DEPT_CODE, DECODE(SUBSTR(EMP_NO,8,1), '1', '남','2','여')
ORDER BY 1;