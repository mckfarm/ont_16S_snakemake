rule minimap:
    input:
        "results/fastp/{sample}/{sample}.fastp.fq.gz"
    output:
        "results/minimap/{sample}/{sample}.mapped.sam"
    params:
        ref = "/home/mckyf/dbs/midas_5.3_minimap.mmi"
    conda:
        "../envs/minimap2.yaml"
    shell:
        """
        minimap2 -ax map-ont {params.ref} {input} > {output}
        """

rule get_mapped_seqs:
    input:
        "results/minimap/{sample}/{sample}.mapped.sam"
    output:
        "results/minimap/{sample}/{sample}.mapped.fasta"
    params:
        "results/minimap"
    conda:
        "../envs/samtools.yaml"
    shell:
        """
        samtools view -b -F 4 {input} | samtools sort - | samtools fasta > {output}
        """

rule get_abundance:
    input:
        "results/minimap/{sample}/{sample}.mapped.sam"
    output:
        "results/minimap/{sample}/{sample}.idxstats.tsv"
    params:
        bam = "results/minimap/{sample}/{sample}.sort.bam",
        index = "results/minimap/{sample}/{sample}.sort.bai"
    conda:
        "../envs/samtools.yaml"
    shell:
        """
        samtools view -b -F 4 {input} | samtools sort -o {params.bam} - 
        samtools index {params.bam} -o {params.index}
        samtools idxstats {params.bam} -X {params.index} > {output}
        """

rule get_read_ids:
    input:
        "results/minimap/{sample}/{sample}.mapped.sam"
    output:
        "results/minimap/{sample}/{sample}.ids.bed"
    conda:
        "../envs/bedtools.yaml"
    shell:
        """
        samtools view -b -F 4 {input} | samtools sort - | bamToBed > {output}
        """