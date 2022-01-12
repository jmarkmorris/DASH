# DASH

DASH is a capability to run various benchmarks on IRIS database systems.

NOTE : This benchmarking tool is specific to the ISC IRIS development organization environment. Portions will not run in a generic environment. Specifically, the table data is not provided in this repo, because it is very large and unwieldy. There are also some dependencies on network file system paths and Linux which I hope to remove at some point. That said, the code is open for use as a reference implementation.

Benchmark categories are:

- TPCH : the 22 TPCH SQL queries as well as other queries using the same tables.
- NYTaxi : SQL queries
- SELECTIVITY : SQL queries that use predicates and equijoin conditions of various selectivities.
- micro : ObjectScript microbenchmarks comparing various code implementations, including embedded Python.

Process

1. Extract a zip of the DASH repo from GitHub and unpack it on the server with the IRIS instance to benchmark.
2. Table data is not included in this repo due to its size. ISC IRIS users may copy the data files, using the getdashdata script.
3. chmod +x dash and then run the script "dash" to see benchmark choices and get commands to import DASH.Utils, load data to IRIS, and run benchmarks.

Classes

1. classmethod Load(path As %String = "", database As %String = "", schema As %String = "", scale As %String = "1", ddl As %String = "ddl-row", useindices As %Boolean = 1, verbose As %Boolean = 1) as %Status [ SQLProc = Load ]
2. classmethod Run(path As %String = "", database As %String = "", parasetting As %String = "", query As %String = "Q*", iterations As %String = "5", verbose As %Boolean = 1) as %Status


Notes

1. Micro benchmarks are self contained files which initialize and then measure a repeated code segment.
2. In general benchmark names are in the form Q{id}{string}.{sql|cls}
3. Benchmarks with the same Q{id} are comparable, while {string} clarifies the variation of the benchmark.
4. A warmup run is performed for every benchmark and is not timed. On SQL warmups, a plan explain is gathered.
5. DASH will gather a MONLBL for every Q* specified if the Run method is called with iterations = 0.



