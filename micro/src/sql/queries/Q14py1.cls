Class DASH.Benchmark 
{

// Write !,"micro14 - create table, insert rows, drop table"
ClassMethod micro() As %Float [ Language = python ]
{
	import iris
	import time
	import itertools
	try:
		rs = iris.sql.exec("DROP TABLE TT")
	except:
		pass
	finally:
		rs = iris.sql.exec("CREATE TABLE TT (num int)")
		start = time.monotonic()
		for i in itertools.repeat(None, 50000):
			rs = iris.sql.exec("INSERT INTO TT select 1")
		elapsed = time.monotonic() - start
		rs = iris.sql.exec("DROP TABLE TT")
		return elapsed

}

}

