-- GROUP BY & HAVING 
-- GROUP BY
SELECT SUM(SALARY) 
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- EMPLOYEE ���̺��� �μ��ڵ�, �׷캰 �޿��� �հ�, �׷캰 �޿��� ���(����ó��),
-- �ο����� ��ȸ�ϰ� �μ��ڵ� ������ ����.

SELECT 
    DEPT_CODE "�μ��ڵ�",
    COUNT(*),
    SUM (SALARY) "�޿��հ�",
    FLOOR(AVG (SALARY)) "�޿� ���"
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING COUNT(*) > 3 
ORDER BY 1 ASC;
 
 -- EMPLOYEE ���̺��� EMP_NO�� 8��° �ڸ��� 1�̸� '��', 2�̸� '��'�� ����� ��ȸ�ϰ�
-- ������ �޿��� ���(����ó��), �޿��� �հ�, �ο����� ��ȸ�� �� �ο����� �������� �����Ͻÿ�.

SELECT 
    DECODE(SUBSTR(EMP_NO,8,1), '1', '��', '2', '��') "����",
    SUM(SALARY),
    FLOOR(AVG(SALARY)),
    COUNT(*)
FROM EMPLOYEE
GROUP BY DECODE(SUBSTR(EMP_NO,8,1), '1', '��', '2', '��')
ORDER BY 1;

-- <�ǽ� ����>
-- @ �ǽ� ���� 1 --> J1���� ������
--EMPLOYEE ���̺��� ������ J1�� �����ϰ�, ����,���޺� ����� �� ��ձ޿��� ����ϼ���.
SELECT
    JOB_CODE "����",
    COUNT(*) "�ο� ��",
    FLOOR(AVG(SALARY)) "�������"
FROM EMPLOYEE
WHERE JOB_CODE != 'J1'
GROUP BY JOB_CODE;


-- @ �ǽ� ���� 2
-- EMPLOYEE���̺��� ������ J1�� �����ϰ�,  
-- �Ի�⵵�� �ο����� ��ȸ�ؼ�, �Ի�� �������� �������� �����ϼ���.
SELECT
    EXTRACT(YEAR FROM HIRE_DATE) "�Ի�⵵",
    COUNT(*) "�ο� ��"
FROM EMPLOYEE
WHERE JOB_CODE NOT LIKE 'J1'
GROUP BY EXTRACT(YEAR FROM HIRE_DATE);
    

--@ �ǽ� ���� 3
--�μ��� ���� �ο����� ���ϼ���.
-- ������ ���� ��� �ǵ��� ����ÿ�
--ex)
--D1	��	2
--D1	��	1

SELECT
    DEPT_CODE "�μ��ڵ�", 
    DECODE(SUBSTR(EMP_NO,8,1), '1', '��','2','��') "����",
    COUNT(*) "�ο� ��"
FROM EMPLOYEE
GROUP BY DEPT_CODE, DECODE(SUBSTR(EMP_NO,8,1), '1', '��','2','��')
ORDER BY 1;