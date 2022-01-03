Class DASH.Benchmark 
{

// Write !,"micro10 - $query for (x,1,1) for every x of 3-dimensional global, in order"
ClassMethod micro() As %Float [ Language = python ]
{
	import iris
	import time

	entries = 10000000
	iris.cls('DASH.Benchmark').microinit(entries)
	g3D = iris.gref('^bench3D')
	start = time.monotonic()
	x = g3D[1]
	for i in range(entries):
		for (loc, val) in g3D.query([i,1,1]):
			break 		# only access the first result
	elapsed = time.monotonic() - start
	return elapsed
}

ClassMethod microinit(entries As %Integer) [ Language = objectscript ]
{
	// ^bench is a global with data nodes that are keys for other entries. Reading the chain will jump around randomly
	kill ^bench3D
	for i=1:1:entries {
		set ^bench3D(i) = $random(entries) + 1
		// between 0 and 3 children
		for j=1:1:$random(4) {
			set ^bench3D(i,j) = $random(entries + 1)

			// between 0 and 1 children
			for k=1:1:$random(2) {
				set ^bench3D(i,j,k) = $random(entries + 1)
			}
		}

	}

}


}
