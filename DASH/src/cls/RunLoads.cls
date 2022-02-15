Class RunLoads extends DASH.Utils
{

// do ##class(RunLoads).RunLoads()
ClassMethod RunLoads(iterations As %String = "5", verbose As %Boolean = 1) As %Status
{
	
	kill ^%zDashResults
	
	for i = 1:1:iterations {

		// Load TPCH 1G to R_IDX tables 
		set idx = 1
		do ##class(DASH.Utils).Load("/nethome/marmorri/DASH/TPCH","tpch","","1","ddl-row",idx)
		
		// Create destination tables
		do ##class(DASH.Utils).Load("/nethome/marmorri/DASH/TPCH","tpch","","1","ddl-row",1,,,"_R_IDX")
		do ##class(DASH.Utils).Load("/nethome/marmorri/DASH/TPCH","tpch","","1","ddl-row",0,,,"_R_NOIDX")
		
		// insert selects R to R
		do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/TPCH","tpch","%PARALLEL","IS*", iterations,,"_R_IDX")
		do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/TPCH","tpch","%NOPARALLEL","IS*", iterations,,"_R_IDX")
		do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/TPCH","tpch","%PARALLEL","IS*", iterations,,"_R_NOIDX")
		do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/TPCH","tpch","%NOPARALLEL","IS*", iterations,,"_R_NOIDX")

		if $FIND($zv,"VEC") {

			// Create destination tables
			do ##class(DASH.Utils).Load("/nethome/marmorri/DASH/TPCH","tpch","","1","ddl-colfields",1,,,"_CF_IDX")
			do ##class(DASH.Utils).Load("/nethome/marmorri/DASH/TPCH","tpch","","1","ddl-colfields",0,,,"_CF_NOIDX")
			do ##class(DASH.Utils).Load("/nethome/marmorri/DASH/TPCH","tpch","","1","ddl-coltable",1,,,"_CT_IDX")
			do ##class(DASH.Utils).Load("/nethome/marmorri/DASH/TPCH","tpch","","1","ddl-coltable",0,,,"_CT_NOIDX")
			
			// insert selects R to CF
			do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/TPCH","tpch","%PARALLEL","IS*", iterations,,"_CF_IDX")
			do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/TPCH","tpch","%NOPARALLEL","IS*", iterations,,"_CF_IDX")
			do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/TPCH","tpch","%PARALLEL","IS*", iterations,,"_CF_NOIDX")
			do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/TPCH","tpch","%NOPARALLEL","IS*", iterations,,"_CF_NOIDX")

			// insert selects R to CT
			do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/TPCH","tpch","%PARALLEL","IS*", iterations,,"_CT_IDX")
			do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/TPCH","tpch","%NOPARALLEL","IS*", iterations,,"_CT_IDX")
			do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/TPCH","tpch","%PARALLEL","IS*", iterations,,"_CT_NOIDX")
			do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/TPCH","tpch","%NOPARALLEL","IS*", iterations,,"_CT_NOIDX")
			
		}

		//do ##class(DASH.Utils).Load("/nethome/marmorri/DASH/TPCH","tpch","","1","ddl-row-id")
		//do ##class(DASH.Utils).Load("/nethome/marmorri/DASH/TPCH","tpch","","1","ddl-coltable",1)
		//do ##class(DASH.Utils).Load("/nethome/marmorri/DASH/TPCH","tpch","","1","ddl-coltable",0)

		if $FIND($zv,"VEC") {

			// Create destination tables
			do ##class(DASH.Utils).Load("/nethome/marmorri/DASH/TPCH","tpch","","1","ddl-colfields",1,,,"_CF_IDX")
			do ##class(DASH.Utils).Load("/nethome/marmorri/DASH/TPCH","tpch","","1","ddl-colfields",0,,,"_CF_NOIDX")
			do ##class(DASH.Utils).Load("/nethome/marmorri/DASH/TPCH","tpch","","1","ddl-coltable",1,,,"_CT_IDX")
			do ##class(DASH.Utils).Load("/nethome/marmorri/DASH/TPCH","tpch","","1","ddl-coltable",0,,,"_CT_NOIDX")
			do ##class(DASH.Utils).Load("/nethome/marmorri/DASH/TPCH","tpch","","1","ddl-row",1,,,"_R_IDX")
			do ##class(DASH.Utils).Load("/nethome/marmorri/DASH/TPCH","tpch","","1","ddl-row",0,,,"_R_NOIDX")

			for idx = 0:1:1 {
			
				// Load to CF tables (idx=0, and idx=1)
				do ##class(DASH.Utils).Load("/nethome/marmorri/DASH/TPCH","tpch","","1","ddl-colfields",idx)

				// insert selects to R
				do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/TPCH","tpch","%PARALLEL","IS*", iterations,,"_R_IDX")
				do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/TPCH","tpch","%NOPARALLEL","IS*", iterations,,"_R_IDX")
				do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/TPCH","tpch","%PARALLEL","IS*", iterations,,"_R_NOIDX")
				do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/TPCH","tpch","%NOPARALLEL","IS*", iterations,,"_R_NOIDX")
					
				// insert selects to CF
				do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/TPCH","tpch","%PARALLEL","IS*", iterations,,"_CF_IDX")
				do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/TPCH","tpch","%NOPARALLEL","IS*", iterations,,"_CF_IDX")
				do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/TPCH","tpch","%PARALLEL","IS*", iterations,,"_CF_NOIDX")
				do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/TPCH","tpch","%NOPARALLEL","IS*", iterations,,"_CF_NOIDX")

				// insert selects to CT
				do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/TPCH","tpch","%PARALLEL","IS*", iterations,,"_CT_IDX")
				do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/TPCH","tpch","%NOPARALLEL","IS*", iterations,,"_CT_IDX")
				do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/TPCH","tpch","%PARALLEL","IS*", iterations,,"_CT_NOIDX")
				do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/TPCH","tpch","%NOPARALLEL","IS*", iterations,,"_CT_NOIDX")

			}
			
		}
		
		// Selectivity Loads
		set idx = 1
		do ##class(DASH.Utils).Load("/nethome/marmorri/DASH/SELECTIVITY","SelectivityTest","","1","ddl-row",idx)
		if $FIND($zv,"VEC") {
			do ##class(DASH.Utils).Load("/nethome/marmorri/DASH/SELECTIVITY","SelectivityTest","","1","ddl-coltable",1)
			do ##class(DASH.Utils).Load("/nethome/marmorri/DASH/SELECTIVITY","SelectivityTest","","1","ddl-coltable",0)
		}

		// NYTaxi Loads
		do ##class(DASH.Utils).Load("/nethome/marmorri/DASH/NYTaxi","NYTaxi","","1","ddl-row",idx)
		if $FIND($zv,"VEC") {
			do ##class(DASH.Utils).Load("/nethome/marmorri/DASH/NYTaxi","NYTaxi","","1","ddl-coltable",1)
			do ##class(DASH.Utils).Load("/nethome/marmorri/DASH/NYTaxi","NYTaxi","","1","ddl-coltable",0)
		}

		do ##class(RunLoads).GenerateData()
		do ##class(DASH.Utils).Load("/nethome/marmorri/DASH/LOAD","load1m","","1","ddl-row",idx)
		if $FIND($zv,"VEC") {
			do ##class(DASH.Utils).Load("/nethome/marmorri/DASH/LOAD","load1m","","1","ddl-colfields",1)
			do ##class(DASH.Utils).Load("/nethome/marmorri/DASH/LOAD","load1m","","1","ddl-colfields",0)
			do ##class(DASH.Utils).Load("/nethome/marmorri/DASH/LOAD","load1m","","1","ddl-coltable",1)
			do ##class(DASH.Utils).Load("/nethome/marmorri/DASH/LOAD","load1m","","1","ddl-coltable",0)
		}

	}
}

ClassMethod GenerateData (records As %Integer = 1000000, verbose As %Boolean = 1) As %Status
{
	// generate the data in a table with populate
	set RecordCount = ##class(DASH.Utils).Populate(records,0 /* verbose */,1 /* Defer indices */,,0 /* Don't do tune table */ ,1 /* deterministic */) 
	write !, "Records requested : "_records
	write !, "Records populated : "_RecordCount,!

	SET myfile = "/tmp/dashdata"  // TO DO : make this a unique file name so can run concurrent sessions.
	OPEN myfile:("WEAS"):5 // time out limit of 5 seconds to avoid indefinite wait when myfile cannot be opened
	USE myfile
	for i = 1:1:RecordCount {
		Set oref =##class(DASH.Utils).%OpenId(i)
		// Populate puts a string such as J3546 in the Binary field1. Replace it with alternating 0, 1 pattern.
		write i#2_"|"_oref.field2_"|"_oref.field3_"|"_oref.field4_"|"_oref.field5_"|"_oref.field6_"|"_oref.field7_"|"_oref.field8_"|"_oref.field9_"|",!
	}
	CLOSE myfile

}

}