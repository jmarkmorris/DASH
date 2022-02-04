DROP TABLE ${schema}DASHLOAD
;


-- purge SQL Loader logs

DELETE FROM %SQL_Diag.Message
;

DELETE FROM %SQL_Diag.Result
;
