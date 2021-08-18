#author: Ioana Onut Brännström


# v.2 is made to use several hits files
# I changed a bit the ending of the blob file


module load bioinfo-tools
module load blobtools/1.1.1


# do not forget to give the 3 parameters!!!

## do this first to connect NAMES and NODES to myBlobDB.txt. Then is not necessary to do it again.
NAMES_DB=/sw/data/uppnex/ncbi_taxonomy/latest/names.dmp # The location of the names database
NODES_DB=/sw/data/uppnex/ncbi_taxonomy/latest/nodes.dmp # The location of the nodes database
blobtools create -i $ASSEMBLY -b $BAM -t $BLAST -o Blobs_onlyNCBI-${Append}-vs-${Append} --names $NAMES_DB --nodes $NODES_DB --db $DB


ASSEMBLY=$1 # The assembly is the first parameter to this function
BAM=$2 # The BAM file is the second parameter to this function
BLAST=$3 # The BLAST file is the third parameter to this function
Append= #the name you want to give if you don't wanted to be too long
Colors= #path to the color scheme if you want to use your own. Otherwise remove this flag from the command. Example for color scheme: Mollusca,#3366ff
				#no-hit,#cccccc
				#Proteobacteria,#99ffff
				#Eukaryota-undef,#cc6699

DB= #path were myBlobDB.txt is



#create a database 
blobtools create -i $ASSEMBLY -b $BAM -t $BLAST  -o Blobs.${Append} --db $DB



blobtools plot -i Blobs.${Append}.blobDB.json --plotgroups 35  -o BlobPlots.Phylum --rank 'phylum' --colours $Colors --format png
#blobtools plot -i Blobs.${Append}.blobDB.json --plotgroups 60  -o Plots.Phylum --rank 'phylum'  #this uses random colors given by blobs


## to plot at order level 
blobtools plot -i Blobs.${Append}.blobDB.json --plotgroups 44  -o Plots.Order --rank 'order'  #this uses random colors given by blob




# to get the tabular file with sequence ID 
blobtools view -i Blobs.${Append}.blobDB.json  --taxrule bestsum --hits --out Blobs.Tabular







