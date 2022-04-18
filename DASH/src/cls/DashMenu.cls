Class DashMenu extends DASH.Utils 
{

ClassMethod DashMenu() As %Status
{
	set exit = 0
	set iterations = 5
	set verbose = 1
	set repo = "/nethome/marmorri/DASH/"
	set indices = 0
	set parallel = ""
	set org = "ddl-colfields"
	set iterations = 1


	while ('exit) {
		set sc = ..Menu1()
	    read !, "Input your numerical choice : ", choice1, !
		if (choice1 = 2) {
			do $system.OBJ.Load(repo_"/DASH/src/cls/Utils.cls","cuk")
			do $system.OBJ.Load(repo_"/DASH/src/cls/WriteResults.cls","cuk")
			do $system.OBJ.Load(repo_"/DASH/src/cls/RunTPCH.cls","cuk")
			do $system.OBJ.Load(repo_"/DASH/src/cls/RunNYTaxi.cls","cuk")
			do $system.OBJ.Load(repo_"/DASH/src/cls/RunLoads.cls","cuk")
			do $system.OBJ.Load(repo_"/DASH/src/cls/RunSelectivity.cls","cuk")
			do $system.OBJ.Load(repo_"/DASH/src/cls/RunMicro.cls","cuk")
			do $system.OBJ.Load(repo_"/DASH/src/cls/RunDASH.cls","cuk")
			do $system.OBJ.Load(repo_"/DASH/src/cls/DashMenu.cls","cuk")
			/* These non-indented copies are for pasting into an ObjectScript session :
do $system.OBJ.Load(repo_"/DASH/src/cls/Utils.cls","cuk")
do $system.OBJ.Load(repo_"/DASH/src/cls/WriteResults.cls","cuk")
do $system.OBJ.Load(repo_"/DASH/src/cls/RunTPCH.cls","cuk")
do $system.OBJ.Load(repo_"/DASH/src/cls/RunNYTaxi.cls","cuk")
do $system.OBJ.Load(repo_"/DASH/src/cls/RunLoads.cls","cuk")
do $system.OBJ.Load(repo_"/DASH/src/cls/RunSelectivity.cls","cuk")
do $system.OBJ.Load(repo_"/DASH/src/cls/RunMicro.cls","cuk")
do $system.OBJ.Load(repo_"/DASH/src/cls/RunDASH.cls","cuk")
do $system.OBJ.Load(repo_"/DASH/src/cls/DashMenu.cls","cuk")
			*/
		} elseif (choice1 = 3) { // Select DASH benchmark suite
			// at this point the menu runs the full suite. ToDo : provide menus to load a suite with a physical design and run individual queries.
			set sc = ..Menu2()
			read !, "Input your numerical choice : ", choice2, !
			if (choice2 = 1) {
				set exit = 1
				continue
			} elseif (choice2 = 2) {
				set database = "TPCH"
				do ##class(RunTPCH).RunTPCH(iterations, verbose)
			} elseif (choice2 = 3) {
				set database = "Selectivity"
				do ##class(RunSelectivity).RunSelectivity(iterations,verbose,0,0)
				do ##class(RunSelectivity).RunSelectivity(iterations,verbose,0,1)
				do ##class(RunSelectivity).RunSelectivity(iterations,verbose,1,0)
				do ##class(RunSelectivity).RunSelectivity(iterations,verbose,1,1)
			} elseif (choice2 = 4) {
				set database = "NYTaxi"
				do ##class(RunNYTaxi).RunNYTaxi(iterations, verbose)
			} elseif (choice2 = 5) {
				set database = "load1m"  // actually this suite does the loads to all databases so need to handle this somehow
				do ##class(RunLoads).RunLoads(iterations, verbose,0,0)
				do ##class(RunLoads).RunLoads(iterations, verbose,0,1)
				do ##class(RunLoads).RunLoads(iterations, verbose,1,0)
				do ##class(RunLoads).RunLoads(iterations, verbose,1,1)
			} elseif (choice2 = 6) {
				set database = "micro"
				do ##class(RunMicro).RunMicro(iterations, verbose)
			} elseif (choice2 = 7) {
				set database = "Selectivity"
				set sc = ..Menu6()
				read !, "Input your numerical choice for organization : ", choice6, !
				if (choice6 = 1) {
					set exit = 1
					continue
				} elseif (choice6 = 2) {
					set org = "ddl-row"
				} elseif (choice6 = 3) {
					set org = "ddl-coltable"
				} elseif (choice6 = 4) {
					set org = "ddl-colfields"
				}
				set sc = ..Menu5()
				read !, "Input your numerical choice for indices : ", choice5, !
				if (choice5 = 1) {
					set exit = 1
					continue
				} elseif (choice5 = 2) {
					set indices = 1
				} elseif (choice5 = 3) {
					set indices = 0
				}
				do ##class(DASH.Utils).Load(repo_"/SELECTIVITY","Selectivity","","1",org,indices)


			

		
			}
		} elseif (choice1 = 4) { // run an individual query in the context of a suite and physical design (i.e., columnar, indices)
			set database = "Selectivity"
			write !, "The query is of the form select AVG(C.RowNUM) FROM C as C JOIN D as D ON C.selX = 0 AND D.selY = 0 AND C.selZ = D.selZ"
			write !, "Please choose x, y, and z in the following menus."
			set sc = ..Menu3()
			read !, "Input your numerical choice for x : ", choice3, !
			set x = choice3
			set sc = ..Menu3()
			read !, "Input your numerical choice for y : ", choice3, !
			set y = choice3
			set sc = ..Menu3()
			read !, "Input your numerical choice for z : ", choice3, !
			set z = choice3	
			read !, "Input the number of iterations: ", iterations, !
			set sc = ..Menu4()
			read !, "Input your numerical choice for parallelism : ", choice4, !
			if (choice4 = 1) {
				set exit = 1
				continue
			} elseif (choice4 = 2) {
				set parallel = "%NOPARALLEL"
			} elseif (choice4 = 3) {
				set parallel = "%PARALLEL"
			} elseif (choice4 = 4) {
				set parallel = ""
			}
			write !, "parallel = ", parallel
			set query = "Q"_"-"_x_"-"_y_"-"_z_"*"
			do ##class(DASH.Utils).Run(repo_"/SELECTIVITY","Selectivity",parallel,query,iterations,verbose)		
			continue
		} elseif (choice1 = 5) {
			set serverfarm =  $TRANSLATE(##class(%SYS.System).GetNodeName(1),"1234567890")
			do ##class(RunDASH).RunDASH(serverfarm)
			continue

		} elseif (choice1 = 1) {
			set exit = 1
			continue
		} else {
			write !, "Invalid input, try again."
			continue
		}
		
	}
	write !, "Exiting DASH menu", !
	quit $$$OK
	
}

ClassMethod Menu1() As %Integer [ Language = objectscript ]
{
	write !
	write !, "1) Exit DASH menu"
	write !, "2) Load DASH classes"
	write !, "3) Select DASH benchmark suite and load data"
	write !, "4) Issue DASH Selectivity benchmark query"
	write !, "5) Run DASH suite assigned to this server"
	return 1
}

ClassMethod Menu2() As %Integer [ Language = objectscript ]
{
	write !
	write !, "1) Exit DASH menu"
	write !, "2) TPCH Suite"
	write !, "3) Selectivity Suite"
	write !, "4) NYTaxi Suite"
	write !, "5) Loads and Insert-Selects Suite"
	write !, "6) Micro-benchmarks Suite"
	write !, "7) Individual Selectivity Query Setup"
	return 1
}

ClassMethod Menu3() As %Integer [ Language = objectscript ]
{
	write !
	write !, "1) 1%"
	write !, "5) 5%"
	write !, "10) 10%"
	return 1
}

ClassMethod Menu4() As %Integer [ Language = objectscript ]
{
	write !
	write !, "1) Exit DASH menu"
	write !, "2) %NOPARALLEL"
	write !, "3) %PARALLEL"
	write !, "4) autoparallel"
	return 1
}

ClassMethod Menu5() As %Integer [ Language = objectscript ]
{
	write !
	write !, "1) Exit DASH menu"
	write !, "2) with indices"
	write !, "3) without indices"
	return 1
}

ClassMethod Menu6() As %Integer [ Language = objectscript ]
{
	write !
	write !, "1) Exit DASH menu"
	write !, "2) Row based tables (ddl-row)"
	write !, "3) Columnar tables (ddl-coltable)"
	write !, "4) Columnar on all eligible fields (ddl-colfields)"
	return 1
}

}