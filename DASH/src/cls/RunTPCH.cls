Class RunTPCH extends DASH.Utils
{

ClassMethod RunTPCH(iterations As %String = "5", verbose As %Boolean = 1) As %Status
{
	
	kill ^%zDashResults
	
	do ##class(DASH.Utils).Load("/nethome/marmorri/DASH/TPCH","tpch","","1","ddl-row")
	do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/TPCH","tpch","%PARALLEL","Q*", iterations)
	do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/TPCH","tpch","%NOPARALLEL","Q*", iterations)
	do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/TPCH","tpch",,"Q*", iterations) // auto parallel
	
	//do ##class(DASH.Utils).Load("/nethome/marmorri/DASH/TPCH","tpch","","1","ddl-row-id")
	
	if $FIND($zv,"VEC") {
		do ##class(DASH.Utils).Load("/nethome/marmorri/DASH/TPCH","tpch","","1","ddl-colfields",1)  // with indices
		do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/TPCH","tpch","%PARALLEL","Q*", iterations)
		do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/TPCH","tpch","%NOPARALLEL","Q*", iterations)
		do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/TPCH","tpch",,"Q*", iterations) // auto parallel
		
		// skip for now
		#; do ##class(DASH.Utils).Load("/nethome/marmorri/DASH/TPCH","tpch","","1","ddl-colfields",0)  // without indices
		#; do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/TPCH","tpch","%PARALLEL","Q*", iterations)
		#; do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/TPCH","tpch","%NOPARALLEL","Q*", iterations)
		#; do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/TPCH","tpch",,"Q*", iterations) // auto parallel

		//do ##class(DASH.Utils).Load("/nethome/marmorri/DASH/TPCH","tpch","","1","ddl-coltable",1)
		#; do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/TPCH","tpch","%PARALLEL","Q*", iterations)
		#; do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/TPCH","tpch","%NOPARALLEL","Q*", iterations)
		#; do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/TPCH","tpch",,"Q*", iterations) // auto parallel

		//do ##class(DASH.Utils).Load("/nethome/marmorri/DASH/TPCH","tpch","","1","ddl-coltable",0)
		#; do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/TPCH","tpch","%PARALLEL","Q*", iterations)
		#; do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/TPCH","tpch","%NOPARALLEL","Q*", iterations)
		#; do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/TPCH","tpch",,"Q*", iterations) // auto parallel
	}

	Set rgkey = $Order(^%zDashResults(""))
 	While (rgkey '= "") {
		for i = 1:1:^%zDashResults(rgkey) { write !, ^%zDashResults(rgkey,i) }
		// Find next node
		Set rgkey = $Order(^%zDashResults(rgkey))
 	}
	kill ^%zDashResults
}

}