Class DASH.Benchmark 
{

ClassMethod micro() As %Float [ Language = objectscript ]
{
	set $bit(mone,32000)=1
	
	set start = $zh
	for j=1:1:100000 {set sum8=$vectorop("sum", v8, mone)}
	set elapsed = $zh - start

	return elapsed
}

}
