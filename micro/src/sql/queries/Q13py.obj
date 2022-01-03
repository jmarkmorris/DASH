Class DASH.Benchmark 
{

// Write !,"micro13 - calculate the {fibonacci}th Fibonacci Number, iterative"
ClassMethod micro() As %Float [ Language = python ]
{
	import iris
	import time

	fibonacci = 91 
	start = time.monotonic()
	for i in range(400000):
		a, b = 0, 1
		for j in range(0, fibonacci):
			prevA = a
			a = b
			b = prevA + b
	elapsed = time.monotonic() - start
	return elapsed
}


}

