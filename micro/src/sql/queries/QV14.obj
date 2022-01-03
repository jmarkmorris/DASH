Class DASH.Benchmark 
{

ClassMethod micro() As %Float [ Language = objectscript ]
{
	for i=1:1:64000 {
		set $bit(mall,i)=1
		set $vector(v8,i,"integer")=$ZH("0") + (i#100)
	}
	
	set start = $zh
	for j=1:1:100000 {set sum8=$vectorop("sum", v8, mall)} 
	set elapsed = $zh - start

	return elapsed
}

}
