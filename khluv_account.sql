SHOW USER;

-- ��������
-- �ߺ� ����, ������ ���� -> Ư�� �÷��� �����ϴ� ����
-- ���������� ����
-- �������� ���Ἲ
-- ���������� ����
-- 1.NOT NULL : �����Ϳ� ���� ������� �ʴ� ���� ����
-- 2.UNIQUE : �ߺ����� ������� ����
-- 3.PRIMARY KEY : �����Ϳ� NULL�� ������� �ʱ�
-- --> �÷��� ���� �ĺ���
-- 4. FOREIGN KEY : ������ �ٸ� ���̺� �����ϴ� ���� ����� �� �ֵ��� �����ϰ�,
--                  �� ���̺� ���� ���踦 �����ϴ� ���� ����.
-- 5. CHECK
-- 6. DEFAULT 

DROP TABLE USER_OTHERCONSTRAINT;
CREATE TABLE USER_OTHERCONSTRAINT (
    USER_NO NUMBER,
    USER_ID VARCHAR2(20),
    USER_PWD VARCHAR2(30),
    USER_NAME VARCHAR2(20),
    GENDER CHAR(3) CHECK(GENDER IN('M','F')),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50),
    DELETE_YN VARCHAR2(6) DEFAULT 'N'
);
INSERT INTO USER_OTHERCONSTRAINT
VALUES(1, 'user01', 'pass01', 'ȫ�浿', 'M', '010-1234-5678', 'hong@iei.or.kr', DEFAULT);
SELECT * FROM USER_OTHERCONSTRAINT;

CREATE TABLE USER_NONE (
    USER_NO NUMBER,
    USER_ID VARCHAR2(20),
    USER_PWD VARCHAR2(30),
    USER_NAME VARCHAR2(20),
    GENDER CHAR(2),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50)
);
INSERT INTO USER_NONE
VALUES(1, 'user01', 'pass01', 'ȫ�浿', 'M', '010-1234-5678', 'hong@iei.or.kr');
SELECT * FROM USER_NONE;

CREATE TABLE USER_NOTNULL (
    USER_NO NUMBER NOT NULL, --> �÷� �����ٰ� �������� �ִ°� �÷������� ��ٰ� ��
    USER_ID VARCHAR2(20) UNIQUE,
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(2),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50)
);

INSERT INTO USER_NOTNULL
VALUES(1, NULL, 'pass01', 'ȫ�浿', 'M', '010-1234-5678', 'hong@iei.or.kr');

CREATE TABLE USER_PRIMARYKEY (
    USER_NO NUMBER UNIQUE, --> �÷� �����ٰ� �������� �ִ°� �÷������� ��ٰ� ��
    USER_ID VARCHAR2(20) PRIMARY KEY, --> �÷�����
    USER_PWD VARCHAR2(30) NOT NULL, --> NOT NULL�� �÷������� ����
    USER_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(2),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50),
);

CREATE TABLE USER_GRADE(
    GRADE_CODE NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR2(30) NOT NULL
);

INSERT INTO USER_GRADE
VALUES (10, '�Ϲ�ȸ��');
INSERT INTO USER_GRADE
VALUES (20, '���ȸ��');
INSERT INTO USER_GRADE
VALUES (30, 'Ư��ȸ��');
SELECT * FROM USER_GRADE;

CREATE TABLE USER_FOREIGNKEY (
    USER_NO NUMBER PRIMARY KEY,
    USER_ID VARCHAR2(20) UNIQUE,
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(20),
    GENDER VARCHAR2(2),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50),
    GRADE_CODE NUMBER REFERENCES USER_GRADE(GRADE_CODE) -- �÷�����
    -- GRADE_CODE NUMBER,
    -- FOREIGN KEY(GRADE_CODE) REFERENCES USER_GRADE(GRADE_CODE) -- ���̺���
    -- �÷������̶� ���̺��� ���� �ϳ��� ����
);

INSERT INTO USER_FOREIGNKEY
VALUES(1, 'user01', 'pass01', 'ȫ�浿', 'M', '010-1234-5678', 'hong@iei.or.kr', 10);
INSERT INTO USER_FOREIGNKEY
VALUES(2, 'user02', 'pass02', '���Ѽ�', 'M', '010-1234-5578', 'han@iei.or.kr', 20);
INSERT INTO USER_FOREIGNKEY
VALUES(3, 'user03', 'pass03', '��ڹ�', 'M', '010-1224-5678', 'parkpark@iei.or.kr', 30);
INSERT INTO USER_FOREIGNKEY
VALUES(4, 'user04', 'pass04', '�ڹٺ�', 'M', '010-1254-5678', 'boo@iei.or.kr', NULL);
INSERT INTO USER_FOREIGNKEY
VALUES(5, 'user05', 'pass05', '���Ҹ�', 'M', '010-1634-5678', '5sound@iei.or.kr', 50);

-- �������� FOREIGN KEY
DROP TABLE SHOP_MEMBER;
CREATE TABLE SHOP_MEMBER (
    USER_NO NUMBER,
    USER_ID VARCHAR2(20),
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(20),
    GENDER VARCHAR2(3),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50),
    UNIQUE(USER_NO),
    PRIMARY KEY(USER_ID)
);

INSERT INTO SHOP_MEMBER
VALUES(1, 'user01', 'pass01', '��ȫ��', '��', '010-2828-3333', 'hong123@kh.com');
INSERT INTO SHOP_MEMBER
VALUES(2, 'user02', 'pass02', '�ּ���', '��', '010-2825-3003', 'ggaebi123@kh.com');
INSERT INTO SHOP_MEMBER
VALUES(3, 'user03', 'pass03', '������', '��', '010-2558-3883', 'kim123@kh.com');
INSERT INTO SHOP_MEMBER
VALUES(4, 'user04', 'pass04', '��â��', '��', '010-2118-3773', 'park123@kh.com');
INSERT INTO SHOP_MEMBER
VALUES(5, 'user05', 'pass05', '�߹���', '��', '010-2348-3553', 'noh123@kh.com');
SELECT * FROM SHOP_MEMBER;

DROP TABLE SHOP_BUY;
CREATE TABLE SHOP_BUY (
    BUY_NO NUMBER PRIMARY KEY,
    USER_ID VARCHAR2(20) REFERENCES SHOP_MEMBER(USER_ID) ON DELETE CASCADE,
    PRODUCT_NAME VARCHAR2(50),                                     
    REG_DATE DATE DEFAULT SYSDATE
);

INSERT INTO SHOP_BUY
VALUES(1, 'user01', '�౸ȭ', DEFAULT);
INSERT INTO SHOP_BUY
VALUES(2, 'user02', '��ȭ', DEFAULT);
INSERT INTO SHOP_BUY
VALUES(3, 'user03', '���ȭ', DEFAULT);
INSERT INTO SHOP_BUY
VALUES(4, 'user04', '�ø�ȭ', DEFAULT);
INSERT INTO SHOP_BUY
VALUES(5, 'user05', '�豸ȭ', DEFAULT);
SELECT * FROM SHOP_BUY;

DELETE FROM SHOP_MEMBER WHERE USER_ID = 'user02'; --> ��������
SELECT * FROM SHOP_BUY;

--> ���� �ɼ� 
--> �⺻ �ɼ� ON DELETE RESTRICTED : ���� �Ұ�
--> NULL�� ����� : ON DELETE SET NULL
--> ������ ��� ���� ���� : ON DELETE CASCADE
