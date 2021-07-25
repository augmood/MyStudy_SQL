
-- ROLLUP
SELECT
    DEPT_CODE,
    JOB_CODE,
    SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(DEPT_CODE, JOB_CODE)
ORDER BY 1;

-- CUBE
SELECT
    DEPT_CODE,
    JOB_CODE,
    SUM(SALARY)
FROM EMPLOYEE
GROUP BY CUBE(DEPT_CODE, JOB_CODE)
ORDER BY 1;
--> j7�� �� �ΰ��� �����°�? ��ü �� ���ѰŶ�, �μ��ڵ尡 NULL�� ��� �ΰ� ����

-- UNION

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION ALL
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;
-- ���� �������� ������ �� : �ΰ��� �������� �÷��� ������ Ÿ���� ���ƾ� ��

-- JOIN ����

SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE;

SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT;

-- DEPT_CODE = DEPT_ID --> JOIN

SELECT EMP_ID, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE INNER JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);

-- �� ���̺��� �÷� �̸��� ������ �浹�ϴ� ������ �ذ�

-- ORACLE ���뱸��
-- ���̺���.�÷���ǥ�� ���� (���ϴ� ���̺����� �����ֱ�) 
SELECT EMP_ID, EMP_NAME, PHONE, EMAIL, EMPLOYEE.JOB_CODE, JOB_NAME
FROM EMPLOYEE INNER JOIN JOB ON(EMPLOYEE.JOB_CODE = JOB.JOB_CODE);

-- ANSI ǥ�ر���
-- USING �ȿ� �ִ� �÷����� JOIN�� ���̺��� �÷���
SELECT EMP_ID, EMP_NAME,  PHONE, EMAIL, JOB_CODE, JOB_NAME
FROM EMPLOYEE INNER JOIN JOB USING(JOB_CODE);

-- JOIN�� ����
-- 1. INNER JOIN �������� : ������
-- 2. OUTER JOIN �ܺ����� : ������
-- * LEFT OUTER JOIN : 
-- * RIGHT OUTER JOIN :
-- * FULL OUYER JOIN :

SELECT EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE LEFT OUTER JOIN DEPARTMENT
ON (DEPT_CODE = DEPT_ID); --> () ���Ǿ��� EMPLOYEE ����

SELECT EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE RIGHT OUTER JOIN DEPARTMENT
ON (DEPT_CODE = DEPT_ID); --> () ���Ǿ��� DEPARTMENT ����

SELECT EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE FULL OUTER JOIN DEPARTMENT
ON (DEPT_CODE = DEPT_ID); ---> �� �� ����

-- SELF JOIN
-- ���� ���̺��� �����ϴ� ��� (������ �Ŵ��� ���� ���)
SELECT EMP.EMP_ID "���", EMP.EMP_NAME "������", EMP.DEPT_CODE "�μ��ڵ�", 
        EMP.MANAGER_ID"�Ŵ��� ���", MANAGER.EMP_NAME "�Ŵ��� �̸�"
FROM EMPLOYEE EMP INNER JOIN EMPLOYEE MANAGER 
                    ON(EMP.MANAGER_ID = MANAGER.EMP_ID);

-- ��������
-- �ڽ��� �����ϰ� �ִ� ����� �̸�,�޿� �� ������ ��� �Ǵ��� �˻��Ͽ���.
SELECT 
    MANAGER.EMP_NAME "�Ŵ����̸�", EMP.EMP_NAME "��� �̸� ", 
    EMP.SALARY "��� �޿�", EMP.JOB_CODE "��� ����"
FROM EMPLOYEE EMP INNER JOIN EMPLOYEE MANAGER ON (EMP.MANAGER_ID = MANAGER.EMP_ID);