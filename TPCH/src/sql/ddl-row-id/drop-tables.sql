DROP TABLE ${schema}NATION
;

DROP TABLE ${schema}REGION
;

DROP TABLE ${schema}PART
;

DROP TABLE ${schema}SUPPLIER
;

DROP TABLE ${schema}PARTSUPP
;

DROP TABLE ${schema}CUSTOMER
;

DROP TABLE ${schema}ORDERS
;

DROP TABLE ${schema}LINEITEM
;


-- purge SQL Loader logs

DELETE FROM %SQL_Diag.Message WHERE diagResult->ProcessID NOT IN (select ID from %SYS.ProcessQuery)
;

DELETE FROM %SQL_Diag.Result WHERE ProcessID NOT IN (select ID from %SYS.ProcessQuery)
;