LOAD BULK %NOJOURN DATA FROM FILE '${data_dir}yellow_tripdata_2012_2021.csv'
	INTO ${schema}NYTaxi${org}
	USING '{ "from": {"file": {"columnseparator":",", "header": true } } }'
;
