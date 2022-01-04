Class DASH.Benchmark 
{

ClassMethod micro() As %Float [ Language = objectscript ]
{
	
	s alphabet="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	
	set start = $zh
	for i=1:1:64000 set $vector(vS,i,"string")=$EXTRACT(alphabet,(i#20))
	set elapsed = $zh - start

	return elapsed
}

}
