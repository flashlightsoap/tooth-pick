#!/usr/bin/env nextflow

nextflow.enable.dsl=2

process convertToLowerCase {
    container 'biocontainers/vcftools'

    output:
    stdout

    script:
    """
    echo "Getting version of vcftool"
    vcftools --version
    echo "Got version of vcftool"

    sleep 2m
    """
}

workflow {
    
    convertToLowerCase() | view
}
