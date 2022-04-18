Class RunTPCH extends DASH.Utils
{

ClassMethod RunTPCH(iterations As %String = "5", verbose As %Boolean = 1) As %Status
{
	
	kill ^%zDashResults

	set repo = "/nethome/marmorri/DASH/"

	
	do ##class(DASH.Utils).Load(repo_"/TPCH","tpch","","1","ddl-row")
	do ##class(DASH.Utils).Run(repo_"/TPCH","tpch","%PARALLEL","Q*", iterations)
	do ##class(DASH.Utils).Run(repo_"/TPCH","tpch","%NOPARALLEL","Q*", iterations)
	do ##class(DASH.Utils).Run(repo_"/TPCH","tpch",,"Q*", iterations) // auto parallel
	
	//do ##class(DASH.Utils).Load(repo_"/TPCH","tpch","","1","ddl-row-id")
	
	if $FIND($zv,"VEC") {
		do ##class(DASH.Utils).Load(repo_"/TPCH","tpch","","1","ddl-colfields",1)  // with indices
		do ##class(DASH.Utils).Run(repo_"/TPCH","tpch","%PARALLEL","Q*", iterations)
		do ##class(DASH.Utils).Run(repo_"/TPCH","tpch","%NOPARALLEL","Q*", iterations)
		do ##class(DASH.Utils).Run(repo_"/TPCH","tpch",,"Q*", iterations) // auto parallel
		
		// skip for now
		#; do ##class(DASH.Utils).Load(repo_"/TPCH","tpch","","1","ddl-colfields",0)  // without indices
		#; do ##class(DASH.Utils).Run(repo_"/TPCH","tpch","%PARALLEL","Q*", iterations)
		#; do ##class(DASH.Utils).Run(repo_"/TPCH","tpch","%NOPARALLEL","Q*", iterations)
		#; do ##class(DASH.Utils).Run(repo_"/TPCH","tpch",,"Q*", iterations) // auto parallel

		//do ##class(DASH.Utils).Load(repo_"/TPCH","tpch","","1","ddl-coltable",1)
		#; do ##class(DASH.Utils).Run(repo_"/TPCH","tpch","%PARALLEL","Q*", iterations)
		#; do ##class(DASH.Utils).Run(repo_"/TPCH","tpch","%NOPARALLEL","Q*", iterations)
		#; do ##class(DASH.Utils).Run(repo_"/TPCH","tpch",,"Q*", iterations) // auto parallel

		//do ##class(DASH.Utils).Load(repo_"/TPCH","tpch","","1","ddl-coltable",0)
		#; do ##class(DASH.Utils).Run(repo_"/TPCH","tpch","%PARALLEL","Q*", iterations)
		#; do ##class(DASH.Utils).Run(repo_"/TPCH","tpch","%NOPARALLEL","Q*", iterations)
		#; do ##class(DASH.Utils).Run(repo_"/TPCH","tpch",,"Q*", iterations) // auto parallel
	}

	do ##class(WriteResults).WriteResults()

	kill ^%zDashResults
}

}