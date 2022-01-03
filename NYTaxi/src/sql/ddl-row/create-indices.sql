CREATE BITMAP INDEX VendorIDIndex ON ${schema}NYTaxi (VendorID)
;
CREATE BITMAP INDEX PassengerCountIndex ON ${schema}NYTaxi (passenger_count)
;
CREATE BITMAP INDEX RatecodeIndex ON ${schema}NYTaxi (RatecodeID)
;
CREATE BITMAP INDEX StorAndFwdFlagIndex ON ${schema}NYTaxi (store_and_fwd_flag)
;
CREATE BITMAP INDEX PULocationIDIndex ON ${schema}NYTaxi (PULocationID)
;
CREATE BITMAP INDEX DOLocationIDIndex ON ${schema}NYTaxi (DOLocationID)
;
CREATE BITMAP INDEX PaymentTypeIndex ON ${schema}NYTaxi (payment_type)
;
