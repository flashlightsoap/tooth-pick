#!/usr/bin/env nextflow

nextflow.enable.dsl=2

process convertToLowerCase {
    output:
    stdout

    script:
    """
    cat $params.inputfile | tr '[:lower:]' '[:upper:]' | tee $params.outputfile
    sleep 2m
    """
}

workflow {
    convertToLowerCase() | view
}
