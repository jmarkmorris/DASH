Class DASH.Utils Extends (%Persistent,%Populate) 
{

Property field1 As %Library.Binary;
Property field2 As %Library.Currency;
Property field3 As %Library.Date;
Property field4 As %Library.Decimal;
Property field5 As %Library.Double;
Property field6 As %Library.Integer;
Property field7 As %Library.Numeric;
Property field8 As %Library.String(MAXLEN = 20);
Property field9 As %Library.TimeStamp;


ClassMethod Load(path As %String = "", database As %String = "", schema As %String = "", scale As %String = "1", ddl As %String = "ddl-row", useindices As %Boolean = 1, verbose As %Boolean = 1, shardkey As %String = "", org As %String = "") As %Status [ SqlName = Load, SqlProc ]
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
				
		set ^Schema.Global = schema
		set ^Scale.Global = scale
		set ^DDL.Global = ddl
		set ^Indices.Global = $SELECT(useindices:"INDICES", 'useindices:"NO INDICES")

		set variables("schema") = $s(schema="":"", 1:schema_".")
		set variables("org") = org   // if this method is called with an org, then create dummy tables only and skip the load
		set variables("shardkey") = $s(shardkey="":"", 1:", shard key("_shardkey_")")


		set (SequenceStart, StepStart) = $zh
		do ..RunSQL(path_"src"_separator_"sql"_separator_ddl_separator_"drop-tables.sql","drop-tables", .variables, 1,, .statement, /* DoPrepare As %Boolean : */ 1, /* DoExplain As %Boolean : */ 0)
		set StepEnd = $zh
		set ^%zDashResults($i(^%zDashResults)) = ##class(%SYS.System).GetNodeName(1)_","_database_","_^Indices.Global_","_^DDL.Global_","_"drop tables"_","_$fn(StepEnd-StepStart,,3)_","_$zv_","_^Scale.Global_","_$ZDATE($HOROLOG)_","_$ZH_","_"Load"


		set StepStart = StepEnd
		set sc = ..RunSQL(path_"src"_separator_"sql"_separator_ddl_separator_"create-tables.sql","create-tables", .variables,,, .statement, /* DoPrepare As %Boolean : */ 1, /* DoExplain As %Boolean : */ 0)
		quit:$$$ISERR(sc)
		set StepEnd = $zh
		set ^%zDashResults($i(^%zDashResults)) = ##class(%SYS.System).GetNodeName(1)_","_database_","_^Indices.Global_","_^DDL.Global_","_"create tables"_","_$fn(StepEnd-StepStart,,3)_","_$zv_","_^Scale.Global_","_$ZDATE($HOROLOG)_","_$ZH_","_"Load"

		if ddl="ddl-row-id" {
			set StepStart = StepEnd
			set sc = ..RunSQL(path_"src"_separator_"sql"_separator_ddl_separator_"swap-keys.sql","swap-keys", .variables,,, .statement, /* DoPrepare As %Boolean : */ 1, /* DoExplain As %Boolean : */ 0)
			quit:$$$ISERR(sc)
			set StepEnd = $zh
			set ^%zDashResults($i(^%zDashResults)) = ##class(%SYS.System).GetNodeName(1)_","_database_","_^Indices.Global_","_^DDL.Global_","_"transform foreign keys"_","_$fn(StepEnd-StepStart,,3)_","_$zv_","_^Scale.Global_","_$ZDATE($HOROLOG)_","_$ZH_","_"Load"

		}
		
		set StepStart = StepEnd
		set sc = ..RunSQL(path_"src"_separator_"sql"_separator_ddl_separator_"create-keys.sql","create-keys", .variables,,, .statement, /* DoPrepare As %Boolean : */ 1, /* DoExplain As %Boolean : */ 0)
		quit:$$$ISERR(sc)
		set StepEnd = $zh
		set ^%zDashResults($i(^%zDashResults)) = ##class(%SYS.System).GetNodeName(1)_","_database_","_^Indices.Global_","_^DDL.Global_","_"create keys"_","_$fn(StepEnd-StepStart,,3)_","_$zv_","_^Scale.Global_","_$ZDATE($HOROLOG)_","_$ZH_","_"Load"


		if useindices {
			set StepStart = StepEnd
			set sc = ..RunSQL(path_"src"_separator_"sql"_separator_ddl_separator_"create-indices.sql","create-indices", .variables,,, .statement, /* DoPrepare As %Boolean : */ 1, /* DoExplain As %Boolean : */ 0)
			quit:$$$ISERR(sc)
			set StepEnd = $zh
			set ^%zDashResults($i(^%zDashResults)) = ##class(%SYS.System).GetNodeName(1)_","_database_","_^Indices.Global_","_^DDL.Global_","_"building indices"_","_$fn(StepEnd-StepStart,,3)_","_$zv_","_^Scale.Global_","_$ZDATE($HOROLOG)_","_$ZH_","_"Load"

		}

		if (org="") {
			set StepStart = StepEnd
			set variables("data_dir") = path_"data"_separator_scale_separator
			set sc = ..RunSQL(path_"src"_separator_"sql"_separator_ddl_separator_"load-tables.sql","load-tables", .variables,,, .statement, /* DoPrepare As %Boolean : */ 1, /* DoExplain As %Boolean : */ 0)
			quit:$$$ISERR(sc)
			set StepEnd = $zh
			set ^%zDashResults($i(^%zDashResults)) = ##class(%SYS.System).GetNodeName(1)_","_database_","_^Indices.Global_","_^DDL.Global_","_"load data"_","_$fn(StepEnd-StepStart,,3)_","_$zv_","_^Scale.Global_","_$ZDATE($HOROLOG)_","_$ZH_","_"Load"

			set StepStart = StepEnd
			set sc = ..RunSQL(path_"src"_separator_"sql"_separator_ddl_separator_"tune-tables.sql","tune-tables", .variables,,, .statement, /* DoPrepare As %Boolean : */ 1, /* DoExplain As %Boolean : */ 0)
			quit:$$$ISERR(sc)
			set StepEnd = $zh
			set ^%zDashResults($i(^%zDashResults)) = ##class(%SYS.System).GetNodeName(1)_","_database_","_^Indices.Global_","_^DDL.Global_","_"tune tables"_","_$fn(StepEnd-StepStart,,3)_","_$zv_","_^Scale.Global_","_$ZDATE($HOROLOG)_","_$ZH_","_"Load"
		}

		if verbose {
			write !, "server, benchmark, indices, organization, query, run time, build, scale, date, $zh, test"
			for i = 1:1:^%zDashResults {
				write !, ^%zDashResults(i)
			}
			// for i = 1:1:^%zDashResults {write !, ^%zDashResults(i)}
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

ClassMethod Run(path As %String = "", database As %String = "", parasetting As %String = "", query As %String = "Q*", iterations As %String = "5", verbose As %Boolean = 1, org As %String = "") As %Status
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
		set variables("org") = org
		set InvokedFromNamespace = $znspace
		do ..RunSQL(path_"src"_separator_"sql"_separator_"queries"_separator_"use-db.sql", "use-db", .variables,1,, .statement, /* DoPrepare As %Boolean : */ 1, /* DoExplain As %Boolean : */ 0)

		// kill ^%zDashResults

		set ListDirStatement = ##class(%SQL.Statement).%New()
    	set status = ListDirStatement.%PrepareClassQuery("%File", "FileSet")
    
    	if $$$ISERR(status) { 
        	do $system.OBJ.DisplayError(status)
        	quit  
    	}
    
		// match all query files in the directory, regardless of their extension.
		set ResultSet = ListDirStatement.%Execute(path_"src"_separator_"sql"_separator_"queries"_separator, query, "Name") 

    	while ResultSet.%Next() {
        	set QueryID = ResultSet.%Get("ItemName")

			// Handle variable extensions here.
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
				if $FIND(QueryID,"IS") {   // workaround because I-S explains are not yet supported 
					set sc = ..RunSQL(path_"src"_separator_"sql"_separator_"queries"_separator_QueryID_".sql", QueryID, .variables,,, .statement, /* DoPrepare As %Boolean : */ 1, /* DoExplain As %Boolean : */ 0)
				} else {
					set sc = ..RunSQL(path_"src"_separator_"sql"_separator_"queries"_separator_QueryID_".sql", QueryID, .variables,,, .statement, /* DoPrepare As %Boolean : */ 1, /* DoExplain As %Boolean : */ 1)
				}
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

				do ##class(%Monitor.System.LineByLine).Pause()

				for MonitoredRoutine = 1:1:RoutineCount {
					// get MonLBL output for all routines
					set RoutineName=##class(%Monitor.System.LineByLine).GetRoutineName(MonitoredRoutine)
					
					set MonitorResults=##class(%ResultSet).%New("%Monitor.System.LineByLine:Result")
					do MonitorResults.%Execute(RoutineName)
					
					// Display a formatted limited set of metrics.  Line,RtnLine,Time,TotalTime,SourceLine
					set line = 1
					set DetailFile = ""
					while MonitorResults.%Next() {
						if (line = 1) { 

							// Create file to store detailed MONLBL output
							set DetailFile = QueryID_RoutineName_".lbl"
							set SummaryFile = QueryID_RoutineName_".txt"
							//write:verbose !,"DetailFile = ", DetailFile
							OPEN DetailFile :("WNS"):10
							OPEN SummaryFile :("WNS"):10

							USE 0 write !!,"RoutineName = ", RoutineName, !
							USE SummaryFile write !!,"RoutineName = ", RoutineName, !
							USE DetailFile write !!,"RoutineName = ", RoutineName, !
							USE 0 write "Line"
							USE SummaryFile write "Line"
							USE DetailFile write "Line"
							set DisplayedField = 1
							for field=1:1:elements {
								USE DetailFile write ",",$piece(metrics,",",field)
								// if field is in the set {RtnLine, Time, TotalTime} then write to terminal
								if ($MATCH($piece(metrics,",",field), "RtnLine") || $MATCH($piece(metrics,",",field), "Time") || $MATCH($piece(metrics,",",field), "TotalTime")) {
									USE 0 write ?(12*DisplayedField),$piece(metrics,",",field)
									USE SummaryFile write ?(12*DisplayedField),$piece(metrics,",",field)
									do $INCREMENT(DisplayedField)
								}
							}
							USE 0 write ?(12*(DisplayedField)), "SourceLine"
							USE SummaryFile write ?(12*(DisplayedField)), "SourceLine"
							USE DetailFile write ",", "SourceLine"
						}
						set row=MonitorResults.GetData(1)
						
						USE 0 write !,line
						USE SummaryFile write !,line
						USE DetailFile write !,line
						set DisplayedField = 1
						for field=1:1:elements {
							USE DetailFile write ",",$list(row,field)
							if ($MATCH($piece(metrics,",",field), "RtnLine") || $MATCH($piece(metrics,",",field), "Time") || $MATCH($piece(metrics,",",field), "TotalTime")) {
								USE 0 write ?(12*DisplayedField),$list(row,field)
								USE SummaryFile write ?(12*DisplayedField),$list(row,field)
								do $INCREMENT(DisplayedField)
							}
						}

						set atom="+"_line_"^"_RoutineName
						USE 0 write ?(12*(DisplayedField)), $text(@atom)
						USE SummaryFile write ?(12*(DisplayedField)), $text(@atom)
						USE DetailFile write ",",$text(@atom)

						do $INCREMENT(line)
					}
					if (DetailFile '= "") {
							CLOSE DetailFile
							CLOSE SummaryFile
					}
					kill MonitorResults
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
							set ^%zDashResults($i(^%zDashResults)) = ##class(%SYS.System).GetNodeName(1)_","_parasetting_","_^Indices.Global_","_^DDL.Global_","_QueryID_","_$fn(elapsed,,3)_","_$zv_","_^Scale.Global_","_$ZDATE($HOROLOG)_","_$ZH_","_database
						} else {
							set ^%zDashResults($i(^%zDashResults)) = ##class(%SYS.System).GetNodeName(1)_","_parasetting_","_^Indices.Global_","_^DDL.Global_","_QueryID_","_$fn(StepEnd-StepStart,,3)_","_$zv_","_^Scale.Global_","_$ZDATE($HOROLOG)_","_$ZH_","_database
						}
					} else {
						set StepStart = $zh
						set sc = ..RunSQL(path_"src"_separator_"sql"_separator_"queries"_separator_QueryID_".sql", QueryID, .variables,,, .statement, /* DoPrepare : */ 0, /* DoExplain As %Boolean : */ 0)
						set StepEnd = $zh

						// rewrite this for modularity and conciseness
						if ^Indices.Global = "INDICES" { set Qidx = "IDX" } else { set Qidx = "NOIDX" }
						if ^DDL.Global = "ddl-row" { 
							set Qorg = "R" 
						} elseif ^DDL.Global = "ddl-colfields" { 
							set Qorg = "CF" 
						} elseif ^DDL.Global = "ddl-coltable" {
							set Qorg = "CT" 
						} else {
							set Qorg = "ERR"
						}
						
						if $FIND(QueryID,"IS") {
							set QueryDescriptor = Qorg_","_Qidx_","_QueryID_$REPLACE(org,"_",",",1) // org has a leading underscore
						} else {
							set QueryDescriptor = QueryID
							if (database = "SelectivityTest") {
									set QueryDescriptor = $REPLACE(QueryID,"-",",",3)  // Remove the "Q- and convert the other "-" to ","
							}
						}
						

						set ^%zDashResults($i(^%zDashResults)) = ##class(%SYS.System).GetNodeName(1)_","_parasetting_","_^Indices.Global_","_^DDL.Global_","_QueryDescriptor_","_$fn(StepEnd-StepStart,,3)_","_$zv_","_^Scale.Global_","_$ZDATE($HOROLOG)_","_$ZH_","_database
					}				
					quit:$$$ISERR(sc)
				}
			}
		
        }

		//SET myfile = "/nethome/marmorri/benchmark/results/queued-results.csv"
		//OPEN myfile:("WEAS"):5 // time out limit of 5 seconds to avoid indefinite wait when myfile cannot be opened
		//USE myfile
			//write !, "server, para, indices, organization, query, run time, build, scale, date, $zh, test"
			//for i = 1:1:^%zDashResults {
			//	write !, ^%zDashResults(i)
			//}
		//CLOSE myfile

		if (verbose & iterations) {
			if $FIND(QueryID,"IS",1) {
				write !, "server, para, indices, organization, sel org, sel idx, table, ins org, ins idx, run time, build, scale, date, $zh, test"
			} else {
				if (database = "SelectivityTest") {
					write !, "server, para, indices, organization, x, y, z, run time, build, scale, date, $zh, test"
				} else {
					write !, "server, para, indices, organization, query, run time, build, scale, date, $zh, test"
				}
			}
			for i = 1:1:^%zDashResults {
				write !, ^%zDashResults(i)
			}
			// for i = 1:1:^%zDashResults {write !, ^%zDashResults(i)}
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
				
					//if (DoPrepare) { // Bug here when the benchmark has two sql statements in the file. Then we can't skip the prepare and repeat the query.
						write:verbose !,"Preparing statement : ",SQL(1)
						set rs = statement.%Prepare(.SQL)
						if ($System.Status.IsError(rs)) {
							write:verbose !,"FAILED : ",rs
							if 'IgnoreErrors {
								set sc = $$$ERROR($$$GeneralError, "Error preparing statement: "_rs)
								return sc
							}
						}
						
					//}					

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
        //set elapsed = ##class(DASH.Benchmark).micro()
		set elapsed = $CLASSMETHOD("DASH.Benchmark","micro")
		
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
	//s Obj=##Class(Config.config).Open() // ObjectScript Language Server flags errors.
	s Obj= $CLASSMETHOD("Config.config","Open")  // Using $CLASSMETHOD prevents the ObjectScript Language Server from flagging errors.
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

	// Restart iris. This is not exactly graceful, but it gets the job done.
	write !, "Performing restart. A warning message will emit, followed by a delay, and then an OS prompt", !
	set InstanceName = ##class(%SYS.System).GetInstanceName()
	set sc = $ZF(-100,"", "sudo", "/usr/bin/iris", "stop", InstanceName, "restart", "quietly")


	quit $$$OK
}



}



