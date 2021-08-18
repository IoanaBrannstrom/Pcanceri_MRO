#author: Ioana Onut Brännström

module load bioinfo-tools 
module load bowtie/1.2.3
module load samtools/1.10
module load  trinity/2.9.1
module load jellyfish/2.2.6
module load Salmon/1.1.0


Fasta=$1

###  compute  The 'Gene' Contig Nx Statistic
TrinityStats.pl  $Fasta 
# output comes in the slurm, I didn't figure out yet how to make it. So I will copy the slurm to a stats file

