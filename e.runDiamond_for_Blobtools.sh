#author: Ioana Onut Brännström


module load bioinfo-tools
module load diamond/0.9.29

# this is the format Blobplots needs --outfmt '6 qseqid staxids bitscore'

#### SETTINGS #####

QUERY= 	#path for the fasta file  																											DIAMOND_NR=/sw/data/uppnex/diamond_databases/Blast/latest/nr.dmnd       #this is a protein database
TAXONMAP=     #Path to mapping file that maps NCBI protein accession numbers to taxon ids (gzip com- pressed).
OUTDIR=  	# give a path where I want my file to come
Append1= 	#database name
Append2= 	#the output file name
E=1-20
hits=500

TMPDIR=$SNIC_TMP/diamond_${Append2}
mkdir $TMPDIR
cd $TMPDIR

diamond blastx --query $QUERY \
	 -d $DIAMOND_NR --tmpdir $TMPDIR  \
	 -c 1 --threads 13 --more-sensitive \
	 --taxonmap $TAXONMAP  -f 6 qseqid staxids bitscore qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue stitle  \
	 --max-target-seqs 500  -o DiamondBlastxBlobs.${Append1}.${Append2}_${E}_${hits}.tab \
	 -e $E \

rsync -av $TMPDIR/DiamondBlastxBlobs.${Append1}.${Append2}_${E}_${hits}.tab $OUTDIR