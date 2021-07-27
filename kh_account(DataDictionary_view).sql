-- DATA DICTIONARY
-- �پ��� ������ �����ϰ� �ְ�, �����ϴ� �ý��� ���̺�
-- DATA DICTIONARY�� ����ڰ� ���̺��� �����ϰų� ����ڸ� �����ϴ� ���� �۾��� �Ҷ� 
-- DB������ ���� �ڵ����� ���� ��, ������ �� ���� ��ȸ�� ������
-- 1. DBA_XXXX : �����ͺ��̽� �����ڸ��� ������ ������ ��ü(ORACLE)���� ��ȸ
-- 2. ALL_XXXX : �ڽ��� ������ �����ϰų� ������ �ο� ���� ��ü(ORACLE)�� ���� ���� ��ȸ
-- 3. USER_XXXX : �ڽ��� ������ ������ ��ü�� ���� ���� ��ȸ

-- KH �������� ���� 
SELECT CONSTRAINT_NAME FROM USER_CONSTRAINTS;
-- ������ �����ϴ� CONSTRAINT �̸��� �� �� �ִ�.

SELECT * FROM USER_SEQUENCES;
SELECT * FROM USER_CONSTRAINTS;
SELECT * FROM USER_INDEXES;

-- SYS AS DBA �������� ����
SELECT * FROM DBA_USERS;
-- �׵��� ������� �������� ������ ����Ѵ�.

-- ////////// VIEW ���� �ǽ� ///////////

SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE; -- ������ ���� �����

CREATE VIEW V_EMPLOYEE(���, �̸�, �μ��ڵ�, �̸���)
-- �ѱ� �Ⱦ��� �׳� �÷� �̸����� ����
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, EMAIL
FROM EMPLOYEE; 
--> �ٷ� �� ������� WHY? CREATE VIEW ������ ����
--> KH ACCOUNT�� GRANT�� ������ �������־�� ��
GRANT CREATE VIEW TO KH; --> SYS �������� �ϱ�

SELECT * FROM V_EMPLOYEE; --> ���ϴ� ��� ������� 

-- ���, �̸�, �μ���, ���޸��� ��ȸ�� �� �ִ� VIEW�� �����Ͻÿ�
-- EMPLOYEE, JOB, DEPARTMETN TABLE ���� �ʿ���
CREATE OR REPLACE VIEW V2_EMPLOYEE(���, �̸�, �μ��̸�, ���޸�)
-- �ѱ� �Ⱦ��� �׳� �÷� �̸����� ����
AS SELECT EMP_ID, EMP_NAME, JOB_NAME, DEPT_TITLE
FROM EMPLOYEE
INNER JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
INNER JOIN JOB USING (JOB_CODE);
SELECT * FROM V2_EMPLOYEE;
DROP VIEW V2_EMPLOYEE;

-- �μ���� ���޸� NULL�� ������ �ʰ� �ϱ�, �ζ��κ� ����ϱ�
CREATE OR REPLACE VIEW V2_EMPLOYEE(���, �̸�, �μ���, ���޸�)
-- �ѱ� �Ⱦ��� �׳� �÷� �̸����� ����
AS SELECT * FROM (
    SELECT
    EMP_ID, 
    EMP_NAME, 
    (SELECT DEPT_TITLE FROM DEPARTMENT DEPT WHERE EMP.DEPT_CODE = DEPT_ID)"DEPT_TITLE",
    (SELECT JOB_NAME FROM JOB J WHERE EMP.JOB_CODE = J.JOB_CODE)"JOB_NAME"
FROM EMPLOYEE EMP) WHERE DEPT_TITLE IS NOT NULL AND JOB_NAME IS NOT NULL;
SELECT * FROM V2_EMPLOYEE;


CREATE OR REPLACE VIEW EMP_VIEW (�̸�, �̸���, ����ó)
AS SELECT EMP_NAME, EMAIL, PHONE
FROM EMPLOYEE;
SELECT * FROM EMP_VIEW;

-- �� ���̺� ��ü ���� �ٲ� -> ���� �ٲ�
UPDATE EMPLOYEE
SET PHONE = '01038159410'
WHERE EMP_NAME = '�ӽ�ȯ';

-- VIEW ���̺� ���� �ٲ� -> ���� �ٲ�
UPDATE EMP_VIEW
SET "����ó" = '01091115980'
WHERE "�̸�" = '�̿���';

COMMIT;

-- ������ ��Ÿ���� VIEW
-- ��������� �ص� INSERT �Ҷ� ������ ���� 
CREATE OR REPLACE VIEW EMP_SAL_VIEW (�̸�, ����)
AS SELECT EMP_NAME, SALARY*12
FROM EMPLOYEE;

SELECT * FROM EMP_SAL_VIEW;

-- USER_VIEW ������ ��ųʸ� �� ��ȸ
-- ���� � ���� �������, ������ ��� ������ 
SELECT * FROM USER_VIEWS;
