#!/usr/bin/env nextflow

// Define input parameters
params.outputDir = "output"

process vcftoolsProcess {
   beforeScript '/Users/amaan.saifan/Documents/kube/new/next/h.sh'

   container 'biocontainers/vcftools:v0.1.14_cv2'
   
   output:
   val "test"

    """
    #!/bin/bash
    #echo "Hi there!"
    #echo $params.outputDir
    #ls $params.fileName
    #sleep 2m
    

    echo "Getting version of vcftool"
    vcftools --version
    echo "Got version of vcftool"
    #vcftools --gzvcf /mnt/NA18992/NA18992_haplotyper.vcf.gz --bed /mnt/Reference-data/bed_10K_extended_pharmgkb_clinical_associations.txt --recode --out /mnt/output/NA18992
    

    """
}

process pharmcatProcess {
    container 'pgkb/pharmcat:latest'

    input:
    val vcftoolsOutput 

    //output:
    //val "pharmcatProcess"

    script:
    """
    #!/bin/bash
    #echo "Running pre-run script..."
    #apt-get install bzip2
    #echo "Done pre-run script..."

    echo "Getting version of pharmcat"
    #bzip2 -V
    #pwd
    #sleep 2m
    /pharmcat/pharmcat -version
    ls /pharmcat/pharmcat_vcf_preprocessor.py
    
    """
}

process pypgxProcess {
    container 'ubuntu:latest'
    //output:
    //val "pharmcatProcess"

    script:
    """
    sleep 10m
    #print("Hello world")
    #pip3 install pypgx
    
    """
}


workflow {

    //vcftoolsProcess() 
    //pharmcatProcess(vcftoolsProcess.out) 


    pypgxProcess()    

    // vcftoolsOutput = "errsds"
    // vcftoolsProcess() { output_file -> vcftoolsOutput }

    // pharmcatProcess(vcftoolsOutput)
}
