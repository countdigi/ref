# Bcftools

## VCF Format

1. CHROM - Chromosome name
2. POS - 1-based position. For an indel, this is the position preceding the indel.
3. ID - Variant identifier. Usually the dbSNP rsID.
4. REF - Reference sequence at POS involved in the variant. For a SNP, it is a single base.
5. ALT - Comma delimited list of alternative seuqence(s).
6. QUAL - Phred-scaled probability of all samples being homozygous reference.
7. FILTER - Semicolon delimited list of filters that the variant fails to pass.
8. INFO - Semicolon delimited list of variant information.
9. FORMAT - Colon delimited list of the format of individual genotypes in the following fields.
10. Sample(s) - Individual genotype information defined by FORMAT (Column 10, ...etc.)


```
*bcftools filter
*Filter variants per region (in this example, print out only variants mapped to chr1 and chr2)
qbcftools filter -r1,2 ALL.chip.omni_broad_sanger_combined.20140818.snps.genotypes.hg38.vcf.gz

*printing out info for only 2 samples:
bcftools view -s NA20818,NA20819 filename.vcf.gz

*printing stats only for variants passing the filter:
bcftools view -f PASS filename.vcf.gz

*printing variants withoud header:
bcftools view -H

*printing variants on a particular region:
bcftools view -r chr20:1-200000 -s NA20818,NA20819 filename.vcf.gz

*print all variants except for the ones falling within region:
bcftools view -t ^chr20:1-30000000 ex_bams.samtools.20161231.vcf.gz >out.vcf

*view the positions passed in a file (accepted files are .vcf and .bed):
bcftools view -R 0002.vcf in.vcf.gz


*view the positions passed in a tsv file:
bcftools view -R 0002.tsv in.vcf.gz
# The format of 0002.tsv:
20      79000   80000
20      90000   100000

*printing out only the chr info:
bcftools query -f '%CHROM\n' filename.vcf
/
*now, print out the chr\tpos
bcftools query -f '%CHROM\t%POS\n' filename.vcf
/
*now, print out the AF INFO field
bcftools query -f '%INFO/AF\n'
/
#getting a particular annotation from the VCF
bcftools query -f '%QUAL\n' 0002.vcf
/
#printing chr pos and a particular annotation from a VCF:
bcftools query -f '%CHROM\t%POS\t%INFO/DP\n' in.vcf.gz
/
#printing out the sets assigned by GATK CombineVariants
~/bin/bcftools-1.6/bcftools query -f '%set\n' out_combine.vcf.gz |sort |uniq
/
0#printing a list of samples from a VCF:
bcftools query -l test.vcf
/
#also, the FORMAT annotations can be obtained by:
~/bin/bcftools/bcftools query -f '[%GT]\n' ../0002.vcf |wc -l #the GT in this case
/
*selecting snps from file:
~/bin/bcftools/bcftools view -v snps lc_bams.bcftools.20170319.NA12878.vcf.gz
/
*selecting the variants from a VCF (excluding 0|0 genotypes)
bcftools view -c1 input.vcf
/
*selecting the non-variants from a VCF(AC=0)
bcftools view -H -C0 concat.allchrs.sites.vcf.gz
/
#filtering:
/
#using one of the INFO annotations (IDV)
bcftools filter -sFilterName -e'IDV<5' input.vcf
/
#OR logical operator:
bcftools filter -sFilterName -e'DP>50000 | IDV<9' input.vcf
/
#filtering on FORMAT annotation:
bcftools filter -sFilterName -e'FORMAT/DP<5' input.vcf
/
#filtering on INFO annotation:
bcftools filter -sFilterName -e'INFO/DP<5' input.vcf
/
#printing out variants that pass the filter:
~/bin/bcftools/bcftools view -f.,PASS lc_bams.bcftools.20170411.exc.norm.SNP.filtered.vcf.gz
/
#bcftools stats and filtering:
~/bin/bcftools/bcftools stats -f "PASS,." file.vcf
/
#select only biallelic (excluding multiallelic) snps
bcftools view -m2 -M2 -v snps input.vcf.gz
/
#select only the multiallelic snps
bcftools view -m3 -v snps input.vcf.gz
/
#printing the set info in the INFO field:
bcftools view -i 'set="freebayes_lcex"' combined.all.chr20.vcf.gz
/
#printing all entries having a quality <10
bcftools view -i 'QUAL<10' in.vcf.gz
/
#removing FORMAT column from the VCF
#it will remove all FORMAT annotations except the GT information
bcftools annotate -x FORMAT ifile.vcf.gz
/
#removing INFO field from VCF
bcftools annotate --remove INFO in.vcf.gz
/
#annotating a vcf file using the annotations from a different VCF (in this case we only annotate the INFO/DP)
bcftools annotate -c 'INFO/DP' -a annt.vcf.gz in.vcf.gz
/
#annotating a vcf file with a tabular file:
see page https://github.com/samtools/bcftools/wiki/HOWTOs#annotate-from-bed
/
#drop individual genotype information
bcftools view -G input.vcf.gz
/
#getting stats on the number of REF/ALT swaps and other things:
bcftools +fixref file.bcf -- -f ref.fa
/
#correcting the REF/ALT swaps:
bcftools norm --check-ref ws -f ref.fa in.vcf.gz -o out.vcf.gz -Oz
//
#changing the sample names in a VCF:
#the samplenames.txt file has the following format:
#oldsamplename newsamplename
bcftools reheader -s samplenames.txt NA12878.giab.SNP.chr20.non_valid.vcf.gz -o NA12878.giab.SNP.chr20.non_valid.reheaded.vcf.gz
//
#changing the header:
bcftools reheader -h newheader.txt ../combined.all.chr20.vcf.gz.snps.biallelic.vcf_chr20.vcf.gz.ensembl.vcf.gz.phased.ligated.NA12878.ucsc.vcf.gz -o combined.all.chr20.vcf.gz.snps.biallelic.vcf_chr20.vcf.gz.ensembl.vcf.gz.phased.ligated.NA12878.ucsc.reheaded.vcf.gz
//
# in order to use the plugins:
export BCFTOOLS_PLUGINS=~/bin/bcftools-1.6/plugins/
//
# taqg2tag:
# convert PL to GL
bcftools +tag2tag in.vcf -- -r --pl-to-gl
//
# normalizing the multiallelic variants:

# with -any I will split the multiallelic variants (SNPs+INDELs) into several records
bcftools norm -m -any in.vcf.gz -o out.norm.vcf.gz -Oz

For example:

chr20   60280   .       TTTCCA  TTTCCATTCCA,T   744     PASS    .

Will be converted to:

chr20   60280   .       TTTCCA  TTTCCATTCCA     744     PASS    .
chr20   60280   .       TTTCCA  T       744     PASS    .
//
#selecting the missing (uncalled) genotypes:
bcftools view -u in.vcf.gz -o missing_genotypes.vcf.gz -Oz
//
#select a particular genotype (0/1 or 1/1) from a vcf. In this case access sample accessed by index 8:
bcftools view -H combined.snps_indels_chr1.filt.vcf.gz.onlyvariants.vcf.gz.ensembl.vcf.gz.85706.vcf.gz -i 'GT[8]="het"'
//
#select all lines having exactly AC=2
bcftools view -i'AC=2' in.vcf.gz
//
# if we have a tab in a VCF defined in the header like:
##INFO=<ID=GRCH37_38_REF_STRING_MATCH,Number=0,Type=Flag,Description="Indicates reference allele in origin GRCh37 vcf string-matches reference allele in dbsnp GRCh38 vcf">
/
#we can check for the records having this tag by doing:
bcftools view -H -i'GRCH37_38_REF_STRING_MATCH=1' ALL.chr7_GRCh38.genotypes.20170504.ensembl.vcf.NA12878.biallelic.nonvariants.nonvalid.snps.vcf.gz |less
/
#And the contrary by doing:
bcftools view -H -i'GRCH37_38_REF_STRING_MATCH=0' ALL.chr7_GRCh38.genotypes.20170504.ensembl.vcf.NA12878.biallelic.nonvariants.nonvalid.snps.vcf.gz |less
/
# Filtering a VCF depending on a certain Allele frequency:
bcftools view -i 'INFO/AF > 0.8' z.vcf.gz
```
