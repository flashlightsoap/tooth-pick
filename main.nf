#!/usr/bin/env nextflow

nextflow.enable.dsl=2

params.inputFile= file('input.txt')

process convertToLowerCase {
    Container 'biocontainers/vcftools'

    output:
    stdout

    script:
    """
    echo "Getting version of vcftool"
    vcftools --version
    echo "Got version of vcftool"

    #cat /mnt/${inputFile} | tr '[:lower:]' '[:upper:]' | tee /mnt/output.txt

    sleep 2m
    """
}

workflow {
    inputFile = Channel.fromPath(params.inputFile)

    convertToLowerCase(inputFile) | view
}
