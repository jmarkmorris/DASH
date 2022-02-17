CREATE TABLE ${schema}NYTaxi  ( 
			VendorID  INTEGER WITH STORAGETYPE = COLUMNAR,
			tpep_pickup_datetime       TIMESTAMP WITH STORAGETYPE = COLUMNAR,
			tpep_dropoff_datetime       TIMESTAMP WITH STORAGETYPE = COLUMNAR,
			passenger_count  INTEGER WITH STORAGETYPE = COLUMNAR,
			trip_distance    DOUBLE WITH STORAGETYPE = COLUMNAR,
			RatecodeID  INTEGER WITH STORAGETYPE = COLUMNAR,
			store_and_fwd_flag  VARCHAR(25) WITH STORAGETYPE = COLUMNAR,
			PULocationID  INTEGER WITH STORAGETYPE = COLUMNAR,
			DOLocationID  INTEGER WITH STORAGETYPE = COLUMNAR,
			payment_type INTEGER WITH STORAGETYPE = COLUMNAR,
			fare_amount DOUBLE WITH STORAGETYPE = COLUMNAR,
			extra DOUBLE WITH STORAGETYPE = COLUMNAR,
			mta_tax DOUBLE WITH STORAGETYPE = COLUMNAR,
			tip_amount DOUBLE WITH STORAGETYPE = COLUMNAR,
			tolls_amount DOUBLE WITH STORAGETYPE = COLUMNAR,
			improvement_surcharge DOUBLE WITH STORAGETYPE = COLUMNAR,
			total_amount DOUBLE WITH STORAGETYPE = COLUMNAR,
			congestion_surcharge DOUBLE WITH STORAGETYPE = COLUMNAR)
;

