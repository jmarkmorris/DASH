Class RunLoads extends DASH.Utils
{

// do ##class(RunLoads).RunLoads()
ClassMethod RunLoads(iterations As %String = "5", verbose As %Boolean = 1, indices As %Boolean = 0, columnar As %Boolean = 1) As %Status
{
	
	kill ^%zDashResults

	do ##class(RunLoads).GenerateData() // for the load 1m tests
	
	// load base tables
	if (columnar = 0) {

		// Load TPCH 1G to R tables 
		do ##class(DASH.Utils).Load("/nethome/marmorri/DASH/TPCH","tpch","","1","ddl-row",indices)
		
		// Load TPCH 1G to RID tables - if decide to enable this, need to add another command line option to create R or RID tables, not both
		// do ##class(DASH.Utils).Load("/nethome/marmorri/DASH/TPCH","tpch","","1","ddl-row-id", indices) // skip
		
		// Load Selectivity to R tables
		do ##class(DASH.Utils).Load("/nethome/marmorri/DASH/SELECTIVITY","SelectivityTest","","1","ddl-row",indices)
		
		// Load NYTaxi to R tables
		do ##class(DASH.Utils).Load("/nethome/marmorri/DASH/NYTaxi","NYTaxi","","1","ddl-row",indices)

		// Load Load1m to R tables
		do ##class(DASH.Utils).Load("/nethome/marmorri/DASH/LOAD","load1m","","1","ddl-row",indices)

	} elseif $FIND($zv,"VEC") { // columnar
		
		// Load TPCH 1G to CF tables
		do ##class(DASH.Utils).Load("/nethome/marmorri/DASH/TPCH","tpch","","1","ddl-colfields",indices)

		// Load NYTaxi to CT tables
		do ##class(DASH.Utils).Load("/nethome/marmorri/DASH/NYTaxi","NYTaxi","","1","ddl-coltable",indices)

		// Load Selectivity to CT tables
		do ##class(DASH.Utils).Load("/nethome/marmorri/DASH/SELECTIVITY","SelectivityTest","","1","ddl-coltable",indices)

		// Load Load1m to CT tables
		do ##class(DASH.Utils).Load("/nethome/marmorri/DASH/LOAD","load1m","","1","ddl-coltable",indices)
		
	}	// else {

		// if decide to enable CF sources, need to add another command line option to create CF or CT tables, not both

		// Load TPCH 1G to CT tables - if decide to enable this, need to add another command line option to create CF or CT tables, not both
		//do ##class(DASH.Utils).Load("/nethome/marmorri/DASH/TPCH","tpch","","1","ddl-coltable",indices) // actually this will move up and CF above will move here

		// Load NYTaxi to CF tables

		// Load Selectivity to CF tables

		// Load Load1m to CF tables -  
		// do ##class(DASH.Utils).Load("/nethome/marmorri/DASH/LOAD","load1m","","1","ddl-colfields",indices)

	//}

	// To Do : The following could be done with loops and far less code.
		
	// Create R destination tables
	do ##class(DASH.Utils).Load("/nethome/marmorri/DASH/TPCH","tpch","","1","ddl-row",1,,,"_R_IDX")
	do ##class(DASH.Utils).Load("/nethome/marmorri/DASH/TPCH","tpch","","1","ddl-row",0,,,"_R_NOIDX")
	do ##class(DASH.Utils).Load("/nethome/marmorri/DASH/NYTaxi","NYTaxi","","1","ddl-row",1,,,"_R_IDX")
	do ##class(DASH.Utils).Load("/nethome/marmorri/DASH/NYTaxi","NYTaxi","","1","ddl-row",0,,,"_R_NOIDX")
	do ##class(DASH.Utils).Load("/nethome/marmorri/DASH/SELECTIVITY","SelectivityTest","","1","ddl-row",1,,,"_R_IDX")
	do ##class(DASH.Utils).Load("/nethome/marmorri/DASH/SELECTIVITY","SelectivityTest","","1","ddl-row",0,,,"_R_NOIDX")
	do ##class(DASH.Utils).Load("/nethome/marmorri/DASH/LOAD","load1m","","1","ddl-row",1,,,"_R_IDX")
	do ##class(DASH.Utils).Load("/nethome/marmorri/DASH/LOAD","load1m","","1","ddl-row",0,,,"_R_NOIDX")

	if $FIND($zv,"VEC") {

		// Create CF destination tables
		do ##class(DASH.Utils).Load("/nethome/marmorri/DASH/TPCH","tpch","","1","ddl-colfields",1,,,"_CF_IDX")
		do ##class(DASH.Utils).Load("/nethome/marmorri/DASH/TPCH","tpch","","1","ddl-colfields",0,,,"_CF_NOIDX")
		do ##class(DASH.Utils).Load("/nethome/marmorri/DASH/NYTaxi","NYTaxi","","1","ddl-colfields",1,,,"_CF_IDX")
		do ##class(DASH.Utils).Load("/nethome/marmorri/DASH/NYTaxi","NYTaxi","","1","ddl-colfields",0,,,"_CF_NOIDX")
		do ##class(DASH.Utils).Load("/nethome/marmorri/DASH/SELECTIVITY","SelectivityTest","","1","ddl-colfields",1,,,"_CF_IDX")
		do ##class(DASH.Utils).Load("/nethome/marmorri/DASH/SELECTIVITY","SelectivityTest","","1","ddl-colfields",0,,,"_CF_NOIDX")
		do ##class(DASH.Utils).Load("/nethome/marmorri/DASH/LOAD","load1m","","1","ddl-colfields",1,,,"_CF_IDX")
		do ##class(DASH.Utils).Load("/nethome/marmorri/DASH/LOAD","load1m","","1","ddl-colfields",0,,,"_CF_NOIDX")

		// Create CT destination tables
		// do ##class(DASH.Utils).Load("/nethome/marmorri/DASH/TPCH","tpch","","1","ddl-coltable",1,,,"_CT_IDX")
		// do ##class(DASH.Utils).Load("/nethome/marmorri/DASH/TPCH","tpch","","1","ddl-coltable",0,,,"_CT_NOIDX")
		do ##class(DASH.Utils).Load("/nethome/marmorri/DASH/NYTaxi","NYTaxi","","1","ddl-coltable",1,,,"_CT_IDX")
		do ##class(DASH.Utils).Load("/nethome/marmorri/DASH/NYTaxi","NYTaxi","","1","ddl-coltable",0,,,"_CT_NOIDX")
		do ##class(DASH.Utils).Load("/nethome/marmorri/DASH/SELECTIVITY","SelectivityTest","","1","ddl-coltable",1,,,"_CT_IDX")
		do ##class(DASH.Utils).Load("/nethome/marmorri/DASH/SELECTIVITY","SelectivityTest","","1","ddl-coltable",0,,,"_CT_NOIDX")
		do ##class(DASH.Utils).Load("/nethome/marmorri/DASH/LOAD","load1m","","1","ddl-coltable",1,,,"_CT_IDX")
		do ##class(DASH.Utils).Load("/nethome/marmorri/DASH/LOAD","load1m","","1","ddl-coltable",0,,,"_CT_NOIDX")

	}

	// insert selects to R
	do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/TPCH","tpch","%PARALLEL","IS*", iterations,,"_R_IDX")
	do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/TPCH","tpch","%NOPARALLEL","IS*", iterations,,"_R_IDX")
	do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/TPCH","tpch","%PARALLEL","IS*", iterations,,"_R_NOIDX")
	do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/TPCH","tpch","%NOPARALLEL","IS*", iterations,,"_R_NOIDX")
	do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/NYTaxi","NYTaxi","%PARALLEL","IS*", iterations,,"_R_IDX")
	do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/NYTaxi","NYTaxi","%NOPARALLEL","IS*", iterations,,"_R_IDX")
	do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/NYTaxi","NYTaxi","%PARALLEL","IS*", iterations,,"_R_NOIDX")
	do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/NYTaxi","NYTaxi","%NOPARALLEL","IS*", iterations,,"_R_NOIDX")
	do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/SELECTIVITY","SelectivityTest","%PARALLEL","IS*", iterations,,"_R_IDX")
	do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/SELECTIVITY","SelectivityTest","%NOPARALLEL","IS*", iterations,,"_R_IDX")
	do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/SELECTIVITY","SelectivityTest","%PARALLEL","IS*", iterations,,"_R_NOIDX")
	do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/SELECTIVITY","SelectivityTest","%NOPARALLEL","IS*", iterations,,"_R_NOIDX")
	do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/LOAD","load1m","%PARALLEL","IS*", iterations,,"_R_IDX")
	do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/LOAD","load1m","%NOPARALLEL","IS*", iterations,,"_R_IDX")
	do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/LOAD","load1m","%PARALLEL","IS*", iterations,,"_R_NOIDX")
	do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/LOAD","load1m","%NOPARALLEL","IS*", iterations,,"_R_NOIDX")
	
	if $FIND($zv,"VEC") {
		// insert selects to CF
		do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/TPCH","tpch","%PARALLEL","IS*", iterations,,"_CF_IDX")
		do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/TPCH","tpch","%NOPARALLEL","IS*", iterations,,"_CF_IDX")
		do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/TPCH","tpch","%PARALLEL","IS*", iterations,,"_CF_NOIDX")
		do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/TPCH","tpch","%NOPARALLEL","IS*", iterations,,"_CF_NOIDX")
		do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/NYTaxi","NYTaxi","%PARALLEL","IS*", iterations,,"_CF_IDX")
		do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/NYTaxi","NYTaxi","%NOPARALLEL","IS*", iterations,,"_CF_IDX")
		do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/NYTaxi","NYTaxi","%PARALLEL","IS*", iterations,,"_CF_NOIDX")
		do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/NYTaxi","NYTaxi","%NOPARALLEL","IS*", iterations,,"_CF_NOIDX")
		do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/SELECTIVITY","SelectivityTest","%PARALLEL","IS*", iterations,,"_CF_IDX")
		do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/SELECTIVITY","SelectivityTest","%NOPARALLEL","IS*", iterations,,"_CF_IDX")
		do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/SELECTIVITY","SelectivityTest","%PARALLEL","IS*", iterations,,"_CF_NOIDX")
		do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/SELECTIVITY","SelectivityTest","%NOPARALLEL","IS*", iterations,,"_CF_NOIDX")
		do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/LOAD","load1m","%PARALLEL","IS*", iterations,,"_CF_IDX")
		do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/LOAD","load1m","%NOPARALLEL","IS*", iterations,,"_CF_IDX")
		do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/LOAD","load1m","%PARALLEL","IS*", iterations,,"_CF_NOIDX")
		do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/LOAD","load1m","%NOPARALLEL","IS*", iterations,,"_CF_NOIDX")

		// insert selects to CT
		#; do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/TPCH","tpch","%PARALLEL","IS*", iterations,,"_CT_IDX")
		#; do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/TPCH","tpch","%NOPARALLEL","IS*", iterations,,"_CT_IDX")
		#; do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/TPCH","tpch","%PARALLEL","IS*", iterations,,"_CT_NOIDX")
		#; do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/TPCH","tpch","%NOPARALLEL","IS*", iterations,,"_CT_NOIDX")
		do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/NYTaxi","NYTaxi","%PARALLEL","IS*", iterations,,"_CT_IDX")
		do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/NYTaxi","NYTaxi","%NOPARALLEL","IS*", iterations,,"_CT_IDX")
		do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/NYTaxi","NYTaxi","%PARALLEL","IS*", iterations,,"_CT_NOIDX")
		do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/NYTaxi","NYTaxi","%NOPARALLEL","IS*", iterations,,"_CT_NOIDX")
		do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/SELECTIVITY","SelectivityTest","%PARALLEL","IS*", iterations,,"_CT_IDX")
		do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/SELECTIVITY","SelectivityTest","%NOPARALLEL","IS*", iterations,,"_CT_IDX")
		do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/SELECTIVITY","SelectivityTest","%PARALLEL","IS*", iterations,,"_CT_NOIDX")
		do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/SELECTIVITY","SelectivityTest","%NOPARALLEL","IS*", iterations,,"_CT_NOIDX")
		do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/LOAD","load1m","%PARALLEL","IS*", iterations,,"_CT_IDX")
		do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/LOAD","load1m","%NOPARALLEL","IS*", iterations,,"_CT_IDX")
		do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/LOAD","load1m","%PARALLEL","IS*", iterations,,"_CT_NOIDX")
		do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/LOAD","load1m","%NOPARALLEL","IS*", iterations,,"_CT_NOIDX")
	}
}

ClassMethod GenerateData (records As %Integer = 1000000, verbose As %Boolean = 1) As %Status
{
	write !, "Generating data for the Load1m tests"
	
	// generate the data in a table with populate
	set RecordCount = ##class(DASH.Utils).Populate(records,0 /* verbose */,1 /* Defer indices */,,0 /* Don't do tune table */ ,1 /* deterministic */) 
	write !, "Records requested : "_records
	write !, "Records populated : "_RecordCount,!

	SET myfile = "/tmp/dashdata"  // TO DO : make this a unique file name so can run concurrent sessions.
	OPEN myfile:("WTAS"):5 // time out limit of 5 seconds to avoid indefinite wait when myfile cannot be opened
	USE myfile
	for i = 1:1:RecordCount {
		Set oref =##class(DASH.Utils).%OpenId(i)
		// Populate puts a string such as J3546 in the Binary field1. Replace it with alternating 0, 1 pattern.
		write i#2_"|"_oref.field2_"|"_oref.field3_"|"_oref.field4_"|"_oref.field5_"|"_oref.field6_"|"_oref.field7_"|"_oref.field8_"|"_oref.field9_"|",!
	}
	CLOSE myfile

}

}