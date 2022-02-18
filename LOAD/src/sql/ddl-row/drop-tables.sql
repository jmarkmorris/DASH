DROP TABLE ${schema}DASHLOAD
;


-- purge SQL Loader logs

DELETE FROM %SQL_Diag.Message WHERE diagResult->ProcessID NOT IN (select ID from %SYS.ProcessQuery)
;

DELETE FROM %SQL_Diag.Result WHERE ProcessID NOT IN (select ID from %SYS.ProcessQuery)
;