Class DASH.Utils
{
ClassMethod Load(path As %String = "", database As %String = "", schema As %String = "", scale As %String = "100", ddl As %String = "ddl-row", useindices As %Boolean = 1, verbose As %Boolean = 1) As %Status [ SqlName = Load, SqlProc ]
{
	set sc = $$$OK
	set statement = ##class(%SQL.Statement).%New()  // default dialect is IRIS
	set statement.%SelectMode = 1 // 1=ODBC
	set saveNS = $znspace
	try {
		set separator = $s($$$isWINDOWS:"\",1:"/")
		set:$e(path,*)'=separator path = path_separator
		set doPrepare = 1
		set dontExplain = 0

		// create a new database if requested
		if (database'="") {
			set variables("database") = database
			do ..RunSQL(path_"src"_separator_"sql"_separator_ddl_separator_"create-db.sql","create-db", .variables,,, .statement, doPrepare, dontExplain)
		}

		do ..RunSQL(path_"src"_separator_"sql"_separator_"queries"_separator_"use-db.sql", "use-db", .variables,,, .statement, doPrepare, dontExplain)

		set t1 = $zh

		set variables("schema") = $s(schema="":"", 1:schema_".")
		do ..RunSQL(path_"src"_separator_"sql"_separator_ddl_separator_"drop-tables.sql","drop-tables", .variables, 1,, .statement, doPrepare, dontExplain)
		set t2 = $zh, t($i(t)) = "Dropping existing tables: "_$fn(t2-t1,,2)_"s"

		set sc = ..RunSQL(path_"src"_separator_"sql"_separator_ddl_separator_"create-tables.sql","create-tables", .variables,,, .statement, doPrepare, dontExplain)
		quit:$$$ISERR(sc)
		set (t3, t4) = $zh, t($i(t)) = "Creating new tables: "_$fn(t3-t2,,2)_"s"


		if ddl="ddl-row-id" {
			set sc = ..RunSQL(path_"src"_separator_"sql"_separator_ddl_separator_"swap-keys.sql","swap-keys", .variables,,, .statement, doPrepare, dontExplain)
			quit:$$$ISERR(sc)
			set t4 = $zh, t($i(t)) = "Transforming foreign keys: "_$fn(t4-t3,,2)_"s"
		}
		
		set sc = ..RunSQL(path_"src"_separator_"sql"_separator_ddl_separator_"create-keys.sql","create-keys", .variables,,, .statement, doPrepare, dontExplain)
		quit:$$$ISERR(sc)
		set (t5, t6) = $zh, t($i(t)) = "Creating keys: "_$fn(t5-t4,,2)_"s"

		if useindices {
			set sc = ..RunSQL(path_"src"_separator_"sql"_separator_ddl_separator_"create-indices.sql","create-indices", .variables,,, .statement, doPrepare, dontExplain)
			quit:$$$ISERR(sc)
			set t6 = $zh, t($i(t)) = "Building indices: "_$fn(t6-t5,,2)_"s"
		}

		set variables("data_dir") = path_"data"_separator_scale_separator
		set sc = ..RunSQL(path_"src"_separator_"sql"_separator_ddl_separator_"load-tables.sql","load-tables", .variables,,, .statement, doPrepare, dontExplain)
		quit:$$$ISERR(sc)
		set t7 = $zh, t($i(t)) = "Loading data: "_$fn(t7-t6,,2)_"s"

		set sc = ..RunSQL(path_"src"_separator_"sql"_separator_ddl_separator_"tune-tables.sql","tune-tables", .variables,,, .statement, doPrepare, dontExplain)
		quit:$$$ISERR(sc)
		set t8 = $zh, t($i(t)) = "Tune tables: "_$fn(t8-t7,,2)_"s"


		if verbose {
			write !,"Total time spent: "_$fn(t8-t1,,2)_"s"
			for i = 1:1:t {
				write !,"  - ",t(i)
			}
		}

	} catch (ex) {
		set sc = ex.AsStatus()
        write:verbose !,"Unexpected error: ",$system.Status.GetOneErrorText(sc)
	}
	write:verbose !
	kill statement
	zn saveNS
	quit sc
}

ClassMethod Run(path As %String = "", database As %String = "", parasetting As %String = "", query As %String = "all", iterations As %String = "5", verbose As %Boolean = 1) As %Status
{
	kill t
	set sc = $$$OK
	set statement = ##class(%SQL.Statement).%New()  // default dialect is IRIS
	set statement.%SelectMode = 1 // 1=ODBC
	set doPrepare = 1
	set dontPrepare = 0
	set dontExplain = 0
	set doExplain = 1

	try {
		set separator = $s($$$isWINDOWS:"\",1:"/")
		set:$e(path,*)'=separator path = path_separator

		if (database'="") {
			set variables("database") = database
		}
		set variables("parasetting") = parasetting
		set saveNS = $znspace
		do ..RunSQL(path_"src"_separator_"sql"_separator_"queries"_separator_"use-db.sql", "use-db", .variables,1,, .statement, doPrepare, dontExplain)

		set listdirstatement = ##class(%SQL.Statement).%New()
    	set status = listdirstatement.%PrepareClassQuery("%File", "FileSet")
    
    	if $$$ISERR(status) { 
        	do $system.OBJ.DisplayError(status)
        	quit  
    	}
    
		// match all Q* files in the directory, regardless of their extension.
		// set resultSet = listdirstatement.%Execute(path_"src"_separator_"sql"_separator_"queries"_separator, "Q*", "Name") 
		set resultSet = listdirstatement.%Execute(path_"src"_separator_"sql"_separator_"queries"_separator, query, "Name") 


    	while resultSet.%Next() {
        	set queryid = resultSet.%Get("ItemName")

			// Need to handle variable extensions here.
			if $FIND(queryid,".sql") {
				set queryid = $REPLACE(queryid,".sql","")
				set benchmarktype = "sql"
			} elseif $FIND(queryid,".obj") {
				set queryid = $REPLACE(queryid,".obj","")
				set benchmarktype = "obj"
			} else {
				// DASH doesn't support this benchmarktype.
				continue
			}
			

			//if ((query '= "all") & (query '= queryid)) {
				//continue
			//}
		
			// Always do a warmup query. It is not recorded.
			// No need yet to change RunObjScr.
			// In the warmup also save the explain.
			if (benchmarktype="obj") {
				set elapsed = 0
				set sc = ..RunObjScr(path_"src"_separator_"sql"_separator_"queries"_separator_queryid_".obj", 1, .elapsed)
			} else {
				set sc = ..RunSQL(path_"src"_separator_"sql"_separator_"queries"_separator_queryid_".sql", queryid, .variables,,, .statement, doPrepare, doExplain)
			}
			quit:$$$ISERR(sc)

			for j = 1:1:iterations {
				
				if (benchmarktype="obj") {
					set elapsed = 0
					set t1 = $zh
					set sc = ..RunObjScr(path_"src"_separator_"sql"_separator_"queries"_separator_queryid_".obj", 1, .elapsed)
					set t2 = $zh
					if elapsed > 0 {
						set t($i(t)) = queryid_","_$fn(elapsed,,3)
					} else {
						set t($i(t)) = queryid_","_$fn(t2-t1,,3)
					}
				} else {
					set t1 = $zh
					set sc = ..RunSQL(path_"src"_separator_"sql"_separator_"queries"_separator_queryid_".sql", queryid, .variables,,, .statement, dontPrepare, dontExplain)
					set t2 = $zh
					set t($i(t)) = queryid_","_$fn(t2-t1,,3)
				}				
				quit:$$$ISERR(sc)
				
			}
		
        }

		// things to add : scale, organization
		//SET myfile = "/nethome/marmorri/benchmark/results/queued-results.csv"
		//OPEN myfile:("WEAS"):5 // add a time out limit of 5 seconds to avoid indefinite wait when myfile cannot be opened
		//USE myfile
			//for i = 1:1:t {
			//	write ##class(%SYS.System).GetNodeName(1),",",parasetting,",,,",t(i),",",$zv,!
			//}
		//CLOSE myfile


		if verbose {
			for i = 1:1:t {
				write !, ##class(%SYS.System).GetNodeName(1),",",parasetting,",,,",t(i),",",$zv
			}
		}
		

	} catch (ex) {
		set sc = ex.AsStatus()
        write:verbose !,"Unexpected error: ",$system.Status.GetOneErrorText(sc)
	}
	write:verbose !
	kill statement
	zn saveNS
	quit sc
}

ClassMethod RunSQL(file As %String, ResultSetFile As %String, ByRef replace As %String, ignoreErrors As %Boolean = 0, verbose As %Boolean = 1, ByRef statement, DoPrepare As %Boolean = 1, DoExplain As %Boolean = 0) As %Status
{
    write !, "RunSQL ", file
	set sc = $$$OK
    try {
        set sep = $s($$$isWINDOWS:"\",1:"/")
        
        //write:verbose !,$piece(file,sep,*)," : "

        set stream = ##class(%Stream.FileCharacter).%New()
        set sc = stream.LinkToFile(file)
        quit:$$$ISERR(sc)

		
        set sql = 1
        set sql(1) = ""
        

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
					set sql(1) = $replace(sql(1),"${"_str_"}",rep)
				}

				set sql(1) = $zstrip(sql(1),"<>WC"), ts = $zh
				//write !,"SQL read from file : ", sql(1)

				if ($find(sql(1), "VIEW") || $find(sql(1), "view"))
				{ 
					// TO DO add error handling
					//write !, "preparing and executing statement with a VIEW"
					set ddlstatement = ##class(%SQL.Statement).%New()  // default dialect is IRIS
					set ddlstatement.%SelectMode = 1 // 1=ODBC
					set rs = ddlstatement.%Prepare(.sql)
					set rs = ddlstatement.%Execute()
					kill ddlstatement
					set sql(1) = ""
				} else {
					//write !, "About to check if Explain flag is set"
					if (DoExplain)
					{
						set savesql = sql(1)
						set sql(1) = "explain "_savesql
						write:verbose !,"Explaining statement : ",sql(1)
						
						//write:verbose !,"Before prepare : "
						set rs = statement.%Prepare(.sql)
						//write:verbose !,"After prepare : "

						if ($System.Status.IsError(rs)) 
						{
							write:verbose !,"FAILED : ",rs,!
							if 'ignoreErrors {
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
							if 'ignoreErrors {
								set sc = $$$ERROR($$$GeneralError, "Error running explain of statement: "_rs.%Message)
								Return sc
							}
						} 
						do rs.%DisplayFormatted("CSV","explain"_ResultSetFile)				
						if (rs.%SQLCODE'=0) & (rs.%SQLCODE'=100) {
							write:verbose !,"FAILED: ",rs.%Message
							if 'ignoreErrors {
								set sc = $$$ERROR($$$GeneralError, "Error displaying statement: "_rs.%Message)
								Return sc
							}
						}
						set sql(1) = savesql
					}
				
					if (DoPrepare)
					{
						write:verbose !,"Preparing statement : ",sql(1)
						set rs = statement.%Prepare(.sql)
						if ($System.Status.IsError(rs)) 
						{
							write:verbose !,"FAILED : ",rs
							if 'ignoreErrors {
								set sc = $$$ERROR($$$GeneralError, "Error preparing statement: "_rs)
								Return sc
							}
						}
						
					}
					write:verbose !,"Executing statement : ",sql(1)
					set rs = statement.%Execute()
					if (rs.%SQLCODE'=0) & (rs.%SQLCODE'=100) {
						write:verbose !,"FAILED : ",rs.%Message
						if 'ignoreErrors {
							set sc = $$$ERROR($$$GeneralError, "Error running statement: "_rs.%Message)
							Return sc
						}
					} 
					// area for improvement. do I keep saving results files over on top of each other? Or do I only save the warmup results?
					// if so, how to I ensure that the performance run results are displayed in the most efficient null way possible?
					do rs.%DisplayFormatted("CSV",ResultSetFile)				
					if (rs.%SQLCODE'=0) & (rs.%SQLCODE'=100) {
						write:verbose !,"FAILED: ",rs.%Message
						if 'ignoreErrors {
							set sc = $$$ERROR($$$GeneralError, "Error displaying statement: "_rs.%Message)
							Return sc
						}
					} else {
						write:verbose !,"SUCCESS (",$normalize($zh-ts,3),"s) " 
						write:verbose&&rs.%ROWCOUNT rs.%ROWCOUNT," rows affected"
					}

					set sql(1) = ""
				}

			} else {
				// this is adding CR LF 
				set sql(1) = sql(1)_$c(13,10)_line
			}

        }

		if $zstrip(sql(1),"<>WC")'="" {
			write:verbose !,"leftover statement not executed: ",!,sql(1)
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
