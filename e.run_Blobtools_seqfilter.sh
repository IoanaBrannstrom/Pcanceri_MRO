#author: Ioana Onut Brännström

module load bioinfo-tools
module load blobtools/1.1.1


FASTA=$1
LIST=$2
PREFIX=clean_v1.${FASTA}


blobtools seqfilter  -i $FASTA -l $LIST -o $PREFIX



#USAGE:

#blobtools seqfilter       -i FASTA -l LIST [-o PREFIX] [-v]   [-h|--help]

    #Options:
        #-h --help                   show this

        #-i, --infile <FASTA>        FASTA file of sequences (Headers are split at whitespaces)
        #-l, --list <LIST>           TXT file containing headers of sequences to keep
        #-o, --out <PREFIX>          Output prefix
        #-v, --invert                Invert filtering (Sequences w/ headers NOT in list)

