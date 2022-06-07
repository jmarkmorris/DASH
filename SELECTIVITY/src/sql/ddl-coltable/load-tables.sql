LOAD BULK %NOJOURN DATA FROM FILE '${data_dir}selectivity.tbl'
	INTO ${schema}C${org}
	USING '{ "from": {"file": {"columnseparator":"|"} } }'
;

LOAD BULK %NOJOURN DATA FROM FILE '${data_dir}selectivity.tbl'
	INTO ${schema}D${org}
	USING '{ "from": {"file": {"columnseparator":"|"} } }'
;

