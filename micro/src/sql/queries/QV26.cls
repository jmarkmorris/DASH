Class DASH.Benchmark 
{

ClassMethod micro() As %Float [ Language = objectscript ]
{
	
	set start = $zh
	for i=1:1:64000 set $vector(vD,i,"double")=(0.1 + (i#100))
	set elapsed = $zh - start

	return elapsed
}

}
