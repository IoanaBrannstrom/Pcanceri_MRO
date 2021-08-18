#author: Max Emil Schön


### The script will take the tabular output of a blast or diamond search and identify contigs 
	#that are covered with equal or more then 10% by hits of supposed contamination. The script will
	#generate a clean fasta output where the contaminant contigs are removed
	
### Make sure to change were necessary the parameters with the Position of query name, start and end of query (contig), covergae, etc. See bellow


#USAGE:
#python3 get_contamination1.py --blast theBlastOutput.tab --fasta Genomefile.fasta --output cleanFasta.fasta


from collections import defaultdict
from Bio import SeqIO
import ete3
import argparse

ncbi = ete3.ncbi_taxonomy.NCBITaxa()

def is_prokaryote(taxid):
    contaminants = [2, 2157, 33208, 4751] # Bacteria, Metazoa, Archaea, Fungi  Taxid of the suppposed contamination
    lineage = ncbi.get_lineage(taxid)
    if any([t in lineage for t in contaminants]):
        return True
    return False

def merge_intervals(intervals):
    sorted_by_lower_bound = sorted(intervals, key=lambda tup: tup[0])
    merged = []
    for higher in sorted_by_lower_bound:
        if not merged:
            merged.append(higher)
        else:
            lower = merged[-1]
            # test for intersection between lower and higher:
            # we know via sorting that lower[0] <= higher[0]
            if higher[0] <= lower[1]:
                upper_bound = max(lower[1], higher[1])
                merged[-1] = (lower[0], upper_bound)  # replace by merged interval
            else:
                merged.append(higher)
    return merged

def get_contamination_coverage(blast_result):
    contig2hit = defaultdict(list)
    for line in open(blast_result):
        line = line.strip().split()
        if float(line[2]) > 50: # Position of the bitscore of the blast hit (counting starts from 0)
            try:
                hitid = int(line[1]) # position of the target name and getting GI number
                if is_prokaryote(hitid):
                    contig2hit[line[0]].append((int(line[9]), int(line[10]))) # Position of query name, start and end of query (contig)
            except:
                pass
    return contig2hit



def get_contaminant_contigs(contig2hit, seqlengths):
    contaminant_contigs = []
    for contig, intervals in contig2hit.items():
        contig2hit[contig] = merge_intervals(intervals)
        length = seqlengths[contig]
        contamination = sum([i[1]-i[0] for i in contig2hit[contig]])
        if (contamination/length) >= 0.1: # coverage of contamination hits, e.g. 0.1 for 10%
            contaminant_contigs.append(contig)
    return contaminant_contigs


def clean_fasta_file(fastafile, contaminant_contigs, outfile):
    with open(outfile, 'w') as out:
        for rec in SeqIO.parse(fastafile, "fasta"):
            if not rec.id in contaminant_contigs:
                SeqIO.write(rec, out, 'fasta')

def main(args):
    contig2hit = get_contamination_coverage(args.blast)
    seqlengths = {rec.id: len(rec.seq) for rec in SeqIO.parse(args.fasta, "fasta")}
    contaminant_contigs = get_contaminant_contigs(contig2hit, seqlengths)
    print("Finished calculating the contamination coverage")
    clean_fasta_file(args.fasta, contaminant_contigs, args.output)
    print("Finished writing the decontaminated fasta file")

parser = argparse.ArgumentParser()
parser.add_argument('--blast', '-b', type=str, help='input blast results file')
parser.add_argument('--fasta', '-f', type=str, help='input fasta file with contigs')
parser.add_argument('--output', '-o', type=str, help='output fasta file with contigs withouth contamination')
parser.add_argument('--gi2tax', '-g', type=str, help='gi2tax file with mapping of taxid and GI numbers from ncbi')
args = parser.parse_args()

if __name__ == '__main__':
    main(args)
