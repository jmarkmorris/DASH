Class RunMicro extends DASH.Utils 
{

ClassMethod RunMicro(iterations As %String = "5", verbose As %Boolean = 1) As %Status
{
	
	kill ^%zDashResults

	do ##class(DASH.Utils).Run("/nethome/marmorri/DASH/micro","objectscript","","Q*",iterations, verbose)

	do ##class(WriteResults).WriteResults()

	kill ^%zDashResults
}

}