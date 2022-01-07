Class DASH.Benchmark 
{

ClassMethod micro() As %Float [ Language = objectscript ]
{
	
	set maxd32=$zh("7fffff")
	
	set start = $zh
	for i=1:1:64000 set $vector(v32d,i,"decimal")=(maxd32 - 1 - (i#100))
	set elapsed = $zh - start

	return elapsed
}

}