Class DASH.Benchmark 
{

ClassMethod micro() As %Float [ Language = objectscript ]
{
	
	set start = $zh
	for i=1:1:64000 set $vector(v64i,i,"integer")=$ZH("100000000") + (i#100)
	set elapsed = $zh - start

	return elapsed
}

}
