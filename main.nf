process pypgxProcess {
    container 'pgkb/pharmcat:latest'
   //container 'nextflow-pharmcat:0.0.1'
   beforeScript '/mnt/Reference-data/backupscript.sh' 

    output:
    stdout

    script:
    """
    sleep 10m
    
    python3 --version
    tabix --version

    tabix /mnt/NA18992/NA18992.hard-filtered.vcf.gz 'chr1:169549811-169549811' > /mnt/output/F5.csv
    
    tabix /mnt/NA18992/NA18992.hard-filtered.vcf.gz 'chrM:663-663' 'chrM:669-669' 'chrM:747-747' 'chrM:786-786' 'chrM:807-807' 'chrM:827-827' 'chrM:839-839' 'chrM:896-896' 'chrM:930-930' 'chrM:951-951' 'chrM:956-960' 'chrM:961-961' 'chrM:955-966' 'chrM:988-988' 'chrM:1095-1095' 'chrM:1189-1189' 'chrM:1243-1243' 'chrM:1494-1494' 'chrM:1520-1520' 'chrM:1537-1537' 'chrM:1555-1555' 'chrM:1556-1556' > /mnt/output/MT.csv


    echo "PyPGX for CYP2D6, G6PD"

    mkdir /root/pypgx-bundle
    mkdir /root/pypgx-bundle/1kgp
    mkdir /root/pypgx-bundle/cnv 
    mkdir /root/pypgx-bundle/1kgp/GRCh38 
    mkdir /root/pypgx-bundle/cnv/GRCh38

    cp /Users/amaan.saifan/Documents/kube/new/next/samples/NA18992/nf/CYP2D6.vcf.gz.tbi '/root/pypgx-bundle/1kgp/GRCh38/'

    cp /Users/amaan.saifan/Documents/kube/new/next/samples/NA18992/nf/CYP2D6.vcf.gz '/root/pypgx-bundle/1kgp/GRCh38/'

    cp /Users/amaan.saifan/Documents/kube/new/next/samples/NA18992/nf/CYP2D6.zip '/root/pypgx-bundle/cnv/GRCh38/'
    cp /Users/amaan.saifan/Documents/kube/new/next/samples/NA18992/nf/G6PD.vcf.gz.tbi '/root/pypgx-bundle/1kgp/GRCh38/'
    cp /Users/amaan.saifan/Documents/kube/new/next/samples/NA18992/nf/G6PD.vcf.gz '/root/pypgx-bundle/1kgp/GRCh38/'
    cp /Users/amaan.saifan/Documents/kube/new/next/samples/NA18992/nf/G6PD.zip '/root/pypgx-bundle/cnv/GRCh38/'

    
    pypgx --version

    #TODO: Rebuilding not required.
    bgzip /mnt/output/NA18992.recode.vcf && tabix /mnt/output/NA18992.recode.vcf.gz

    pypgx prepare-depth-of-coverage /mnt/output/stage2-test-depth-of-coverage.zip /mnt/NA18992/NA18992_deduped.bam  --assembly GRCh38 --genes GSTT1 --exclude


    pypgx compute-control-statistics VDR  /mnt/output/stage2-test-control-statistics-VDR.zip /mnt/NA18992/NA18992_deduped.bam --assembly GRCh38

    rm -rf /mnt/output/CYP2D6_pypgx_op

    pypgx run-ngs-pipeline CYP2D6 /mnt/output/CYP2D6_pypgx_op --variants /mnt/output/NA18992.recode.vcf.gz --depth-of-coverage /mnt/output/stage2-test-depth-of-coverage.zip --control-statistics /mnt/output/stage2-test-control-statistics-VDR.zip --assembly GRCh38

    rm -rf /mnt/output/G6PD_pypgx_op

    pypgx run-ngs-pipeline G6PD /mnt/output/G6PD_pypgx_op --variants /mnt/output/NA18992.recode.vcf.gz --depth-of-coverage /mnt/output/stage2-test-depth-of-coverage.zip --control-statistics /mnt/output/stage2-test-control-statistics-VDR.zip --assembly GRCh38

    #sleep 10m


    echo "Done"

    
    """
}

workflow {

    //vcftoolsProcess() 
    //pharmcatProcess(vcftoolsProcess.out) 


    pypgxProcess()    |  view

    // vcftoolsOutput = "errsds"
    // vcftoolsProcess() { output_file -> vcftoolsOutput }

    // pharmcatProcess(vcftoolsOutput)
}
