Class DASH.Benchmark 
{

ClassMethod micro() As %Float [ Language = objectscript ]
{
	set $bit(mone,32000)=1
	
	set start = $zh
	for j=1:1:100000 {set sum32=$vectorop("sum", v32,mone)}
	set elapsed = $zh - start

	return elapsed
}

}
