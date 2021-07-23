SHOW USER;

CREATE USER KHTEST01 IDENTIFIED BY KHTEST01;

-- 권한 주기
GRANT CONNECT TO KHTEST01;
GRANT SELECT ON KHLUV.COFFEE TO KHTEST01; --> COFFEE를 KHTEST01에서 열게 해줌
GRANT INSERT ON KHLUV.COFFEE TO KHTEST01; --> COFFEE를 KHTEST01에서 내용 추가하게 해줌

-- 권한 뺏기
REVOKE SELECT ON KHLUV.COFFEE FROM KHTEST01; --> 못열어
REVOKE INSERT ON KHLUV.COFFEE FROM KHTEST01; --> 입력 불가