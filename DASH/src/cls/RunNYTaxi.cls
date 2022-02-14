Class RunNYTaxi extends DASH.Utils 
{

ClassMethod RunNYTaxi(iterations As %String = "5", verbose As %Boolean = 1) As %Status
{
	
	kill ^%zDashResults

	do ##class(DASH.Utils).Load("/nethome/marmorri/DASH/NYTaxi","NYTaxi","","1","ddl-row",1)
	do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/NYTaxi","NYTaxi","%NOPARALLEL","Q*", iterations,verbose)
	do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/NYTaxi","NYTaxi","%PARALLEL","Q*", iterations,verbose)
	do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/NYTaxi","NYTaxi","","Q*", iterations,verbose)

	do ##class(DASH.Utils).Load("/nethome/marmorri/DASH/NYTaxi","NYTaxi","","1","ddl-row",0)
	do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/NYTaxi","NYTaxi","%NOPARALLEL","Q*", iterations,verbose)
	do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/NYTaxi","NYTaxi","%PARALLEL","Q*", iterations,verbose)
	do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/NYTaxi","NYTaxi","","Q*", iterations,verbose)

	if $FIND($zv,"VEC") {
		do ##class(DASH.Utils).Load("/nethome/marmorri/DASH/NYTaxi","NYTaxi","","1","ddl-coltable",1)
		do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/NYTaxi","NYTaxi","%NOPARALLEL","Q*", iterations,verbose)
		do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/NYTaxi","NYTaxi","%PARALLEL","Q*", iterations,verbose)
		do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/NYTaxi","NYTaxi","","Q*", iterations,verbose)

		do ##class(DASH.Utils).Load("/nethome/marmorri/DASH/NYTaxi","NYTaxi","","1","ddl-coltable",0)
		do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/NYTaxi","NYTaxi","%NOPARALLEL","Q*", iterations,verbose)
		do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/NYTaxi","NYTaxi","%PARALLEL","Q*", iterations,verbose)
		do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/NYTaxi","NYTaxi","","Q*", iterations,verbose)
	}
		
}

}