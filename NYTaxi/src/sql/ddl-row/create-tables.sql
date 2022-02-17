CREATE TABLE ${schema}NYTaxi  ( 
			VendorID  INTEGER,
			tpep_pickup_datetime       TIMESTAMP,
			tpep_dropoff_datetime       TIMESTAMP,
			passenger_count  INTEGER,
			trip_distance    DOUBLE,
			RatecodeID  INTEGER,
			store_and_fwd_flag  VARCHAR(25),
			PULocationID  INTEGER,
			DOLocationID  INTEGER,
			payment_type INTEGER,
			fare_amount DOUBLE,
			extra DOUBLE,
			mta_tax DOUBLE,
			tip_amount DOUBLE,
			tolls_amount DOUBLE,
			improvement_surcharge DOUBLE,
			total_amount DOUBLE,
			congestion_surcharge DOUBLE)
;

