Class DASH.Benchmark 
{

ClassMethod micro() As %Float [ Language = objectscript ]
{
	for i=1:1:64000 {
		set $bit(mhalf,i)=(i#2)
		set $vector(v64,i,"integer")=$ZH("100000000") + (i#100)
	}
	
	set start = $zh
	for j=1:1:100000 {set sum64=$vectorop("sum", v64, mhalf)}
	set elapsed = $zh - start

	return elapsed
}

}
