# ONT 16S
My snakemake workflow for processing 16S data from ONT.  

- QC: fastplong for length and quality filtering
- Map: minimap2 for mapping, samtools for .sam manipulation to fasta of mapped seqs and abundance table
- Parse: R script to add taxonomy table and summarize abundances by sample