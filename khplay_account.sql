CREATE TABLE MEMBER (
    MEMBER_JM VARCHAR2(30) PRIMARY KEY,
    MEMBER_CODE NUMBER NOT NULL,
    MEMBER_NAME VARCHAR2(30) NOT NULL,
    MEMBER_GENDER VARCHAR2(6) CHECK(MEMBER_GENDER IN('F','M')),
    MEMBER_AGE NUMBER NOT NULL,
    MEMBER_HOBBY 
    ENROLL_DATE DATE DEFAULT SYSDATE
);

COMMENT ON COLUMN MEMBER.MEMBER_JM IS '선수 종목';
COMMENT ON COLUMN MEMBER.MEMBER_CODE IS '선수 코드';
COMMENT ON COLUMN MEMBER.MEMBER_NAME IS '선수 이름';
COMMENT ON COLUMN MEMBER.MEMBER_GENDER IS '선수 성별';
COMMENT ON COLUMN MEMBER.MEMBER_AGE IS '선수 나이';
COMMENT ON COLUMN MEMBER.ENROLL_DATE IS '입력 시기';
COMMENT ON TABLE MEMBER IS '선수 테이블';

SELECT *
FROM ALL_TAB_COMMENTS
WHERE TABLE_NAME = 'MEMBER';
    
INSERT INTO MEMBER
VALUES('vollyball', '1234', '김연경', 'F', 34 ,SYSDATE);
        
COMMIT;
SELECT * FROM MEMBER;

DROP TABLE MEMBER;

UPDATE MEMBER 
SET MEMBER_NAME = '김지수'
WHERE MEMBER_JM = '사브르';
