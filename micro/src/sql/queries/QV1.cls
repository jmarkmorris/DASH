Class DASH.Benchmark 
{

ClassMethod micro() As %Float [ Language = objectscript ]
{

	set iters = 10000
	for i=1:1:64000 {
		set $vector(veca, i, "int") = $random(88)
		set $vector(vecb, i, "int") = $random(99)
	}
	
	set start = $zh
	for i=1:1:iters {
		set x = $vectorop("v*",veca,vecb)
	}
	set elapsed = $zh - start

	return elapsed
}

}
