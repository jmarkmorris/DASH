CREATE OR REPLACE VIEW orders_per_cust0 (custkey, ordercount) as select c_custkey, count(o_orderkey) FROM ${parasetting} customer left outer join orders on c_custkey = o_custkey and o_comment not like '%%special%%requests%%' group by c_custkey
;

SELECT ordercount, count(*) as custdist FROM ${parasetting} orders_per_cust0 group by ordercount order by custdist desc, ordercount desc
;

DROP VIEW orders_per_cust0
;
