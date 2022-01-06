Class DASH.Benchmark 
{

// Write !,"micro4 - call simple Python method"
ClassMethod micro() As %Float [ Language = python ]
{
	import iris
	import time

	entries = 10000000
	iris.cls('DASH.Benchmark').microinit(entries)
	g = iris.gref('^bench')
	start = time.monotonic()
	for i in range(entries):
		status = iris.cls('DASH.Benchmark').AddPy()
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


ClassMethod AddPy() As %Status [ Language = python ]
{
	a, b = 5, 7
	c = a + b
	return c
}

ClassMethod AddObj() As %Status [ Language = objectscript ]
{
	set a = 5
	set b = 7
	set c = a + b
	return c
}

}
