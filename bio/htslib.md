# Htslib

## Bcftools

### Get the number of samples

New:
```bash
bcftools query --list-samples input.bcf
```

Obsolete:
```bash
bcftools view --header-only run/grch38/work/vt_genotype/chr1:1-20000000.vcf.gz | tail -1 | cut -f10- | tr '\t' '\n' | wc -l
```
