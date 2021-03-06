Class DASH.Benchmark 
{

// Write !,"micro11 - $query for (x,1,1) for every x of 3-dimensional global, random walk"
ClassMethod micro() As %Float [ Language = objectscript ]
{
        set entries = 10000000
	// ^bench3D is a 3-dimensional global, with default 10M entries in the 1st level.
	// Each 1st-level entry has 0-3 children, each of which has 0 or 1 child.
	// Every data node is a valid id for a 1st level entry.
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

        set start = $zh
	set x = ^bench3D(1)
	for i=1:1:entries {
		set loc = $query(^bench3D(x,1,1),1,x)
	}
        set elapsed = $zh - start

	kill x
	kill ^bench3D
	kill entries

	return elapsed
}

}
