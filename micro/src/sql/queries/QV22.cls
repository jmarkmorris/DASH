Class DASH.Benchmark 
{

ClassMethod micro() As %Float [ Language = objectscript ]
{
	
	set maxd16=127
	
	set start = $zh
	for i=1:1:64000 set $vector(v16d,i,"decimal")=(maxd16 - 1 - (i#100))
	set elapsed = $zh - start

	return elapsed
}

}
