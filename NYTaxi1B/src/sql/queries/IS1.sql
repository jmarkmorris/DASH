TRUNCATE TABLE NYTaxi${org}
;

INSERT INTO NYTaxi${org} SELECT * FROM ${parasetting} NYTaxi
;