Class RunSelectivity extends DASH.Utils 
{

ClassMethod RunSelectivity(iterations As %String = "5", verbose As %Boolean = 1, indices As %Boolean = 1, columnar As %Boolean = 1) As %Status
{
	
	kill ^%zDashResults

	if (columnar = 0) {
		do ##class(DASH.Utils).Load("/nethome/marmorri/DASH/SELECTIVITY","SelectivityTest","","1","ddl-row",indices)
		do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/SELECTIVITY","SelectivityTest","%NOPARALLEL","Q*",iterations,verbose)
		do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/SELECTIVITY","SelectivityTest","%PARALLEL","Q*",iterations,verbose)
		do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/SELECTIVITY","SelectivityTest","","Q*",iterations,verbose)
	} else {
		if $FIND($zv,"VEC") {
			do ##class(DASH.Utils).Load("/nethome/marmorri/DASH/SELECTIVITY","SelectivityTest","","1","ddl-coltable",indices)
			do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/SELECTIVITY","SelectivityTest","%NOPARALLEL","Q*",iterations,verbose)
			do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/SELECTIVITY","SelectivityTest","%PARALLEL","Q*",iterations,verbose)
			do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/SELECTIVITY","SelectivityTest","","Q*",iterations,verbose)
		}
	}
}

}