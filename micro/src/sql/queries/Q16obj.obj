Class DASH.Benchmark 
{

ClassMethod micro() As %Float [ Language = objectscript ]
{

	set entries = 50000
	// Add keys to the array
	for i = 1:1:entries {
		set data("cat"_i) = i
		set data("ca"_i) = i
		set data("c"_i) = i
	}

        set start = $zh
	set sum = 0
	for i = 1:1:10000000 {
		set sum = sum + data("cat"_($random(entries)+1))
		set sum = sum + data("ca"_($random(entries)+1))
		set sum = sum + data("c"_($random(entries)+1))
	}
        set elapsed = $zh - start

	kill entries
	kill data
	kill sum

	return elapsed
}

}
