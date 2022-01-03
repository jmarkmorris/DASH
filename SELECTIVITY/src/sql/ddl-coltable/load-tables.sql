LOAD DATA FROM FILE '${data_dir}selectivity.tbl'
	INTO ${schema}C
	USING '{ "from": {"file": {"columnseparator":"|"} }, "bufferrowcount":50000 }'
;

LOAD DATA FROM FILE '${data_dir}selectivity.tbl'
	INTO ${schema}D
	USING '{ "from": {"file": {"columnseparator":"|"} }, "bufferrowcount":50000 }'
;

