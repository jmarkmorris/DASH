Class DASH.Benchmark 
{

ClassMethod micro() As %Float [ Language = objectscript ]
{
	
	set maxd64=$zh("7fffffffffffff")
	
	set start = $zh
	for i=1:1:64000 set $vector(v64d,i,"decimal")=(maxd64 - 1 - (i#100))
	set elapsed = $zh - start

	return elapsed
}

}
