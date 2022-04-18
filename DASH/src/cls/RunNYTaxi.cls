Class RunNYTaxi extends DASH.Utils 
{

ClassMethod RunNYTaxi(iterations As %String = "5", verbose As %Boolean = 1) As %Status
{
	
	kill ^%zDashResults

	set repo = "/nethome/marmorri/DASH/"


    // with indices
	do ##class(DASH.Utils).Load(repo_"/NYTaxi","NYTaxi","","1","ddl-row",1)
	do ##class(DASH.Utils).Run(repo_"/NYTaxi","NYTaxi","%NOPARALLEL","Q*", iterations,verbose)
	do ##class(DASH.Utils).Run(repo_"/NYTaxi","NYTaxi","%PARALLEL","Q*", iterations,verbose)
	do ##class(DASH.Utils).Run(repo_"/NYTaxi","NYTaxi","","Q*", iterations,verbose)

    // without indices
	do ##class(DASH.Utils).Load(repo_"/NYTaxi","NYTaxi","","1","ddl-row",0)
	do ##class(DASH.Utils).Run(repo_"/NYTaxi","NYTaxi","%NOPARALLEL","Q*", iterations,verbose)
	do ##class(DASH.Utils).Run(repo_"/NYTaxi","NYTaxi","%PARALLEL","Q*", iterations,verbose)
	do ##class(DASH.Utils).Run(repo_"/NYTaxi","NYTaxi","","Q*", iterations,verbose)

	if $FIND($zv,"VEC") {
		// with indices
        do ##class(DASH.Utils).Load(repo_"/NYTaxi","NYTaxi","","1","ddl-coltable",1)
		do ##class(DASH.Utils).Run(repo_"/NYTaxi","NYTaxi","%NOPARALLEL","Q*", iterations,verbose)
		do ##class(DASH.Utils).Run(repo_"/NYTaxi","NYTaxi","%PARALLEL","Q*", iterations,verbose)
		do ##class(DASH.Utils).Run(repo_"/NYTaxi","NYTaxi","","Q*", iterations,verbose)

        // without indices
		do ##class(DASH.Utils).Load(repo_"/NYTaxi","NYTaxi","","1","ddl-coltable",0)
		do ##class(DASH.Utils).Run(repo_"/NYTaxi","NYTaxi","%NOPARALLEL","Q*", iterations,verbose)
		do ##class(DASH.Utils).Run(repo_"/NYTaxi","NYTaxi","%PARALLEL","Q*", iterations,verbose)
		do ##class(DASH.Utils).Run(repo_"/NYTaxi","NYTaxi","","Q*", iterations,verbose)
	}

	do ##class(WriteResults).WriteResults()

	kill ^%zDashResults
		
}

}