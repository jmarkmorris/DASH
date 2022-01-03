SELECT n_name, SUM(o_totalprice), MAX(o_orderdate) FROM ${parasetting} Orders JOIN Customer ON o_custkey = c_custkey JOIN Nation ON c_nationkey = n_nationkey WHERE o_orderstatus = 'O' GROUP BY n_nationkey ORDER BY 2 DESC
;
