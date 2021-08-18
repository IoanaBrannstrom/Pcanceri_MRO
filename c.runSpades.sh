#author: Ioana Onut Brännström

module load bioinfo-tools 
module load spades/3.13.1    #spades/3.11.1

#The script can run metaspades and spades with differen options
#Change the k to a number if auto is not desired.

READ1=$1
READ2=$2
#READ3=$3
#READ4=$4
#READ5=$5
#READ6=$6
#READ7=$7
#READ8=$8



OUTDIR= # path for the output directory. Make it in advance
Append=raw
TMPDIR=$SNIC_TMP/Spades.${Append}
mkdir $TMPDIR

#### MetaSpades
#metaspades.py -t 10 -o $OUTDIR --pe1-1 $READ1 --pe1-2 $READ2 -k auto

#### normal Spades but careful
#spades.py --careful -t 10 -k auto -o $TMPDIR --pe1-1 $READ1 --pe1-2 $READ2


#### normal Spades but no error correction
#spades.py -t 10 -k auto -o $TMPDIR --pe1-1 $READ1 --pe1-2 $READ2





#### Spades guided
#Trust_contig=/proj/uppstore2018069/Ioana/Marteilia/Assembly_valid/Mrefringens_S37norm_metaSpades/Marteilia_trust_contigs.Mrefringens_S37norm_metaSpades_scaffolds.filtered.fasta
#spades.py --careful -t 32 -k auto -o $TMPDIR --pe1-1 $READ1 --pe1-2 $READ2 --pe1-s $READ3 --trusted-contigs $Trust_contig


#### normal Spades, with many libraries, just assembly
#spades.py -t 16 -k auto -o $TMPDIR --pe1-1 $READ1 --pe1-2 $READ2 --pe2-1 $READ3 --pe2-2 $READ4 --pe3-1 $READ5 --pe3-2 $READ6 --pe4-1 $READ7 --pe4-2 $READ8 
#spades.py -t 16 -k auto -o $TMPDIR --pe1-1 $READ1 --pe1-2 $READ2 --pe2-1 $READ3 --pe2-2 $READ4 --pe3-1 $READ5 --pe3-2 $READ6  

#rsync -av $TMPDIR/* $OUTDIR
rsync -av $TMPDIR/* $OUTDIR
#rsync -av $TMPDIR/*.fasta $OUTDIR
#rsync -av $TMPDIR/*.gfa $OUTDIR
#rsync -av $TMPDIR/*.log $OUTDIR


