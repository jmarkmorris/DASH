Class DASH.Benchmark 
{

ClassMethod micro() As %Float [ Language = objectscript ]
{
	
	set start = $zh
	for i=1:1:64000 {
		set $bit(mhalf,i)=(i#2)
	}
	set elapsed = $zh - start

	return elapsed
}

}
