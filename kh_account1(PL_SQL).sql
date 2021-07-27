-- PL / SQL
--> Procedural language extension to SQL의 약자
--> 오라클 자체에 내장되어 있는 절차적 언어로서, SQL의 단점을 보완하여
--  SQL 문장내에서 변수의 정의, 조건처리, 반복처리 등을 지원

-- PL / SQL 블록 문법
-- DECLARE
-- BEGIN
-- EXCEPTION
-- END;
-- / 

-- PL / SQL의 구조
-- DECLARE SECTION(선언부) - 생략가능
--> 변수나 상수를 선언하는 부분
--> DECLARE로 시작함

-- EXECUTABLE SECTION(실행부) - 필수
--> 제어문, 반복문, 함수 정의 등 로직 기술
-- BEGIN으로 시작함

-- EXCETION SECTION(예외처리부) - 생략가능
--> 예의사항 발생시 해결하기 위한 문장 기술
-- EXCEPTION으로 시작함

-- END; 블록 종료

-- PL / SQL 종료 및 실행

BEGIN
DBMS_OUTPUT.PUT_LINE('HELLO ORACLE');
END;
/

-- PL / SQL 기본 설정
SET SERVEROUTPUT ON;

-- 변수선언 후 값 대입
-- #변수선언
-- 변수형 자료형 (바이트크기) [:=초기값];
DECLARE
    EMPNO NUMBER := 1001;
    ENAME VARCHAR2(20) := '김사랑';
BEGIN
    DBMS_OUTPUT.PUT_LINE('      사번      이름');
    DBMS_OUTPUT.PUT_LINE('-------------------');
    DBMS_OUTPUT.PUT_LINE('    '||EMPNO||'     '||ENAME);
END;
/

DECLARE
    USER_NAME VARCHAR2(20) := '송세라';
    USER_NAME2 VARCHAR2(20) := '강영미';
BEGIN
    DBMS_OUTPUT.PUT_LINE('USER_NAME : ' || USER_NAME);
    USER_NAME2 := '최인정'; --> 강영미에서 최인정으로 변경됨
    DBMS_OUTPUT.PUT_LINE('USER_NAME2 : ' || USER_NAME2);
END;
/

-- PL / SQL에서 SELECT문
--> SQL에서 사용하는 명령어를 그대로 사용할 수 있으며,
-- SELECT 쿼리 결과로 나온 값을 변수에 할당하기 위해 사용함

SELECT EMP_NO, EMP_NAME FROM EMPLOYEE;
DECLARE
    VEMPNO CHAR(14);
    VENAME VARCHAR2(20);
BEGIN
    SELECT EMP_NO, EMP_NAME
    INTO VEMPNO, VENAME
    FROM EMPLOYEE
    WHERE EMP_NAME = '송종기';
    DBMS_OUTPUT.PUT_LINE('주민번호 : '||VEMPNO);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || VENAME); 
EXCEPTION --> 예외처리 송종기가 아니면 이 메세지 출력
    WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('No Data !');
END;
/


-- 사원번호를 입력 받아서 사원의 사원번호, 이름, 급여, 입사일을 출력하시오

DECLARE
    VEMPID VARCHAR2(3);
    VENAME VARCHAR2(20);
    VSAL NUMBER;
    VHIREDATE DATE;
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, HIRE_DATE
    INTO VEMPID, VENAME, VSAL, VHIREDATE
    FROM EMPLOYEE
    WHERE EMP_ID = '&EMPID';  --> 입력받기 &만 들어가면 됨
    DBMS_OUTPUT.PUT_LINE('사원번호 ' || VEMPID);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || VENAME);
    DBMS_OUTPUT.PUT_LINE('급여 : ' || VSAL);
    DBMS_OUTPUT.PUT_LINE('입사일 : ' || VHIREDATE);
EXCEPTION
    WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('NO DATA');
END;
/

-- 간단 실습
-- 사원의 사원번호 입력시, 이름, 부서코드, 직급코드가 출력 되도록 PL/SQL 만들어보시오

DECLARE
    VEMPID VARCHAR2(3);
    VENAME VARCHAR2(20);
    VDEPCODE CHAR(2);
    VJCODE CHAR(2);
BEGIN
    SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE
    INTO VEMPID, VENAME, VDEPCODE, VJCODE
    FROM EMPLOYEE
    WHERE EMP_ID = '&EMPID'; 
    DBMS_OUTPUT.PUT_LINE('이름 : ' || VENAME);
    DBMS_OUTPUT.PUT_LINE('부서코드 : ' || VDEPCODE);
    DBMS_OUTPUT.PUT_LINE('직급코드 : ' || VJCODE);
EXCEPTION
    WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('NO DATA');
END;
/

-- 사원의 사원번호 입력시, 이름, 부서명, 직급명이 출력되도록 PL/SQL을 만들어보시오.

DECLARE
    VEMPID VARCHAR2(3);
    VENAME VARCHAR2(20);
    VDEPTITLE VARCHAR(35);
    VJNAME VARCHAR(35);
BEGIN
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
    INTO VEMPID, VENAME, VDEPTITLE, VJNAME
    FROM EMPLOYEE
    INNER JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    INNER JOIN JOB USING (JOB_CODE)
    WHERE EMP_ID = '&EMPID'; 
    DBMS_OUTPUT.PUT_LINE('이름 : ' || VENAME);
    DBMS_OUTPUT.PUT_LINE('부서명 : ' || VDEPTITLE);
    DBMS_OUTPUT.PUT_LINE('직급명 : ' || VJNAME);
EXCEPTION
    WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('NO DATA');
END;
/

-- PL / SQL 선택문
--> 모든 문장들은 기술한 순서대로 순차적으로 수행함
--> 문장을 선택적으로 수행하려면 IF문을 사용하면 됨
-- # IF ~ THEN ~ EMD IF 문
--> 조건에 따라 어떤 명령을 선택적으로 처리하기 위한 가장 기본 구문
-- IF 조건 THEN
--  조건을 만족할 경우 처리 구문
-- END IF

DECLARE
    BONUS NUMBER := 1;
BEGIN
    IF(BONUS = 0)
    THEN DBMS_OUTPUT.PUT_LINE('보너스가 0입니다.');
    END IF;
END;
/
DECLARE
    VEMPID VARCHAR2(3);
    VENAME VARCHAR2(20);
    VSALARY NUMBER;
    VBONUS NUMBER;
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS, 0)
    INTO VEMPID, VENAME, VSALARY, VBONUS
    FROM EMPLOYEE
    WHERE EMP_ID = '&EMP_ID';
    DBMS_OUTPUT.PUT_LINE('사번 : '||VEMPID);
    DBMS_OUTPUT.PUT_LINE('이름 : '||VENAME);
    DBMS_OUTPUT.PUT_LINE('급여 : '||VSALARY);
    DBMS_OUTPUT.PUT_LINE('보너스 : '||VBONUS);
    
    IF(VBONUS = 0)
    THEN DBMS_OUTPUT.PUT_LINE('보너스를 지급 받지 않는 사람입니다.');
    END IF;
    
END;
/

-- PL / SQL 반복문