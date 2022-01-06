Class DASH.Benchmark 
{

// Write !,"micro14 - create table, insert rows, drop table"
ClassMethod micro() As %Float [ Language = objectscript ]
{
	set tStatement = ##class(%SQL.Statement).%New()
	try {
		set qStatus = tStatement.%Prepare("DROP TABLE TT")
		set rset = tStatement.%Execute()
	} catch exc {
		Write !,"Drop did not succeed" 
	}

	try {
		set qStatus = tStatement.%Prepare("CREATE TABLE TT (num int)")
		set rset = tStatement.%Execute()
	} catch exc2 {
		Write !,"CT did not succeed:" 
	}
	
	set qStatus = tStatement.%Prepare("INSERT INTO TT select 1")
        set start = $zh
	for i = 1:1:50000 {
		set rset = tStatement.%Execute()
	}
	set elapsed = $zh - start

	try {
		set qStatus = tStatement.%Prepare("DROP TABLE TT")
		set rset = tStatement.%Execute()
	} catch exc {
		Write !,"Drop did not succeed" 
	}

	kill rset
	kill qStatus
	kill tStatement

	return elapsed
}

}

