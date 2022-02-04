LOAD DATA FROM FILE '/tmp/dashdata'
	INTO ${schema}DASHLOAD
	USING '{ "from": {"file": {"columnseparator":"|"} } }'
;

