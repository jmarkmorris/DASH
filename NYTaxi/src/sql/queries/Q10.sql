SELECT MAX(total_amount)+MIN(total_amount)-SUM(mta_tax) FROM ${parasetting} NYTaxi
;
