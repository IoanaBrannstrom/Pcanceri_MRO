#author:Ioana Onut Brännström

module load bioinfo-tools
module load blast/2.7.1+



my_query=CaesaR   
OUT1=${my_query}_blastp_NCBI_e-big.tab
OUT2=${my_query}_blastp_NCBI_1e-20.tab
OUT3=${my_query}_blastp_NCBI_hits-names.txt

#### 1. blastp on NCBI
function apply_blastp {
    my_query=$my_query # The assembly is the first parameter to this function
    blastp -db nr  -query $my_query -num_threads 5  -max_target_seqs 10000 -evalue 1e-5 -outfmt '6 std sseqid staxids sscinames scomnames sskingdoms stitle' -out $OUT1

}

apply_blastp $my_query



#### 2. filter the output based on e-value
function filter_output {
query_hits=$OUT1
awk '$11<1e-20{print $0}' $query_hits > ${my_query}_blastp_NCBI_1e-20.tab

}

filter_output $query_hits


#### 3. extract the subject id if the hits 
function extract_sseqid {
	hits_IDs=$OUT2
	awk '{ print $2 }' $hits_IDs  > ${my_query}_blastp_NCBI_hits-names.txt
	
}

extract_sseqid $hits_IDs



#### 4. extract fasta based on the hits IDs
 function extract_fasta {
     list=$OUT3 # The first read pair is the second parameter to this function
	 blastdbcmd -db nr -dbtype prot -entry_batch $list -outfmt %f -out ${my_query}_blastp_NCBI_hits_sequences.fasta
 }

extract_fasta $list



