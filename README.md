# DASH

DASH is a capability to run various benchmarks on IRIS database systems.

Benchmark categories are:

TPCH - the 22 TPCH SQL queries as well as other queries using the same tables.
NYTaxi - SQL queries
SELECTIVITY - SQL queries that use predicates and equijoin conditions of various selectivity.
micro - ObjectScript microbenchmarks comparing various implementations, including embedded Python.

Process

1. Extract a zip of the DASH repo from GitHub and unpack it on the system to benchmark.
2. Table data is not included in this repo due to its size, so copy in the data files, using the getdashdata script.
3. Run the script "dash" to see benchmark choices and get commands to import DASH.Utils, load data to IRIS, and run.


Notes

1. Micro benchmarks are self contained files which initialize and then measure a repeated code segment
2. In general benchmark names are in the form Q{id}{string}.{sql|obj}
3. Benchmarks with the same Q{id} are comparable, while {string} clarifies the variation of the benchmark.
4. A warmup run is performed for every benchmark and is not timed. On SQL warmups, a plan explain is gathered.



