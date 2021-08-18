#author: Ioana Onut Brännström

module load bioinfo-tools
module load samtools/1.9
module load bwa/0.7.8 

### Variables
REF= #path for the assembly
READ1= #path for the forward reads
READ2= #path for the reverse reads
OUTDIR= #path for the output directory
Append1=  #short name of the assembly
Append2= #short name of the reads
SAMPLE=BWA_${Append1}-vs-${Append2} # Name of output files

# Make temp dir for mapping
MAPDIR_temp=$SNIC_TMP/bwa_metaSpades
mkdir $MAPDIR_temp
cd $MAPDIR_temp
cp $REF .
bwa index $REF



##  BWA FLAGS:
	## -M to flag shorter split hits as secondary.
	## -C but keep comments
	## -v 3 verbose level normal messages

## run BWA on paired reads
bwa mem -t 5 -M -v 3 $REF $READ1 $READ2 > $MAPDIR_temp/${SAMPLE}.sam  


#BWA on paired reads, but keep comments 
#bwa mem -t 10 -C $REF $READ1 $READ2 > $MAPDIR_temp/${SAMPLE}.sam   

#run BWA on interleaved reads
#bwa mem -t 10 $REF -p $READ1 > $MAPDIR_temp/${SAMPLE}.sam  



#for normal Illumina reads: convert to bam (Ioana's old version)
samtools view -@ 5 -b -S $MAPDIR_temp/${SAMPLE}.sam > $MAPDIR_temp/${SAMPLE}.bam


#sort
samtools sort -@ 5 -o $MAPDIR_temp/${SAMPLE}_sorted.bam $MAPDIR_temp/${SAMPLE}.bam 
#samtools sort -@ 10 -o $MAPDIR_temp/${SAMPLE}_sorted.sam $MAPDIR_temp/${SAMPLE}.sam #keep only if you think you need

# Sync to output directory
rsync -av $MAPDIR_temp/${SAMPLE}_sorted.bam $OUTDIR
#rsync -av $MAPDIR_temp/${SAMPLE}_sorted.sam $OUTDIR   #keep only if you think you need


# Index final bam, will produce file of format .bai, which needs to be in the same folder as the bam file for IGV viewing
samtools index $OUTDIR/${SAMPLE}_sorted.bam
samtools flagstat $OUTDIR/${SAMPLE}_sorted.bam > $OUTDIR/${SAMPLE}.bam.stats



