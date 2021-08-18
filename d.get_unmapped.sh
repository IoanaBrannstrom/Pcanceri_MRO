#author: Ioana Onut Brännström


ml bioinfo-tools
ml bwa/0.7.17
ml samtools/1.9
module load BEDTools/2.27.1 

BAM= 	#path for the bam file
OUTDIR=	#path for the put directory
Append= #name of the file

##################
# Index final bam, will produce file of format .bai, which needs to be in the same folder as the bam file for IGV viewing
#samtools index $BAM



# Make temp dir for mapping
MAPDIR_temp=$SNIC_TMP/mapped

mkdir $MAPDIR_temp
cd $MAPDIR_temp
cp $BAM .


############################################################################################################
### GET THE UN-MAPPED READS.  It is removing everything that  mapped ### 
############################################################################################################
samtools view -b -@ 5 -f 4 $BAM  > ${Append}_unmapped.bam

## sort the un- mapped bam file. very important !!!!!!
samtools sort -n  -@ 5 ${Append}_unmapped.bam -o ${Append}_unmapped_sorted.bam   # sort reads by identifier-name (-n)


### convert to fastq for paired reads using BEDtools
bedtools bamtofastq -i ${Append}_unmapped_sorted.bam  -fq ${Append}_unmapped_pe1.fastq  -fq2 ${Append}_unmapped_pe2.fastq



## zip the files
gzip ${Append}_unmapped_pe1.fastq
gzip ${Append}_unmapped_pe2.fastq


rsync -av $MAPDIR_temp/${Append}_unmapped_pe* $OUTDIR



