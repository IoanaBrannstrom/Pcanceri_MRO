#author: Ioana Onut Brännström

module load bioinfo-tools
module load samtools/1.9
module load bbmap/38.61b
module load BEDTools/2.29.2
BAM=$1
Append=$2 #the name of the output file
###### Get the coverage with bbmap #####
pileup.sh in=$BAM out=Coverage.${Append}.BBmap.txt headerpound=f