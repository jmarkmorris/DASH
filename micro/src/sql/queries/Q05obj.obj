Class DASH.Benchmark 
{

// Write !,"micro5 - call simple ObjectScript method"
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
		set status = ##class(DASH.Benchmark).AddObj()
	}
        set elapsed = $zh - start

        kill ^bench
        kill entries

	return elapsed
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
