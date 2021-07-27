-- DATA DICTIONARY
-- 다양한 정보를 저장하고 있고, 저장하는 시스템 테이블
-- DATA DICTIONARY는 사용자가 테이블을 생성하거나 사용자를 변경하는 등의 작업을 할때 
-- DB서버에 의해 자동으로 갱신 됨, 삭제할 수 없고 조회만 가능함
-- 1. DBA_XXXX : 데이터베이스 관리자만이 접근이 가능한 객체(ORACLE)정보 조회
-- 2. ALL_XXXX : 자신의 계정이 소유하거나 권한을 부여 받은 객체(ORACLE)에 관한 정보 조회
-- 3. USER_XXXX : 자신의 계정이 소유한 객체에 관한 정보 조회

-- KH 계정에서 실행 
SELECT CONSTRAINT_NAME FROM USER_CONSTRAINTS;
-- 유저가 관리하는 CONSTRAINT 이름을 볼 수 있다.

SELECT * FROM USER_SEQUENCES;
SELECT * FROM USER_CONSTRAINTS;
SELECT * FROM USER_INDEXES;

-- SYS AS DBA 계정에서 실행
SELECT * FROM DBA_USERS;
-- 그동안 만들었던 계정들의 정보를 출력한다.

-- ////////// VIEW 생성 실습 ///////////

SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE; -- 내용이 전부 노출됨

CREATE VIEW V_EMPLOYEE(사번, 이름, 부서코드, 이메일)
-- 한글 안쓰면 그냥 컬럼 이름으로 나옴
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, EMAIL
FROM EMPLOYEE; 
--> 바로 안 만들어짐 WHY? CREATE VIEW 권한이 없음
--> KH ACCOUNT에 GRANT로 권한을 생성해주어야 함
GRANT CREATE VIEW TO KH; --> SYS 계정에서 하기

SELECT * FROM V_EMPLOYEE; --> 원하는 대로 만들어짐 

-- 사번, 이름, 부서명, 직급명을 조회할 수 있는 VIEW를 생성하시오
-- EMPLOYEE, JOB, DEPARTMETN TABLE 전부 필요함
CREATE OR REPLACE VIEW V2_EMPLOYEE(사번, 이름, 부서이름, 직급명)
-- 한글 안쓰면 그냥 컬럼 이름으로 나옴
AS SELECT EMP_ID, EMP_NAME, JOB_NAME, DEPT_TITLE
FROM EMPLOYEE
INNER JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
INNER JOIN JOB USING (JOB_CODE);
SELECT * FROM V2_EMPLOYEE;
DROP VIEW V2_EMPLOYEE;

-- 부서명과 직급명에 NULL이 나오지 않게 하기, 인라인뷰 사용하기
CREATE OR REPLACE VIEW V2_EMPLOYEE(사번, 이름, 부서명, 직급명)
-- 한글 안쓰면 그냥 컬럼 이름으로 나옴
AS SELECT * FROM (
    SELECT
    EMP_ID, 
    EMP_NAME, 
    (SELECT DEPT_TITLE FROM DEPARTMENT DEPT WHERE EMP.DEPT_CODE = DEPT_ID)"DEPT_TITLE",
    (SELECT JOB_NAME FROM JOB J WHERE EMP.JOB_CODE = J.JOB_CODE)"JOB_NAME"
FROM EMPLOYEE EMP) WHERE DEPT_TITLE IS NOT NULL AND JOB_NAME IS NOT NULL;
SELECT * FROM V2_EMPLOYEE;


CREATE OR REPLACE VIEW EMP_VIEW (이름, 이메일, 연락처)
AS SELECT EMP_NAME, EMAIL, PHONE
FROM EMPLOYEE;
SELECT * FROM EMP_VIEW;

-- 본 테이블 자체 값을 바꿈 -> 전부 바뀜
UPDATE EMPLOYEE
SET PHONE = '01038159410'
WHERE EMP_NAME = '임시환';

-- VIEW 테이블 값을 바꿈 -> 전부 바뀜
UPDATE EMP_VIEW
SET "연락처" = '01091115980'
WHERE "이름" = '이오리';

COMMIT;

-- 연봉을 나타내는 VIEW
-- 만들어지긴 해도 INSERT 할때 오류가 생김 
CREATE OR REPLACE VIEW EMP_SAL_VIEW (이름, 연봉)
AS SELECT EMP_NAME, SALARY*12
FROM EMPLOYEE;

SELECT * FROM EMP_SAL_VIEW;

-- USER_VIEW 데이터 딕셔너리 뷰 조회
-- 내가 어떤 것을 만들었고, 쿼리가 어떤지 보여줌 
SELECT * FROM USER_VIEWS;
