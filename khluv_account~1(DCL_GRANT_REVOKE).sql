CREATE TABLE COFFEE (
    PRODUCT_NAME VARCHAR2(50) PRIMARY KEY,
    PRICE NUMBER NOT NULL,
    COMPARY VARCHAR2(50) NOT NULL
);

-- CHAR, VHRCHAR2의 차이점?
-- CHAR(10), VHACHAR2(10)
-- 각각 자바 입력
-- 각각의 크기는? CHAR(10) --> 그냥 10임[자바____]
--              VHRCHAR2(10) --> 가변형 문자, 자바에 맞게 줄어든다 [자바]

-- INSERT,
-- 1. 맥심커피, 30000, MAXIM
-- 2. 카누, 50000, KANU
-- 3. 네스카페, 40000, NESCAFE

SELECT * FROM COFFEE;
INSERT INTO COFFEE
VALUES('맥심커피', 30000, 'MAXIM');
INSERT INTO COFFEE
VALUES('카누', 50000, 'KANU');
INSERT INTO COFFEE
VALUES('네스카페', 40000, 'NESCAFE');
COMMIT; --> 이걸 안해주면 다른 계정에서 이 테이블의 값을 출력할 수 없음

SHOW USER;
SELECT * FROM COFFEE;