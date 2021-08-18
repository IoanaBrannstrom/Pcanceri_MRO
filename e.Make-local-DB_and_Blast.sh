#author: Ioana Onut Brännström


module load bioinfo-tools
module load blast/2.9.0+

######################


DB=$1
Query=$2
#OUT1=Blastn_$1_vs_$2_1e-10.tab
OUT2=BlastnBlobs_$1_vs_$2_${e}.tab
e=1e-20
$DBtype=  #choose 'nucl' for nucleotide fasta file and 'prot' for proteins

## BLASTn tabular output format 6: qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore

################# change to the appropriate taxid
#TAXID=29158  # Mytilus galoprovincialis
TAXID=2184066  #Marteilia pararefringens 
#TAXID=135620  # Oceanospirillaceae
#TAXID=267888  #Pseudoalteromonadaceae 
#TAXID=6550   # Mytilus edulis
#TAXID=6565 # Crassosstrea virginica
#TAXID=33208 # Metazoa
#TAXID=195010 #Mikrocytos mackini
#TAXID=1483957 #Paramikrocytos canceri
#TAXID=2 #Bacteria
#TAXID=6755 #Cancer pagurus 
#TAXID=1081671 #Enterospora canceri
#TAXID=1822052 #Hepatospora eriocheir
#TAXID=40302 #Nosema ceranae
#TAXID=2387 #transpozons contigs cloud S from P. canceri
#TAXID=146866 #Pseudoloma neurophilia


## with taxid for nucl/prot
makeblastdb -in $DB -dbtype $DBtype -parse_seqids -blastdb_version 5 -taxid $TAXID

## without taxid for nucl
#makeblastdb -in $DB -dbtype $DBtype -parse_seqids -blastdb_version 5 


## with tax id for proteins
#makeblastdb -in $GenomeFasta -dbtype prot -parse_seqids -blastdb_version 5 -taxid $TAXID

### outfmt 6 + extra
#blastn -db $DB  -query $Query  -max_target_seqs 300 -out $OUT1 -num_threads 2   -outfmt '6 std sscinames scomnames sskingdoms stitle staxids' -evalue $e



### for blobtools
#blastn -db $DB  -query $Query  -max_target_seqs 300 -out $OUT2 -num_threads 2   -outfmt '6 qseqid staxids bitscore std sscinames scomnames sskingdoms stitle' -evalue $e

#blastx -db $DB  -query $Query  -max_target_seqs 300 -out $OUT2 -num_threads 4   -outfmt '6 qseqid staxids bitscore std sscinames scomnames sskingdoms stitle frames qgi' -evalue $e

#blastp -db $DB  -query $Query  -max_target_seqs 300 -out $OUT2 -num_threads 4   -outfmt '6 qseqid staxids bitscore std sscinames scomnames sskingdoms stitle frames qgi' -evalue $e
