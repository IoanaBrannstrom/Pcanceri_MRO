#author: Ioana Onut Brännström


module load bioinfo-tools
module load blast/2.11.0+         #blast/2.9.0+
module load gnuparallel/20180822

# this is the format Blobplots needs --outfmt '6 qseqid staxids bitscore'
# the script can be used for blast searches against NCBI or against a local database if changed accordingly

#####------Blastn against NCBInt - format for Blobplots
MyFasta=$1
E=1e-20   #change parameters if need it  
MAX=500	#change parameters if need it
MONTH=March2021 	#change parameters if need it
Append=Pcan.2014.MiSeq_Ge	#change parameters if need it


### Blastn searches
blastn -db nt -query $MyFasta -num_threads 4  -max_target_seqs $MAX -evalue $E -outfmt '6 qseqid staxids bitscore std sscinames sskingdoms stitle' -out Blastn.${Append}-vs-NCBInt.${MONTH}_${E}_${MAX}hits.tab



### Blastp searches
blastp -db nr -query $MyFasta -num_threads 6  -max_target_seqs $MAX -evalue $E -outfmt '6 qseqid staxids bitscore std sscinames sskingdoms stitle' -out Blastp.${Append}-vs-NCBInr.${MONTH}_${E}_${MAX}hits.tab

### Blastx searches
blastx -db nr -query $MyFasta  -out $OUT3 -max_target_seqs 500 -num_threads 6   -outfmt '6 qseqid staxids bitscore std sscinames sskingdoms stitle'  -culling_limit 5 -evalue $e
