DROP TABLE ${schema}C${org}
;

DROP TABLE ${schema}D${org}
;

-- purge SQL Loader logs

DELETE FROM %SQL_Diag.Message WHERE diagResult->ProcessID NOT IN (select ID from %SYS.ProcessQuery)
;


