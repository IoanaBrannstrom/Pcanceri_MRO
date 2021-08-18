#author: Ioana Onut Brännström


module load bioinfo-tools   			 # check for updates
module load TransDecoder/5.3.0
module load blast/2.9.0+
module load  pfam_scan/1.6
module load R_packages/3.5.0
module load hmmer/3.2.1

target_transcripts=$1

# I need to take it one step at the time because TransDecoder.LongOrf needs to be done first

# STEP 1: obtain the long ORFs
###################################
#TransDecoder.LongOrfs -t $target_transcripts


# STEP 2: blastp searches
###############################

#uniprot
#blastp -query /crex/proj/uppstore2018069/Ioana/Transdecoder/Trinity2.8.4_Paramikrocystos_de-novo.fasta.transdecoder_dir/longest_orfs.pep \
	#-db uniprot_sprot -max_target_seqs 1 \
    #-outfmt 6 -evalue 1e-5 -num_threads 10 > blastp_Trinity2.8.4_Paramikrocystos_de-novo.fasta.transdecoder.outfmt6


#Pfam search 
#hmmscan --cpu 8 -o TrinityDeNovo_MetaSpadesPcanceri.v-Sep2020_RENAMED  /crex/proj/uppstore2018069/Ioana/Paramykrocitos/Transdecoder/TrinityDenovo_MetatranscriptsPcanceri/TrinityDeNovo_MetaSpadesPcanceri.v-Sep2020_RENAMED.fasta.transdecoder_dir/longest_orfs.pep

#hmmscan [-options] <hmmdb> <seqfile>

#- I need to figure out where the HMMDB is



# STEP 3: predict the likely coding regions
###############################
TransDecoder.Predict -t $target_transcripts


# Common options TransDecoder.Predict:
#
#
#   --retain_long_orfs_mode <string>        'dynamic' or 'strict' (default: dynamic)
#                                        In dynamic mode, sets range according to 1%FDR in random sequence of same GC content.
#
# 
#   --retain_long_orfs_length <int>         under 'strict' mode, retain all ORFs found that are equal or longer than these many nucleotides even if no other evidence 
#                                         marks it as coding (default: 1000000) so essentially turned off by default.)
#
#   --retain_pfam_hits <string>            domain table output file from running hmmscan to search Pfam (see transdecoder.github.io for info)     
#                                        Any ORF with a pfam domain hit will be retained in the final output.
# 
#   --retain_blastp_hits <string>          blastp output in '-outfmt 6' format.
#                                        Any ORF with a blast match will be retained in the final output.
#
#   --single_best_only                     Retain only the single best orf per transcript (prioritized by homology then orf length)
#
#   --output_dir | -O  <string>            output directory from the TransDecoder.LongOrfs step (default: basename( -t val ) + ".transdecoder_dir")
#
#   -G <string>                            genetic code (default: universal; see PerlDoc; options: Euplotes, Tetrahymena, Candida, Acetabularia, ...)
#
#   --no_refine_starts                     start refinement identifies potential start codons for 5' partial ORFs using a PWM, process on by default.
