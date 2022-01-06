Class DASH.Benchmark 
{

// Write !,"micro7 - randomized set in 1-dimensional global"
ClassMethod micro() As %Float [ Language = objectscript ]
{
        set entries = 10000000
        // ^bench is a global with data nodes that are keys for other entries. Reading the chain will jump around randomly.
        kill ^bench
        set ^bench = entries
        for i=1:1:entries {
                set ^bench(i) = $random(entries) + 1
        }

        set start = $zh
	for i=1:1:entries {
		set ^benchSet($random(^bench)) = 1
	}
        set elapsed = $zh - start

	kill ^benchSet
        kill ^bench
        kill entries

	return elapsed
}

}
