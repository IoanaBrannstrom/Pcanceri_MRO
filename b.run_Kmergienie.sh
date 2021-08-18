#author: Ioana Onut Brännström

module load bioinfo-tools
module load KmerGenie/1.7039

read1=$1
read2=$2
k.number=$3

kmergenie $read1 -t 8 -k $k.number -l 15 -o KMERGINIE_$read1
kmergenie $read2 -t 8 -k $k.number -l 15 -o KMERGINIE_$read2


###############################################

# Usage: kmergenie <read_file> [options]

#Options:
    #--diploid    use the diploid model (default: haploid model)
    #--one-pass   skip the second pass to estimate k at 2 bp resolution (default: two passes)
    #-k <value>   largest k-mer size to consider (default: 121)
    #-l <value>   smallest k-mer size to consider (default: 15)
    #-s <value>   interval between consecutive kmer sizes (default: 10)
    #-e <value>   k-mer sampling value (default: auto-detected to use ~200 MB memory/thread)
    #-t <value>   number of threads (default: number of cores minus one)
    #-o <prefix>  prefix of the output files (default: histograms)
    #--debug      developer output of R scripts
    #--orig-hist  legacy histogram estimation method (slower, less accurate)
