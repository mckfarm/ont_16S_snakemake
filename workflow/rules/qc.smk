rule fastp:
    input:
        r1 = get_raw_reads
    output:
        r1_filt = "results/fastp/{sample}/{sample}.fastp.fq.gz"
    params:
        json = "results/fastp/{sample}/{sample}_fastp.json",
        html = "results/fastp/{sample}/{sample}_fastp.html"
    conda:
        "../envs/fastplong.yaml"
    shell:
        """
        fastplong -i {input} -o {output.r1_filt} \
        --json {params.json} --html {params.html} \
        --qualified_quality_phred 15 --unqualified_percent_limit 50 \
        --length_required 400 --length_limit 1600 
        """