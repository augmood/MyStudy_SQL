SHOW USER;

CREATE USER KHTEST01 IDENTIFIED BY KHTEST01;

-- ���� �ֱ�
GRANT CONNECT TO KHTEST01;
GRANT SELECT ON KHLUV.COFFEE TO KHTEST01; --> COFFEE�� KHTEST01���� ���� ����
GRANT INSERT ON KHLUV.COFFEE TO KHTEST01; --> COFFEE�� KHTEST01���� ���� �߰��ϰ� ����

-- ���� ����
REVOKE SELECT ON KHLUV.COFFEE FROM KHTEST01; --> ������
REVOKE INSERT ON KHLUV.COFFEE FROM KHTEST01; --> �Է� �Ұ�