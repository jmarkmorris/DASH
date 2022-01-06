Class DASH.Utils
{

ClassMethod Load(path As %String = "", database As %String = "", schema As %String = "", scale As %String = "100", ddl As %String = "ddl-row", useindices As %Boolean = 1, verbose As %Boolean = 1) As %Status [ SqlName = Load, SqlProc ]
{
	set sc = $$$OK
	set statement = ##class(%SQL.Statement).%New()  // default dialect is IRIS
	set statement.%SelectMode = 1 // 1=ODBC
	set InvokedFromNamespace = $znspace
	try {
		set separator = $s($$$isWINDOWS:"\",1:"/")
		set:$e(path,*)'=separator path = path_separator
		set DoPrepare = 1
		set DontExplain = 0

		// create a new database if requested
		if (database'="") {
			set variables("database") = database
			do ..RunSQL(path_"src"_separator_"sql"_separator_ddl_separator_"create-db.sql","create-db", .variables,,, .statement, DoPrepare, DontExplain)
		}

		do ..RunSQL(path_"src"_separator_"sql"_separator_"queries"_separator_"use-db.sql", "use-db", .variables,,, .statement, DoPrepare, DontExplain)
		
		kill ^DashResults // in this database
		
		set ^SchemaGlobal = schema  // Why do we need schema?
		set ^ScaleGlobal = scale
		if useindices {set ^IndicesGlobal = "INDICES"} else {set ^IndicesGlobal = "NO INDICES"}

		set (SequenceStart, StepStart) = $zh
		set variables("schema") = $s(schema="":"", 1:schema_".")
		do ..RunSQL(path_"src"_separator_"sql"_separator_ddl_separator_"drop-tables.sql","drop-tables", .variables, 1,, .statement, DoPrepare, DontExplain)
		set StepEnd = $zh
		set ^DashResults($i(^DashResults)) = "Dropping existing tables: "_$fn(StepEnd-StepStart,,2)_"s"

		set StepStart = StepEnd
		set sc = ..RunSQL(path_"src"_separator_"sql"_separator_ddl_separator_"create-tables.sql","create-tables", .variables,,, .statement, DoPrepare, DontExplain)
		quit:$$$ISERR(sc)
		set StepEnd = $zh
		set ^DashResults($i(^DashResults)) = "Creating new tables: "_$fn(StepEnd-StepStart,,2)_"s"

		
		if ddl="ddl-row-id" {
			set StepStart = StepEnd
			set sc = ..RunSQL(path_"src"_separator_"sql"_separator_ddl_separator_"swap-keys.sql","swap-keys", .variables,,, .statement, DoPrepare, DontExplain)
			quit:$$$ISERR(sc)
			set StepEnd = $zh
			set ^DashResults($i(^DashResults)) = "Transforming foreign keys: "_$fn(StepEnd-StepStart,,2)_"s"
		}
		
		set StepStart = StepEnd
		set sc = ..RunSQL(path_"src"_separator_"sql"_separator_ddl_separator_"create-keys.sql","create-keys", .variables,,, .statement, DoPrepare, DontExplain)
		quit:$$$ISERR(sc)
		set StepEnd = $zh
		set ^DashResults($i(^DashResults)) = "Creating keys: "_$fn(StepEnd-StepStart,,2)_"s"

		if useindices {
			set StepStart = StepEnd
			set sc = ..RunSQL(path_"src"_separator_"sql"_separator_ddl_separator_"create-indices.sql","create-indices", .variables,,, .statement, DoPrepare, DontExplain)
			quit:$$$ISERR(sc)
			set StepEnd = $zh
			set ^DashResults($i(^DashResults)) = "Building indices: "_$fn(StepEnd-StepStart,,2)_"s"
		}

		set StepStart = StepEnd
		set variables("data_dir") = path_"data"_separator_scale_separator
		set sc = ..RunSQL(path_"src"_separator_"sql"_separator_ddl_separator_"load-tables.sql","load-tables", .variables,,, .statement, DoPrepare, DontExplain)
		quit:$$$ISERR(sc)
		set StepEnd = $zh
		set ^DashResults($i(^DashResults)) = "Loading data: "_$fn(StepEnd-StepStart,,2)_"s"

		set StepStart = StepEnd
		set sc = ..RunSQL(path_"src"_separator_"sql"_separator_ddl_separator_"tune-tables.sql","tune-tables", .variables,,, .statement, DoPrepare, DontExplain)
		quit:$$$ISERR(sc)
		set StepEnd = $zh
		set ^DashResults($i(^DashResults)) = "Tune tables: "_$fn(StepEnd-StepStart,,2)_"s"


		if verbose {
			write !,"Total time spent: "_$fn(StepEnd-SequenceStart,,2)_"s"
			for i = 1:1:^DashResults {
				write !,"  - ",^DashResults(i)
			}
		}

	} catch (ex) {
		set sc = ex.AsStatus()
        write:verbose !,"Unexpected error: ",$system.Status.GetOneErrorText(sc)
	}
	write:verbose !
	kill statement
	set $namespace =  InvokedFromNamespace
	quit sc
}

ClassMethod Run(path As %String = "", database As %String = "", parasetting As %String = "", query As %String = "all", iterations As %String = "5", verbose As %Boolean = 1) As %Status
{
	set sc = $$$OK
	set statement = ##class(%SQL.Statement).%New()  // default dialect is IRIS
	set statement.%SelectMode = 1 // 1=ODBC
	set DoPrepare = 1
	set DontPrepare = 0
	set DontExplain = 0
	set DoExplain = 1

	try {
		set separator = $s($$$isWINDOWS:"\",1:"/")
		set:$e(path,*)'=separator path = path_separator

		if (database'="") {
			set variables("database") = database
		}
		set variables("parasetting") = parasetting
		set InvokedFromNamespace = $znspace
		do ..RunSQL(path_"src"_separator_"sql"_separator_"queries"_separator_"use-db.sql", "use-db", .variables,1,, .statement, DoPrepare, DontExplain)

		kill ^DashResults // in this database

		set ListDirStatement = ##class(%SQL.Statement).%New()
    	set status = ListDirStatement.%PrepareClassQuery("%File", "FileSet")
    
    	if $$$ISERR(status) { 
        	do $system.OBJ.DisplayError(status)
        	quit  
    	}
    
		// match all Q* files in the directory, regardless of their extension.
		// set ResultSet = ListDirStatement.%Execute(path_"src"_separator_"sql"_separator_"queries"_separator, "Q*", "Name") 
		set ResultSet = ListDirStatement.%Execute(path_"src"_separator_"sql"_separator_"queries"_separator, query, "Name") 

    	while ResultSet.%Next() {
        	set QueryID = ResultSet.%Get("ItemName")

			// Need to handle variable extensions here.
			if $FIND(QueryID,".sql") {
				set QueryID = $REPLACE(QueryID,".sql","")
				set BenchmarkType = "sql"
			} elseif $FIND(QueryID,".cls") {
				set QueryID = $REPLACE(QueryID,".cls","")
				set BenchmarkType = "obj"
			} else {
				// DASH doesn't support this BenchmarkType.
				continue
			}
		
			// Always do a warmup query. It is not recorded.
			// For SQL warmups also save the explain to a file.
			if (BenchmarkType="obj") {
				set elapsed = 0
				set sc = ..RunObjScr(path_"src"_separator_"sql"_separator_"queries"_separator_QueryID_".cls", 1, .elapsed)
			} else {
				set sc = ..RunSQL(path_"src"_separator_"sql"_separator_"queries"_separator_QueryID_".sql", QueryID, .variables,,, .statement, DoPrepare, DoExplain)
			}
			quit:$$$ISERR(sc)

			if '$DATA(^IndicesGlobal) {set ^IndicesGlobal = ""}
			for j = 1:1:iterations {
				
				if (BenchmarkType="obj") {
					set elapsed = 0
					set StepStart = $zh
					set sc = ..RunObjScr(path_"src"_separator_"sql"_separator_"queries"_separator_QueryID_".cls", 1, .elapsed)
					set StepEnd = $zh
					if elapsed > 0 {
						set ^DashResults($i(^DashResults)) = ##class(%SYS.System).GetNodeName(1)_","_parasetting_","_^IndicesGlobal_",,"_QueryID_","_$fn(elapsed,,3)_","_$zv
						// set ^DashResults($i(^DashResults)) = QueryID_","_$fn(elapsed,,3)
					} else {
						set ^DashResults($i(^DashResults)) = ##class(%SYS.System).GetNodeName(1)_","_parasetting_","_^IndicesGlobal_",,"_QueryID_","_$fn(StepEnd-StepStart,,3)_","_$zv
						// set ^DashResults($i(^DashResults)) = QueryID_","_$fn(StepEnd-StepStart,,3)
					}
				} else {
					set StepStart = $zh
					set sc = ..RunSQL(path_"src"_separator_"sql"_separator_"queries"_separator_QueryID_".sql", QueryID, .variables,,, .statement, DontPrepare, DontExplain)
					set StepEnd = $zh
					set ^DashResults($i(^DashResults)) = ##class(%SYS.System).GetNodeName(1)_","_parasetting_","_^IndicesGlobal_",,"_QueryID_","_$fn(StepEnd-StepStart,,3)_","_$zv
					// set ^DashResults($i(^DashResults)) = QueryID_","_$fn(StepEnd-StepStart,,3)
				}				
				quit:$$$ISERR(sc)
		
			}
		
        }

		// things to add : scale, organization
		//SET myfile = "/nethome/marmorri/benchmark/results/queued-results.csv"
		//OPEN myfile:("WEAS"):5 // add a time out limit of 5 seconds to avoid indefinite wait when myfile cannot be opened
		//USE myfile
			//for i = 1:1:^DashResults {
			//	write !, ^DashResults(i)
			//	write ##class(%SYS.System).GetNodeName(1),",",parasetting,","_^IndicesGlobal_",,",^DashResults(i),",",$zv,!
			//}
		//CLOSE myfile

		if verbose {
			for i = 1:1:^DashResults {
				write !, ^DashResults(i)
				// write !, ##class(%SYS.System).GetNodeName(1),",",parasetting,","_^IndicesGlobal_",,",^DashResults(i),",",$zv
			}
		}
		

	} catch (ex) {
		set sc = ex.AsStatus()
        write:verbose !,"Unexpected error: ",$system.Status.GetOneErrorText(sc)
	}
	write:verbose !
	kill statement
	set $namespace =  InvokedFromNamespace
	quit sc
}

ClassMethod RunSQL(file As %String, ResultSetFile As %String, ByRef replace As %String, IgnoreErrors As %Boolean = 0, verbose As %Boolean = 1, ByRef statement, DoPrepare As %Boolean = 1, DoExplain As %Boolean = 0) As %Status
{
    write !, "RunSQL ", file
	set sc = $$$OK
    try {
        set sep = $s($$$isWINDOWS:"\",1:"/")
        
        //write:verbose !,$piece(file,sep,*)," : "

        set stream = ##class(%Stream.FileCharacter).%New()
        set sc = stream.LinkToFile(file)
        quit:$$$ISERR(sc)

		
        set SQL = 1
        set SQL(1) = ""
        

        while 'stream.AtEnd {
            set line = $zstrip(stream.ReadLine(),">WC")
            continue:line=""
            continue:$e(line,1,2)="--" // skip comment lines

			// somewhat blunt comment section skipping
			if $zstrip(line,"<WC") = "/*" {
				while 'stream.AtEnd {
					set line = $zstrip(stream.ReadLine(),"<>WC")
					quit:line="*/"
				}
				continue
			}

			// somewhat blunt statement termination
			if $zstrip(line,"<WC") = ";" {

				// replace constants
				set str = ""
				for {
					set str = $order(replace(str),1,rep)
					quit:str=""
					set SQL(1) = $replace(SQL(1),"${"_str_"}",rep)
				}

				set SQL(1) = $zstrip(SQL(1),"<>WC"), ts = $zh
				//write !,"SQL read from file : ", SQL(1)

				if ($find(SQL(1), "VIEW") || $find(SQL(1), "view")) { 
					// TO DO add error handling
					//write !, "preparing and executing statement with a VIEW"
					set DDLstatement = ##class(%SQL.Statement).%New()  // default dialect is IRIS
					set DDLstatement.%SelectMode = 1 // 1=ODBC
					set rs = DDLstatement.%Prepare(.SQL)
					set rs = DDLstatement.%Execute()
					kill DDLstatement
					set SQL(1) = ""
				} else {
					//write !, "About to check if Explain flag is set"
					if (DoExplain)
					{
						set SaveSQL = SQL(1)
						set SQL(1) = "explain "_SaveSQL
						write:verbose !,"Explaining statement : ",SQL(1)
						
						//write:verbose !,"Before prepare : "
						set rs = statement.%Prepare(.SQL)
						//write:verbose !,"After prepare : "

						if ($System.Status.IsError(rs)) 
						{
							write:verbose !,"FAILED : ",rs,!
							if 'IgnoreErrors {
								set sc = $$$ERROR($$$GeneralError, "Error preparing explain of statement: "_rs)
								write:verbose !,"Error preparing explain of statement. Returning.: "
								Return sc
							}
						}
						//write:verbose !,"Before execute : "
						set rs = statement.%Execute()
						//write:verbose !,"After execute : "

						if (rs.%SQLCODE'=0) & (rs.%SQLCODE'=100) {
							write:verbose !,"FAILED : ",rs.%Message
							if 'IgnoreErrors {
								set sc = $$$ERROR($$$GeneralError, "Error running explain of statement: "_rs.%Message)
								Return sc
							}
						} 
						do rs.%DisplayFormatted("CSV","explain"_ResultSetFile)				
						if (rs.%SQLCODE'=0) & (rs.%SQLCODE'=100) {
							write:verbose !,"FAILED: ",rs.%Message
							if 'IgnoreErrors {
								set sc = $$$ERROR($$$GeneralError, "Error displaying statement: "_rs.%Message)
								Return sc
							}
						}
						set SQL(1) = SaveSQL
					}
				
					if (DoPrepare)
					{
						write:verbose !,"Preparing statement : ",SQL(1)
						set rs = statement.%Prepare(.SQL)
						if ($System.Status.IsError(rs)) 
						{
							write:verbose !,"FAILED : ",rs
							if 'IgnoreErrors {
								set sc = $$$ERROR($$$GeneralError, "Error preparing statement: "_rs)
								Return sc
							}
						}
						
					}
					write:verbose !,"Executing statement : ",SQL(1)
					set rs = statement.%Execute()
					if (rs.%SQLCODE'=0) & (rs.%SQLCODE'=100) {
						write:verbose !,"FAILED : ",rs.%Message
						if 'IgnoreErrors {
							set sc = $$$ERROR($$$GeneralError, "Error running statement: "_rs.%Message)
							Return sc
						}
					} 
					// area for improvement. do I keep saving results files over on top of each other? Or do I only save the warmup results?
					// if so, how to I ensure that the performance run results are displayed in the most efficient null way possible?
					do rs.%DisplayFormatted("CSV",ResultSetFile)				
					if (rs.%SQLCODE'=0) & (rs.%SQLCODE'=100) {
						write:verbose !,"FAILED: ",rs.%Message
						if 'IgnoreErrors {
							set sc = $$$ERROR($$$GeneralError, "Error displaying statement: "_rs.%Message)
							Return sc
						}
					} else {
						write:verbose !,"SUCCESS (",$normalize($zh-ts,3),"s) " 
						write:verbose&&rs.%ROWCOUNT rs.%ROWCOUNT," rows affected"
					}

					set SQL(1) = ""
				}

			} else {
				// this is adding CR LF 
				set SQL(1) = SQL(1)_$c(13,10)_line
			}

        }

		if $zstrip(SQL(1),"<>WC")'="" {
			write:verbose !,"leftover statement not executed: ",!,SQL(1)
		}
        
    } catch (ex) {
        set sc = ex.AsStatus()
        write:verbose !,"Unexpected error: ",$system.Status.GetOneErrorText(sc)
    }
	write:verbose !
    quit sc
}

ClassMethod RunObjScr(file As %String, verbose As %Boolean = 1, ByRef elapsed As %Float = 0.0) As %Status
{
    write !, "RunObjScr ", file
	set sc = $$$OK
    try {
        
        do $SYSTEM.OBJ.Load(file,"cuk")  
		//write !,"before executing micro from file : "_file
        set elapsed = ##class(DASH.Benchmark).micro()
        //write !,"after executing micro"
		do $SYSTEM.OBJ.Delete("DASH.Benchmark") 

    } catch (ex) {
		write !,"in catch block. ex = "_ex
        set sc = ex.AsStatus()
		write !,"sc = ", sc
		write !,"ZE = ", $ZE
        write:verbose !,"Unexpected error: ",$system.Status.GetOneErrorText(sc)
    }
	//write !,"after catch block"

	write:verbose !
    quit sc

}



ClassMethod Tune() As %Integer [ Language = objectscript ]
{
	zn "%SYS"
	s Obj=##Class(Config.config).Open()
	s Obj.MaxServers=64
	s Obj.MaxServerConn=64
	s Obj.globals8kb=193058
	s Obj.locksiz=128057344
	s Obj.gmheap=51200000
	s Obj.routines=1020
	s Obj.LargePagesRequired=1
	s Status=Obj.%Save()

	quit $$$OK
}

}
