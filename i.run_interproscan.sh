#author: Ioana Onut Brännström


module load bioinfo-tools   
module load InterProScan/5.30-69.0
module load perl  
module load pfam_scan 1.6


interproscan.sh -i $1 -dp --goterms --iprlookup --pathways --disable-residue-annot --tempdir Scan -cpu 16



# The ‘-appl’ option allows defining the database used. By default all analyses are run
# Interproscan uses an internal database that related entries in public databases to established GO (Gene ontology) terms. By running the ‘-goterms’ option, we can add this information to our data set.
#If you enable the InterPro lookup (‘-iprlookup’), you can also get the InterPro identifier corresponding to each motif retrieved: for example, the same motif is known as PF01623 in Pfam and as IPR002568 in InterPro.
#The option ‘-pa’ or --pathways provides mappings from matches to pathway information (MetaCyc,UniPathway,KEGG,Reactome).
#-dp,--disable-precalc                      Optional.  Disables use of the precalculated match lookupservice.  All match  calculations will be run locally.
#-t,--seqtype <SEQUENCE-TYPE>               Optional, the type of the input sequences (dna/rna (n)or protein (p)).  The default sequence type is protein.
#-dra / --disable-residue-annot (optional)
								#Optionally, you can prevent InterProScan from calculating the residue 
								#level annotations and displaying in the output where available. 
								#If you don't require this information then disabling the feature will 
								#improve performance and result in smaller output files.
								
#--tempdir <TEMP-DIR>                    #Optional, specify temporary
                                            #file directory (relative or absolute path). The default location is temp/.


