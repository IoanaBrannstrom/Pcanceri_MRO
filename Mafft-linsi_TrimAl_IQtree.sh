#author:Ioana Onut Brännström


module load bioinfo-tools   			 # check for updates
module load MAFFT/7.407
module load trimAl/1.4.1
module load iqtree/1.6.5-omp-mpi
module load gcc/6.3.0 openmpi/2.1.0 

### SETTINGS
fasta=$1 
append=$2

##### Run Mafft-linsi
  function align {
     fasta=$1
     append=$2
     OUT1=${append}.linsi.fa
     linsi --maxiterate 1000 --reorder --thread 2 --anysymbol $fasta > $OUT1
	
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


##### Run IQtree on trim align with ultrafast boostrap and the 'sht tests' -----or-----  The standard nonparametric bootstrap 
	function IQtree {
	TREEit=$trimmed
	OUT3=IQtree.${TREEit}.ultra-fastBP1000
	#OUT3=IQtree.${TREEit}.non-parametricBP100
	iqtree -s $TREEit -m TEST -bb 1000 -st AA -nt 2 -alrt 1000 -pre $OUT3
	#iqtree -s $TREEit -m TEST -b 100 -st AA -nt 2 -pre $OUT3
 }
 
 IQtree $TREEit $OUT3
 
 
