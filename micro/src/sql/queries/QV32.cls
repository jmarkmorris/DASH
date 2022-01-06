Class DASH.Benchmark 
{

ClassMethod micro() As %Float [ Language = objectscript ]
{
	
	set start = $zh
	for i=1:1:64000 {
		if (0=(i#128)) {
			set $bit(m128s,i)=0
		} else {
			set $bit(m128s,i)=1
		}
	}
	set elapsed = $zh - start

	return elapsed
}

}
