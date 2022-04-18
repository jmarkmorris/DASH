Class RunSelectivity extends DASH.Utils 
{

ClassMethod RunSelectivity(iterations As %String = "5", verbose As %Boolean = 1, indices As %Boolean = 0, columnar As %Boolean = 1) As %Status
{
	if columnar {
		if '$FIND($zv,"VEC") { // columnar
			quit
		}
	}
	
	kill ^%zDashResults

	set repo = "/nethome/marmorri/DASH/"

	if (columnar = 0) {
		do ##class(DASH.Utils).Load(repo_"/SELECTIVITY","Selectivity","","1","ddl-row",indices)
		do ##class(DASH.Utils).Run(repo_"/SELECTIVITY","Selectivity","%NOPARALLEL","Q*",iterations,verbose)
		do ##class(DASH.Utils).Run(repo_"/SELECTIVITY","Selectivity","%PARALLEL","Q*",iterations,verbose)
		do ##class(DASH.Utils).Run(repo_"/SELECTIVITY","Selectivity","","Q*",iterations,verbose)
	} else {
		if $FIND($zv,"VEC") {
			do ##class(DASH.Utils).Load(repo_"/SELECTIVITY","Selectivity","","1","ddl-coltable",indices)
			do ##class(DASH.Utils).Run(repo_"/SELECTIVITY","Selectivity","%NOPARALLEL","Q*",iterations,verbose)
			do ##class(DASH.Utils).Run(repo_"/SELECTIVITY","Selectivity","%PARALLEL","Q*",iterations,verbose)
			do ##class(DASH.Utils).Run(repo_"/SELECTIVITY","Selectivity","","Q*",iterations,verbose)

			do ##class(DASH.Utils).Load(repo_"/SELECTIVITY","Selectivity","","1","ddl-colfields",indices)
			do ##class(DASH.Utils).Run(repo_"/SELECTIVITY","Selectivity","%NOPARALLEL","Q*",iterations,verbose)
			do ##class(DASH.Utils).Run(repo_"/SELECTIVITY","Selectivity","%PARALLEL","Q*",iterations,verbose)
			do ##class(DASH.Utils).Run(repo_"/SELECTIVITY","Selectivity","","Q*",iterations,verbose)
		}
	}

	do ##class(WriteResults).WriteResults()

	kill ^%zDashResults
}

}