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
    echo "Got version of vcftool"

    """
}

workflow {
    
    convertToLowerCase() | view
}
