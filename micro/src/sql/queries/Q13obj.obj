Class DASH.Benchmark 
{

// Write !,"micro13 - calculate the "_fibonacci_"th Fibonacci Number, iterative"
ClassMethod micro() As %Float [ Language = objectscript ]
{
	set fibonacci = 91

        set start = $zh
	for i=1:1:400000 {
		set a = 0
		set b = 1
		for j=0:1:(fibonacci-1) {
			set prevA = a
			set a = b
			set b = prevA + b
		}
	}
        set elapsed = $zh - start

	kill fibonacci
	kill a
	kill ^b
	kill prevA

	return elapsed
}

}
