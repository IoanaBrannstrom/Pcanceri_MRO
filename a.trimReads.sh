#author: Ioana Onut Brännström

module load bioinfo-tools
module load FastQC/0.11.8
module load java/sun_jdk1.8.0_151
module load trimmomatic/0.36



# Made by Ioana: 26/4-2018
# The script runs Trimmomatic and FastQC on clean reads
# Do not forget to change with the appropriate  files

Read1= #path for the forward reads
Read2= #path for the reverse reads
AdapterFasta=  # path were the adapter Illumina list is

Var= #the name of how the trimmed reads should be named 

Trimmomatic_OUT_I_1=${Var}_PQ_pe1.fastq.gz
Trimmomatic_OUT_SE_1=${Var}_PQ_se1.fastq.gz
Trimmomatic_OUT_I_2=${Var}_PQ_pe2.fastq.gz
Trimmomatic_OUT_SE_2=${Var}_PQ_se2.fastq.gz
Trimmomatic_OUT_SE_final=${Var}_PQ_se.fastq.gz

Project=  # directory name where the trimmed reads should be 



#### run trimmomatic and cut adaptors
java -Xmx60g -jar /sw/apps/bioinfo/trimmomatic/0.36/rackham/trimmomatic.jar PE -threads 8 $Read1 $Read2 $Trimmomatic_OUT_I_1 $Trimmomatic_OUT_SE_1 $Trimmomatic_OUT_I_2 $Trimmomatic_OUT_SE_2 ILLUMINACLIP:$AdapterFasta:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36
# these are the SciLife instructions: https://scilifelab.github.io/courses/assembly/2017-11-15/lectures/Sequence_Quality_Assessment.pdf


# zcat the orphan files
zcat $Trimmomatic_OUT_I_1 $Trimmomatic_OUT_I_2 > $Trimmomatic_OUT_SE_final


# FastQC report on post-QC reads
cd $Project
mkdir FastQC_PQ${Var}
OUTfastqc2=$Project/FastQC_PQ${Var}

fastqc --quiet --threads 10 --outdir $OUTfastqc2 --extract $Trimmomatic_OUT_I_1 $Trimmomatic_OUT_I_2



