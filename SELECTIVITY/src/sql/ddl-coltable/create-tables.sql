CREATE TABLE ${schema}C${org} (
    Sel1 INTEGER, 
    Sel5 INTEGER, 
    Sel10 INTEGER, 
    Sel20 INTEGER, 
    Sel50 INTEGER, 
    RowNUM INTEGER ${shardkey}
    ) WITH STORAGETYPE = COLUMNAR
;

CREATE TABLE ${schema}D${org} (
    Sel1 INTEGER, 
    Sel5 INTEGER, 
    Sel10 INTEGER, 
    Sel20 INTEGER, 
    Sel50 INTEGER, 
    RowNUM INTEGER ${shardkey}
    ) WITH STORAGETYPE = COLUMNAR
;
