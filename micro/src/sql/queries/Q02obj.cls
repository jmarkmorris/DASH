Class DASH.Benchmark 
{

// Write !,"micro2 - $order ascending through 1-dimensional global"
ClassMethod micro() As %Float [ Language = objectscript ]
{
        set entries = 10000000
        // ^bench is a global with data nodes that are keys for other entries. Reading the chain will jump around randomly.
        kill ^bench
        for i=1:1:entries {
                set ^bench(i) = $random(entries) + 1
        }

        set start = $zh
	set x = ""
        for i=1:1:entries {
        	set x = $o(^bench(x)) 	
        }
        set elapsed = $zh - start

        kill ^bench
        kill entries
        kill x

        return elapsed
}

}
