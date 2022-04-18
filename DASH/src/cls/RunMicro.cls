Class RunMicro extends DASH.Utils 
{

ClassMethod RunMicro(iterations As %String = "5", verbose As %Boolean = 1) As %Status
{
	
	kill ^%zDashResults

	set repo = "/nethome/marmorri/DASH/"


	do ##class(DASH.Utils).Run(repo_"/micro","objectscript","","Q*",iterations, verbose)

	do ##class(WriteResults).WriteResults()

	kill ^%zDashResults
}

}