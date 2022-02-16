TRUNCATE TABLE C${org}
;

INSERT INTO C${org} SELECT * FROM ${parasetting} C
;