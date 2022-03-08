Class RunNYTaxi extends DASH.Utils 
{

ClassMethod RunNYTaxi(iterations As %String = "5", verbose As %Boolean = 1) As %Status
{
	
	kill ^%zDashResults

    // with indices
	do ##class(DASH.Utils).Load("/nethome/marmorri/DASH/NYTaxi","NYTaxi","","1","ddl-row",1)
	do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/NYTaxi","NYTaxi","%NOPARALLEL","Q*", iterations,verbose)
	do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/NYTaxi","NYTaxi","%PARALLEL","Q*", iterations,verbose)
	do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/NYTaxi","NYTaxi","","Q*", iterations,verbose)

    // without indices
	do ##class(DASH.Utils).Load("/nethome/marmorri/DASH/NYTaxi","NYTaxi","","1","ddl-row",0)
	do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/NYTaxi","NYTaxi","%NOPARALLEL","Q*", iterations,verbose)
	do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/NYTaxi","NYTaxi","%PARALLEL","Q*", iterations,verbose)
	do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/NYTaxi","NYTaxi","","Q*", iterations,verbose)

	if $FIND($zv,"VEC") {
		// with indices
        do ##class(DASH.Utils).Load("/nethome/marmorri/DASH/NYTaxi","NYTaxi","","1","ddl-coltable",1)
		do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/NYTaxi","NYTaxi","%NOPARALLEL","Q*", iterations,verbose)
		do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/NYTaxi","NYTaxi","%PARALLEL","Q*", iterations,verbose)
		do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/NYTaxi","NYTaxi","","Q*", iterations,verbose)

        // without indices
		do ##class(DASH.Utils).Load("/nethome/marmorri/DASH/NYTaxi","NYTaxi","","1","ddl-coltable",0)
		do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/NYTaxi","NYTaxi","%NOPARALLEL","Q*", iterations,verbose)
		do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/NYTaxi","NYTaxi","%PARALLEL","Q*", iterations,verbose)
		do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/NYTaxi","NYTaxi","","Q*", iterations,verbose)
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