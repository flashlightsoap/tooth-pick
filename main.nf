#!/usr/bin/env nextflow

nextflow.enable.dsl=2

process convertToLowerCase {
    container 'biocontainers/vcftools:v0.1.16-1-deb_cv1'

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
