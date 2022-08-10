# ref

## aws

```
kubectl -n kube-system logs --follow --tail=10 deployment.apps/cluster-autoscaler-aws-cluster-autoscaler \
  | egrep '] Scale-(up|down):'

  I0805 13:15:48.623554       1 scale_up.go:663] Scale-up: setting group eks-bravo-Hrxh84Y2-amd64-RAM-4x32-20220... size to 1
  I0805 13:23:11.372839       1 scale_down.go:1054] Scale-down: removing empty node ip-172-18-5-110.us-east-2.compute.internal
```

### Pricing

us-east-2 (Ohio) 2022-08
  - EC2
    - m6i.large    2  x 8   0.096/h,  2.304/d,  69.12/m
    - m6i.xlarge   4  x 16  0.192/h,  4.608/d, 138.24/m
    - m6i.2large   8  x 32  0.384/h,  9.216/d, 276.40/m
    - m6i.2xlarge  16 x 64  0.768/h, 18.432/d, 552.96/m
  - EBS
    - 500GB - 0.070 / hour
    - 200GB - 0.080 = $0.32

## one-liners

- `comm -12 <sorted_file_a> <sorted_file_b>` - Show lines that appear in both files a and b (intersection)
- `comm -13 <sorted_file_a> <sorted_file_b>` - Show lines unique to file b
- `comm -3  <sorted_file_a> <sorted_file_b>` - Show lines unique in file a and b

## snakemake

- `--dryrun, -n` - Do not execute anything, and display what would be done.
- `--snakefile FILE, -s FILE` - The workflow definition in a snakefile.
- `--keep-going, -k` - Go on with independent jobs if a job fails.

## bcftools

- `bcftools view --no-version --threads=...`
- `bcftools query --list-samples`
- `bcftools view --exclude ID=@file --output-type=b --output=file.bcf input.bcf`
- `bcftools --include="HWE_SLP_I < $_hwe_slp_i_min || HWE_SLP_I > $_hwe_slp_i_max" --format='%ID\t%POS\t%REF\t%ALT\n'`

## vim

Modeline
```
# vim: filetype=snakemake tabstop=4 shiftwidth=4 softtabstop=4 textwidth=132 expandtab
```

Insert Mode
- `<C-h>` - delete one character
- `<C-w>` - delete one word
- `<C-u>` - delete entire line

```
Ctrl-r "    # insert the last yank/delete
Ctrl-r %    # insert file name
Ctrl-r /    # insert last search term
Ctrl-r :    # insert last command line
Ctrl-r =1+1 # Evaluate math
```

- `:help fo-table`
