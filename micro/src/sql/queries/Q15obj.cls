Class DASH.Benchmark 
{

// Write !,"micro15 - test"
ClassMethod micro() As %Float [ Language = objectscript ]
{
	set start = $zh
	set elapsed = $zh - start

	return elapsed
}

}

