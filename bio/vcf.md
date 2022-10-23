# VCF

1. CHROM
2. POS
3. ID
4. REF
5. ALT
6. QUAL
7. FILTER
8. INFO

## Example

```
##fileformat=VCFv4.2
##fileDate=20090805
##source=myImputationProgramV3.1
##reference=file:///seq/references/1000GenomesPilot-NCBI36.fasta
##contig=<ID=20,length=62435964,assembly=B36,md5=f126cdf8a6e0c7f379d618ff66beb2da,species="Homo sapiens",taxonomy=x>
##phasing=partial
##INFO=<ID=NS,Number=1,Type=Integer,Description="Number of Samples With Data">
##INFO=<ID=DP,Number=1,Type=Integer,Description="Total Depth">
##INFO=<ID=AF,Number=A,Type=Float,Description="Allele Frequency">
##INFO=<ID=AA,Number=1,Type=String,Description="Ancestral Allele">
##INFO=<ID=DB,Number=0,Type=Flag,Description="dbSNP membership, build 129">
##INFO=<ID=H2,Number=0,Type=Flag,Description="HapMap2 membership">
##FILTER=<ID=q10,Description="Quality below 10">
##FILTER=<ID=s50,Description="Less than 50% of samples have data">
##FORMAT=<ID=GT,Number=1,Type=String,Description="Genotype">
##FORMAT=<ID=GQ,Number=1,Type=Integer,Description="Genotype Quality">
##FORMAT=<ID=DP,Number=1,Type=Integer,Description="Read Depth">
##FORMAT=<ID=HQ,Number=2,Type=Integer,Description="Haplotype Quality">

#CHROM  POS      ID         REF  ALT     QUAL  FILTER  INFO                               FORMAT       NA00001         NA00002         NA00003
chr20   14370    rs6054257  G    A       29    PASS    NS=3;DP=14;AF=0.5;DB;H2            GT:GQ:DP:HQ  0|0:48:1:51,51  1|0:48:8:51,51  1/1:43:5:.,.
chr20   17330    .          T    A       3     q10     NS=3;DP=11;AF=0.017                GT:GQ:DP:HQ  0|0:49:3:58,50  0|1:3:5:65,3    0/0:41:3
chr20   1110696  rs6040355  A    G,T     67    PASS    NS=2;DP=10;AF=0.333,0.667;AA=T;DB  GT:GQ:DP:HQ  1|2:21:6:23,27  2|1:2:0:18,2    2/2:35:4
chr20   1230237  .          T    .       47    PASS    NS=3;DP=13;AA=T                    GT:GQ:DP:HQ  0|0:54:7:56,60  0|0:48:4:51,51  0/0:61:2
chr20   1234567  microsat1  GTC  G,GTCT  50    PASS    NS=3;DP=9;AA=G                     GT:GQ:DP     0/1:35:4        0/2:17:2        1/1:40
```
# Variant Call Format Reference

- Reference: <https://samtools.github.io/hts-specs/VCFv4.2.pdf>


## Header Line Syntax

- `CHROM` - The name of the sequence (typically a chromosome) on which the variation is being called. This sequence is usually known as 'the reference sequence', i.e. the sequence against which the given sample varies.
- `POS` - The 1-based position of the variation on the given sequence.
- `ID` - The identifier of the variation, e.g. a dbSNP rs identifier or just . if unknown. Multiple identifiers should be separated by semi-colons without white-space.
- `REF` - The reference base (or bases in the case of an indel) at the given position on the given reference sequence.
- `ALT` - The list of alternative alleles at this position.
- `QUAL` - A quality score associated with the inference of the given alleles.
- `FILTER` - A flag indicating which of a given set of filters the variation has passed.
- `INFO` - An extensible list of key-value pairs (fields) describing the variation. See below for some common fields. Multiple fields are separated by semicolons with optional values in the format: "<key>=[,data]".
- `FORMAT` - An (optional) extensible list of fields for describing the samples. See below for some common fields.
- `SAMPLE,[SAMPLE...]` - For each (optional) sample described in the file, values are given for the fields listed in FORMAT

## Notes

AF (Alternate allele frequency)
- AF is the frequency for an alternate allele
- AF is calculated (AC/AN)
- AF tag can be used to infer the minor allele frequency (MAF) (Check bcftools fill-tags plugin)
- If AF < 0.5, then AF is equal to MAF
- Rare variants generally has AF or MAF < 5 % (0.05)

MAF (Minor allele frequency)
- MAF refers to the minor allele (least frequent) frequency
- An alternate allele may not be always minor allele
