SELECT STDDEV(mta_tax), STDDEV_SAMP(total_amount), STDDEV_POP(total_amount) FROM ${parasetting} NYTaxi
;
