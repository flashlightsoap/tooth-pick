#!/usr/bin/env nextflow

nextflow.enable.dsl=2

process convertToLowerCase {
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
