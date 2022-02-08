
-- this script will replace the foreign key fields referring to another table's 
-- dbgen-generated key with the corresponding IRIS-assigned IDKey

-- creating a quick index for the bigger _DBGEN fields is worthwhile
CREATE INDEX P_PARTKEY_DBGEN ON ${schema}PART${org}(P_PARTKEY_DBGEN)
;
CREATE INDEX S_SUPKEY_DBGEN ON ${schema}SUPPLIER${org}(S_SUPPKEY_DBGEN)
;
CREATE INDEX O_ORDERKEY_DBGEN ON ${schema}ORDERS${org}(O_ORDERKEY_DBGEN)
;
CREATE INDEX C_CUSTKEY_DBGEN ON ${schema}CUSTOMER${org}(C_CUSTKEY_DBGEN)
;


-- now update the tables
UPDATE ${schema}NATION${org}
    SET N_REGIONKEY = (SELECT R_REGIONKEY 
                        FROM ${schema}REGION${org}
                        WHERE R_REGIONKEY_DBGEN = N_REGIONKEY)
;

UPDATE %NOLOCK /*#OPTIONS {"DML_PARALLEL":1} */ ${schema}SUPPLIER${org}
    SET S_NATIONKEY = (SELECT N_NATIONKEY 
                        FROM ${schema}NATION${org}
                        WHERE N_NATIONKEY_DBGEN = S_NATIONKEY)
;

UPDATE %NOLOCK /*#OPTIONS {"DML_PARALLEL":1} */ ${schema}PARTSUPP${org}
    SET PS_PARTKEY = (SELECT P_PARTKEY 
                        FROM ${schema}PART${org}
                        WHERE P_PARTKEY_DBGEN = PS_PARTKEY),
        PS_SUPPKEY = (SELECT S_SUPPKEY 
                        FROM ${schema}SUPPLIER${org}
                        WHERE S_SUPPKEY_DBGEN = PS_SUPPKEY)
;

UPDATE %NOLOCK /*#OPTIONS {"DML_PARALLEL":1} */ ${schema}CUSTOMER${org}
    SET C_NATIONKEY = (SELECT N_NATIONKEY 
                        FROM ${schema}NATION${org}
                        WHERE N_NATIONKEY_DBGEN = C_NATIONKEY)
;

UPDATE %NOLOCK /*#OPTIONS {"DML_PARALLEL":1} */ ${schema}ORDERS${org}
    SET O_CUSTKEY = (SELECT C_CUSTKEY 
                        FROM ${schema}CUSTOMER${org}
                        WHERE C_CUSTKEY_DBGEN = O_CUSTKEY)
;

UPDATE %NOLOCK /*#OPTIONS {"DML_PARALLEL":1} */ ${schema}LINEITEM${org}
    SET L_PARTKEY = (SELECT P_PARTKEY 
                        FROM ${schema}PART${org}
                        WHERE P_PARTKEY_DBGEN = L_PARTKEY),
        L_ORDERKEY = (SELECT O_ORDERKEY 
                        FROM ${schema}ORDERS${org}
                        WHERE O_ORDERKEY_DBGEN = L_ORDERKEY),
        L_SUPPKEY = (SELECT S_SUPPKEY 
                        FROM ${schema}SUPPLIER${org}
                        WHERE S_SUPPKEY_DBGEN = L_SUPPKEY)
;

-- we no longer need the _DBGEN fields
DROP INDEX P_PARTKEY_DBGEN
;
DROP INDEX S_SUPKEY_DBGEN
;
DROP INDEX O_ORDERKEY_DBGEN
;
DROP INDEX C_CUSTKEY_DBGEN
;

ALTER TABLE ${schema}REGION${org} DROP COLUMN R_REGIONKEY_DBGEN
;
ALTER TABLE ${schema}NATION${org} DROP COLUMN N_NATIONKEY_DBGEN
;
ALTER TABLE ${schema}PART${org} DROP COLUMN P_PARTKEY_DBGEN
;
ALTER TABLE ${schema}SUPPLIER${org} DROP COLUMN S_SUPPKEY_DBGEN
;
ALTER TABLE ${schema}CUSTOMER${org} DROP COLUMN C_CUSTKEY_DBGEN
;
ALTER TABLE ${schema}ORDERS${org} DROP COLUMN O_ORDERKEY_DBGEN
;
