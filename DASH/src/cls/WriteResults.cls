Class WriteResults extends DASH.Utils 
{

ClassMethod WriteResults() As %Status
{
	
	
	SET myfile = "/nethome/marmorri/DASHBOARD/data/"_$CHANGE($ZTS,",","-")
	OPEN myfile:("WEAS"):5 // time out limit of 5 seconds to avoid indefinite wait when myfile cannot be opened
	USE myfile
	
	#; if $FIND(QueryID,"IS",1) {
	#; 	write !, "server, para, indices, organization, sel org, sel idx, table, ins org, ins idx, run time, build, scale, date, $zh, test"
	#; } else {
	#; 	if (database = "SelectivityTest") {
	#; 		write !, "server, para, indices, organization, x, y, z, run time, build, scale, date, $zh, test"
	#; 	} else {
	#; 		write !, "server, para, indices, organization, query, run time, build, scale, date, $zh, test"
	#; 	}
	#; }
	
	Set rgkey = $Order(^%zDashResults(""))
 	While (rgkey '= "") {
		for i = 1:1:^%zDashResults(rgkey) { write !, ^%zDashResults(rgkey,i) }
		// Find next node
		Set rgkey = $Order(^%zDashResults(rgkey))
 	}	
	CLOSE myfile

}

}