CREATE TABLE COFFEE (
    PRODUCT_NAME VARCHAR2(50) PRIMARY KEY,
    PRICE NUMBER NOT NULL,
    COMPARY VARCHAR2(50) NOT NULL
);

-- CHAR, VHRCHAR2�� ������?
-- CHAR(10), VHACHAR2(10)
-- ���� �ڹ� �Է�
-- ������ ũ���? CHAR(10) --> �׳� 10��[�ڹ�____]
--              VHRCHAR2(10) --> ������ ����, �ڹٿ� �°� �پ��� [�ڹ�]

-- INSERT,
-- 1. �ƽ�Ŀ��, 30000, MAXIM
-- 2. ī��, 50000, KANU
-- 3. �׽�ī��, 40000, NESCAFE

SELECT * FROM COFFEE;
INSERT INTO COFFEE
VALUES('�ƽ�Ŀ��', 30000, 'MAXIM');
INSERT INTO COFFEE
VALUES('ī��', 50000, 'KANU');
INSERT INTO COFFEE
VALUES('�׽�ī��', 40000, 'NESCAFE');
COMMIT; --> �̰� �����ָ� �ٸ� �������� �� ���̺��� ���� ����� �� ����

SHOW USER;
SELECT * FROM COFFEE;