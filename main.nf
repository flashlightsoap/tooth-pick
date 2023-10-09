#!/usr/bin/env nextflow

// Define input parameters
params.outputDir = "output"

process vcftoolsProcess {

   container 'biocontainers/vcftools:v0.1.14_cv2'
   
   output:
   stdout

    """
    #!/bin/bash
   

    echo "Getting version of vcftool"
    vcftools --version
    echo "Got version of vcftool"
    vcftools --gzvcf /mnt/NA18992/NA18992_haplotyper.vcf.gz --bed /mnt/Reference-data/bed_10K_extended_pharmgkb_clinical_associations.txt --recode --out /mnt/output/NA18992
    

    """
}



workflow {

    vcftoolsProcess() 
   
}
