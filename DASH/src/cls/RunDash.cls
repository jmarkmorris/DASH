Class RunDASH extends DASH.Utils
{



ClassMethod RunDASH(serverfarm As %String = "", iterations As %String = "5", verbose As %Boolean = 1) As %Status
{
  set server = ##class(%SYS.System).GetNodeName(1)
  set servernum = $REPLACE(server, serverfarm, "")
   
  if (servernum = 1) {do ##class(RunSelectivity).RunSelectivity(iterations,verbose,0,0)}
  if (servernum = 2) {do ##class(RunSelectivity).RunSelectivity(iterations,verbose,0,1)}
  if (servernum = 3) {do ##class(RunSelectivity).RunSelectivity(iterations,verbose,1,0)}
  if (servernum = 4) {do ##class(RunSelectivity).RunSelectivity(iterations,verbose,1,1)}
  if (servernum = 5) {do ##class(RunTPCH).RunTPCH(iterations, verbose)}
  if (servernum = 6) {do ##class(RunLoads).RunLoads(iterations, verbose)}
  if (servernum = 7) {do ##class(RunNYTaxi).RunNYTaxi(iterations, verbose)}
  //if (servernum = 8) {do ##class(DASH.Utils).RunSelectivity(iterations, verbose)}

  
}

}