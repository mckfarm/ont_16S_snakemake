def get_reads(wildcards):
    return samples.loc[wildcards.sample, ["sample_name", "r1"]].dropna()

def get_raw_reads(wildcards):
    return get_reads(wildcards)["r1"]