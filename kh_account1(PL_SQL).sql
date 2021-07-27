-- PL / SQL
--> Procedural language extension to SQL�� ����
--> ����Ŭ ��ü�� ����Ǿ� �ִ� ������ ���μ�, SQL�� ������ �����Ͽ�
--  SQL ���峻���� ������ ����, ����ó��, �ݺ�ó�� ���� ����

-- PL / SQL ��� ����
-- DECLARE
-- BEGIN
-- EXCEPTION
-- END;
-- / 

-- PL / SQL�� ����
-- DECLARE SECTION(�����) - ��������
--> ������ ����� �����ϴ� �κ�
--> DECLARE�� ������

-- EXECUTABLE SECTION(�����) - �ʼ�
--> ���, �ݺ���, �Լ� ���� �� ���� ���
-- BEGIN���� ������

-- EXCETION SECTION(����ó����) - ��������
--> ���ǻ��� �߻��� �ذ��ϱ� ���� ���� ���
-- EXCEPTION���� ������

-- END; ��� ����

-- PL / SQL ���� �� ����

BEGIN
DBMS_OUTPUT.PUT_LINE('HELLO ORACLE');
END;
/

-- PL / SQL �⺻ ����
SET SERVEROUTPUT ON;

-- �������� �� �� ����
-- #��������
-- ������ �ڷ��� (����Ʈũ��) [:=�ʱⰪ];
DECLARE
    EMPNO NUMBER := 1001;
    ENAME VARCHAR2(20) := '����';
BEGIN
    DBMS_OUTPUT.PUT_LINE('      ���      �̸�');
    DBMS_OUTPUT.PUT_LINE('-------------------');
    DBMS_OUTPUT.PUT_LINE('    '||EMPNO||'     '||ENAME);
END;
/

DECLARE
    USER_NAME VARCHAR2(20) := '�ۼ���';
    USER_NAME2 VARCHAR2(20) := '������';
BEGIN
    DBMS_OUTPUT.PUT_LINE('USER_NAME : ' || USER_NAME);
    USER_NAME2 := '������'; --> �����̿��� ���������� �����
    DBMS_OUTPUT.PUT_LINE('USER_NAME2 : ' || USER_NAME2);
END;
/

-- PL / SQL���� SELECT��
--> SQL���� ����ϴ� ��ɾ �״�� ����� �� ������,
-- SELECT ���� ����� ���� ���� ������ �Ҵ��ϱ� ���� �����

SELECT EMP_NO, EMP_NAME FROM EMPLOYEE;
DECLARE
    VEMPNO CHAR(14);
    VENAME VARCHAR2(20);
BEGIN
    SELECT EMP_NO, EMP_NAME
    INTO VEMPNO, VENAME
    FROM EMPLOYEE
    WHERE EMP_NAME = '������';
    DBMS_OUTPUT.PUT_LINE('�ֹι�ȣ : '||VEMPNO);
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || VENAME); 
EXCEPTION --> ����ó�� �����Ⱑ �ƴϸ� �� �޼��� ���
    WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('No Data !');
END;
/


-- �����ȣ�� �Է� �޾Ƽ� ����� �����ȣ, �̸�, �޿�, �Ի����� ����Ͻÿ�

DECLARE
    VEMPID VARCHAR2(3);
    VENAME VARCHAR2(20);
    VSAL NUMBER;
    VHIREDATE DATE;
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, HIRE_DATE
    INTO VEMPID, VENAME, VSAL, VHIREDATE
    FROM EMPLOYEE
    WHERE EMP_ID = '&EMPID';  --> �Է¹ޱ� &�� ���� ��
    DBMS_OUTPUT.PUT_LINE('�����ȣ ' || VEMPID);
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || VENAME);
    DBMS_OUTPUT.PUT_LINE('�޿� : ' || VSAL);
    DBMS_OUTPUT.PUT_LINE('�Ի��� : ' || VHIREDATE);
EXCEPTION
    WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('NO DATA');
END;
/

-- ���� �ǽ�
-- ����� �����ȣ �Է½�, �̸�, �μ��ڵ�, �����ڵ尡 ��� �ǵ��� PL/SQL �����ÿ�

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
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || VENAME);
    DBMS_OUTPUT.PUT_LINE('�μ��ڵ� : ' || VDEPCODE);
    DBMS_OUTPUT.PUT_LINE('�����ڵ� : ' || VJCODE);
EXCEPTION
    WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('NO DATA');
END;
/

-- ����� �����ȣ �Է½�, �̸�, �μ���, ���޸��� ��µǵ��� PL/SQL�� �����ÿ�.

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
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || VENAME);
    DBMS_OUTPUT.PUT_LINE('�μ��� : ' || VDEPTITLE);
    DBMS_OUTPUT.PUT_LINE('���޸� : ' || VJNAME);
EXCEPTION
    WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('NO DATA');
END;
/

-- PL / SQL ���ù�
--> ��� ������� ����� ������� ���������� ������
--> ������ ���������� �����Ϸ��� IF���� ����ϸ� ��
-- # IF ~ THEN ~ EMD IF ��
--> ���ǿ� ���� � ����� ���������� ó���ϱ� ���� ���� �⺻ ����
-- IF ���� THEN
--  ������ ������ ��� ó�� ����
-- END IF

DECLARE
    BONUS NUMBER := 1;
BEGIN
    IF(BONUS = 0)
    THEN DBMS_OUTPUT.PUT_LINE('���ʽ��� 0�Դϴ�.');
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
    DBMS_OUTPUT.PUT_LINE('��� : '||VEMPID);
    DBMS_OUTPUT.PUT_LINE('�̸� : '||VENAME);
    DBMS_OUTPUT.PUT_LINE('�޿� : '||VSALARY);
    DBMS_OUTPUT.PUT_LINE('���ʽ� : '||VBONUS);
    
    IF(VBONUS = 0)
    THEN DBMS_OUTPUT.PUT_LINE('���ʽ��� ���� ���� �ʴ� ����Դϴ�.');
    END IF;
    
END;
/

-- PL / SQL �ݺ���