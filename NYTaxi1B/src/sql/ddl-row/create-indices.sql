CREATE BITMAP INDEX VendorIDIndex ON ${schema}NYTaxi${org} (VendorID)
;
CREATE BITMAP INDEX PassengerCountIndex ON ${schema}NYTaxi${org} (passenger_count)
;
CREATE BITMAP INDEX RatecodeIndex ON ${schema}NYTaxi${org} (RatecodeID)
;
CREATE BITMAP INDEX StorAndFwdFlagIndex ON ${schema}NYTaxi${org} (store_and_fwd_flag)
;
CREATE BITMAP INDEX PULocationIDIndex ON ${schema}NYTaxi${org} (PULocationID)
;
CREATE BITMAP INDEX DOLocationIDIndex ON ${schema}NYTaxi${org} (DOLocationID)
;
CREATE BITMAP INDEX PaymentTypeIndex ON ${schema}NYTaxi${org} (payment_type)
;
