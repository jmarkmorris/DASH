Class DASH.Benchmark 
{

// Write !,"micro12 - calculate the "_fibonacci_"th Fibonacci Number, recursive"
ClassMethod micro() As %Float [ Language = objectscript ]
{
	set fibonacci = 10
        set start = $zh
	for i=1:1:400000 {
		set num = ##class(DASH.Benchmark).FibonacciObj(fibonacci)
	}
        set elapsed = $zh - start

        kill fibonacci
        kill num

	return elapsed
}

ClassMethod FibonacciObj(n As %Integer) As %Integer [ Language = objectscript ]
{
	if n < 0 {
		write !,"Invalid input to FibonacciObj: n = "_num
		return -1
	}

	if n = 0 {
		return 0
	}

	if (n = 1) || (n = 2) {
		return 1
	} else {
		return ##class(DASH.Benchmark).FibonacciObj(n-1) + ##class(DASH.Benchmark).FibonacciObj(n-2)
	}
}

}
