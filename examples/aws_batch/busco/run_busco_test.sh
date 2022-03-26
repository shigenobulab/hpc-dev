#! /bin/bash

#INPUT=/mnt/efs/GCF_000001215.4_Release_6_plus_ISO1_MT_genomic.fna
INPUT=/mnt/efs/work/projects/220223-busco_Docker/GCF_000001215.4_Release_6_plus_ISO1_MT_genomic.fna

MODE=genome

LINEAGE=eukaryota

NCPU=12

OUTF=`basename ${INPUT}`_BUSCO5_${AWS_BATCH_JOB_ID}

/usr/local/bin/busco -i ${INPUT} -l ${LINEAGE} -o ${OUTF} -m ${MODE} -c ${NCPU}

cp -r ./${OUTF} /mnt/efs/tmp
