Class DASH.Benchmark 
{

ClassMethod micro() As %Float [ Language = python ]
{
	import random
	import time
	data = {}

	entries = 50000
	# Add keys to the array
	for i in range(entries):
		data["cat" + str(i)] = i
		data["ca" + str(i)] = i
		data["c" + str(i)] = i

	start = time.monotonic()
	sum = 0
	for i in range(10000000):
		sum = sum + data["cat" + str(random.randint(0,entries-1))]
		sum = sum + data["ca" + str(random.randint(0,entries-1))]
		sum = sum + data["c" + str(random.randint(0,entries-1))]
	elapsed = time.monotonic() - start

	return elapsed

}

}
