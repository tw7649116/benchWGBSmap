#!/bin/bash

#***
#author: Marc-Christoph Wagner, Claudius Grehl
#date:   09.2018
#task:   master script (combines hole workflow)
#***

#set chosen parameter
ERRORRATES=(0 0.1 0.5 1)
CONVERSIONRATES=(90 98 100)
MISMATCHES=(0 1 2 3)
MAPPERLIST=(bismark bsmap bsseeker2 gem3 gsnap bwameth bismarkbwt2)
#MAPPERLIST=(bwameth)


genomeDir=../data/genomes/ArabidopsisTAIR10/
wd=/scratch/user/ahgyg/benchmarkWGBS/data/genomes/ArabidopsisTAIR10/
genomeGsnap=ArabidopsisTAIR10/Arabidopsis_thaliana.TAIR10.dna.toplevel.gmap.index/
genome=Arabidopsis_thaliana.TAIR10.dna.toplevel

#create parameter list
for c in "${CONVERSIONRATES[@]}" 
do
    convPara=$convPara"-c $c "
done

for e in "${ERRORRATES[@]}" 
do
    errPara=$errPara"-e $e "
done

for m in "${MISMATCHES[@]}" 
do
    misPara=$misPara"-m $m "
done

#create tmp folder
#mkdir -p ../data/ara/tmp_ara/

#--------------------------------------------------------------
#Step 1: generate simulated reads
#--------------------------------------------------------------

echo "Step 1: generate simulated reads"

#for CONVERSIONRATE in "${CONVERSIONRATES[@]}"
#do
#    for ERRORRATE in "${ERRORRATES[@]}"
#    do
#        sbatch --job-name=genBsReads --partition standard,special --mem-per-cpu=5000 --time=24:00:00 --ntasks-per-node=1 \
#        --error=../data/ara/tmp_ara/generateCov5BsReads_${CONVERSIONRATE}_${ERRORRATE}.err \
#        --output=../data/ara/tmp_ara/generateCov5BsReads_${CONVERSIONRATE}_${ERRORRATE}.out \
#        <<<"#!/bin/bash
#        ./generateBsReads.sh -o ../data/ara/simulatedCov5BsReads/ -t ../data/ara/tmp_ara/ -g ../../../${genomeDir} -n 2261170 -e ${ERRORRATE} -c ${CONVERSIONRATE} "
#
#        sleep 0.1

        #miniTestSet
        #./generateBsReads.sh -o ../data/ara/simulatedMiniTestBsReads/ -t ../data/ara/tmp_ara/ -g ../../${genomeDir}/ -n 500

        #normalTestSet
        #./generateBsReads.sh -o ../data/ara/simulatedTestBsReads/ -t ../data/ara/tmp_ara/ -n 250000

#        #Cov 5X
#        ./generateBsReads.sh -o ../data/ara/simulatedCov5BsReads/ -t ../data/ara/tmp_ara/ -n 4522341

#        #Cov 20X
#        ./generateBsReads.sh -o ../data/ara/simulatedCov20BsReads/ -t ../data/ara/tmp_ara/ -n 18089364

#    done
#done
#
#wait
#while [[ $(squeue | grep genBsRea) ]]
#do
#    sleep 3
#done


echo "Step 2: map reads to ref genome using bismark bowtie2"
#bismark_genome_preparation --bowtie2 ${genomeDir}/
#./mappBismarkbwt2.sh    -g ${genomeDir}/ \
#                    -t ../data/ara/tmp_ara/mappedCov5BsReads/bismarkbwt2/ \
#                    -r ../data/ara/simulatedCov5BsReads/ \
#                    -o ../data/ara/mappedCov5BsReads/bismarkbwt2/ \
#                    ${errPara}${convPara}


echo "Step 1: map reads to ref genome using bwa-meth"
#preperation step
#bwameth.py index ${genomeDir}/${genome}.fa
#./mappBwameth.sh    -g ${wd}${genome}.fa \
#                    -t ../data/ara/tmp_ara/mappedCov5BsReads/bwameth/ \
#                    -r ../data/ara/simulatedCov5BsReads/ \
#                    -o ../data/ara/mappedCov5BsReads/bwameth/ \
#                    ${errPara}${convPara} 








#Step 2: map reads to ref genome using bismark
#---------------------------------------------
echo "Step 2: map reads to ref genome using bismark"
#preperation step
#bismark_genome_preparation --bowtie1 ${genomeDir}/
#./mappBismark.sh    -g ${genomeDir}/ \
#                    -t ../data/ara/tmp_ara/mappedCov5BsReads/bismark/ \
#                    -r ../data/ara/simulatedCov5BsReads/ \
#                    -o ../data/ara/mappedCov5BsReads/bismark/ \
#                    ${errPara}${convPara}${misPara} 
echo "Step 2: map reads to ref genome using bsmap"
#bsmap
#./mappBsmap.sh    -g ${genomeDir}/${genome}.fa \
#                    -t ../data/ara/tmp_ara/mappedCov5BsReads/bsmap/ \
#                    -r ../data/ara/simulatedCov5BsReads/ \
#                    -o ../data/ara/mappedCov5BsReads/bsmap/ \
#                    ${errPara}${convPara}${misPara}

echo "Step 2: map reads to ref genome using bsseeker 3"
#bsseeker2
#preperation step
#../tools/bs3/bs3-build.py -f ${genomeDir}/${genome}.fa
#./mappBsseeker3.sh    -g ${genomeDir}/${genome}.fa \
#                    -t ../data/ara/tmp_ara/mappedCov5BsReads/bsseeker3/ \
#                    -r ../data/ara/simulatedCov5BsReads/ \
#                    -o ../data/ara/mappedCov5BsReads/bsseeker3/ \
#                    ${errPara}${convPara}${misPara}

echo "Step 2: map reads to ref genome using bsseeker 2"
#bsseeker2
#preperation step
#../tools/BSseeker2/bs_seeker2-build.py -f ${genomeDir}/${genome}.fa
#./mappBsseeker2.sh    -g ${genomeDir}/${genome}.fa \
#                    -t ../data/ara/tmp_ara/mappedCov5BsReads/bsseeker2/ \
#                    -r ../data/ara/simulatedCov5BsReads/ \
#                    -o ../data/ara/mappedCov5BsReads/bsseeker2/ \
#                    ${errPara}${convPara}${misPara}

#echo "Step 2: map reads to ref genome using erne-bs5"
#Erne-Bs5
#preperation step
#../tools/erne-2.1.1-linux/bin/erne-create --fasta ${genomeDir}/${genome}.fa --output-prefix ${genomeDir}/${genome}.fa.erne --methyl-hash
#./mappErneBs5.sh    -g ${genomeDir}/${genome}.fa.erne.ebm \
#                    -t ../data/ara/tmp_ara/mappedCov5BsReads/ernebs5/ \
#                    -r ../data/ara/simulatedCov5BsReads/ \
#                    -o ../data/ara/mappedCov5BsReads/ernebs5/ \
#                    ${errPara}${convPara}${misPara}

echo "Step 2: map reads to ref genome using gem 3"
#Gem3
#preperation step
#../tools/gem3-mapper/bin/gem-indexer -i ${genomeDir}/${genome}.fa -o ${genomeDir}/${genome} -b
#./mappGem3.sh    -g ${genomeDir}/${genome}.gem \
#                    -t ../data/ara/tmp_ara/mappedCov5BsReads/gem3/ \
#                    -r ../data/ara/simulatedCov5BsReads/ \
#                    -o ../data/ara/mappedCov5BsReads/gem3/ \
#                    ${errPara}${convPara}${misPara}
echo "Step 2: map reads to ref genome using gsnap"
#gsnap
#../tools/gmap-2019-06-10/bin/gmap_build -d Arabidopsis_thaliana.TAIR10.dna.toplevel.gmap.index -D ../data/genomes/ArabidopsisTAIR10/ ../data/genomes/ArabidopsisTAIR10/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa
#../tools/gmap-2019-06-10/bin/cmetindex -d ArabidopsisTAIR10/Arabidopsis_thaliana.TAIR10.dna.toplevel.gmap.index -F ../data/genomes/ -D /scratch/user/ahgyg/benchmarkWGBS/data/genomes/ArabidopsisTAIR10/Arabidopsis_thaliana.TAIR10.dna.toplevel.gmap.index/ 
#./mappGsnap.sh      -g  ${genomeGsnap}\
#                    -t ../data/ara/tmp_ara/mappedCov5BsReads/gsnap/ \
#                    -r ../data/ara/simulatedCov5BsReads/ \
#                    -o ../data/ara/mappedCov5BsReads/gsnap/ \
#                    ${errPara}${convPara}${misPara}

echo "Step 2: map reads to ref genome using segemehl"
#Segemehl
#preperation step
#./mappSegemehl.sh   -g ${genomeDir}/ \
#                    -t ../data/ara/tmp_ara/mappedCov5BsReads/segemehl/ \
#                    -r ../data/ara/simulatedCov5BsReads/ \
#                    -o ../data/ara/mappedCov5BsReads/segemehl/ \
#                    ${errPara}${convPara}${misPara}


#--------------------------------------------------------------
#Step 3: calculate f1 score
#--------------------------------------------------------------
#echo "Step 3: calculate f1 score"
ERRORRATES=(0 0.1 0.5 1)
CONVERSIONRATES=(90 98 100)
MISMATCHES=(0 1 2 3)
MAPPERLIST=(bismarkbwt2)

#mkdir -p ../results/ara/f1Score

for CONVERSIONRATE in "${CONVERSIONRATES[@]}"
do
    for ERRORRATE in "${ERRORRATES[@]}"
    do
        for MISMATCH in "${MISMATCHES[@]}"
        do
            for MAPPER in "${MAPPERLIST[@]}"
            do
                mkdir -p ../data/ara/tmp_ara/mappedCov5BsReads/${MAPPER}/mm_${MISMATCH}/

                sbatch --job-name=f1ara --partition standard,special --ntasks-per-node=1 --mem-per-cpu=50000 --time=24:00:00 \
                    --error=../data/ara/tmp_ara/mappedCov5BsReads/${MAPPER}/mm_${MISMATCH}/f1ScoreConvRate${CONVERSIONRATE}ErrRate${ERRORRATE//./}.err \
                    --output=../data/ara/tmp_ara/mappedCov5BsReads/${MAPPER}/mm_${MISMATCH}/f1ScoreConvRate${CONVERSIONRATE}ErrRate${ERRORRATE//./}.out \
                    <<<"#!/bin/bash
                        python f1Score.py -i ../data/ara/mappedCov5BsReads/${MAPPER}/mm_${MISMATCH}/simulatedConvRate${CONVERSIONRATE}ErrRate${ERRORRATE//./}.sam \
                        -t ${MAPPER} \
                        -c ${CONVERSIONRATE} \
                        -e ${ERRORRATE} \
                        -m ${MISMATCH} \
                        -o ../results/ara/f1Score/f1ScoreConvRate${CONVERSIONRATE}ErrRate${ERRORRATE//./}Mismatch${MISMATCH}_${MAPPER}.csv"
            done 
        done
    done
done
wait
while [[ $(squeue | grep f1ara) ]]
do
    sleep 3
done

echo "Step 4: combine all files"

echo -e "mapper\tconversionRate\terrorRate\tmismatches\tmacroAvgPrecision\tmacroAvgRecall\tmacroF1Score\tmicroAvgPrecision\tmicroAvgRecall\tmicroF1Score\tavgAccuracy\tmatchedReads" > ../results/ara/f1ScoreCombined.csv
for file in ../results/ara/f1Score/*.csv
do
    #echo ${file}
    cat ${file} | sed -n 2p >> ../results/ara/f1ScoreCombined.csv
done

#list files in a folder
#ls ../data/ara/simulatedCov5BsReads/*_1.fastq | sed 's#.*/##' | sed 's/_1.fastq$//'
