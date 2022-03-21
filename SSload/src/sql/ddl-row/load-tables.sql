LOAD DATA FROM FILE '/tmp/ssdata'
	INTO ${schema}trip_info${org}
	USING '{ "from": {"file": {"columnseparator":","} } }'
;

