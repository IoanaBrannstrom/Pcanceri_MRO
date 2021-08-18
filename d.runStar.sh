#author: Ioana Onut Brännström


### SETTINGS ####
module load bioinfo-tools
module load star/2.7.2b
module load samtools/1.10


READ1= #path for the forward reads
READ2=	#path for the reverse reads
GenomeDir= #path of the genome directory
OUTPUT= 	#output name

star --genomeDir $GenomeDir --runThreadN 8 --runMode alignReads --readFilesCommand zcat --limitBAMsortRAM 1327536135\
    --readFilesIn $READ1 $READ2\
    --outFileNamePrefix $OUTPUT\
    --outSAMtype BAM SortedByCoordinate 
    #--outReadsUnmapped Fastx

   
#GFF=/proj/uppstore2018069/Ioana/Find_Mithocondria/index_Enterospora/GCA_002087915.1_ASM208791v1_genomic.gff   				  
# --readFilesCommand zcat\
# --sjdbGTFfile $GFF\

# --limitBAMsortRAM 1327536135
	# I got this value after I run STAR, it came in the slurm output
	
    
#--outReadsUnmapped Fastx\
