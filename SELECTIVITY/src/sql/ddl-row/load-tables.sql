LOAD DATA FROM FILE '${data_dir}selectivity.tbl'
	INTO ${schema}C
	USING '{ "from": {"file": {"columnseparator":"|"} } }'
;

LOAD DATA FROM FILE '${data_dir}selectivity.tbl'
	INTO ${schema}D
	USING '{ "from": {"file": {"columnseparator":"|"} } }'
;

