#! /bin/bash

#SBATCH -p medium-m5d
#SBATCH -N 1
#SBATCH -n 8

set -e
set -u
set -o pipefail


INPUT=genome.fasta

MODE=genome

LINEAGE=eukaryota

NCPU=8

OUTF=`basename ${INPUT}`_BUSCO5_${SLURM_JOB_ID}

RUN_CMD="busco -i ${INPUT} -l ${LINEAGE} -o ${OUTF} -m ${MODE} -c ${NCPU} -r"

CON_ID=`sudo docker run -dit --mount type=bind,src=$(pwd),dst=/busco_wd ezlabgva/busco:v5.2.2_cv2`

sudo docker exec -t ${CON_ID} ${RUN_CMD}

sudo docker stop ${CON_ID}
