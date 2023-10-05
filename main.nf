#!/usr/bin/env nextflow

nextflow.enable.dsl=2

params.inputFile= file('input.txt')

process convertToLowerCase {
    input:
    file inputFile

    output:
    file 'output.txt'

    script:
    """
    cat /mnt/${inputFile} | tr '[:lower:]' '[:upper:]' | tee /mnt/output.txt

    sleep 2m
    """
}

workflow {
    inputFile = Channel.fromPath(params.inputFile)

    convertToLowerCase(inputFile)
}
