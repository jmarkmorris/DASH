Class DASH.Benchmark 
{

// Write !,"micro3 - sum loop "
ClassMethod micro() As %Float [ Language = python ]
{
	import iris
	import time

	entries = 10000000
	iris.cls('DASH.Benchmark').microinit(entries)
	g = iris.gref('^bench')
	start = time.monotonic()
	x = 0
	for i in range(entries):
		x = x + 1
	elapsed = time.monotonic() - start
	return elapsed
}

ClassMethod microinit(entries As %Integer) [ Language = objectscript ]
{
	// ^bench is a global with data nodes that are keys for other entries. Reading the chain will jump around randomly
	kill ^bench
	for i=1:1:entries {
		set ^bench(i) = $random(entries) + 1
	}

}


}
