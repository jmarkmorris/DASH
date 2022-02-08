LOAD DATA FROM FILE '${data_dir}nation.tbl'
	INTO ${schema}NATION${org}
	USING '{ "from": {"file": {"columnseparator":"|"} } }'
;

LOAD DATA FROM FILE '${data_dir}region.tbl'
	INTO ${schema}REGION${org}
	USING '{ "from": {"file": {"columnseparator":"|"} } }'
;

LOAD DATA FROM FILE '${data_dir}part.tbl'
	INTO ${schema}PART${org}
	USING '{ "from": {"file": {"columnseparator":"|"} } }'
;

LOAD DATA FROM FILE '${data_dir}supplier.tbl'
	INTO ${schema}SUPPLIER${org}
	USING '{ "from": {"file": {"columnseparator":"|"} } }'
;

LOAD DATA FROM FILE '${data_dir}partsupp.tbl'
	INTO ${schema}PARTSUPP${org}
	USING '{ "from": {"file": {"columnseparator":"|"} } }'
;

LOAD DATA FROM FILE '${data_dir}customer.tbl'
	INTO ${schema}CUSTOMER${org}
	USING '{ "from": {"file": {"columnseparator":"|"} } }'
;

LOAD DATA FROM FILE '${data_dir}orders.tbl'
	INTO ${schema}ORDERS${org}
	USING '{ "from": {"file": {"columnseparator":"|"} } }'
;

LOAD DATA FROM FILE '${data_dir}lineitem.tbl'
	INTO ${schema}LINEITEM${org}
	USING '{ "from": {"file": {"columnseparator":"|"} } }'
;
