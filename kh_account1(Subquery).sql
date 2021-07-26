-- ��������

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

-- ������ ������ �Ŵ��� �̸��� ����Ͻÿ�
SELECT
    EMP_NAME 
FROM EMPLOYEE
WHERE EMP_ID = (SELECT MANAGER_ID FROM EMPLOYEE WHERE EMP_NAME = '������');


-- ���ù���
--@ �ǽ����� 
--1. �����ؿ� �޿��� ���� ������� �˻��ؼ�, �����ȣ,����̸�, �޿��� ����϶�.
--��, �����ش� ��� �Ǹ� �ȵ� --> ?

SELECT
    EMP_ID,
    EMP_NAME,
    SALARY
FROM EMPLOYEE
WHERE SALARY = (SELECT SALARY FROM EMPLOYEE WHERE EMP_NAME = '������')
AND EMP_NAME != '������';

--2. employee ���̺��� �⺻�޿��� ���� ���� ����� ���� ���� ����� ������ 
-- ���, �����, �⺻�޿��� ��Ÿ������.
SELECT
    EMP_ID,
    EMP_NAME,
    SALARY
FROM EMPLOYEE
WHERE SALARY = (SELECT MAX(SALARY) FROM EMPLOYEE) 
        OR SALARY = (SELECT MIN(SALARY) FROM EMPLOYEE);

-- 3. D1, D2�μ��� �ٹ��ϴ� ����� �߿���
-- �⺻�޿��� D5 �μ� �������� '��տ���' ���� ���� ����鸸 
-- �μ���ȣ, �����ȣ, �����, ������ ��Ÿ������.
SELECT
    DEPT_CODE,
    EMP_ID,
    EMP_NAME,
    SALARY
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D1','D2') 
    AND SALARY > (SELECT AVG(SALARY) FROM EMPLOYEE WHERE DEPT_CODE = 'D5');


-- ������ �������� 

SELECT DEPT_CODE FROM EMPLOYEE
WHERE EMP_NAME IN ('������', '�ڳ���');

SELECT 
    EMP_ID,
    EMP_NAME,
    SALARY
FROM EMPLOYEE
WHERE DEPT_CODE IN (SELECT DEPT_CODE FROM EMPLOYEE 
WHERE EMP_NAME IN ('������','�ڳ���'));

-- �ǽ����� 
-- ���¿� ������ ����� �޿���ް� ���� ����� ���޸�, ������� ����Ͻÿ�

SELECT
    JOB_NAME,
    EMP_NAME
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE) --> �̰� ����
WHERE SAL_LEVEL IN (SELECT SAL_LEVEL FROM EMPLOYEE 
WHERE EMP_NAME IN ('���¿�','������'));

-- �ζ��� ��
-- FROM�� ���̺� ��� ���������� ���̺��� ��� ��
-- 1. ��ŷ�м� (TON-N �м�)
-- 2. ����¡ ó�� (�� �������� �����ִ� �Խù��� ����)
SELECT
    EMP_NAME,
    SALARY
FROM (SELECT EMP_ID, EMP_NAME, SALARY FROM EMPLOYEE);

-- ��ŷ�м�
-- RANK() OVER 
-- EX) ȸ���� ���� ������ ����Ͻÿ�
-- �ߺ� ���� ������ �ش� ������ŭ �ǳʶٰ� ��ȯ
-- 1,2,3,4,5,6,6,6,9,10
SELECT EMP_NAME,  SALARY*12, RANK() OVER(ORDER BY SALARY DESC)
FROM EMPLOYEE;

-- DENSE_RANK() OVER
-- �ߺ� ���� ������� ���������� ��ȯ
-- 1,2,3,4,5,6,6,7,...
SELECT EMP_NAME,  SALARY*12, DENSE_RANK() OVER(ORDER BY SALARY DESC)
FROM EMPLOYEE;

-- ȸ�翡�� �޿��� ���� ���� 5���� ����Ͻÿ�
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

--SELECT �������
-- FROM WHERE GROUP BY HAVING SELECT ORDER BY

-- ��Į�� ��������
-- SELECT ������ ����ϴ� ��������
-- ��ȣ���� ��������
SELECT 
    (SELECT DEPT_TITLE FROM DEPARTMENT DEPT WHERE EMP.DEPT_CODE = DEPT.DEPT_ID)
    EMP_NAME, 
    SALARY
FROM EMPLOYEE EMP;

-- EMPLOYEE ���̺��� ���޸�, �����, ���������� �̿��Ͽ� ����Ͻÿ�
SELECT EMP_NAME,
        PHONE,
        JOB_NAME
FROM EMPLOYEE
INNER JOIN JOB USING(JOB_CODE);

SELECT (SELECT JOB_NAME FROM JOB J WHERE EMP.JOB_CODE = J.JOB_CODE), 
        EMP_NAME "�����", PHONE "����ó"
FROM EMPLOYEE EMP;


-- <�������� �ǽ� ����>
--����1
--��������ο� ���� ������� ����� �̸�,�μ��ڵ�,�޿��� ����Ͻÿ�
SELECT
    EMP_NAME,
    DEPT_CODE,
    SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_ID FROM DEPARTMENT WHERE DEPT_TITLE = '���������');

--����2
--��������ο� ���� ����� �� ���� ������ ���� ����� �̸�,�μ��ڵ�,�޿��� ����Ͻÿ�

SELECT
    EMP_NAME,
    DEPT_CODE,
    SALARY
FROM (
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_ID FROM DEPARTMENT WHERE DEPT_TITLE = '���������')
ORDER BY SALARY DESC)
WHERE ROWNUM =1;

--����3
--�Ŵ����� �ִ� ����߿� ������ ��ü��� ����� �Ѱ� 
--���,�̸�,�Ŵ��� �̸�,����(������������)�� ���Ͻÿ�
 --* ��, JOIN�� �̿��Ͻÿ�
SELECT 
    EMP.EMP_ID, EMP.EMP_NAME, MNG.EMP_NAME, TRUNC(EMP.SALARY, -4)
FROM EMPLOYEE EMP
JOIN EMPLOYEE MNG
ON (EMP.MANAGER_ID = MNG.EMP_ID)
WHERE EMP.MANAGER_ID IS NOT NULL
AND EMP.SALARY > (SELECT AVG(SALARY) FROM EMPLOYEE);

--����4
--�μ� �� �� ���޸��� �޿� ����� ���� ���� ������ �̸�, �����ڵ�, �޿�, �޿���� ��ȸ

SELECT MAX(SAL_LEVEL) FROM EMPLOYEE;
SELECT
    EMP_NAME, JOB_CODE, SALARY, SAL_LEVEL
FROM EMPLOYEE E1
WHERE SAL_LEVEL = (SELECT MIN (SAL_LEVEL) FROM EMPLOYEE E2 WHERE E1.JOB_CODE  = E2.JOB_CODE)
ORDER BY 4;

--����5
--�μ��� ��� �޿��� 2200000 �̻��� �μ���, ��� �޿� ��ȸ
--��, ��� �޿��� �Ҽ��� ����

SELECT DEPT_CODE, "���" ,DEPT_TITLE
FROM
(SELECT
    DEPT_CODE,
    FLOOR(AVG(SALARY)) "���"
FROM EMPLOYEE 
GROUP BY DEPT_CODE
HAVING FLOOR(AVG(SALARY)) >= 220000)
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
    
--����6
--������ ���� ��պ��� ���� �޴� ���ڻ����
--�����,�����ڵ�,�μ��ڵ�,������ �̸� ������������ ��ȸ�Ͻÿ�
--���� ��� => (�޿�+(�޿�*���ʽ�))*12    
-- �����,���޸�,�μ���,������ EMPLOYEE ���̺��� ���� ����� ������ 
-- ���޺� ����
SELECT 
    EMP_NAME, DEPT_CODE, (SALARY*12)
FROM EMPLOYEE E1
WHERE SUBSTR(EMP_NO,8,1)= 2 
AND (SALARY*12) < 
(SELECT AVG(SALARY*12) FROM EMPLOYEE E2 WHERE E1.JOB_CODE = E2.JOB_CODE);
