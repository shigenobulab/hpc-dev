#!/bin/sh

#SBATCH -p medium-m5d
#SBATCH -N 1
#SBATCH -n 8

#=== conf ===
REFIDX=References/Apisum_Buchnera_hologenome
MAXINS=1000
NCPU=8
UPTO=80000000

NAME=N701-N501

SEQ1=220127-Shigenobu-CUT2201-1_S1_Lall_R1_N701-N501.cln.Q20L25.fastq.gz
SEQ2=220127-Shigenobu-CUT2201-1_S1_Lall_R2_N701-N501.cln.Q20L25.fastq.gz

OUTSAM=$NAME.on.`basename $REFIDX`.bowtie2.sam

RUN_CMD="bowtie2  -1 $SEQ1 -2 $SEQ2  -p $NCPU  -x $REFIDX  --end-to-end  --maxins $MAXINS >$OUTSAM "

CON_WD=/host_mount
CON_ID=`sudo docker run -dit --mount type=bind,src=$(pwd),dst=$CON_WD --workdir $CON_WD quay.io/biocontainers/bowtie2:2.4.5--py38hfbc8389_2 `

sudo docker exec -t ${CON_ID} ${RUN_CMD}

sudo docker stop ${CON_ID}
