# Slurm Reference

## Links

- <https://github.com/Snakemake-Profiles/slurm> - Snakemake profile to run on Slurm

## Quickref

Show jobs that have had problems since `YYYY-MM-DDTHH:MM`:
```bash
sacct --format=user,node%-20,jobid%-16,jobname%-72,start,elapsed,ncpus,reqm,ntasks,avecpu,maxrss,state --user=${USER} \
      --start=2020-11-02T07:40 --state=CA,F,NF,TO
```

- Add more time: `sudo scontrol update jobid=<job_id> TimeLimit=+<days>-<hours>`
- Show job: `scontrol show -d job <jobid>`
- Get interactive shell: `srun --partition hii02 --pty --mem=100G --exclusive --time 1-00:00 /bin/bash -o vi`
- Cancel job: `scancel -u $USER <jobid>`
- Variables
  - `${SLURM_CPUS_PER_TASK}` - Contains core count when running a normal task
  - `${SLURM_JOB_CPUS_PER_NODE}` - Contains core count when requesting `--exclusive` use of node
  - `${SLURM_ARRAY_TASK_ID}` - Contains number of task for Job Arrays
  - `${SLURM_NODELIST}`
  - `${SLURM_NODE_ALIASES}`
  - `${SLURM_NNODES}`
  - `${SLURM_JOBID}`
  - `${SLURM_TASKS_PER_NODE}`
  - `${SLURM_JOB_ID}`
  - `${SLURM_SUBMIT_DIR}`
  - `${SLURM_JOB_NODELIST}`

## Sbatch

Options
- `--array=n[%<limit>]` - Submit a job array (Use `${SLURM_ARRAY_TASK_ID}` to know which you are)
- `--constraint|-C <constraint_spec>`
- `-–job-name=<name>`
- `-–output=<filename>` - Output sent to this file (`%a - array, %N - nodename, %j - jobid`)
- `-–error=<filename>` - STDERR written to this file
- `-–partition=<name>` - Specify the partition
- `-–cpus-per-task=<n>`
- `-–nodes=<n>`
- `--nodelist <names>`
- `-–time=<days>-<hours>:<min>:<sec>` - The maximum amount of time before job is killed
- `--mail-type=<BEGIN|END|FAIL|ALL>`
- `-–mail-user=<email>`
- `-–mem=<n><K|M|G|T>` - Memory for the job
- `--exclusive` - Specify that you need exclusive access to nodes for your job
- `-–dependency=afterany:100:101` -  Wait for jobs 100 and 101 to complete before starting
- `--dependency=afterok:100:101` - Wait for jobs 100 and 101 to finish without error
- `--wrap "<command string>"` - Run command instead of giving a script
- `--signal [B:]<num>[@time]` (Send signal `<num>` to job within `<time>` seconds of its end time - `B` only send the batch shell signal)

## Job States

- Common
  - `CANCELLED (CA)` - Job was explicitly cancelled by the user or system administrator.  The job may or may not have been initiated.
  - `COMPLETED (CD)` - Job has terminated all processes on all nodes with an exit code of zero.
  - `FAILED (F)` - Job terminated with non-zero exit code or other failure condition.
  - `PENDING (PD)` - Job is awaiting resource allocation.
  - `COMPLETING (CG)` - Job is in the process of completing. Some processes on some nodes may still be active.
  - `TIMEOUT (TO)` - Job terminated upon reaching its time limit.
  - `RUNNING (R)` - Job currently has an allocation.
  - `NODE_FAIL (NF)` - Job terminated due to failure of one or more allocated nodes.
- Other
  - `BOOT_FAIL (BF)` - Job  terminated  due to launch failure, typically due to a hardware failure
  - `CONFIGURING (CF)` - Job has been allocated resources, but are waiting for them to become ready for use (e.g. booting).
  - `DEADLINE (DL)` - Job missed its deadline.
  - `PREEMPTED (PR)` - Job terminated due to preemption.
  - `RESIZING (RS)` - Job is about to change size.
  - `SUSPENDED (S)` - Job has an allocation, but execution has been suspended.

## Sacct

Format Specs
- `sacct --helpformat`
- Add `<name>%-<columns>` for extra formatting, e.g. `--format=node%-20,jobname%102`


Powercommand
```bash
start="24 hours ago"
startdate=$(date -d "${start}" "+%FT%T")

sacct \
  --start ${startdate} \
  --format \
"
node%-20,
jobid%-16,
jobname%-72,
start,
elapsed,
ncpus,
reqm,
ntasks,
avecpu,
maxrss,
state"
```


Options
- `--allusers`
- `--accounts=<name>`
- `--endtime=<time>`
- `--format=<spec>`
- `--name=<jobname>`
- `--partition=<names>`
- `--state=<state,[state]>`

