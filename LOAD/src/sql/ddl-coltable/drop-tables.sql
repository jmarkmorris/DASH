DROP TABLE ${schema}DASHLOAD${org}
;

DELETE FROM %SQL_Diag.Message WHERE diagResult->ProcessID NOT IN (select ID from %SYS.ProcessQuery)
;

