#author: Ioana Onut Brännström

my_assembly=$1
my_read1=$2
my_read2=$3
#my_genomesize=${4:?Please provide estimated genome size as fourth parameter}



module load bioinfo-tools   			
module load KAT/2.4.2_py3.7.2



#### run KAT comp; it will compare your k-mers in the reads with k-mers in the assembly; in this way you can see if all your reads went in your assembly or if you have a diploid, triploid, etc
 function apply_KAT {
     my_assembly=$1 # The assembly is the first parameter to this function
     my_read1=$2 # The first read pair is the second parameter to this function
     my_read2=$3 # The second read pair is the third parameter to this function
     COMBINED_DATA=combined_data.fastq # The file combining the read data
     mkfifo $COMBINED_DATA && cat $my_read1 $my_read2 > $COMBINED_DATA & # Make a named pipe and combine reads   #if your reads are not zipped use cat instead of zcat
     kat comp -t 10 -o ${my_assembly}_vs_reads.cmp $COMBINED_DATA $my_assembly # Compare Reads to Assembly
     rm -rf $COMBINED_DATA # Clean up
 }
apply_KAT $my_assembly $my_read1 $my_read2 
