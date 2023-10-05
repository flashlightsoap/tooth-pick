#!/usr/bin/env nextflow

nextflow.enable.dsl=2

params.inputFile= file('/mnt/input.txt')

process convertToLowerCase {
    input:
    file inputFile

    output:
    file '/mnt/output.txt'

    script:
    """
    cat ${inputFile} | tr '[:lower:]' '[:upper:]' | tee output.txt

    sleep 2m
    """
}

workflow {
    inputFile = Channel.fromPath(params.inputFile)

    convertToLowerCase(inputFile)
}
