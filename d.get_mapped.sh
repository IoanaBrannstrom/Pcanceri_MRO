#author: Ioana Onut Brännström

ml bioinfo-tools
ml bwa/0.7.17
ml samtools/1.9
module load BEDTools/2.27.1 

BAM= #add mapped file (with the entire path)
OUTDIR= #add the path of the directory where you want your script
Append= #append a name to your fastqc mapped files

##################
# Index final bam, will produce file of format .bai, which needs to be in the same folder as the bam file for IGV viewing
#samtools index $BAM



# Make temp dir for mapping
MAPDIR_temp=$SNIC_TMP/mapped

mkdir $MAPDIR_temp
cd $MAPDIR_temp
cp $BAM .


##############################################################################################################
### GET THE MAPPED READS
##############################################################################################################
## get all mapped reads
#samtools view -b -F 4 $BAM -@ 5 > ${Append}_mapped.bam

## get properly paired reads primerly alligned; see explanations at http://www.metagenomics.wiki/tools/samtools/number-of-reads-in-bam-file
samtools view -b -F 260 $BAM > ${Append}_mapped.bam

## sort the mapped bam file. very important !!!!!!
samtools sort -n  -@ 5 ${Append}_mapped.bam -o ${Append}_mapped_sorted.bam   # sort reads by identifier-name (-n)


### convert to fastq for paired reads using BEDtools
#bedtools bamtofastq -i ${Append}_mapped_sorted.bam  -fq ${Append}_mapped_pe1.fastq  -fq2 ${Append}_mapped_pe2.fastq
bedtools bamtofastq -i ${Append}_mapped_sorted.bam  -fq ${Append}_pe1.fastq  -fq2 ${Append}_pe2.fastq



## zip the files
gzip ${Append}_mapped_pe1.fastq
gzip ${Append}_mapped_pe2.fastq



rsync -av $MAPDIR_temp/${Append}_mapped_pe* $OUTDIR


