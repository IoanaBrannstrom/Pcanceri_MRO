#author: Ioana Onut Brännström


# !!! Change to correct lineage for Busco

my_assembly=$1

module load bioinfo-tools   			 # check for updates
module load BUSCO/4.1.4
module load augustus/3.2.3



##### run Busco with eukaryota_odb9
source $BUSCO_SETUP
function apply_BUSCOeuk {
    my_assembly=$1 #The my_assembly is the first parameter to this function
    LINEAGE=$BUSCO_LINEAGE_SETS/eukaryota_odb9
   run_BUSCO.py -i $my_assembly -l $LINEAGE -c 4 -m genome -o BUSCOeuk_${my_assembly} -f
}

apply_BUSCOeuk $my_assembly



