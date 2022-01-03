-- changes from original dss.ddl script, delivered with the dbgen utility:
--    - addition of a ${schema} variable


-- Sccsid:     @(#)dss.ddl	2.1.8.1

CREATE TABLE ${schema}NATION  ( N_NATIONKEY  INTEGER NOT NULL ,
                            N_NAME       CHAR(25) NOT NULL WITH STORAGETYPE = COLUMNAR,
                            N_REGIONKEY  INTEGER NOT NULL WITH STORAGETYPE = COLUMNAR,
                            N_COMMENT    VARCHAR(152))
;

CREATE TABLE ${schema}REGION  ( R_REGIONKEY  INTEGER NOT NULL ,
                            R_NAME       CHAR(25) NOT NULL WITH STORAGETYPE = COLUMNAR,
                            R_COMMENT    VARCHAR(152))
;

CREATE TABLE ${schema}PART  ( P_PARTKEY     INTEGER NOT NULL ,
                          P_NAME        VARCHAR(55) NOT NULL WITH STORAGETYPE = COLUMNAR,
                          P_MFGR        CHAR(25) NOT NULL WITH STORAGETYPE = COLUMNAR,
                          P_BRAND       CHAR(10) NOT NULL WITH STORAGETYPE = COLUMNAR,
                          P_TYPE        VARCHAR(25) NOT NULL WITH STORAGETYPE = COLUMNAR,
                          P_SIZE        INTEGER NOT NULL WITH STORAGETYPE = COLUMNAR,
                          P_CONTAINER   CHAR(10) NOT NULL WITH STORAGETYPE = COLUMNAR,
                          P_RETAILPRICE DECIMAL(15,2) NOT NULL WITH STORAGETYPE = COLUMNAR,
                          P_COMMENT     VARCHAR(23) NOT NULL )
;

CREATE TABLE ${schema}SUPPLIER ( S_SUPPKEY     INTEGER NOT NULL ,
                             S_NAME        CHAR(25) NOT NULL WITH STORAGETYPE = COLUMNAR,
                             S_ADDRESS     VARCHAR(40) NOT NULL WITH STORAGETYPE = COLUMNAR,
                             S_NATIONKEY   INTEGER NOT NULL WITH STORAGETYPE = COLUMNAR,
                             S_PHONE       CHAR(15) NOT NULL WITH STORAGETYPE = COLUMNAR,
                             S_ACCTBAL     DECIMAL(15,2) NOT NULL WITH STORAGETYPE = COLUMNAR,
                             S_COMMENT     VARCHAR(101) NOT NULL)
;

CREATE TABLE ${schema}PARTSUPP ( PS_PARTKEY     INTEGER NOT NULL ,
                             PS_SUPPKEY     INTEGER NOT NULL WITH STORAGETYPE = COLUMNAR,
                             PS_AVAILQTY    INTEGER NOT NULL WITH STORAGETYPE = COLUMNAR,
                             PS_SUPPLYCOST  DECIMAL(15,2)  NOT NULL WITH STORAGETYPE = COLUMNAR,
                             PS_COMMENT     VARCHAR(199) NOT NULL )
;

CREATE TABLE ${schema}CUSTOMER ( C_CUSTKEY     INTEGER NOT NULL ,
                             C_NAME        VARCHAR(25) NOT NULL WITH STORAGETYPE = COLUMNAR,
                             C_ADDRESS     VARCHAR(40) NOT NULL WITH STORAGETYPE = COLUMNAR,
                             C_NATIONKEY   INTEGER NOT NULL WITH STORAGETYPE = COLUMNAR,
                             C_PHONE       CHAR(15) NOT NULL WITH STORAGETYPE = COLUMNAR,
                             C_ACCTBAL     DECIMAL(15,2)   NOT NULL WITH STORAGETYPE = COLUMNAR,
                             C_MKTSEGMENT  CHAR(10) NOT NULL WITH STORAGETYPE = COLUMNAR,
                             C_COMMENT     VARCHAR(117) NOT NULL)
;

CREATE TABLE ${schema}ORDERS  ( O_ORDERKEY       INTEGER NOT NULL ,
                           O_CUSTKEY        INTEGER NOT NULL WITH STORAGETYPE = COLUMNAR,
                           O_ORDERSTATUS    CHAR(1) NOT NULL WITH STORAGETYPE = COLUMNAR,
                           O_TOTALPRICE     DECIMAL(15,2) NOT NULL WITH STORAGETYPE = COLUMNAR,
                           O_ORDERDATE      DATE NOT NULL WITH STORAGETYPE = COLUMNAR,
                           O_ORDERPRIORITY  CHAR(15) NOT NULL WITH STORAGETYPE = COLUMNAR,  
                           O_CLERK          CHAR(15) NOT NULL WITH STORAGETYPE = COLUMNAR, 
                           O_SHIPPRIORITY   INTEGER NOT NULL WITH STORAGETYPE = COLUMNAR,
                           O_COMMENT        VARCHAR(79) NOT NULL)
;

CREATE TABLE ${schema}LINEITEM ( L_ORDERKEY    INTEGER NOT NULL ,
                             L_PARTKEY     INTEGER NOT NULL WITH STORAGETYPE = COLUMNAR,
                             L_SUPPKEY     INTEGER NOT NULL WITH STORAGETYPE = COLUMNAR,
                             L_LINENUMBER  INTEGER NOT NULL WITH STORAGETYPE = COLUMNAR,
                             L_QUANTITY    DECIMAL(15,2) NOT NULL WITH STORAGETYPE = COLUMNAR,
                             L_EXTENDEDPRICE  DECIMAL(15,2) NOT NULL WITH STORAGETYPE = COLUMNAR,
                             L_DISCOUNT    DECIMAL(15,2) NOT NULL WITH STORAGETYPE = COLUMNAR,
                             L_TAX         DECIMAL(15,2) NOT NULL WITH STORAGETYPE = COLUMNAR,
                             L_RETURNFLAG  CHAR(1) NOT NULL WITH STORAGETYPE = COLUMNAR,
                             L_LINESTATUS  CHAR(1) NOT NULL WITH STORAGETYPE = COLUMNAR,
                             L_SHIPDATE    DATE NOT NULL WITH STORAGETYPE = COLUMNAR,
                             L_COMMITDATE  DATE NOT NULL WITH STORAGETYPE = COLUMNAR,
                             L_RECEIPTDATE DATE NOT NULL WITH STORAGETYPE = COLUMNAR,
                             L_SHIPINSTRUCT CHAR(25) NOT NULL WITH STORAGETYPE = COLUMNAR,
                             L_SHIPMODE     CHAR(10) NOT NULL WITH STORAGETYPE = COLUMNAR,
                             L_COMMENT      VARCHAR(44) NOT NULL)
;

