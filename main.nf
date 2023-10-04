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
    ls $params.fileName
    sleep 5m
    
    """
}


workflow {
    perlStuff() | view
}
