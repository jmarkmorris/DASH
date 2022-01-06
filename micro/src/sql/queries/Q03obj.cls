Class DASH.Benchmark 
{

// Write !,"micro3 - sum loop "
ClassMethod micro() As %Float [ Language = objectscript ]
{
        set entries = 10000000
        // ^bench is a global with data nodes that are keys for other entries. Reading the chain will jump around randomly.
        kill ^bench
        for i=1:1:entries {
                set ^bench(i) = $random(entries) + 1
        }

        set start = $zh
	set x = 0
        for i=1:1:entries {
		set x = x + 1
        }
        set elapsed = $zh - start

        kill ^bench
        kill entries
        kill x

	return elapsed
}

}
