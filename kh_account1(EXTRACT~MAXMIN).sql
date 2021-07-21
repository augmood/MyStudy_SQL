-- ����Ŭ �Լ�
-- ����ó�� �Լ�, ����ó�� �Լ�, ��¥ó�� �Լ�, NULLó�� �Լ�, ����ȯ�Լ�, �����Լ�
-- ����ȯ �Լ�
-- EXTRACT : �����ؼ� �����ϴ� �Լ�
SELECT SYSDATE FROM DUAL;
SELECT
    EXTRACT(YEAR FROM SYSDATE),
    EXTRACT(MONTH FROM SYSDATE),
    EXTRACT(DAY FROM SYSDATE)
FROM DUAL;

-- EMPLOYEE ���̺��� �����غ���, � �÷����� ������ �� ������
SELECT EXTRACT(YEAR FROM HIRE_DATE) 
FROM EMPLOYEE
ORDER BY 1;

-- <�ǽ� ����>
-- @ �ǽ����� 1
-- EMPLOYEE ���̺��� ����� �̸�,�Ի���,������ ����Ͽ���. 
-- ��, �Ի����� YYYY��M��D�Ϸ� ����ϵ��� �Ͽ���.
-- ���� ����� �Ҽ��� �ϰ�� �ø����� �Ͽ� ����Ͽ���. (28.144 -> 29����)
-- (��½� ������ �Ի��� �������� ��������)
SELECT EMP_NAME, 
        EXTRACT(YEAR FROM HIRE_DATE) ||'��'||
        EXTRACT(MONTH FROM HIRE_DATE)||'��'||
        EXTRACT(DAY FROM HIRE_DATE)|| '��' AS "�Ի���", 
        CEIL((SYSDATE-HIRE_DATE)/365) AS "����"
FROM EMPLOYEE
ORDER BY 2 ASC;

-- @ �ǽ����� 2
-- Ư�� ���ʽ��� �����ϱ� ���Ͽ� �ڷᰡ �ʿ��ϴ�
-- �Ի����� �������� ������ 1�� ���� 6������ ����Ͽ� 
-- ����Ͻÿ� (�̸�,�Ի���,������,������+6,���ش�(��))
-- ex) 90��2��6�� �Ի� -> 90��3��1�� ���� ���
-- ex) 90��2��26�� �Ի� -> 90��3��1�� ���� ���
-- ex) 97��12��1�� �Ի� -> 98��1��1�� ���� ���
-- ��½� �Ի��� �������� �����Ͻÿ�
-- ù° ���� ���� ���Ѵٴ� ����

SELECT EMP_NAME AS "�̸�",
        HIRE_DATE AS "�Ի���",
        LAST_DAY(HIRE_DATE)+1 AS "������",
        ADD_MONTHS(LAST_DAY(HIRE_DATE)+1,6) AS "������+6",
        EXTRACT (MONTH FROM HIRE_DATE) || '��' AS "���ش�(��)"
FROM EMPLOYEE
ORDER BY 2 ASC;

-- ����ȯ �Լ�
-- Integer.parseInt("33") -> 33, String.valueof(33) -> "33"
-- TO.CHAR(���������� �ٲ�), TO_DATE(��¥������ �ٲ�), TO_NUMBER(���������� �ٲ�)
SELECT SYSDATE FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD')FROM DUAL; 
--> SimpleDateFormat, hh:mm:ss
SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD')FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD PM HH12:MI:SS')FROM DUAL;
--> HH24 24�ð� ���� ǥ��, ���� ���� PMHH12
SELECT TO_CHAR(SYSDATE, 'FM YYYY-MM-DD PMHH12:MI:SS')FROM DUAL;
--> FM �� �� �� �� �� ���� 0�� ��������

SELECT EMP_NAME,
        TO_CHAR(HIRE_DATE, 'YY/MM/DD') AS "HIRE_DATE",
        TO_CHAR(HIRE_DATE, 'YYYY-MM-DD') AS "�Ի���"
FROM EMPLOYEE;

-- ��� ���̺��� �����, ����� (1990/02/06(ȭ))�� ����ϼ���
SELECT EMP_NAME,
        TO_CHAR(HIRE_DATE, 'YYYY/MM/DD(DY)') AS "�����"
FROM EMPLOYEE;

-- TO_CHAR : ��¥�� -> ������, ������ (NUMBER) -> ������
SELECT
    SALARY,
    TO_CHAR(SALARY, '999,999,999') "�޿�1", --> 8,000,000
    TO_CHAR(SALARY, 'L999,999,999') "�޿�2", --> ��8,000,000
    TO_CHAR(SALARY, '000,000,000') "�޿�3" --> 008,000,000
FROM EMPLOYEE;

-- TO_DATE : ������ �����͸� ��¥ �����ͷ� ��ȯ�ϰų� ������ �����͸� ��¥�� �����ͷ� ��ȯ
-- ��¥�� ǥ���ϴµ� ���ڷ� ǥ���ϰų� ��¥�� ǥ���� �����͸� ��¥������ �ٲٴ� ��
-- ��¥������ �ٲٸ� ��¥ ���� ������ �������� ������ �ٲ���

SELECT 20210618 FROM DUAL;
SELECT TO_DATE(20210618) FROM DUAL;
--> 20210618 / 21/06/18
SELECT '20211124' FROM DUAL;
SELECT TO_DATE('20211124') FROM DUAL;
--> 20211124 -> 21/11/24
SELECT TO_DATE(TO_DATE(20210618), 'YYYY/MM/DD') 
FROM DUAL;

-- EMPLOYEE ���̺��� 2010�⵵ ���Ŀ� �Ի��� ����� ���, �̸�, �Ի����� ��ȸ�Ͻÿ�
SELECT EMP_NAME, EMP_ID, HIRE_DATE
FROM EMPLOYEE
--WHERE HIRE_DATE > TO_DATE(20100101);
WHERE HIRE_DATE > '20100101';

--TO_NUMBER : ������ �����͸� ���������� ��ȯ (��¥���� ��ȯ �Ұ�)
SELECT SYSDATE FROM DUAL;
SELECT TO_NUMBER('2000') FROM DUAL;

-- '2000'+'3000' -> 2000+3000 = 5000
SELECT TO_NUMBER('2000') + TO_NUMBER('3000') FROM DUAL;
SELECT '2000'+'3000' FROM DUAL;

-- ��ȿ�� ���ڷ� �� ���ڵ������� ��쿡�� ����ȯ�� �����ϴ�.
SELECT TO_NUMBER('1000a') FROM DUAL;  --> �Ұ���

-- ����ó�� �Լ�, ����ó�� �Լ�, ��¥ó�� �Լ�, NULLó�� �Լ�, ����ȯ �Լ�, �����Լ�
-- �����Լ�
-- DECODE �����Լ� : �������� ��쿡 ������ �� �� �ִ� ��� �����ϴ� �Լ�
-- �ۼ��� 
-- DECODE(ǥ����, ����1, ���1, ����2, ���2, ����3, ���3 , ....) 
-- DEFAULT : ��� ������ ����ġ �� ������ ��

SELECT DECODE('B', 'A', 'true', 'B', 'false') FROM DUAL;
--> FALSE

-- EMPLOYEE ���̺��� ���ڻ���� ��, ���ڻ���� ���� ǥ���Ͽ�
-- ��� �̸� �ֹι�ȣ�� ����Ͻÿ�
SELECT 
    EMP_ID,
    EMP_NAME,
    EMP_NO,
    DECODE(SUBSTR(EMP_NO,8,1), '2', '��', '1', '��', '4', '��', '3', '��') "����"
FROM EMPLOYEE;

-- CASE WHEN ~ THEN END
-- CASE
--      WHEN ����1 THEN ���1
--      WHEN ����2 THEN ���2
--      ELSE ��� N
-- END

SELECT 
    EMP_ID,
    EMP_NAME,
    EMP_NO,
    CASE
    WHEN SUBSTR(EMP_NO,8,1) = '2' THEN '��'
    WHEN SUBSTR(EMP_NO,8,1) = '4' THEN '��'
    ELSE '��'
    END AS "����"
FROM EMPLOYEE;

-- EMPLOYEE ���̺��� ����⵵ ���� 60��� �� ������ ���Ͽ� 
-- 65������ ����ڴ� 60��� �ʹ�, 65�� ���� ����ڴ� 60��� �Ĺ��̶�� ����Ͻÿ�

SELECT
    EMP_NAME,
    EMP_NO,
    CASE
    WHEN SUBSTR(EMP_NO,1,2) < '65' THEN '60��� �ʹ�'
    WHEN SUBSTR(EMP_NO,1,2) >= '65' THEN '60��� �Ĺ�'
    END AS "����"
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,1,2) BETWEEN '60' AND '69';

-- �׷��Լ�
-- SUM, AVG, COUNT, MAX/MIN
-- SUM
-- EMPLOYEE ���̺��� ���� ����� �޿� ������ ���
SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) = 1;

-- EMPLOYEE ���̺��� �μ��ڵ尡 D5�� ������ ���ʽ� ���� ������ ���� ���Ͻÿ�
SELECT SUM(SALARY*12 + SALARY*NVL(BONUS, 0))
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

--AVG : ��� ���ϴ� �׷��Լ�
SELECT FLOOR(AVG(SALARY))
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) = 1;

-- EMPLOYEE ���̺��� �μ��ڵ尡 D5�� ������ ���ʽ� ���� ������ ���� ���Ͻÿ�
SELECT FLOOR(AVG(SALARY*12 + SALARY*NVL(BONUS, 0)))
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

-- COUNT
SELECT COUNT(EMP_ID)
FROM EMPLOYEE;

SELECT COUNT(*)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) = 2;

-- MAX/MIN
SELECT MAX(SALARY), MIN(SALARY)
FROM EMPLOYEE;

SELECT MAX(HIRE_DATE), MIN(HIRE_DATE)
FROM EMPLOYEE;
--> MAX �ֱ�, MIN ������ ��¥

-- <���� ���� ����>

--1. ������� �̸��� , �̸��� ���̸� ����Ͻÿ�
--		  �̸�	    �̸���		�̸��ϱ���
--	ex) 	ȫ�浿 , hong@kh.or.kr   	  13

SELECT EMP_NAME "������", EMAIL "�̸���", LENGTH(EMAIL) "�̸��� ����"
FROM EMPLOYEE;

--2. ������ �̸��� �̸��� �ּ��� ���̵� �κи� ����Ͻÿ� --���̵�?
--	ex) ���ö	no_hc
--	ex) ������	jung_jh
SELECT EMP_NAME "�̸� ", 
        SUBSTR(EMAIL, 1, (INSTR(EMP_EMAIL, '@', 1, 1)-1)) "���̵�"
FROM EMPLOYEE;

--3. 60����� ������� ���, ���ʽ� ���� ����Ͻÿ� 
--	�׶� ���ʽ� ���� null�� ��쿡�� 0 �̶�� ��� �ǰ� ����ÿ�
--	    ������    ���      ���ʽ�
--	ex) ������	62	0.3
--	ex) ������	63  	0
SELECT 
    EMP_NAME "�̸�",
    SUBSTR(EMP_NO,1,2) "���",
    NVL(BONUS,0) "���ʽ�"
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,1,2) BETWEEN 60 AND 69;

--4. '010' �ڵ��� ��ȣ�� ���� �ʴ� ����� ���� ����Ͻÿ� (�ڿ� ������ ���� ���̽ÿ�)
--	   �ο�
--	ex) 3��

SELECT 
    COUNT(PHONE) || '��'
FROM EMPLOYEE
WHERE (SUBSTR(PHONE, 1,3) NOT LIKE '010');
    
--5. ������� �Ի����� ����Ͻÿ� 
--	��, �Ʒ��� ���� ��µǵ��� ����� ���ÿ�
--	    ������		�Ի���
--	ex) ������		2012��12��
--	ex) ������		1997�� 3��
SELECT 
    EMP_NAME "������",
    EXTRACT(YEAR FROM HIRE_DATE)||'��'||
    EXTRACT(MONTH FROM HIRE_DATE)||'��' AS "�Ի翬��"
FROM EMPLOYEE
ORDER BY 2;

--6. ������� �ֹι�ȣ�� ��ȸ�Ͻÿ�
--	��, �ֹι�ȣ 9��° �ڸ����� �������� '*' ���ڷ� ä������� �Ͻÿ�
--	ex) ȫ�浿 771120-1******
SELECT EMP_NAME "������", 
        RPAD(SUBSTR(EMP_NO,1,8),14,'*') "�ֹι�ȣ"
FROM EMPLOYEE;


--7. ������, �����ڵ�, ����(��) ��ȸ
--  ��, ������ ��57,000,000 ���� ǥ�õǰ� ��
--     ������ ���ʽ�����Ʈ�� ����� 1��ġ �޿���
SELECT EMP_NAME,
        JOB_CODE,
        TO_CHAR((SALARY+(SALARY*NVL(BONUS,0)))*12, 'L999,999,999')
FROM EMPLOYEE;

--8. �μ��ڵ尡 D5, D9�� ������ �߿��� 2004�⵵�� �Ի��� ������ 
--   �� ��ȸ��.
--   ��� ����� �μ��ڵ� �Ի���
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D5','D9') 
        AND SUBSTR(HIRE_DATE, 1,2) = '04';

--9. ������, �Ի���, ���ñ����� �ٹ��ϼ� ��ȸ 
--	* �ָ��� ���� , �Ҽ��� �Ʒ��� ����
SELECT EMP_NAME, HIRE_DATE,
        FLOOR((SYSDATE-HIRE_DATE))
FROM EMPLOYEE;

--10. ��� ������ ���� �� ���� ���� ���̿� ���� ���� ���̸� ��� �Ͽ���. (���̸� ���)
SELECT MAX(EXTRACT (YEAR FROM SYSDATE) - (1900+SUBSTR(EMP_NO,1,2))) "�ִ�",
        MIN(EXTRACT (YEAR FROM SYSDATE) - (1900+SUBSTR(EMP_NO,1,2))) "�ּ�"
FROM EMPLOYEE;


--11.  ȸ�翡�� �߱��� �ؾ� �Ǵ� �μ��� ��ǥ�Ͽ��� �Ѵ�.
-- �μ��ڵ尡 D5,D6,D9  �߱�, �׿ܴ� �߱پ��� ���� ��µǵ��� �Ͽ���. 
-- ��� ���� �̸�,�μ��ڵ�,�߱����� (�μ��ڵ� ���� �������� ������.)
--   (�μ��ڵ尡 null�� ����� �߱پ��� ��)
SELECT 
    EMP_NAME, 
    DEPT_CODE,
    CASE
    WHEN DEPT_CODE IN ('D5','D6','D9') THEN '�߱�'
    ELSE '�߱پ���'
    END AS "�߱�����"
FROM EMPLOYEE
ORDER BY 2 ASC;
        