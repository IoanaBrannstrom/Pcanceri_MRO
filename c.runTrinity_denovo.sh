#author: Ioana Onut Brännström


module load bioinfo-tools 
module load bowtie/1.2.3
module load samtools/1.10
module load  trinity/2.9.1
module load jellyfish/2.2.6
module load Salmon/1.1.0

CPUS=${SLURM_NTASKS:-1}



#########    Trinity de novo

READ1=$1
READ2=$2
OUTPUT= #path for the output directory (created in advance)

Trinity --seqType fq --left $READ1 --right $READ2 --output $OUTPUT --CPU $CPUS --max_memory 126G

#fq for fastq or fa for fasta

