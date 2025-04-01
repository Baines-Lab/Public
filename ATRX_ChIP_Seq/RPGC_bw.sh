#!/bin/bash
samtools sort .bam  sorted.bam 
samtools index sorted.bam
	
bamCoverage -b sorted.bam  -o hg38_RPGC.bw --binSize 10 --normalizeUsing RPGC --effectiveGenomeSize 2913022398 

samtools view -b sorted.bam "HSV1F" > HSV1F_sorted.bam
samtools index HSV1F_sorted.bam
bamCoverage -b HSV1F_sorted.bam  -o HSV1F_sorted_RPGC.bam --binSize 10 --normalizeUsing RPGC --effectiveGenomeSize 136446  



