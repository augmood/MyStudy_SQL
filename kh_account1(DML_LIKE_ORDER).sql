-- �񱳿����� (LIKE)
-- ���Ϸ��� ���� ������ Ư�������� ������Ű�� TRUE�� �����ϴ� ������
-- '%'�� '_'�� ���ϵ�ī��� ����� �� ����.
-- * ���ϵ�ī�� : �ƹ� ���ڳ� ��ü�ؼ� ����� �� �ִ� ��
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE EMP_NAME LIKE '��%'; -- ��%�� ��_ _�� ���Ե�

-- ��� ���ڿ� '��'�� �ִ� ��� �˻�
SELECT EMP_NAME,SALARY
FROM EMPLOYEE
WHERE EMP_NAME LIKE '_��_';

-- �̸��� '��'�� ���� ��� �˻�
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE EMP_NAME NOT LIKE '��%';

-- <�ǽ�����>
--1. EMPLOYEE ���̺��� �̸� ���� ������ ������ ����� �̸��� ����Ͻÿ�
SELECT EMP_NAME
FROM EMPLOYEE
WHERE EMP_NAME LIKE '__��';

--2. EMPLOYEE ���̺��� ��ȭ��ȣ ó�� 3�ڸ��� 010�� �ƴ� ����� �̸�, ��ȭ��ȣ��
--����Ͻÿ�
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE PHONE NOT LIKE '010%';

--3. EMPLOYEE ���̺��� �����ּ��� 's'�� ���鼭, DEPT_CODE�� D9 �Ǵ� D6�̰�
--������� 90/01/01 ~ 01/12/01�̸鼭, ������ 270�����̻��� ����� ��ü ������ ����Ͻÿ�

SELECT *
FROM EMPLOYEE
WHERE EMAIL LIKE '%s%' AND (DEPT_CODE = 'D9' OR DEPT_CODE = 'D6') AND
HIRE_DATE BETWEEN '90/01/01' AND '01/12/01' AND (SALARY >= 2700000);

-- <# ��������>
-- EMPLOYEE ���̺��� EMAIL ID �� @ ���ڸ��� 5�ڸ��� ������ ��ȸ�Ѵٸ�?
SELECT *
FROM EMPLOYEE
WHERE EMAIL LIKE '_____@%';

-- EMPLOYEE ���̺��� EMAIL ID �� '_' ���ڸ��� 3�ڸ��� ������ ��ȸ�Ѵٸ�?
SELECT EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '___#_%' ESCAPE '#'; --> #�� ���� ������ Ż���Ѵ� (#�ƴϾ ��)

-- <# ��������>
-- EMPLOYEE ���̺��� EMAIL ID �� @ ���ڸ��� 5�ڸ��� ������ ��ȸ�Ѵٸ�?
SELECT *
FROM EMPLOYEE
WHERE EMAIL LIKE '_____@%';

-- EMPLOYEE ���̺��� EMAIL ID �� '_' ���ڸ��� 3�ڸ��� ������ ��ȸ�Ѵٸ�?
SELECT *
FROM EMPLOYEE
WHERE EMAIL LIKE '___#_%' ESCAPE '#'; --> #�� ���� ������ Ż���Ѵ� (#�ƴϾ ��)

-- IS NULL / IS NOT NULL -> NULL ���̰ų� �ƴϰų��� ��ȸ�ϴ� ������ 
SELECT *
FROM EMPLOYEE
WHERE BONUS IS NULL;

SELECT *
FROM EMPLOYEE
WHERE BONUS IS NOT NULL;

-- MANAGER_ID ���� NULL �� ������ �˻� 
SELECT *
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL;

SELECT EMP_NAME, PHONE, EMAIL
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9' OR DEPT_CODE = 'D6';

-- IN ������ --> ���Ϸ��� �� ��Ͽ� ��ġ�ϴ� ���� ������ TRUE�� ��ȯ�ϴ� ����
SELECT EMP_NAME, PHONE, EMAIL
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D9', 'D6', 'D3','D2');

-- ORDER BY ����
-- > NULL �� : ASC �� ��, DESC �� ��
-- > DATE �� : ASC ���� ������ ��¥, DESC �ֱ� ��¥
-- > ORDER BY ������ �÷��� ��� ������ �÷� ������ ��� �ȴ�.
SELECT * FROM EMPLOYEE
ORDER BY PHONE ASC;

SELECT * FROM EMPLOYEE
ORDER BY EMP_NAME DESC;

SELECT * FROM EMPLOYEE
ORDER BY 2 DESC; --> �̸��� �������� �����Ѵ�.


