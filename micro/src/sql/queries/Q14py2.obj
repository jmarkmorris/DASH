Class DASH.Benchmark 
{

// Write !,"micro14 - create table, insert rows, drop table"
ClassMethod micro() As %Float [ Language = python ]
{
	import iris
	import time
	import itertools
	try:
		stmt  = iris.sql.prepare("DROP TABLE TT")
		rs = stmt.execute()
	except:
		pass
	finally:
		stmt = iris.sql.prepare("CREATE TABLE TT (num int)")
		rs = stmt.execute()
		start = time.monotonic()
		for i in itertools.repeat(None, 50000):
			stmt = iris.sql.prepare("INSERT INTO TT select 1")
			rs = stmt.execute()
		elapsed = time.monotonic() - start

		stmt  = iris.sql.prepare("DROP TABLE TT")
		rs = stmt.execute()
		return elapsed
}

}

