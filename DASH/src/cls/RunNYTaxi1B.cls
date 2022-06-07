Class DASH.src.cls.RunNYTaxi1B
{

ClassMethod RunNYTaxi1B(iterations As %String = "5", verbose As %Boolean = 1) As %Status
{
	
	kill ^%zDashResults

	set repo = "/nethome/marmorri/DASH/"


    // with indices
	do ##class(DASH.Utils).Load(repo_"/NYTaxi1B","NYTaxi1B","","1","ddl-row",1)
	do ##class(DASH.Utils).Run(repo_"/NYTaxi1B","NYTaxi1B","%NOPARALLEL","Q*", iterations,verbose)
	do ##class(DASH.Utils).Run(repo_"/NYTaxi1B","NYTaxi1B","%PARALLEL","Q*", iterations,verbose)
	do ##class(DASH.Utils).Run(repo_"/NYTaxi1B","NYTaxi1B","","Q*", iterations,verbose)

    // without indices
	do ##class(DASH.Utils).Load(repo_"/NYTaxi1B","NYTaxi1B","","1","ddl-row",0)
	do ##class(DASH.Utils).Run(repo_"/NYTaxi1B","NYTaxi1B","%NOPARALLEL","Q*", iterations,verbose)
	do ##class(DASH.Utils).Run(repo_"/NYTaxi1B","NYTaxi1B","%PARALLEL","Q*", iterations,verbose)
	do ##class(DASH.Utils).Run(repo_"/NYTaxi1B","NYTaxi1B","","Q*", iterations,verbose)

	if $FIND($zv,"VEC") {
		// with indices
        do ##class(DASH.Utils).Load(repo_"/NYTaxi1B","NYTaxi1B","","1","ddl-coltable",1)
		do ##class(DASH.Utils).Run(repo_"/NYTaxi1B","NYTaxi1B","%NOPARALLEL","Q*", iterations,verbose)
		do ##class(DASH.Utils).Run(repo_"/NYTaxi1B","NYTaxi1B","%PARALLEL","Q*", iterations,verbose)
		do ##class(DASH.Utils).Run(repo_"/NYTaxi1B","NYTaxi1B","","Q*", iterations,verbose)

        // without indices
		do ##class(DASH.Utils).Load(repo_"/NYTaxi1B","NYTaxi1B","","1","ddl-coltable",0)
		do ##class(DASH.Utils).Run(repo_"/NYTaxi1B","NYTaxi1B","%NOPARALLEL","Q*", iterations,verbose)
		do ##class(DASH.Utils).Run(repo_"/NYTaxi1B","NYTaxi1B","%PARALLEL","Q*", iterations,verbose)
		do ##class(DASH.Utils).Run(repo_"/NYTaxi1B","NYTaxi1B","","Q*", iterations,verbose)
	}

	do ##class(WriteResults).WriteResults()

	kill ^%zDashResults
		
}

}