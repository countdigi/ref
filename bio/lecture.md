# 2018-05 MIT GWAS Lecture

Lecture by Prof. David Gifford is on human genetics.
He covers how scientists discover variation in the human genome.
He discusses how to prioritize variants based on their importance.
And then covers how to prove causation, not just correlation.￼

[Video](https://www.youtube.com/watch?v=KYQ2dPW5nEU)

Today's Narrative Arc

- We can discover human variants that are associated with a phentotype by studying the genotypes of
  case and control populations
  - Approach 1 - Use allelic counts from SNP arrays (SNPs called from microarray data)
  - Approach 2 - Use read counts from sequeuncing (multiple reads per variant per individual)
- We can prioritize variants based upon their estimated importantce
- Follow up confirmation is important because correlation is not equivalent to causality


Computational Approaches

- Contingency tables for allelic association tests and genotypic association tests
- Methods of testing - Chi-Square tests, Fisher's exact test
- Likelihood based tests of case/control posterior genotypes

Mendelian Disorder

- Disorder defined by a single gene or single locus in an inheritance pattern
- They are relative easy to map
- They are usually at a low-frequency in the population due to selection bias

Allele Frequency

- 50.0% High-frequency polymorphisms (hapmap)
- 5.0% Lower-frequency polymorphisms (1000 genomes, new arrays, imputation)
- 0.5% Rare mutations (MC4R, ABCA) (Direct sequencing, CNV array-based detection)
- Association between genotype and phenotype
- Very common variants tend to have small effects
- Very rare variants tend to have large effects


Association between genotype and phenotype

- some have the mutation but only some show the disease

Age-related macular degeneration (AMD

- Cohort - 2172 unrelated European descent individuals at least 60 years old
- 1328 cases with AMD
- 934 controls with no AMD
- Genotyped cases and controls them with microarray
- SNP rs1061170
- 2004 - little know about cause of AMD
- 2006 - GWAS study identified 3 genes and 5 common variants together explaining > 50% of risk

Chi-Squared

```
allele   | cases    | controls  | total alleles
C        | 1522 (a) |  670 (b)  | 2192
T        |  954 (c) |  1198 (d) | 2152
-----------------------------------------------
total    | 2476     |  1868     | 4344

chi-square metric:

x2 = (ad-bc)2(a+b+c+d) / (a+b)(c+d)(b+d)(a+c)
x2 = 279
Df = (2 rows -1 ) x (2 columns -1 ) = 1
P-value = 1.2 x 10^-62

Looks like we have SNP that is associated with a disease.
````

Fisher's Exact Test

- Population stratification is when subpopulations exhibit allelic variation because of ancestry
- Can cause false positives in an association study if there are SNP differences in the case and control population structures
- Control for this artifact by testing control SNPs for general elevation in x2 distribution between cases and controls

Linkage Disequilibrium

- In population genetics, linkage disequilibrium is the non-random association of alleles at different loci
  in a given population.
- Loci are said to be in linkage disequilibrium when the frequency of association of their different alleles is higher or lower   than what would be expected if the loci were independent and associated randomly.

Haploid Gamete with: A/a, B/b

- 4 Possibilities:
  - AB, aB, Ab, ab
- But AB and ab are the only ones who result
- Aha - these 2 things are linked so if they are always inhereted together the disance between

- Linkage Disequilibrium (LD) between two loci L1 and L2 in gametes
  - Average distance of crossover events? 40-50 Megabases
  - LD is showing how skewed the probability is for two loci from being independent
  - r^s from human chromosome 22 graph (0 to 1000 kb distance)

Proxy SNPs - SNP highly correlated to another SNP we are interested in detecting variant

Interesting point about mom-and-dad for alleles: <https://youtu.be/KYQ2dPW5nEU?t=1883>

- Phasing of the variants - placing the variants on a particular chromosome and figuring out different
  phentotypic consequences (dominant/recessive)

Variant phasing
- Phasing assigns alleles to their parental chromosome
- Set of ordered alleles along a chromosome is a haplotype
- Known haplotypes can assist with phasing
- Phasing is critical for understanding the functional status of genes with more than one important SNP
 (are the non-reference alleses on different chromosome?) Is so the gene may not be functional.
- New long read sequencing technologies hase variants in observed reads



BAM headers <https://youtu.be/KYQ2dPW5nEU?t=2271>
- Required: Standard Header
  - `@HD  VN:1.0 GO:none SO:coordinate`
- Essential: Contigs of aligned reference sequence. Should be in karotypic order.
  - `@SQ SN:chrM   LN:16571`
  - `@SQ SN:chr1   LN:2343545`
- Essential: Read Groups. Carries platform (PL), library (LB), and sample (SM) information.
  Each read is associated with a read group.
  - `@RG   ID:20ABC.1  PL:Illumina   PU:d34343434.df LB:Solexa-343434 CN:B`


Variant Calling
- In theory it should be very easy
- But real sequence data does not always align neatly and the challenge is to detect if a variant is really a variant

GATK
- Raw Reads
- Map to Reference (Non-GATK)
- Mark Duplicates (Non-GATK)
- Indel Realignment
- Base Recalibration
- RR Compression
- Analysis-Ready Reads

Problems with false-positive variant calls
- Deletions in an individual can cause things to be mapped on one side but create variants on the other because of shifting effect
- Instruments some times report non-accurate probability scores for reads - you want that estimate as accurate as possible

A genotype of an individual thinks about *both* of the alleles for that individual.
- They can be phased (i.e. knowing which allele comes from what parent)
- Or unphased - in which case you simply know the number of reference alleles

Joint estimation of genotype frequencies

0 - No reference alleles present
1 - One reference alleles present
2 - Two reference alleles present

Is a population in equilibrium?
- Hardy Weinberg Equilibrium (HW)
- When a population is in HWE we can compute genotypic frequencies from allelic frequencies

The best test will change based on whether the population is in equilibrium


