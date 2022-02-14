Class RunDASH extends DASH.Utils
{



ClassMethod RunDASH(serverfarm As %String = "", iterations As %String = "5", verbose As %Boolean = 1) As %Status
{
  set server = ##class(%SYS.System).GetNodeName(1)
  set servernum = $REPLACE(server, serverfarm, "")
   
  if (servernum = 3) {do ##class(RunTPCH).RunTPCH(iterations, verbose)}
  if (servernum = 5) {do ##class(RunNYTaxi).RunNYTaxi(iterations, verbose)}
  //if (servernum = 6) {do ##class(DASH.Utils).RunLoads(iterations, verbose)}
  //if (servernum = 8) {do ##class(DASH.Utils).RunSelectivity(iterations, verbose)}

  
}

}