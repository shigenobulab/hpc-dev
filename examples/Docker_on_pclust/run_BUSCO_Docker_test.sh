#! /bin/bash

#SBATCH -p medium-m5d
#SBATCH -N 1
#SBATCH -n 8

set -e
set -u
set -o pipefail

# ヘッドノードで事前に用意したインプットファイルを指定
INPUT=/busco_wd/GCF_000001215.4_Release_6_plus_ISO1_MT_genomic.fna

MODE=genome

LINEAGE=eukaryota

NCPU=8

OUTF=`basename ${INPUT}`_BUSCO5_${SLURM_JOB_ID}

RUN_CMD="busco -i ${INPUT} -l ${LINEAGE} -o ${OUTF} -m ${MODE} -c ${NCPU} -r"

# ディレクトリをマウントしてコンテナ起動
# ※ sudo なしの実行はコンピュートノードでdockerグループ追加後、再ログインしないと実現できないはずなので妥協してsudoつけている
CON_ID=`sudo docker run -dit --mount type=bind,src=/home/ubuntu/work,dst=/busco_wd ezlabgva/busco:v5.2.2_cv2`
# コンテナ内でコマンド実行
sudo docker exec -t ${CON_ID} ${RUN_CMD}
# 実行後コンテナ停止
sudo docker stop ${CON_ID}

## Notes
# backlog: NIBB_CLOUDHPC-40
# contributed by Y. Ohmura (Classmethod)
