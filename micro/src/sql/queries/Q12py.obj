Class DASH.Benchmark 
{

// Write !,"micro12 - calculate the {fibonacci}th Fibonacci Number"
ClassMethod micro() As %Float [ Language = python ]
{
	import iris
	import time

	fibonacci = 10
	start = time.monotonic()
	for i in range(400000):
		num = iris.cls('DASH.Benchmark').FibonacciPy(fibonacci)
	elapsed = time.monotonic() - start
	return elapsed
}


ClassMethod FibonacciPy(n As %Integer) As %Integer [Language = python]
{
	import iris
	if n < 0:
		print(f'Invalid input to FibonacciPy: n = {n}')
		return -1

	if n == 0:
		return 0

	if ((n == 1) or (n == 2)):
		return 1
	else:
		return iris.cls('DASH.Benchmark').FibonacciPy(n-1) + iris.cls('DASH.Benchmark').FibonacciPy(n-2)
}

}


