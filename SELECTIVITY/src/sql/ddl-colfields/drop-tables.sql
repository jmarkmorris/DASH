DROP TABLE ${schema}C
;

DROP TABLE ${schema}D
;

-- purge SQL Loader logs

DELETE FROM %SQL_Diag.Message
;

DELETE FROM %SQL_Diag.Result
;
