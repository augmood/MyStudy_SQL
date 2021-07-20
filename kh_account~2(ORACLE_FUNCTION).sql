-- ����Ŭ �Լ�
-- ���� ó�� �Լ�, ���� ó�� �Լ�, ��¥ ó�� �Լ�, ���� �Լ�
-- 1.���� ó�� �Լ�
-- ������ ���� LENGTH / ������ ũ�� LENTHB
SELECT LENGTH(EMP_NAME), LENGTHB(EMP_NAME)
FROM EMPLOYEE; 

SELECT EMAIL ,LENGTH(EMAIL) ,LENGTHB(EMAIL)
FROM EMPLOYEE;

--INSTR, INSTRB => Ư�� ������ ��ġ�� ��ȯ
--> (���ڿ�, ����, ��ġ����, ���°��)
--> -1 �����ʺ��� ����, ���ʺ��� ī��Ʈ
SELECT INSTR('YELENA BELOVA', 'E', 1, 3) 
        --> 9
    , INSTR('YELENA BELOVA', 'E', -1, 2) 
        --> 4
FROM DUAL; 

-- <���ܽǽ�>
-- EMPLOYEE ���̺��� EMAIL�� �÷��� ���ڿ� �� "@"�� ��ġ�� ���Ͻÿ�.
SELECT EMAIL, INSTR(EMAIL, '@', 1, 1), INSTRB (EMAIL, '@', 1, 1)
FROM EMPLOYEE;

-- LPAD, RPAD ����ó���Լ�
-- �־��� �÷�, ���ڿ��� ������ ���ڿ��� ���ٿ� ���� N�� ���ڿ��� ��ȯ�ϴ� �Լ�
SELECT LPAD(EMAIL, 20, '#') --> ���ڿ��� 20����, �� ������ #���� 
FROM EMPLOYEE;

SELECT RPAD(EMAIL, 20, '#') 
FROM EMPLOYEE;

SELECT LPAD(EMAIL, 20) 
FROM EMPLOYEE;

-- LTRIM, RTRIM ����ó���Լ�
-- �־��� �÷�, ���ڿ��� ������ ���ڿ��� ���Ե� ���ڸ� �����ϰ� �������� ��ȯ��.
-- ������ ���ִ� ��� �����
SELECT LTRIM('    KH') FROM DUAL;
SELECT RTRIM('KH    ') FROM DUAL;
SELECT LTRIM('000123', '0') FROM DUAL;

SELECT LTRIM('123123KH123', '123') FROM DUAL;
SELECT LTRIM('231312KH123', '123') FROM DUAL;
---> KH ������ ��� 1,2,3�� �����
SELECT RTRIM('123123KH1321', '123') FROM DUAL;
--> KH �������� ��� 1,2,3�� �����

-- TRIM ����ó�� �Լ�
-- �־��� �÷�, ���ڿ��� ��� ���⿡ �ִ� ������ ���ڸ� ������ �������� ����
SELECT TRIM ('Z' FROM 'ZZKHZZZ') FROM DUAL;
SELECT TRIM (LEADING 'Z' FROM 'ZZZ123456ZZZ') FROM DUAL;
--> ���ʸ� ����
SELECT TRIM (TRAILING 'Z' FROM 'ZZZ123456ZZZ') FROM DUAL;
--> �����ʸ� ����
SELECT TRIM (BOTH 'Z' FROM 'ZZZ123456ZZZ') FROM DUAL;
--> ��� ����

-- <���� �ǽ� ����>
-- �ǽ� ���� 1
-- Hello KH Java ���ڿ��� Hello KH �� ��µǰ� �Ͽ���.
SELECT RTRIM ('Hello KH Java','Java') FROM DUAL;

-- �ǽ� ���� 2
-- Hello KH Java ���ڿ��� KH Java �� ��µǰ� �Ͽ���.
SELECT LTRIM ('Hello KH Java','Hello') FROM DUAL;

-- �ǽ� ���� 3 (TRIM���� �غ�����)
-- DEPARTMENT ���̺��� DEPT_TITLE�� ����Ͽ���
-- �̶�, ������ �� ���ڸ� ���� ��µǵ��� �Ͽ��� / ex)ȸ������� -> ȸ�����
SELECT DEPT_TITLE FROM DEPARTMENT;
SELECT TRIM (TRAILING '��' FROM DEPT_TITLE) 
FROM DEPARTMENT;

-- �ǽ� ���� 4 - ���� ������
-- �������ڿ����� �յ� ��� ���ڸ� �����ϼ���.
-- '982341678934509hello89798739273402'
SELECT LTRIM (RTRIM ('982341678934509hello89798739273402','1234567890'), '1234567890') FROM DUAL;

-- SUBSTR ���� ó�� �Լ�
-- �־��� �÷��̳� ���ڿ����� ������ ��ġ���� ������ ������ ���ڿ��� �߶󳻾� �����ϴ� �Լ�
SELECT 'BLACKWIDOW' FROM DUAL;
SELECT SUBSTR('BLACKWIDOW', 5, 2) FROM DUAL;
SELECT SUBSTR('BLACKWIDOW', 6) FROM DUAL;
SELECT SUBSTR('BLACKWIDOW', -5, 5) FROM DUAL; 
--> WIDOW , �����ʿ��� 5��°���� ���� 5�� ���

-- <����� �Ѵ�>
--@ �ǽ�����1
---- ������� ���� �ߺ����� ���������� ����ϼ���.
SELECT DISTINCT SUBSTR(EMP_NAME, 1, 1) 
FROM EMPLOYEE
ORDER BY 1;

-- @ �ǽ�����2
-- employee ���̺��� ���ڸ� �����ȣ, �����, �ֹι�ȣ, ������ ��Ÿ������.
-- �ֹι�ȣ�� ��6�ڸ��� *ó���ϼ���.
SELECT EMP_ID, EMP_NAME, RPAD(SUBSTR(EMP_NO,1,8),14,'*'), SALARY*12
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) = 1;

-- LOWER / UPPER / INITCAP
-- �÷��� ���� Ȥ�� ���ڿ��� �ҹ��� / �빮�� / ù���ڸ� �빮�ڷ� ��ȯ�Ͽ� �����ϴ� �Լ�
SELECT LOWER('Natasha Romanoff') FROM DUAL; -- natacha romanoff
SELECT UPPER('Natasha Romanoff') FROM DUAL; -- NATASHA ROMANOFF
SELECT INITCAP('Natasha Romanoff') FROM DUAL; -- Natasha Romanoff

-- CONCAT ���� ó�� �Լ�
-- �÷��� ����/���ڿ� �ΰ��� ���޹޾� �ϳ��� ��ģ �� �����ϴ� �Լ�
SELECT CONCAT('�����ٶ�', 'ABCD') FROM DUAL; --�����ٶ�ABCD
SELECT '�����ٶ�'||'ABCD' FROM DUAL; --�����ٶ�ABCD

-- REPLACE ���� ó�� �Լ�
SELECT 'ALEXEI GOOD FATHER' FROM DUAL;
SELECT REPLACE('ALEXEI GOOD FATHER' , 'GOOD', 'BAD') FROM DUAL; -- ALEXEI BAD FATHER 

-- <�ǽ�����>
-- EMPLOYEE ���̺��� ��� ������ �̸�,�ֹι�ȣ,Email�� ����Ͻÿ�
-- ��, ��½� Email�� kh.or.kr���� iei.or.kr �� �����Ͽ� ��µǰ� �Ͻÿ�
SELECT EMP_NAME, EMP_NO, REPLACE(EMAIL, 'kh.or.kr', 'iei.or.kr') 
FROM EMPLOYEE;


-- 2. ���� ó�� �Լ�
-- ABS, MOD, ROUND, FLOOR, TRUNC, CEIL

-- ABS : ���� ���� ���ϴ� �Լ�
SELECT 10 FROM DUAL;
SELECT ABS(-10) FROM DUAL; --> 10

-- MOD : �������� ���ϴ� �Լ�
SELECT MOD(10,3) FROM DUAL; --> 1
SELECT MOD(10,2) FROM DUAL; --> 2

-- ROUND : �ݿø��Ͽ� ���� �����ϴ� �Լ�
-- ROUND(���,�ݿø��ϴ� ��ġ)
SELECT ROUND(123.456,3) FROM DUAL; --> 123.456
SELECT ROUND(123.456,2) FROM DUAL; --> 123.46
SELECT ROUND(123.456,1) FROM DUAL; --> 123.5
SELECT ROUND(123.456,0) FROM DUAL; --> 123
SELECT ROUND(123.456,-1) FROM DUAL; --> 120
SELECT ROUND(123.456,-2) FROM DUAL; --> 100

-- FLOOR : �Ҽ��� �ڸ��� ������ �Լ� (���� ���� ����)
SELECT FLOOR(SYSDATE-HIRE_DATE) FROM EMPLOYEE;

--TRUNC : ������ ��ġ ���� �Ҽ��� �ڸ��� ������ �Լ�
SELECT TRUNC (123.456, 1) FROM DUAL; --> 123.4
SELECT TRUNC (123.456, 2) FROM DUAL; --> 123.45
SELECT TRUNC (123.456, 0) FROM DUAL; --> 123
SELECT TRUNC (123.456, -1) FROM DUAL; --> 120

-- CEIL : �ø��ϴ� �Լ�
SELECT CEIL (123.456) FROM DUAL; --> 124

-- ����Ŭ �Լ�
-- ���� ó�� �Լ�, ���� ó�� �Լ�, ��¥ ó�� �Լ�, ����ȯ �Լ�, NULL ó���Լ�, �����Լ�
-- NULL ó�� �Լ�
-- EMPLOYEE ���̺��� ���ʽ��� NULL�� ����� �̸�, ��ȭ��ȣ, �޿�, ���ʽ��� ����ϼ���

SELECT EMP_NAME, PHONE, SALARY, NVL(BONUS, 0),SALARY + SALARY * NVL(BONUS, 0)
FROM EMPLOYEE;

-- ��¥ ó�� �Լ�
-- SYSDATE, MONTHS_BETWEEN, ADD_MONTHS, NEXT_DAY, EXTRACT
-- SYSDATE : ���� ��¥ ��ȯ �Լ�
SELECT SYSDATE FROM DUAL;

-- MONTHS_BETWEEN : �� ��¥�� ���޹޾�, ���� ���� ���̸� ���ڷ� �����ϴ� �Լ�
SELECT MONTHS_BETWEEN ('19/07/20', '18/07/20') FROM DUAL;

-- EMLPOYEE ���̺��� ���ñ����� �ټӰ������� ���϶�
SELECT MONTHS_BETWEEN (SYSDATE, HIRE_DATE) FROM EMPLOYEE;

-- ADD_MONTHS : ���ڷ� ���޹��� ��¥�� ���ڷ� ���޹��� ���ڸ�ŭ ���� ���� ���Ͽ�
-- Ư�� ��¥�� �����ϴ� �Լ�
SELECT ADD_MONTHS(SYSDATE, 4) FROM DUAL;
SELECT ADD_MONTHS('21/06/18', 5) FROM DUAL;

-- EMPLOYEE ���̺��� �Ի����� 3����° �Ǵ� ���� ���������� ���
SELECT EMP_NAME, ADD_MONTHS(HIRE_DATE, 3) FROM EMPLOYEE;

-- <�ǽ�����>
-- ���� �Դ��ϴ� ����� �ֽ��ϴ�.
-- ������ �Ⱓ�� 1�� 6�����̶�� �մϴ�.
-- ù��°, �� ����� �������� ���� �Դϱ�?
-- �ι�°, �� ����� �������� �Ծ�� �ϴ� �Ļ��� ���� ��ȸ�Դϱ�? -> Ʋ��
-- (�� , 1���� �� 3���� �Ļ� �ð��� �ִٰ� �����մϴ�.)

SELECT SYSDATE AS "�Դ���",
        ADD_MONTHS(SYSDATE, 18) AS "������" FROM DUAL; --> 23�� 1�� 20��
SELECT (ADD_MONTHS(SYSDATE, 18)-SYSDATE)*3 AS "�Ļ��� ��" FROM DUAL; --> 1647��

-- NEXT_DAY : ���޹��� ��¥�� ���޹��� ���� �� ���� ����� ���� ������ ��¥�� �����ϴ� �Լ�
-- ���ϰ� ���õ� �Լ�

SELECT SYSDATE, NEXT_DAY(SYSDATE, 'ȭ����') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, 2) FROM DUAL; --> 2�� ������
SELECT SYSDATE, NEXT_DAY(SYSDATE, 1) FROM DUAL; --> 1�� �Ͽ���
SELECT SYSDATE, NEXT_DAY(SYSDATE, '��') FROM DUAL; --> ������

-- **LAST_DAY : ���޹��� ��¥�� ���� ���� ������ ��¥�� ���Ͽ� �����ϴ� �Լ�
SELECT SYSDATE, LAST_DAY(SYSDATE) FROM DUAL;
SELECT SYSDATE, LAST_DAY('19/02/01') FROM DUAL; --> 19�� 2��

-- EMPLOYEE ���̺��� ����� �Ի��, �Ի���� ������ ��¥�� ���Ͻÿ�
SELECT HIRE_DATE, LAST_DAY(HIRE_DATE) FROM EMPLOYEE;

-- �������� ������ �� ���ϱ�
SELECT LAST_DAY(ADD_MONTHS(SYSDATE,1)) FROM DUAL;

-- 1�� 31���� �������� �������� ������ �� ���ϱ�� � ��¥�� ���� ���ΰ�?
-- 1�� 31�� -> 2�� 28�� -> 3�� 31��
SELECT LAST_DAY(ADD_MONTHS('21/01/31', 1)) FROM DUAL;


--<���� �ǽ� ����>

-- ����1. 
-- �Ի����� 5�� �̻�, 10�� ������ ������ �̸�,�ֹι�ȣ,�޿�,�Ի����� �˻��Ͽ���

SELECT EMP_NAME AS "�̸�", EMP_NO AS "�ֹι�ȣ", 
        SALARY AS "�޿� ", HIRE_DATE AS "�Ի���" 
FROM EMPLOYEE
WHERE (SYSDATE-HIRE_DATE) /365 BETWEEN 5 AND 10;

-- ����2.
-- �������� �ƴ� ������ �̸�,�μ��ڵ�, �����, �ٹ��Ⱓ, �������� �˻��Ͽ��� (��� ���� : ENT_YN)
SELECT EMP_NAME, DEPT_CODE, HIRE_DATE, ENT_DATE-HIRE_DATE || '��', ENT_DATE
FROM EMPLOYEE
WHERE ENT_YN = 'Y';

-- ����3.
-- �ټӳ���� 10�� �̻��� �������� �˻��Ͽ�
-- ��� ����� �̸�,�޿�,�ټӳ��(�Ҽ���X)�� �ټӳ���� ������������ �����Ͽ� ����Ͽ���
-- ��, �޿��� 50% �λ�� �޿��� ��µǵ��� �Ͽ���.

SELECT EMP_NAME AS "�̸� ", SALARY+(SALARY*0.5) AS "�޿�", FLOOR((SYSDATE-HIRE_DATE)/365) AS "�ټӳ��"
FROM EMPLOYEE
WHERE (SYSDATE-HIRE_DATE) / 365 >= 10
ORDER BY 3 ASC; --> 3 = FLOOR(SYSDATE-HIRE_DATE) 

 
-- ����4.
-- �Ի����� 99/01/01 ~ 10/01/01 �� ��� �߿��� �޿��� 2000000 �� ������ �����
-- �̸�,�ֹι�ȣ,�̸���,����ȣ,�޿��� �˻� �Ͻÿ�
SELECT EMP_NAME AS "�̸�", EMP_NO AS "�ֹι�ȣ", EMAIL AS "�̸���",
        PHONE AS "����ȣ", SALARY AS "�޿�"
FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN '99/01/01' AND '10/01/01' AND SALARY <= 2000000;


-- ����5.
-- �޿��� 2000000�� ~ 3000000�� �� ������ �߿��� 4�� �����ڸ� �˻��Ͽ� 
-- �̸�,�ֹι�ȣ,�޿�,�μ��ڵ带 �ֹι�ȣ ������(��������) ����Ͽ���
-- ��, �μ��ڵ尡 null�� ����� �μ��ڵ尡 '����' ���� ��� �Ͽ���. --> NULLǥ�� ����

SELECT EMP_NAME AS "�̸�" , EMP_NO AS "�ֹι�ȣ", SALARY AS "�޿�" ,
        NVL(DEPT_CODE,'����') AS "�μ��ڵ�"
FROM EMPLOYEE
WHERE SALARY BETWEEN '2000000' AND '3000000' 
        AND EMP_NO LIKE '___4__-2%'
        -- AND SUBSTR(EMP_NO,8,1) = 2 AND SUBSTR(EMP_NO,4,1) = 4
ORDER BY 1 ASC;

-- ����6.
-- ���� ��� �� ���ʽ��� ���� ����� ���ñ��� �ٹ����� �����Ͽ� 
-- 1000�� ����(�Ҽ��� ����) --> ??
-- �޿��� 10% ���ʽ��� ����Ͽ� �̸�,Ư�� ���ʽ� (��� �ݾ�) ����� ����Ͽ���.
-- ��, �̸� ������ ���� ���� �����Ͽ� ����Ͽ���.

SELECT EMP_NAME AS "�̸�" 
        ,(FLOOR(SYSDATE-HIRE_DATE)/1000)*(SALARY*0.1) AS "Ư�� ���ʽ�"
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) = 1 AND BONUS IS NULL
ORDER BY 1 ASC;

