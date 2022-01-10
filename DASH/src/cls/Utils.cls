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

		// create a new database if requested
		if (database'="") {
			set variables("database") = database
			do ..RunSQL(path_"src"_separator_"sql"_separator_ddl_separator_"create-db.sql","create-db", .variables,,, .statement, /* DoPrepare As %Boolean : */ 1, /* DoExplain As %Boolean : */ 0)
		}

		do ..RunSQL(path_"src"_separator_"sql"_separator_"queries"_separator_"use-db.sql", "use-db", .variables,,, .statement, /* DoPrepare As %Boolean : */ 1, /* DoExplain As %Boolean : */ 0)
		
		kill ^DashResults // in this database
		
		set ^Schema.Global = schema  // How is schema used?
		set ^Scale.Global = scale
		set ^DDL.Global = ddl
		set ^Indices.Global = $SELECT(useindices:"INDICES", 'useindices:"NO INDICES")

		set (SequenceStart, StepStart) = $zh
		set variables("schema") = $s(schema="":"", 1:schema_".")
		do ..RunSQL(path_"src"_separator_"sql"_separator_ddl_separator_"drop-tables.sql","drop-tables", .variables, 1,, .statement, /* DoPrepare As %Boolean : */ 1, /* DoExplain As %Boolean : */ 0)
		set StepEnd = $zh
		set ^DashResults($i(^DashResults)) = "Dropping existing tables: "_$fn(StepEnd-StepStart,,2)_"s"

		set StepStart = StepEnd
		set sc = ..RunSQL(path_"src"_separator_"sql"_separator_ddl_separator_"create-tables.sql","create-tables", .variables,,, .statement, /* DoPrepare As %Boolean : */ 1, /* DoExplain As %Boolean : */ 0)
		quit:$$$ISERR(sc)
		set StepEnd = $zh
		set ^DashResults($i(^DashResults)) = "Creating new tables: "_$fn(StepEnd-StepStart,,2)_"s"

		
		if ddl="ddl-row-id" {
			set StepStart = StepEnd
			set sc = ..RunSQL(path_"src"_separator_"sql"_separator_ddl_separator_"swap-keys.sql","swap-keys", .variables,,, .statement, /* DoPrepare As %Boolean : */ 1, /* DoExplain As %Boolean : */ 0)
			quit:$$$ISERR(sc)
			set StepEnd = $zh
			set ^DashResults($i(^DashResults)) = "Transforming foreign keys: "_$fn(StepEnd-StepStart,,2)_"s"
		}
		
		set StepStart = StepEnd
		set sc = ..RunSQL(path_"src"_separator_"sql"_separator_ddl_separator_"create-keys.sql","create-keys", .variables,,, .statement, /* DoPrepare As %Boolean : */ 1, /* DoExplain As %Boolean : */ 0)
		quit:$$$ISERR(sc)
		set StepEnd = $zh
		set ^DashResults($i(^DashResults)) = "Creating keys: "_$fn(StepEnd-StepStart,,2)_"s"

		if useindices {
			set StepStart = StepEnd
			set sc = ..RunSQL(path_"src"_separator_"sql"_separator_ddl_separator_"create-indices.sql","create-indices", .variables,,, .statement, /* DoPrepare As %Boolean : */ 1, /* DoExplain As %Boolean : */ 0)
			quit:$$$ISERR(sc)
			set StepEnd = $zh
			set ^DashResults($i(^DashResults)) = "Building indices: "_$fn(StepEnd-StepStart,,2)_"s"
		}

		set StepStart = StepEnd
		set variables("data_dir") = path_"data"_separator_scale_separator
		set sc = ..RunSQL(path_"src"_separator_"sql"_separator_ddl_separator_"load-tables.sql","load-tables", .variables,,, .statement, /* DoPrepare As %Boolean : */ 1, /* DoExplain As %Boolean : */ 0)
		quit:$$$ISERR(sc)
		set StepEnd = $zh
		set ^DashResults($i(^DashResults)) = "Loading data: "_$fn(StepEnd-StepStart,,2)_"s"

		set StepStart = StepEnd
		set sc = ..RunSQL(path_"src"_separator_"sql"_separator_ddl_separator_"tune-tables.sql","tune-tables", .variables,,, .statement, /* DoPrepare As %Boolean : */ 1, /* DoExplain As %Boolean : */ 0)
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
	do ##class(%Monitor.System.LineByLine).Stop()	// turn off any concurrent MONLBL

	try {
		set separator = $s($$$isWINDOWS:"\",1:"/")
		set:$e(path,*)'=separator path = path_separator

		set:(database'="") variables("database") = database

		set variables("parasetting") = parasetting
		set InvokedFromNamespace = $znspace
		do ..RunSQL(path_"src"_separator_"sql"_separator_"queries"_separator_"use-db.sql", "use-db", .variables,1,, .statement, /* DoPrepare As %Boolean : */ 1, /* DoExplain As %Boolean : */ 0)

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
			} else { // BenchmarkType = "sql"
				set sc = ..RunSQL(path_"src"_separator_"sql"_separator_"queries"_separator_QueryID_".sql", QueryID, .variables,,, .statement, /* DoPrepare As %Boolean : */ 1, /* DoExplain As %Boolean : */ 1)
			}
			quit:$$$ISERR(sc)
			
			// A MONLBL is requested by specifying 0 iterations. 
			if ('iterations) {
				//write !, "Namespace = ", $znspace 
				do ##class(%Monitor.System.LineByLine).Stop()
				set status=$SYSTEM.SQL.Util.SetOption("CachedQuerySaveSource",1,.oldval) // retain source

				// set up MonLBL : metrics and %sqlcq* 
				set metrics=##class(%Monitor.System.LineByLine).GetMetrics(2) // 2=all metrics
				
				set RoutineList = $listbuild("%sqlcq*")
				set MetricsList = $listfromstring(metrics)
				// set status=##class(%Monitor.System.LineByLine).Start(RoutineList, "") /* default metrics */
				set status=##class(%Monitor.System.LineByLine).Start(RoutineList,MetricsList)
				set RoutineCount=##class(%Monitor.System.LineByLine).GetRoutineCount()
				write:verbose !,"MONLBL : monitoring ", $listlength(MetricsList), " metrics for ",RoutineCount, " %sqlcq* routines"
				set metrics=##class(%Monitor.System.LineByLine).GetMetrics(1) // 1=monitored 
				set elements=$length(metrics,",")

				//write:verbose !,"MONLBL : executing RunSQL"
				set sc = ..RunSQL(path_"src"_separator_"sql"_separator_"queries"_separator_QueryID_".sql", QueryID, .variables,,, .statement, /* DoPrepare As %Boolean : */ 0, /* DoExplain As %Boolean : */ 0)

				// pause MonLBL		
				do ##class(%Monitor.System.LineByLine).Pause()

				for MonitoredRoutine = 1:1:RoutineCount {
					// get MonLBL output for all routines
					set RoutineName=##class(%Monitor.System.LineByLine).GetRoutineName(MonitoredRoutine)
					
					set rset=##class(%ResultSet).%New("%Monitor.System.LineByLine:Result")
					do rset.%Execute(RoutineName)
					
					set line = 1
					while rset.%Next() {
						if (line = 1) { 
							write:verbose !,"RoutineName = ", RoutineName, !
							write "Line"
							for field=1:1:elements {
								write ",",$piece(metrics,",",field)
							}
						}
						set row=rset.GetData(1)
						
						write !,line 
						for field=1:1:elements {
							write ",",$list(row,field)
						}

						set atom="+"_line_"^"_RoutineName
						//write !, "atom =", atom
						write ",", $text(@atom)

						do $INCREMENT(line)
					}
					kill rset

					// ToDo -- Display a formatted limited set of metrics.  Line,Glorefs???,RtnLine,Time,TotalTime,Source
					// ToDo -- Display a detailed csv set of metrics. Well, we already have that.
					// ToDo -- Stage MONLBL results in the same place where the explains are written.
				}

				do ##class(%Monitor.System.LineByLine).Stop()

			}

			set:'$DATA(^Indices.Global) ^Indices.Global = ""
			set:'$DATA(^DDL.Global) ^DDL.Global = ""
			set:'$DATA(^Scale.Global) ^Scale.Global = ""
			set:(parasetting = "") parasetting = "autoparallel"

			if iterations {
				for j = 1:1:iterations {
				
					if (BenchmarkType="obj") {
						set elapsed = 0
						set StepStart = $zh
						set sc = ..RunObjScr(path_"src"_separator_"sql"_separator_"queries"_separator_QueryID_".cls", 1, .elapsed)
						set StepEnd = $zh
						if elapsed > 0 {
							set ^DashResults($i(^DashResults)) = ##class(%SYS.System).GetNodeName(1)_","_parasetting_","_^Indices.Global_","_^DDL.Global_","_QueryID_","_$fn(elapsed,,3)_","_$zv_","_^Scale.Global
						} else {
							set ^DashResults($i(^DashResults)) = ##class(%SYS.System).GetNodeName(1)_","_parasetting_","_^Indices.Global_","_^DDL.Global_","_QueryID_","_$fn(StepEnd-StepStart,,3)_","_$zv_","_^Scale.Global
						}
					} else {
						set StepStart = $zh
						set sc = ..RunSQL(path_"src"_separator_"sql"_separator_"queries"_separator_QueryID_".sql", QueryID, .variables,,, .statement, /* DoPrepare : */ 0, /* DoExplain As %Boolean : */ 0)
						set StepEnd = $zh
						set ^DashResults($i(^DashResults)) = ##class(%SYS.System).GetNodeName(1)_","_parasetting_","_^Indices.Global_","_^DDL.Global_","_QueryID_","_$fn(StepEnd-StepStart,,3)_","_$zv_","_^Scale.Global
					}				
					quit:$$$ISERR(sc)
				}
			}
		
        }

		//SET myfile = "/nethome/marmorri/benchmark/results/queued-results.csv"
		//OPEN myfile:("WEAS"):5 // time out limit of 5 seconds to avoid indefinite wait when myfile cannot be opened
		//USE myfile
			//write !, "server, para, indices, organization, query, run time, build, scale"
			//for i = 1:1:^DashResults {
			//	write !, ^DashResults(i)
			//}
		//CLOSE myfile

		if (verbose & iterations) {
			write !, "server, para, indices, organization, query, run time, build, scale"
			for i = 1:1:^DashResults {
				write !, ^DashResults(i)
				// write !, ##class(%SYS.System).GetNodeName(1),",",parasetting,","_^Indices.Global_",,",^DashResults(i),",",$zv
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

				set SQL(1) = $zstrip(SQL(1),"<>WC")
				set ts = $zh

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
					if (DoExplain) {
						set SaveSQL = SQL(1)
						set SQL(1) = "explain "_SaveSQL
						write:verbose !,"Explaining statement : ",SQL(1)
						
						//write:verbose !,"Before prepare : "
						set rs = statement.%Prepare(.SQL)
						//write:verbose !,"After prepare : "

						if ($System.Status.IsError(rs)) {
							write:verbose !,"FAILED : ",rs,!
							if 'IgnoreErrors {
								set sc = $$$ERROR($$$GeneralError, "Error preparing explain of statement: "_rs)
								write:verbose !,"Error preparing explain of statement. Returning.: "
								return sc
							}
						}
						//write:verbose !,"Before execute : "
						set rs = statement.%Execute()
						//write:verbose !,"After execute : "

						if (rs.%SQLCODE'=0) & (rs.%SQLCODE'=100) {
							write:verbose !,"FAILED : ",rs.%Message
							if 'IgnoreErrors {
								set sc = $$$ERROR($$$GeneralError, "Error running explain of statement: "_rs.%Message)
								return sc
							}
						} 
						do rs.%DisplayFormatted("CSV","explain"_ResultSetFile)				
						if (rs.%SQLCODE'=0) & (rs.%SQLCODE'=100) {
							write:verbose !,"FAILED: ",rs.%Message
							if 'IgnoreErrors {
								set sc = $$$ERROR($$$GeneralError, "Error displaying statement: "_rs.%Message)
								return sc
							}
						}
						set SQL(1) = SaveSQL
					}
				
					if (DoPrepare) {
						write:verbose !,"Preparing statement : ",SQL(1)
						set rs = statement.%Prepare(.SQL)
						if ($System.Status.IsError(rs)) {
							write:verbose !,"FAILED : ",rs
							if 'IgnoreErrors {
								set sc = $$$ERROR($$$GeneralError, "Error preparing statement: "_rs)
								return sc
							}
						}
						
					}					

					write:verbose !,"Executing statement : ",SQL(1)
					set rs = statement.%Execute()
					if (rs.%SQLCODE'=0) & (rs.%SQLCODE'=100) {
						write:verbose !,"FAILED : ",rs.%Message
						if 'IgnoreErrors {
							set sc = $$$ERROR($$$GeneralError, "Error running statement: "_rs.%Message)
							return sc
						}
					} 

					// ToDo: Decide whether to save all query results in files or only warmup results. Append or overwrite?
					// For some queries, execution is deferred until the Display occurs.
					do rs.%DisplayFormatted("CSV",ResultSetFile)				
					if (rs.%SQLCODE'=0) & (rs.%SQLCODE'=100) {
						write:verbose !,"FAILED: ",rs.%Message
						if 'IgnoreErrors {
							set sc = $$$ERROR($$$GeneralError, "Error displaying statement: "_rs.%Message)
							return sc
						}
					} else {
						write:verbose !,"SUCCESS (",$normalize($zh-ts,3),"s) " 
						write:verbose&&rs.%ROWCOUNT rs.%ROWCOUNT," rows affected"
					}

					set SQL(1) = ""
				}

			} else {				
				set SQL(1) = SQL(1)_$c(13,10)_line     // Add CR LF 
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
	set InvokedFromNamespace = $znspace

	set $namespace = "%SYS"
	s Obj=##Class(Config.config).Open()
	s Obj.MaxServers=64
	s Obj.MaxServerConn=64
	s Obj.globals8kb=193058
	s Obj.locksiz=128057344
	s Obj.gmheap=51200000
	s Obj.routines=1020
	s Obj.LargePagesRequired=1
	s Status=Obj.%Save()
	set status=$SYSTEM.SQL.Util.SetOption("CachedQuerySaveSource",1,.oldval) // retain source

	set $namespace =  InvokedFromNamespace

	quit $$$OK
}

}
