# Plink Reference

The versioning of Plink is confusing. Plink 1.9 is sometimes referred to as Plink 2:

- Plink 1.90 beta
  - <https://www.cog-genomics.org/plink/1.9/>
  - <https://www.cog-genomics.org/plink2/> (legacy)
- Plink 2.00 alpha
  - <https://www.cog-genomics.org/plink/2.0/>

- Plink presentation <http://faculty.washington.edu/tathornt/SISG2017/lectures/SISG2017session03.pdf>

## Important Flags

- `--nonfounders` - By default, nonfounders are not counted by `--freq[x]` or `--maf/--max-maf/--hwe`. Use the `--nonfounders` flag to include them.

## Quality Control

Summary statistics options:
- minor allele frequency (MAF): `--freq`
- SNP missing rate: `--missing`
- Individual missing rate: `--missing`
- Hardy-Weinberg: `--hardy`

Inclusion/Exclusion criteria
- MAF: `--maf`
- SNP missing rate: `--geno`
- Individual missing rate: `--mind`
- Hardy-Weinberg: `--hwe`

## Flags

```
--output-chr '26' (default), 'M', 'MT', '0M', 'chr26', 'chrM', and 'chrMT'.
```


## Summary

```
plink --file mydata                     # implicit input: mydata.ped, mydata.map
plink --ped mydata.ped --map mydata.map # explicit input
```

To save space and time, you can make a binary ped file (`*.bed`).

This will store the pedigree/phenotype information in separate file (`*.fam`) and create an extended MAP file (`*.bim`)
(which contains information about the allele names, which would otherwise be lost inthe BED file).

BED, BIM, FAM files
- `plink.bed`      (Binary: genotype information )
- `plink.fam`      (Text: First six columns of mydata.ped )
- `plink.bim`      (Text: extended MAP file: two extra cols = allele names)

To create these files use the command:
```bash
plink --ped mydata.ped --map mydata.map --make-bed --out mydata
```
Output: `mydata.{bed,bim,fam}`

## Affection Status

Affection status, by default, should be coded (alternative coding see `--1` flag):
- `-9`: missing
- `0`:  missing
- `1`:  unaffected
- `2`:  affected

## PED File

Format
- Column 1: Family ID (exclude with `--no-fid`)
- Column 2: Individual ID
- Column 3: Paternal ID (exclude with `--no-parents`)
- Column 4: Maternal ID (exclude with `--no-parents`)
- Column 5: Sex (1=male; 2=female; other=unknown) (exclude with `--no-sex`)
- Column 6: Phenotype (exclude with `--no-pheno`)
- Column 7 and onwards: Genotypes (can be any character except 0 which is, by default, the missing genotype character.

## Genotypes

For Genotypes
  - All markers should be biallelic.
  - All SNPs (whether haploid or not) must have two alleles specified.
  - Either Both alleles should be missing (i.e. 0) or neither.
  - No header row should be given.

For example, here are two individuals typed for 3 SNPs (one row = one person):

```
FAM001  1  0 0  1  2  A A  G G  A C
FAM001  2  0 0  1  2  A A  A G  0 0
```

- A PED file must have 1 and only 1 phenotype in the sixth column.
- The phenotype can be either a quantitative trait or an affection status column
- PLINK will automatically detect which type (i.e. based on whether a value other than 0, 1, 2 or the missing genotype code is observed).


## Map File

Format
- Column 1: chromosome (1-22, X, Y or 0 if unplaced)
- Column 2: rs# or snp identifier
- Column 3: Genetic distance (morgans)
- Column 4: Base-pair position (bp units)

Chromosome Codes
- X = 23
- Y = 24
- XY = 25 (Pseudo-autosomal region of X)
- M/MT =26 (Mitochondrial)

