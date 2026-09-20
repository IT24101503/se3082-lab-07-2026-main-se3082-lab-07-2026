# Exercise 7: Summary Comparison

| Program | Collectives | Array allocation | Root manual sum? | Result location |
|---|---|---|---|---|
| `sum_bcast` | `MPI_Bcast` | Full array on every process | Yes, receives with `MPI_Recv` | Root only |
| `sum_scatter` | `MPI_Scatter` | Full array on root; chunk elsewhere | Yes, receives with `MPI_Recv` | Root only |
| `sum_gather` | `MPI_Scatter`, `MPI_Gather` | Full array on root; chunk elsewhere | Yes, sums gathered values | Root only |
| `sum_reduce` | `MPI_Scatter`, `MPI_Reduce` | Full array on root; chunk elsewhere | No | Root only |
| `sum_allreduce` | `MPI_Scatter`, `MPI_Allreduce` | Full array on root; chunk elsewhere | No | Every process |
| `sum_scan` | `MPI_Scatter`, `MPI_Scan` | Full array on root; chunk elsewhere | No | Different prefix per rank; last rank has total |

## Timing Results

The current Windows environment does not have `mpicc` or `mpirun` installed, so measured timings cannot be recorded here. Run the following commands on an MPI-enabled machine and enter the reported `Time` values in seconds.

| Program | 2 processes | 4 processes | 8 processes |
|---|---:|---:|---:|
| `sum_bcast` | pending | pending | pending |
| `sum_scatter` | pending | pending | pending |
| `sum_gather` | pending | pending | pending |
| `sum_reduce` | pending | pending | pending |
| `sum_allreduce` | pending | pending | pending |
| `sum_scan` | pending | pending | pending |

The scatter-based programs normally use less memory than broadcast because only rank 0 stores the full array. Reduce and Allreduce also avoid a root-side loop. Actual timings depend on the MPI implementation, hardware, process placement, and system load, so the fastest program must be determined by measurement rather than assumed from the algorithm alone.

## Thinking Question

Choose `MPI_Scan` when each rank needs the cumulative result up to its own rank, rather than the same global result everywhere. For example, if each process owns a variable number of records, `MPI_Scan` on the local record counts gives every process a globally unique starting offset for writing its records into one output array.