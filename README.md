# ONT 16S
My snakemake workflow for processing long-read 16S data from ONT sequencers.  

- QC: [fastplong](https://github.com/OpenGene/fastplong) for length and quality filtering
- Map: [minimap2](https://github.com/lh3/minimap2) for mapping, [samtools](https://www.htslib.org/) for .sam manipulation to fasta of mapped seqs and abundance table
- Parse: R script to add taxonomy table and summarize abundances by sample
