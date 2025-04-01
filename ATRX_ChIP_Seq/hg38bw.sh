#!/bin/bash
samtools sort .bam  sorted.bam 
samtools index sorted.bam
	
bamCoverage -b sorted.bam  -o Input_3_RPGC.bw --binSize 10 --normalizeUsing RPGC --effectiveGenomeSize 2913022398 
