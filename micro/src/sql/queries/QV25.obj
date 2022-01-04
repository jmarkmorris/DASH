Class DASH.Benchmark 
{

ClassMethod micro() As %Float [ Language = objectscript ]
{
	
	set maxd96=9223372036854775807e127
	
	set start = $zh
	for i=1:1:64000 set $vector(v96d,i,"decimal")=(maxd96 - 1 - (i#100))
	set elapsed = $zh - start

	return elapsed
}

}
