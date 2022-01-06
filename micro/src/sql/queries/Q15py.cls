Class DASH.Benchmark 
{

// Write !,"micro15 - test"
ClassMethod micro() As %Float [ Language = python ]
{
	import time
	start = time.monotonic()
	elapsed = time.monotonic() - start
	return elapsed
}

}
