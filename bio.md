# Bioinformatics Reference

- HRC - Haplotype Reference Consortium

- Adenine (A) binds to Thymine (T)
- Guanine (G) binds to Cytosine (C)
- Purines: A/G, Pyrimindines: C/T
- 5' to 3' is the + strand
- 3' to 5' is the - strand

Chromosomes
- 1-22
- X (23 Plink)
- Y (24 Plink)
- XY (25 Plink) Pseudo-autosomal region
- M or MT (26 Plink)

RNA
- RNA translates to amino acids in 3 base-pair chunk called codons
- Since there are 4 different bases (ATGC), there are 4^3 or 64 combinations possible.
- 61 of these codons code amino-acids, 3 are stop-codons
- NCBI National Center for Biotechnology Information (Under NLM National Library of Medicine, NIH)
- Central Dogma: DNA (transcription) to RNA (translation) to Protein
- Autosome - Any chromosome that is not a sex chromosomes
- Allosome - A sex chromosome, heterotypical chromosome, heterochromosome, or idiochromosome

# Bioinformatics

## Tools / Links

- https://www.ebi.ac.uk/gwas/ # GWAS Catalog - Links diseases/conditions with genes/SNPs
- http://bedtools.readthedocs.io/
- http://software-carpentry.org/lessons/
- http://crossmap.sourceforge.net/ # Range Translation for bam/sam, bed, vcf, etc.
- http://bedtools.readthedocs.io/en/latest/
- http://quinlanlab.org/tutorials/bedtools/bedtools.html
- http://hmpdacc.org/HMASM/ # microbiome
- http://biom-format.org/ # biological observation matrix (biom) format
- http://gensc.org # genomic standards consortium
- http://software.broadinstitute.org/software/igv/MutationData # Integrative Genomics Viewer
- https://genome.ucsc.edu/cgi-bin/hgTracks?db=hg38 # University of California Santa Cruz Genome Browser
- https://github.com/usnistgov/SVClassify/blob/master/code/svclassify.pl
- http://bmcgenomics.biomedcentral.com/articles/10.1186/s12864-016-2366-2

## NCBI

- National Institutes of Health (NIH)
  - National Library of Medicine (NLM)
    - National Center for Biotechnology Information (NCBI)


- https://www.ncbi.nlm.nih.gov/
- https://eutils.ncbi.nlm.nih.gov/entrez/eutils/einfo.fcgi # Get all DB names
- http://ftp.ncbi.nlm.nih.gov/entrez/entrezdirect/edirect.tar.gz
- https://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/current/sratoolkit.current-centos_linux64.tar.gz

## Next Generation Sequencing (NGS)

- Steps
  - DNA or cDNA Library prepared from subject DNA
  - Adapters added to library DNA fragments
  - DNA fragments introduced to flow cell which has an oligo "lawn" catching fragments via their adapters
  - Fragments are isolated and cloned into a cluster
  - Clusters are sequenced by introducing flourescent nucleotides one by one as they are read

- Multiplexing allows large numbers of librariestobe pooled and sequenced simultaneously during
  a single sequencing run. Unique index sequences are added to each DNA fragment during library
  prepration so that each read can be identified and sorted before final analysis.

## Whole Exome Sequencing (WES)

## TEDDY

- The Environmental Determinants of Diabetes in the Young
- Started in 2002 and anticipated to continue through 2023
- Led by the NIDDK (The National Institute of Diabetes and Digestive and Kidney Diseases) and supported in full by the Special Statutory Funding Program for Type 1 Diabetes Research.
- Right now, there is no known way to prevent type 1 diabetes.
- Scientists know that a complex interplay of genetic and environmental factors underlies the development of the disease, and research has identified many genes that play a role.  H
- owever, scientists do not know what environmental factor or factors may protect against, or “trigger,” the development of type 1 diabetes.  TEDDY was started to answer that critical question.
- Of those screened, over 8,000 were enrolled in the study.
The study takes an enormous commitment by families: each child’s family records information about illnesses, diet, and other environmental exposures in their “TEDDY Book”; collects frequent stool, toenail, and other samples; and makes regular visits to have their child’s blood tested.
- To identify causative or protective factors, they are studying:
genes, gene expression, proteins, and metabolites (products of metabolism);
environmental data; and
bacteria, viruses, and other infectious agents.

## GRCh38

See: https://www.ncbi.nlm.nih.gov/grc/human

- Ensembl Genome (release-89)
  - [Homo_sapiens.GRCh38.dna.primary_assembly.fa.gz](http://ftp.ensembl.org/pub/release-89/fasta/homo_sapiens/dna/Homo_sapiens.GRCh38.dna.primary_assembly.fa.gz)
    ([dir](http://ftp.ensembl.org/pub/release-89/fasta/homo_sapiens/dna/)) ([README](http://ftp.ensembl.org/pub/release-89/fasta/homo_sapiens/dna/README))
  - [Homo_sapiens.GRCh38.89.gtf.gz](http://ftp.ensembl.org/pub/release-89/gtf/homo_sapiens/Homo_sapiens.GRCh38.89.gtf.gz)
    ([dir](http://ftp.ensembl.org/pub/release-89/gtf/homo_sapiens/)) ([README](http://ftp.ensembl.org/pub/release-89/gtf/homo_sapiens/README))
  - [GCA_000001405.25 GRCh38.p10 Assembly](http://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/001/405/GCA_000001405.25_GRCh38.p10/)
- UCSC hg38 (release-147)
  - [snp147Common.txt.gz](http://hgdownload.cse.ucsc.edu/goldenPath/hg38/database/snp147Common.txt.gz)
    ([dir](http://hgdownload.cse.ucsc.edu/goldenPath/hg38/database))


## Notes

- Bioinformatics - A field of science in which biology, computer science, and information technology merge into a single discipline to analyse biological information using computers and statistical techniques.

- A tag SNP is a representative single nucleotide polymorphism (SNP) in a region of the genome with high linkage disequilibrium that represents a group of SNPs called a haplotype. It is possible to identify genetic variation and association to phenotypes without genotyping every SNP in a chromosomal region. 10 million SNPs but 500K tag SNPs.

- In population genetics, linkage disequilibrium is the non-random association of alleles at different loci. Loci are said to be in linkage disequilibrium when the frequency of association of their different alleles is higher or lower than what would be expected if the loci were independent and associated randomly.

- Linkage disequilibrium is influenced by many factors, including selection, the rate of recombination, the rate of mutation, genetic drift, the system of mating, population structure, and genetic linkage. As a result, the pattern of linkage disequilibrium in a
genome is a powerful signal of the population genetic processes that are structuring it.

- In spite of its name, linkage disequilibrium may exist between alleles at different loci without any genetic linkage between them and independently of whether or not allele frequencies are in equilibrium (not changing with time).[1] Furthermore, linkage disequilibrium is sometimes referred to as gametic phase disequilibrium;[2] however, the concept also applies to asexual organisms and therefore does not depend on the presence of gametes.

- Each chromosome contains hundreds to thousands of genes, which carry the instructions for making proteins. Each of the estimated 30,000 genes in the human genome makes an average of three proteins.

- Homozygote - An individual having two identical alleles of a particular gene or genes and so breeding true for the corresponding characteristic.

- [Genetic Markers](https://en.wikipedia.org/wiki/Genetic_marker):
  - RFLP (or Restriction fragment length polymorphism)
  - SSLP (or Simple sequence length polymorphism)
  - AFLP (or Amplified fragment length polymorphism)
  - RAPD (or Random amplification of polymorphic DNA)
  - VNTR (or Variable number tandem repeat)
  - SSR Microsatellite polymorphism, (or Simple sequence repeat)
  - SNP (or Single nucleotide polymorphism)
  - STR (or Short tandem repeat) - used by CODIS
  - SFP (or Single feature polymorphism)
  - DArT (or Diversity Arrays Technology)
  - RAD markers (or Restriction site associated DNA markers)


- Bedtools - Collectively, the bedtools utilities are a swiss-army knife of tools for a wide-range of genomics analysis tasks. The most widely-used tools enable genome arithmetic: that is, set theory on the genome. For example, bedtools allows one to intersect, merge, count, complement, and shuffle genomic intervals from multiple files in widely-used genomic file formats such as BAM, BED, GFF/GTF, VCF. While each individual tool is designed to do a relatively simple task (e.g., intersect two interval files), quite sophisticated analyses can be conducted by combining multiple bedtools operations on the UNIX command line.
Bedtools is developed in the Quinlan laboratory at the University of Utah and benefits from fantastic contributions made by scientists worldwide.

- BWA - BWA is a software package for mapping low-divergent sequences against a large reference genome, such as the human genome. It consists of three algorithms: BWA-backtrack, BWA-SW and BWA-MEM. The first algorithm is designed for Illumina sequence reads up to 100bp, while the rest two for longer sequences ranged from 70bp to 1Mbp. BWA-MEM and BWA-SW share similar features such as long-read support and split alignment, but BWA-MEM, which is the latest, is generally recommended for high-quality queries as it is faster and more accurate. BWA-MEM also has better performance than BWA-backtrack for 70-100bp Illumina reads.

- Minor allele frequency (MAF) refers to the frequency at which the second most common allele occurs in a given population. SNPs with
a minor allele frequency of 5% or greater were targeted by the HapMap project.

- Allele - one of two or more alternative forms of a gene that arise by mutation and are found at the same place on a chromosome. An allele is found at a fixed spot on a chromosome. Chromosomes occur in pairs so organisms have two alleles for each gene — one allele in each chromosome in the pair. Since each chromosome in the pair comes from a different parent, organisms inherit one allele from each parent for each gene. The two alleles inherited from parents may be same (homozygous) or different (heterozygotes).

- Allele frequency (also gene frequency) - the relative frequency of an allele (variant of a gene) at a particular locus in a population, expressed as a fraction or percentage. Specifically, it is the fraction of all chromosomes in the population that carry that allele. Microevolution is the change in allele frequencies that occurs over time within a population.

- MAF (Minor allele frequency) - refers to the frequency at which the second most common allele occurs in a given population. It is widely used in population genetics studies because it provides information to differentiate between common and rare variants in the population. As an example, a recent study sequenced the whole genomes of 2,120 Sardinian individuals. The authors classified the variants found in the study in three classes according to the frequency of the MAF. It was observed that rare variants (MAF < 0.5%) appeared more frequently in coding regions than common variants (MAF >5%) in this population.

- How to interpet MAF data:
  - Introduce the reference of a SNP of interest, as an example: rs429358, in a database (dbSNP or other).
  - Find MAF/MinorAlleleCount link. MAF/MinorAlleleCount: C=0.1506/754 (1000 Genomes)
  - What do those numbers mean?:
      - C is the minor allele for that particular locus
      - 0.1506 is the frequency of the C allele (MAF), it means 15% within the 1000 Genomes database.
      - 754 is the number of times this SNP has been observed in the population of the study.


- Gene - a distinct sequence of nucleotides forming part of a chromosome, the order of which determines the order of monomers in a polypeptide or nucleic acid molecule which a cell (or virus) may synthesize. The concept of a gene continues to be refined as new phenomena are discovered.[3] For example, regulatory regions of a gene can be far removed from its coding regions, and coding regions can be split into several exons. Some viruses store their genome in RNA instead of DNA and some gene products are functional non-coding RNAs. Therefore, a broad, modern working definition of a gene is any discrete locus of heritable, genomic sequence which affect an organism's traits by being expressed as a functional product or by regulation of gene expression.

- Gene complex -  tightly linked groups of genes, often created via gene duplication (sometimes called segmental duplication if the duplicates remain side-by-side). Here, each gene has similar though slightly diverged function. For example, the human major histocompatibility complex (MHC) region is a complex of tightly linked genes all acting in the immune system, but has no claim to be a supergene, even though the component genes very likely have epistatic effects and are in strong disequilibrium due in part to selection.

- HLA (Human Leukocyte Antigen) - a gene complex encoding the major histocompatibility complex (MHC) proteins in humans. These cell-surface proteins are responsible for the regulation of the immune system in humans. The HLA gene complex resides on a 3 Mbp stretch within chromosome 6p21. HLA genes are highly polymorphic, which means that they have many different alleles, allowing them to fine-tune the adaptive immune system. The proteins encoded by certain genes are also known as antigens, as a result of their historic discovery as factors in organ transplants.

- Exon - any part of a gene that will encode a part of the final mature RNA produced by that gene after introns have been removed by RNA splicing. The term exon refers to both the DNA sequence within a gene and to the corresponding sequence in RNA transcripts.

- Exome - the part of the genome formed by exons, the sequences which when transcribed remain within the mature RNA after introns are removed by RNA splicing.

- Phenotype - A phenotype (from Greek phainein, meaning "to show", and typos, meaning "type") is the composite of an organism's observable characteristics or traits, such as its morphology, development, biochemical or physiological properties, behavior, and products of behavior (such as a bird's nest). A phenotype results from the expression of an organism's genetic code, its genotype, as well as the influence of environmental factors and the interactions between the two. When two or more clearly different phenotypes exist in the same population of a species, the species is called polymorphic.

- Epigenetics - studies stably heritable traits (phenotypes) that cannot be explained by changes in DNA sequence. It often refers to changes in a chromosome that affect gene activity and expression, but can also be used to describe any heritable phenotypic change that doesn't derive from a maofication of the genome, such as Prions.

- Gene expression - the process by which information from a gene is used in the synthesis of a functional gene product

- Gene product - the biochemical material, either RNA or protein, resulting from expression of a gene. A measurement of the amount of gene product is sometimes used to infer how active a gene is.

- Heritability - statistic used in breeding and genetics works that estimates how much variation in a phenotypic trait in a population is due to genetic variation among individuals in that population

- Genotyping - Genotyping is the process of determining differences in the genetic make-up (genotype) of an individual by examining the individual's DNA sequence using biological assays and comparing it to another individual's sequence or a reference sequence. It reveals the alleles an individual has inherited from their parents.[1] Traditionally genotyping is the use of DNA sequences to define biological populations by use of molecular tools. It does not usually involve defining the genes of an individual.

- Genetic Marker  - a gene or DNA sequence with a known location on a chromosome that can be used to identify individuals or species. It can be described as a variation (which may arise due to mutation or alteration in the genomic loci) that can be observed. A genetic marker may be a short DNA sequence, such as a sequence surrounding a single base-pair change (single nucleotide polymorphism, SNP), or a long one, like minisatellites.

- Meiosis - a type of cell division that reduces the number of chromosomes in the parent cell by half and produces four gamete cells. This process is required to produce egg and sperm cells for sexual reproduction.

- Gamete - a mature haploid male or female germ cell that is able to unite with another of the opposite sex in sexual reproduction to form a zygote.

- Clade (branch) - a group of organisms believed to have evolved from a common ancestor, according to the principles of cladistics. "Clade" comes from the ancient greek "klados" or branch.

- Mitochondria (singlular mitochondrion) - a double membrane-bound organelle found in all eukaryotic organisms, although some cells in some organisms may lack them (e.g. red blood cells).  In addition to supplying cellular energy, mitochondria are involved in other tasks, such as signaling, cellular differentiation, and cell death, as well as maintaining control of the cell cycle and cell growth.[6] Mitochondrial biogenesis is in turn temporally coordinated with these cellular processes. Mitochondria have been implicated in several human diseases, including mitochondrial disorders, cardiac dysfunction, heart failure and autism.

- Components of a typical animal cell:
  - Nucleolus
  - Nucleus
  - Ribosome
  - Vesicle
  - Rough endoplasmic reticulum
  - Golgi apparatus (or "Golgi body")
  - Cytoskeleton
  - Smooth endoplasmic reticulum
  - Mitochondrion
  - Vacuole
  - Cytosol (fluid that contains organelles, comprising the cytoplasm)
  - Lysosome
  - Centrosome
  - Cell membrane


- Open reading frame (ORF) - the part of a reading frame that has the potential to be translated. an ORF is a continous stretch of codons that do not contain a stop codon (usually UAA, UAG, or UGA).

- Databases
  - European Molecular Biology Laboratory (EMBL)
  - GenBank
  - DNA Database of Japan (DDBJ)


- We can summarize the fields of bioinformatics and genomics with three perspectives:
  - Cell
    - DNA (genome)
    - RNA (transcriptome)
    - Protein sequences (proteome)
  - Molecular Biology
    - DNA -> RNA -> protein -> cellular phenotype
  - Genomics
    - genome -> trancriptome -> proteome -> cellular phenotype


- Hemoglobin is the main oxygen carrier in blood of vertebrates.

- CNV (copy-number-variation) - a large category of structure variation, which includes insertions, deletions, and duplications.

- Inversion - A chromosome rearrangement in which a segment of a chromosome is reversed end to end. An inversion occurs when a single chromosome undergoes breakage and rearrangement within itself.

- Inversions are of two types:
  - paracentric - does not include the centromere and both breaks occur in one arm of the chromosome
  - pericentric - include the centromere and there is a break point in each arm.


- SNP (single-nucleotide polymorphism) - a variation in a single nucleotide that occurs at a specific position in the genome, where each variation is present to some appreciable degree within a population (e.g. > 1%). Sickle-cell anemia, β-thalassemia and cystic fibrosis result from SNPs. A single base mutation in the APOE (apolipoprotein E) gene is associated with a higher risk for Alzheimer's disease.

- SNV (single-nucleotide variant) - A single-nucleotide variant (SNV) is a variation in a single nucleotide without any limitations of frequency and may arise in somatic cells. A somatic single nucleotide variation (e.g., caused by cancer) may also be called a single-nucleotide alteration.

- Other structural variants
  - Non-tandem duplications - sequence is duplicated and inserted in inverted or direct orienttion into another part of the genome
  - Deletion-inversion-deletions
  - Duplication-inversion-duplications
  - Tandem duplications with nested deletions


- Single-nucleotide polymorphisms may fall within coding sequences of genes, non-coding regions of genes, or in the intergenic regions
(regions between genes). SNPs within a coding sequence do not necessarily change the amino acid sequence of the protein that is
produced, due to degeneracy of the genetic code.

- SNPs in the coding region are of two types:
  - Synonymous (do not affect the protein sequence)
  - Nonsynonymous SNPs change the amino acid sequence of protein
    - missense - results in a codon that codes for a different amino acid
    - nonsense - results in a premature stop codon resulting in a truncated, incomplete, and usually nonfunctional protein product

- For a variety of reasons, including decay of reagents as they sit on the sequencing machine, the quality of base calls tends to decrease as sequencing progresses. As a result the 5’ ends will tend to have higher quality than the 3’ ends and forward reads will tend to have better quality than reverse reads. Low quality base calls can impair the accuracy of mapping algorithms so it is important to to remove them. Low quality tails can be removed though the removal of the 3’ ends from all of the reads but, that would result in the removal of many reads that were of higher quality as well.

- Phred Q = -10log(p), where p is the probability that the inferred base is incorrect.
  - 10 = 1 in 10
  - 20 = 1 in 100
  - 30 = 1 in 1000
  - 40 = 1 in 10000
  - 50 = 1 in 100000

- DNA Replication
  - A helicase that unwinds the superhelix as well as the double-stranded DNA helix to create a replication fork
  - SSB protein that binds open the double-stranded DNA to prevent it from reassociating
  - RNA primase that adds a complementary RNA primer to each template strand as a starting point for replication
  - DNA polymerase III that reads the existing template chain from its 3' end to its 5' end and adds new complementary nucleotides from the 5' end to the 3' end of the daughter chain
  - DNA polymerase I that removes the RNA primers and replaces them with DNA.
  - DNA ligase that joins the two Okazaki fragments with phosphodiester bonds to produce a continuous chain.

- RNA Transcription
  - RNA polymerase, together with one or more general transcription factors, binds to promoter DNA.
  - RNA polymerase creates a transcription bubble, which separates the two strands of the DNA helix. This is done by breaking the hydrogen bonds   between complementary DNA nucleotides.
  - RNA polymerase adds RNA nucleotides (which are complementary to the nucleotides of one DNA strand).
  - RNA sugar-phosphate backbone forms with assistance from RNA polymerase to form an RNA strand.
  - Hydrogen bonds of the RNA–DNA helix break, freeing the newly synthesized RNA strand.
  - If the cell has a nucleus, the RNA may be further processed. This mayclude polyadenylation, capping, and splicing.

- A DNA transcription unit encoding for a protein may contain both a coding sequence, which will be translated into the protein, and regulatory sequences, which direct and regulate the synthesis of that protein. The regulatory sequence before ("upstream" from) the coding sequence is called the five prime untranslated region (5'UTR); the sequence after ("downstream" from) the coding sequence is called the three prime untranslated region (3'UTR).

Amino Acids

```
     A   C   G   T
_____________________________
AA | Lys Asn Lys Asn
AC | Thr Thr Thr Thr
AG | Arg Ser Arg Ser
AT | Ile Ile MET Ile
CA | Gln His Gln His
CC | Pro Pro Pro Pro
CG | Arg Arg Arg Arg
CT | Leu Leu Leu Leu
GA | Glu Asp Glu Asp
GC | Ala Ala Ala Ala
GG | Gly Gly Gly Gly
GT | Val Val Val Val
TA | Z   Tyr Z   Tyr
TC | Ser Ser Ser Ser
TG | Z   Cys Trp Cys
TT | Leu Phe Leu Phe

Z = STOP CODON
```

- Isoleucine, I, ATT, ATC, ATA
- Leucine, L, CTT, CTC, CTA, CTG, TTA, TTG
- Valine, V, GTT, GTC, GTA, GTG
- Phenylalanine, F, TTT, TTC
- Methionine	M	ATG
- Cysteine 	C, TGT, TGC
- Alanine, A, GCT, GCC, GCA, GCG
- Glycine, G, GGT, GGC, GGA, GGG
- Proline, P, CCT, CCC, CCA, CCG
- Threonine, T, ACT, ACC, ACA, ACG
- Serine, S, TCT, TCC, TCA, TCG, AGT, AGC
- Tyrosine, Y,	TAT, TAC
- Tryptophan  	W	TGG
- Glutamine  	Q	CAA, CAG
- Asparagine  	N	AAT, AAC
- Histidine, H, CAT, CAC
- Glutamic acid, E, GAA, GAG
- Aspartic acid, D, GAT, GAC
- Lysine, K, AAA, AAG
- Arginine, R, CGT, CGC, CGA, CGG, AGA, AGG
- Stop codons: TAA, TAG, TGA


## Notes

adapters: The oligosbound tothe 5′and 3′end ofeachDNAfragment in a sequencinglibrary. The adaptersare
complementary tothe lawnofoligospresent on the surface ofIllumina sequencingflow cells.
