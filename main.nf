#!/usr/bin/env nextflow

nextflow.enable.dsl=2

process convertToLowerCase {
    container 'biocontainers/vcftools:v0.1.14_cv2'
    output:
    stdout

    script:
    """
    echo "Getting version of vcftool"
    vcftools --version

    vcftools --gzvcf {input_vcf_file_path} --bed {reference_path}/genes.txt --recode --out {output_intermediate_path}/{sample_id}
    echo "Got version of vcftool"

    sleep 3m

    """
}

workflow {
    
    convertToLowerCase() | view
}
