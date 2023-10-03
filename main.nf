#!/usr/bin/env nextflow

// Define input parameters
params.outputDir = "output"

process perlStuff {

   output:
   stdout
    """
    #!/bin/bash
    echo "Hi there!"
    echo $params.outputDir
    sleep 5m
    #ls $params.fileName
    """
}


workflow {
    perlStuff() | view
}
