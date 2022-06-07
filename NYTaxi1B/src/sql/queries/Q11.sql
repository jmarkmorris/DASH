SELECT * FROM (SELECT SUM(mta_tax) AS s FROM ${parasetting} NYTaxi) AS t
;
