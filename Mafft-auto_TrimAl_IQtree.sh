#author:Ioana Onut Brännström


module load bioinfo-tools   			 # check for updates
module load MAFFT/7.407
module load trimAl/1.4.1
module load iqtree/1.6.5-omp-mpi
module load gcc/6.3.0 openmpi/2.1.0 

### SETTINGS
fasta=$1 
append=$2

##### Run Mafft-auto
  function align {
     fasta=$1
     append=$2
     OUT1=${append}.mafft-auto.fa
      mafft --auto --thread 2 --anysymbol --reorder  --amino $fasta > $OUT1
	
 }

align $fasta $append $OUT1
aligned=$OUT1 
 
    
##### Run Trim-Al
	function trim {
	TRIM=$aligned
	OUT2=${TRIM}.trimAlauto1.fa
	trimal -in $TRIM -out $OUT2 -automated1 -fasta 
 }
 
 trim $TRIM $OUT2 
 trimmed=$OUT2


##### Run IQtree with ultrafast bootstrap approximation
	function IQtree {
	TREEit=$trimmed
	OUT3=IQtree.${TREEit}
	iqtree -s $TREEit -m TEST -bb 100 -st AA -nt 5 -alrt 1000 -pre $OUT3
 }
 
 IQtree $TREEit $OUT3
 
 
