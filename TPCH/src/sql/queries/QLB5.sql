SELECT O_ORDERPRIORITY, SUM(O_TOTALPRICE) FROM ${parasetting} ORDERS GROUP BY O_ORDERPRIORITY
;
