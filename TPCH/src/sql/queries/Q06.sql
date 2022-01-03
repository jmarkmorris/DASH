SELECT SUM(L_EXTENDEDPRICE*L_DISCOUNT) AS REVENUE FROM ${parasetting} LINEITEM WHERE L_SHIPDATE >= '1993-01-01' AND L_SHIPDATE < dateadd (yy, 1, cast('1993-01-01' as date)) AND L_DISCOUNT BETWEEN (0.09 - 0.01) AND (0.09 + 0.01) AND L_QUANTITY < 24
;
