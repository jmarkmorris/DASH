Class DASH.Benchmark 
{

// Write !,"micro1 - randomized walk through 1-dimensional global"
ClassMethod micro() As %Float [ Language = python ]
{
	import iris
	import time

	entries = 10000000
	iris.cls('DASH.Benchmark').microinit(entries)
	g = iris.gref('^bench')
	start = time.monotonic()
	x = g[1]
	for i in range(entries):
		x = g[x]
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
