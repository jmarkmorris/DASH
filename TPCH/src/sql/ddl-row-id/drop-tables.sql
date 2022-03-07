DROP TABLE ${schema}NATION${org}
;

DROP TABLE ${schema}REGION${org}
;

DROP TABLE ${schema}PART${org}
;

DROP TABLE ${schema}SUPPLIER${org}
;

DROP TABLE ${schema}PARTSUPP${org}
;

DROP TABLE ${schema}CUSTOMER${org}
;

DROP TABLE ${schema}ORDERS${org}
;

DROP TABLE ${schema}LINEITEM${org}
;


-- purge SQL Loader logs

DELETE FROM %SQL_Diag.Message WHERE diagResult->ProcessID NOT IN (select ID from %SYS.ProcessQuery)
;


