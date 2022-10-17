# Snakemake Reference

- Notes
  - Example of a snakemake report showing `rule,input-file(s)`:
    ```
    bin/snake --detailed-summary 2>/dev/null | cut -d$'\t' -f3,6 | sed -e 's|/hii/work/k/kcounts/fac-parikhh-teddy-gwas/||g' | column -t | uniq
    ```

## Vim Modeline

```
# vim: filetype=snakemake tabstop=4 shiftwidth=4 softtabstop=4 expandtab
```

## Callables

```
input:
    lambda wildcards: "bar" if wildcards.foo == "x" else "y"
```

```
params:
    prefix=lambda wildcards[, input, output, threads, resources]: ...
```

Example to strip `.bim` from plink:
```
params:
    prefix=lambda wildcards, output: output[0][:-4]
```

Resources (return `int`)
```
resources:
    mem_mb=lambda wildcards [, input] [, threads] [, attempt]: ...
```


Use `--dry-run|-n` to validate a run without executing any rules:
```
snakemake -n
```

## File wrappers

- `protected()` - marked read-only
- `temp()` - removed after all dependent rules have consumed it (override with `--notemp`)
- `ancient()` - consider it an old timestamp if it exixsts
- `touch()` - touches file once shell is command,shell is successful
- `directory()` - directory is used and special `.snakemake_timestamp` file is used

## Using params to solve programs taking a prefix

```
rule foo:
    input: ...
    output: "somedir/{sample}.csv"
    params: prefix=lambda wildcards, output: output[0][:-4]
    shell: "somecommand -o {params.prefix}"
```

## Generating DAG Diagram

```
snakemake --dag | dot -Tsvg > dag.svg
```

### Conditional Run of Different Shell Commands

```snakemake
run:
    if int(wildcards.radius) > 2:
        shell('script_B.sh {input} {output}')
    else:
        shell('touch {output}')
```

- Resources
  - <https://github.com/Snakemake-Profiles/slurm>
- Generate DAG or Rulegraph
  - `snakemake --dag | dot -T png > dag.png`
  - `snakemake --rulegraph | dot -T png > rulegraph.png`
- Options
  - `--list-untracked` -  List all files in the working directory that are not used in the workflow.
  - `--stats` - Write stats about Snakefile execution in JSON format to the given file.
  - `--directory=<dirname>` - Specifify wroking directory (relative paths will use this as their origin)
  - `--snakefile=<filename>`
  - `--keep-going`
  - `--batch=x/y` - Run a portion of the wildcards (e.g. 1/3 runs the first third)
  - `--list` - Show available rules in given Snakefile.
  - `--list-target-rules` - Show available target rules in given Snakefile.
  - `--summary`
  - `--detailed-summary`
  - `--dry-run`
  - `--reason`
  - `--jobs=n` - Maximum jobs to run at once
- Cluster Options
  - `--cluster-config=<filename>` - (e.g. `${BASE}/cluster.yaml`)
  - `--cluster=<script>` - Python submit script (e.g. `/shares/hii/sw/snakemake/latest/bin/python3 ${BASE}/bin/cluster-slurm`)
  - `--jobscript=<scripts>` - Default `<snakemake_install>/executors/jobscript.sh`
  - `--jobname=<spec> ` - Default: `snakejob.{name}.{jobid}.sh`
- Rule Example:
  ```
  rule target_foo:
      input:
        expand(join(WORK, "foo/{sample}.tsv"), sample=SAMPLES)

  rule foo:
      input:
          dat=join(WORK, "data/{sample}.dat")
      output:
          tsv=join(WORK, "foo/{sample}.tsv")
      params:
          jobname="foo-{sample}", log="foo/{sample}.log", cpus="1", mem="2G", time="0-1"
      shell:
          """
          process_command {input.dat} > {output.tsv}
          """
  ```


restart-times: 3
jobscript: "slurm-jobscript.sh"
cluster: "slurm-submit.py"
cluster-status: "slurm-status.py"
max-jobs-per-second: 1
max-status-checks-per-second: 10
local-cores: 1
latency-wait: 60
