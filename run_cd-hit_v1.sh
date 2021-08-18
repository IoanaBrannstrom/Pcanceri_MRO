#author:Ioana Onut Brännström

#CD-HIT stands for Cluster Database at High Identity with Tolerance. 
	#The program (cd-hit) takes a fasta format sequence database as input and produces a set of 
	#'non-redundant' (nr) representative sequences as output. In addition cd-hit outputs a cluster file, 
	#documenting the sequence 'groupies' for each nr sequence representative. 
	#The idea is to reduce the overall size of the database without removing any sequence information 
	#by only removing 'redundant' (or highly similar) sequences. 
	#This is why the resulting database is called non-redundant (nr). 
	#Essentially, cd-hit produces a set of closely related protein families from a given fasta sequence database.




module load bioinfo-tools
module load cd-hit/4.8.1

input=$1
output=${input}_nonred90.fas

#run cd-hit
cd-hit -i $input -o $output -c 0.90 -T 1 -d 0



####################################################
 #-i	input filename in fasta format, required
 #-o	output filename, required
 #-c	sequence identity threshold, default 0.9
 	#this is the default cd-hit's "global sequence identity" calculated as:
 	#number of identical amino acids in alignment
 	#divided by the full length of the shorter sequence
 	
 	
#-G	use global sequence identity, default 1
 	#if set to 0, then use local sequence identity, calculated as :
 	#number of identical amino acids in alignment
 	#divided by the length of the alignment
 	#NOTE!!! don't use -G 0 unless you use alignment coverage controls
 	#see options -aL, -AL, -aS, -AS
#-b	band_width of alignment, default 20
#-M	memory limit (in MB) for the program, default 800; 0 for unlimitted;
#-T	number of threads, default 1; with 0, all CPUs will be used
#-n	word_length, default 5, see user's guide for choosing it
#-l	length of throw_away_sequences, default 10
#-t	tolerance for redundance, default 2


