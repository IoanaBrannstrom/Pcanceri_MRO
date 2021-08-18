# Pcanceri_MRO
# A novel mitochondrion-related organelle revealed through comparative genomics  of the uncultured protist parasite *Paramikrocytos canceri* (Rhizaria, Ascetosporea)

The following scripts were used to analyse the data for xxxx article

## **A.Scripts used in the Decontamination Workflow**
*The a-i tags represent the tags used in Figure.X.Decontamination workflow.*

**a. Adaptor removal and read trimming**
- Fastqc   -> *a.Fastqc.sh*
- Trimmomatic ->  *a.trimReads.sh*

**b. k-mer and GC frequency plots**
- KATgc and KAThist ->  *b.runKAT_plotGC_and_hist.sh*
- K-merginie ->   *b.run_Kmergienie.sh*
	  
**c. Assemblies**
- Metaspades -> *c.runSpades.sh*
- Spades -> *c.runSpades.sh*
- Trinity de novo -> *c.runTrinity_denovo.sh*


**d. Retrieve mapped and unmapped reads**
- BWA -> *d.runBWA.sh*
- STAR -> *d.runStar.sh*
- Samtools & Bedtools to get mapped reads -> *d.get_mapped.sh*
- Samtools & Betdtools to get unmapped reads -> *d.get_unmapped.sh*


**e. Identify and remove contamination**
- Blast searches against NCBI  -> *e.Blast_searches_againstNCBI.sh*
- Blast searches against a local database -> *e.Make-local-DB_and_Blast.sh*
- Blobtools -> *e.run_Blobtools.sh*
            -> *e.run_Blobtools_seqfilter.sh*
- Diamond searches -> *e.runDiamond_for_Blobtools.sh*
- inhouse scripts to remove final contamination from the fasta file -> *e.get_contamination_TAXID.py*

**f. read coverage normalisation**
- BBnorm -> *f.Run_bbnorm.sh*

**g. evaluate assemblies**
- BWA   -> use *d.runBWA.sh*
- Blast   -> use Blast scripts from point e.
- Busco   -> *g.run_Busco.sh*
- KATcomp -> *g.runKAT_comp.sh*
- Trinity stats -> *g.Trinity.stats.sh*
- Samtools calculate coverage -> *g.calculate_coverage.sh*
- R script  correlation plots   -> *g.Plot_genome.size-coverage-BUSCO.R*
- Blobtools to visualise possible contamination -> use *e.run_Blobtools.sh*

**h. gene models**
- Prodigal was used for all genome assemblies -> *h.run_Prodigal_v1.sh*
- Transdecoder for the *P. canceri* transcriptome and the metatranscriptomes - *h.run_Transdecoder.sh*



**i. genes functional annotation**
- Interproscan  -> *i.run_interproscan.sh*
- GhostKoala -> searches were performed online @ https://www.kegg.jp/ghostkoala/
- EggNog -> searches were performed online @  http://eggnog-mapper.embl.de/ under the following settings:
```
emapper.py --cpu 10 -i /data/shared/emapper_jobs/user_data/MM_94ph5et0/query_seqs.fa --output query_seqs.fa --output_dir /data/shared/emapper_jobs/user_data/MM_94ph5et0 -m diamond -d none --tax_scope auto --go_evidence non-electronic --target_orthologs all --seed_ortholog_evalue 0.001 --seed_ortholog_score 60 --query-cover 20 --subject-cover 0 --override --temp_dir /data/shared/emapper_jobs/user_data/MM_94ph5et0
```
- Diamond blastp  -> use *e.runDiamond_for_Blobtools.sh*


 ## **C. Other scripts**
- deposit data to ENA -> *submit_to_ENA.sh*

## **D. Individual gene phylogenies**
- *Blastp_and_get-fasta_localDB.sh*
- *Blastp_and_get-fasta_NCBI.sh*
- *run_cd-hit_v1.sh* 
- *Mafft-linsi_TrimAl_IQtree.sh*
- *color_trees.pl*
- *FigTree2seq_remove_yellow.pl*
