LOAD BULK %NOJOURN DATA FROM FILE '/tmp/dashdata'
	INTO ${schema}DASHLOAD${org}
	USING '{ "from": {"file": {"columnseparator":"|"} } }'
;

