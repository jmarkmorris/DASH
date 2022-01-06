Class DASH.Benchmark 
{

// Write !,"micro7 - randomized set in 1-dimensional global"
ClassMethod micro() As %Float [ Language = python ]
{
	import iris
	import random
	import time

	entries = 10000000
	iris.cls('DASH.Benchmark').microinit(entries)
	g = iris.gref('^bench')
	gSet = iris.gref('^benchSet')
	start = time.monotonic()
	x = g[1]
	for i in range(entries):
		gSet.set([random.randint(0,entries)],1)
	elapsed = time.monotonic() - start
	gSet.kill([None])
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
