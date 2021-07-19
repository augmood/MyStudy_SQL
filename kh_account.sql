SELECT * FROM EMPLOYEE;
SELECT EMP_ID, EMP_NAME, EMP_NO, EMAIL, PHONE FROM EMPLOYEE;
SELECT EMP_ID, EMP_NAME, EMP_NO, EMAIL, PHONE FROM EMPLOYEE
WHERE EMP_ID = '201';

-- SELECT �÷� �� �������
SELECT EMP_NAME, SALARY, SALARY*12 FROM EMPLOYEE;

-- SELECT �÷� ��Ī, ���ͷ�
SELECT EMP_NAME, SALARY, SALARY*12 AS "ANNUAL_SALARY" FROM EMPLOYEE; 
--> AS "ANNUAL_SALARY",  AS ANNUAL_SALARY, "ANNUAL_SALARY" ��� ����

SELECT EMP_NAME, SALARY, SALARY*12 AS "ANNUAL_SALARY",'��' AS "����" FROM EMPLOYEE; 

-- <����>
-- 1. JOB���̺��� JOB_NAME�� ������ ��µǵ��� �Ͻÿ�

SELECT JOB_NAME 
FROM JOB;

-- 2. DEPARTMENT���̺��� ���� ��ü�� ����ϴ� SELECT���� �ۼ��Ͻÿ�

SELECT * FROM DEPARTMENT;

-- 3. EMPLOYEE ���̺��� �̸�(EMP_NAME),�̸���(EMAIL),
-- ��ȭ��ȣ(PHONE),�����(HIRE_DATE)�� ����Ͻÿ�

SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE 
FROM EMPLOYEE;

-- 4. EMPLOYEE ���̺��� �����(HIRE_DATE) �̸�(EMP_NAME),����(SALARY)�� ����Ͻÿ�

SELECT HIRE_DATE, EMP_NAME, SALARY 
FROM EMPLOYEE;

-- 5. EMPLOYEE ���̺��� ����(SALARY)�� 2,500,000���̻��� ����� 
-- EMP_NAME �� SAL_LEVEL�� ����Ͻÿ� 
-- (��Ʈ : >(ũ��) , <(�۴�) �� �̿�)

SELECT EMP_NAME, SAL_LEVEL 
FROM EMPLOYEE
WHERE SALARY > 2500000;

-- 6. EMPLOYEE ���̺��� ����(SALARY)�� 350���� �̻��̸鼭 
-- JOB_CODE�� 'J3' �� ����� 
-- �̸�(EMP_NAME)�� ��ȭ��ȣ(PHONE)�� ����Ͻÿ�
-- (��Ʈ : AND(�׸���) , OR (�Ǵ�))

SELECT EMP_NAME, PHONE 
FROM EMPLOYEE
WHERE SALARY >= 3500000 AND JOB_CODE = 'J3';

SELECT JOB_CODE 
FROM EMPLOYEE;

--> JOB_CODE�� �ߺ����� ������
SELECT DISTINCT JOB_CODE 
FROM EMPLOYEE;

--> WHERE ������
SELECT EMP_NAME, DEPT_CODE 
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

SELECT EMP_NAME, SALARY 
FROM EMPLOYEE 
WHERE SALARY < 6000000;


--<����>
-- 1. EMPLOYEE ���̺��� �̸�,����, �Ѽ��ɾ�(���ʽ�����), �Ǽ��ɾ�(�� ���ɾ�-(����*���� 3%))�� ��µǵ��� �Ͻÿ�.
SELECT EMP_NAME AS "�̸� ", SALARY*12 AS "����", SALARY*12+(SALARY*BONUS) AS "�Ѽ��ɾ�", 
(SALARY*12+(SALARY*BONUS))-(SALARY*0.03*12) AS "�Ǽ��ɾ�"
FROM EMPLOYEE;

-- 2. EMPLOYEE ���̺��� �̸�, �ٹ� �ϼ��� ����غ��ÿ�. (SYSDATE�� ����ϸ� ���� �ð� ���)
SELECT EMP_NAME AS "�̸�" , FLOOR(SYSDATE - HIRE_DATE) AS "�ٹ��ϼ�" 
FROM EMPLOYEE;


-- 3. EMPLOYEE ���̺��� 20�� �̻� �ټ����� �̸�,����,���ʽ��� ����Ͻÿ�
SELECT EMP_NAME AS "�̸�" , SALARY AS "����" , BONUS AS "���ʽ���", FLOOR(SYSDATE-HIRE_DATE)/365 AS "�ټӳ��"
FROM EMPLOYEE
WHERE FLOOR(SYSDATE-HIRE_DATE)/365 >= 20;

-- 4. �޿��� 3500000�� �̻� �ް� 6000000�� ���Ϸ� �޴� ������ �̸��� �޿� ��ȸ�Ͻÿ�
SELECT EMP_NAME, SALARY 
FROM EMPLOYEE 
WHERE SALARY >= 3500000 AND SALARY <= 6000000;
-- BETWEEN A AND B
SELECT EMP_NAME, SALARY 
FROM EMPLOYEE 
WHERE SALARY BETWEEN 3500000 AND 6000000; --> = �� ���Ե�