TRUNCATE TABLE CUSTOMER${org}
;

INSERT INTO CUSTOMER${org} SELECT * FROM ${parasetting} CUSTOMER
;