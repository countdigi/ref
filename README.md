# ref

## top

Sample bam file
```
bio-sw-samtools view -s 0.05 -b -o tmp/MICH627979391240_P1.bam \
  /shares/hii/fac/parikhh/output/teddy/MICH/CORRECTED-fac-parikhh-teddy-um-uva-human-wgs/grch38/bam/MICH627979391240_P1.bam

bio-sw-samtools index tmp/MICH627979391240_P1.bam
```

---

Generate documentable git commit history

---

Xscreensaver
```
# /home/countskm/.config/systemd/user/xscreensaver.service
systemctl --user status xscreensaver

  ```

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

## git

- `git show <sha>:<path>`
- `git diff --diff-filter=M` - restricts diff outputs to only content modifications
- Diff online:
  - <https://github.com/usf-hii/fac-parikhh-teddy-hla-imputation/compare/master...86bcbf8>
- `git log --format="- [x] \`%s\`%n  - [%h](https://github.com/usf-hii/$(basename $(pwd))/commit/%h)"`

## one-liners

- `comm -12 <sorted_file_a> <sorted_file_b>` - Show lines that appear in both files a and b (intersection)
- `comm -23 <sorted_file_a> <sorted_file_b>` - Show lines unique to file a
- `comm -13 <sorted_file_a> <sorted_file_b>` - Show lines unique to file b
- `comm -3  <sorted_file_a> <sorted_file_b>` - Show lines unique in file a and b

## snakemake

- `--dryrun, -n` - Do not execute anything, and display what would be done.
- `--snakefile FILE, -s FILE` - The workflow definition in a snakefile.
- `--keep-going, -k` - Go on with independent jobs if a job fails.

Singularity
```
#=====================================================================================================
# Singularity Specifications
#=====================================================================================================

SINGULARITY_CMD = " ".join([
    "/shares/hii/sw/singularity/latest/bin/singularity",
    "exec",
    "--bind /shares:/shares",
    "--bind /hii/work:/hii/work"
])

#=====================================================================================================
# Image Specifications
#=====================================================================================================

IMAGE_HTSLIB = os.environ.get("IMAGE_HTSLIB", "/shares/hii/images/bioinfo/htslib/1.15.1.simg")
IMAGE_KING = os.environ.get("IMAGE_KING", "/shares/hii/images/bioinfo/king/227.simg")
IMAGE_PICARD = os.environ.get("IMAGE_PICARD", "/shares/hii/images/bioinfo/picard/2.26.11.simg")
IMAGE_PLINK19 = os.environ.get("IMAGE_PLINK19", "/shares/hii/images/bioinfo/plink1.9/20210606.simg")
IMAGE_PLINK20 = os.environ.get("IMAGE_PLINK20", "/shares/hii/images/bioinfo/plink2.0/20211217.simg")
IMAGE_PYTHON3 = os.environ.get("IMAGE_PYTHON", "/shares/hii/images/bioinfo/python/3.10.simg")
IMAGE_R = os.envrion.get("IMAGE_R", "/shares/hii/images/bioinfo/rocker-verse/4.0.2.simg")
IMAGE_SNPTK = os.environ.get("IMAGE_SNPTK", "/shares/hii/images/bioinfo/snptk/2020-06-26-7ae425d.simg")

#=====================================================================================================
# Commands
#=====================================================================================================

BCFTOOLS = " ".join([SINGULARITY_CMD, IMAGE_HTSLIB, "bcftools"])
BGZIP = " ".join([SINGULARITY_CMD, IMAGE_HTSLIB, "bgzip"])
KING = " ".join([SINGULARITY_CMD, IMAGE_KING, "king"])
PICARD = " ".join([SINGULARITY_CMD, IMAGE_PICARD, "java -jar /usr/local/bin/picard.jar"])
PLINK19 = " ".join([SINGULARITY_CMD, IMAGE_PLINK19, "plink"])
PLINK20 = " ".join([SINGULARITY_CMD, IMAGE_PLINK20, "plink2"])
PYTHON3 = " ".join([SINGULARITY_CMD, IMAGE_PYTHON, "/usr/local/bin/python3"])
RSCRIPT = " ".join([SINGULARITY_CMD, IMAGE_R, "Rscript", "--vanilla"])
SNPTK = " ".join([SINGULARITY_CMD, IMAGE_SNPTK, "snptk"])

```

---

Dynamic environmental variables
```
ENV_DEFAULTS = {
    "FOO": "alpha",
    "BAR": "beta"
}

for name, value in ENV_DEFAULTS.items():
    if os.environ.get(name):
        vars()[name] = os.environ[name]
    else:
        vars()[name] = value
```

Example rule:
```
rule input_chip:
    """
    This creates a zero-byte plink prefix file so we can use the prefix for all future input/output targets.
    It also simplifies the source name to
    """
    input:
        bed=lambda wildcards: INPUT_SOURCE[wildcards.source] + ".bed",
        bim=lambda wildcards: INPUT_SOURCE[wildcards.source] + ".bim",
        fam=lambda wildcards: INPUT_SOURCE[wildcards.source] + ".fam"
    output:
        prefix=join(WORK, "input_chip/{source}"
    params:
        job_name="input_chip-{source}", log="input_chip/{source}.log", cpus="1", mem="20G", time="0-1"
    shell:
        """
        /bin/ln -s {input.bed} {output.prefix}.bed
        /bin/ln -s {input.bim} {output.prefix}.bim
        /bin/ln -s {input.fam} {output.prefix}.fam
        /bin/touch {output.prefix}
        """
```

## python

Date diff in days

```
(date(2022, 9, 6) - date(2022, 7, 11)).days
```

## bcftools

- `bcftools view --no-version --threads=...`
- `bcftools query --list-samples`
- `bcftools view --exclude ID=@file --output-type=b --output=file.bcf input.bcf`
- `bcftools --include="HWE_SLP_I < $_hwe_slp_i_min || HWE_SLP_I > $_hwe_slp_i_max" --format='%ID\t%POS\t%REF\t%ALT\n'`

## vim

Modeline
```
# vim: filetype=snakemake expandtab tabstop=4 softtabstop=4 shiftwidth=4 textwidth=132
# vim: filetype=markdown expandtab tabstop=2 softtabstop=2 shiftwidth=2 textwidth=132
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

## snippets

```
rule gwa_1:
    """
    Delete SNPs and individuals with high levels of missingness.
    """
    input:
        prefix=join(WORK, "input_chip/{source}")
    output:
        prefix=join(WORK, "gwa_1/{source}"),
        counts_txt=join(WORK, "gwa_1/{source}.counts.txt")
    params:
        job_name="gwa_1-{source}", log="gwa_1/{source}.log", cpus="2", mem="20G", time="0-1"
    shell:
        """
        _opts="--silent --keep-allele-order --make-bed"
        _filters="geno_0.2 mind_0.2 geno_0.05 mind_0.05"
        _in={input.prefix}

        > {output.counts_txt}

        for filter in $_filters; do
          _out={output.prefix}.$filter
          _opts_filter=$(echo --$filter | tr '_' ' ')

          _before_fam=$(wc -l < $_in.fam)
          _before_bim=$(wc -l < $_in.bim)

          {PLINK19} $_opts --bfile $_in $_opts_filter --out $_out

          _after_fam=$(wc -l < $_out.fam)
          _after_bim=$(wc -l < $_out.bim)

          echo "$filter .fam before($_before_fam) - after($_after_fam) = $(( _before_fam - _after_fam )) " >> {output.counts_txt}
          echo "$filter .bim before($_before_bim) - after($_after_bim) = $(( _before_bim - _after_bim )) " >> {output.counts_txt}
          echo >> {output.counts_txt}

          _in=$_out
        done

        for ext in bed bim fam; do /bin/cp $_out.$ext {output.prefix}.$ext; done
        /bin/touch {output.prefix}
"""
```


- `:help fo-table`
