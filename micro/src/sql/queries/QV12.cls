Class DASH.Benchmark 
{

ClassMethod micro() As %Float [ Language = objectscript ]
{
	for i=1:1:64000 {
		set $bit(mhalf,i)=(i#2)
		set $vector(v32,i,"integer")=$ZH("10000") + (i#100)
	}

	set start = $zh
	for j=1:1:100000 {set sum32=$vectorop("sum", v32, mhalf)}
	set elapsed = $zh - start

	return elapsed
}

}
