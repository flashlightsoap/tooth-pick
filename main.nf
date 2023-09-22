#!/usr/bin/env nextflow

// Define input parameters
params.outputDir = "output"

process perlStuff {

   output:
   stdout
    """

    echo "Hi there! "
    echo $params.outputDir
    """
}


workflow {
    perlStuff() | view
}
