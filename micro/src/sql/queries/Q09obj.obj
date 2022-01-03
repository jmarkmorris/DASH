Class DASH.Benchmark 
{

// Write !,"micro9 - $order ascending through 3-dimensional global"
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

	set x = ""
	for i=1:1:entries {
		set x = $o(^bench3D(x),1,data)
	}
	set elapsed = $zh - start

	kill x
	kill ^bench3D
	kill entries

	return elapsed
}

}
