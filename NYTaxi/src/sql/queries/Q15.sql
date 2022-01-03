SELECT COUNT(*) FROM ${parasetting} NYTaxi GROUP BY congestion_surcharge HAVING congestion_surcharge>0
;
