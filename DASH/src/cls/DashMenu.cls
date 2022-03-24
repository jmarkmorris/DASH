Class DashMenu extends DASH.Utils 
{

ClassMethod DashMenu() As %Status
{
	set exit = 0
	set iterations = 5
	set verbose = 1
	while ('exit) {
		set sc = ..Menu1()
	    read !, "Input your numerical choice : ", choice1, !
		if (choice1 = 2) {
			do $system.OBJ.Load("/nethome/marmorri/DASH/DASH/src/cls/Utils.cls","cuk")
			do $system.OBJ.Load("/nethome/marmorri/DASH/DASH/src/cls/WriteResults.cls","cuk")
			do $system.OBJ.Load("/nethome/marmorri/DASH/DASH/src/cls/RunTPCH.cls","cuk")
			do $system.OBJ.Load("/nethome/marmorri/DASH/DASH/src/cls/RunNYTaxi.cls","cuk")
			do $system.OBJ.Load("/nethome/marmorri/DASH/DASH/src/cls/RunLoads.cls","cuk")
			do $system.OBJ.Load("/nethome/marmorri/DASH/DASH/src/cls/RunSelectivity.cls","cuk")
			do $system.OBJ.Load("/nethome/marmorri/DASH/DASH/src/cls/RunMicro.cls","cuk")
			do $system.OBJ.Load("/nethome/marmorri/DASH/DASH/src/cls/RunDASH.cls","cuk")
			do $system.OBJ.Load("/nethome/marmorri/DASH/DASH/src/cls/DashMenu.cls","cuk")
			/* These non-indented copies are for pasting into an ObjectScript session :
do $system.OBJ.Load("/nethome/marmorri/DASH/DASH/src/cls/Utils.cls","cuk")
do $system.OBJ.Load("/nethome/marmorri/DASH/DASH/src/cls/WriteResults.cls","cuk")
do $system.OBJ.Load("/nethome/marmorri/DASH/DASH/src/cls/RunTPCH.cls","cuk")
do $system.OBJ.Load("/nethome/marmorri/DASH/DASH/src/cls/RunNYTaxi.cls","cuk")
do $system.OBJ.Load("/nethome/marmorri/DASH/DASH/src/cls/RunLoads.cls","cuk")
do $system.OBJ.Load("/nethome/marmorri/DASH/DASH/src/cls/RunSelectivity.cls","cuk")
do $system.OBJ.Load("/nethome/marmorri/DASH/DASH/src/cls/RunMicro.cls","cuk")
do $system.OBJ.Load("/nethome/marmorri/DASH/DASH/src/cls/RunDASH.cls","cuk")
do $system.OBJ.Load("/nethome/marmorri/DASH/DASH/src/cls/DashMenu.cls","cuk")
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
			}
		} elseif (choice1 = 4) { // run an individual query in the context of a suite and physical design (i.e., columnar, indices)
			// not yet implemented
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
	

}

ClassMethod Menu1() As %Integer [ Language = objectscript ]
{
	write !
	write !, "1) Exit DASH menu"
	write !, "2) Load DASH classes"
	write !, "3) Select DASH benchmark suite and load data"
	write !, "4) Issue DASH benchmark query"
	return 1
}

ClassMethod Menu2() As %Integer [ Language = objectscript ]
{
	write !
	write !, "1) Exit DASH menu"
	write !, "2) TPCH"
	write !, "3) Selectivity"
	write !, "4) NYTaxi"
	write !, "5) Loads and Insert-Selects"
	write !, "6) Micro-benchmarks"
	return 1
}
}