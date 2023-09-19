#!/usr/bin/env nextflow

// Define the input parameter
params.inputFile = file("/Users/amaan.saifan/Documents/kube/input.txt")

// Define the output directory
outputDir = "output"

// Define the Nextflow process
process copyFile {
    input:
    file inputFile

    output:
    file "/Users/amaan.saifan/Documents/kube/output_file123.txt"

    script:
    """
    # Create the output directory if it doesn't exist
    # mkdir -p ${outputDir}

    # Copy the input file to the output directory
    cp ${inputFile} /Users/amaan.saifan/Documents/kube/output_file123.txt
    """
}

// Define the workflow
workflow {
    // Run the copyFile process with the inputFile as input
    copyFile(params.inputFile)
}


