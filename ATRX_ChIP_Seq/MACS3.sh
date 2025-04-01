#!/bin/bash

#for Hg38 analysis
macs3 predictd -i ATRX_merge.bam  --format BAMPE --outdir macsoutput --verbose 3
macs3 callpeak -B -f BAMPE -t ATRX_merge.bam -c Input_merge.bam -n ATRXbdg --nomodel --extsize 292

#for HSV-1 analysis:
macs3 predictd -i ATRX_merge_HSV1F.bam  --format BAMPE --outdir macsoutput --verbose 3
macs3 callpeak -B -f BAMPE -t ATRX_merge_HSV1F.bam -c Input_merge_HSV1F.bam -n ATRXvinputHSV1Fbdg --slocal 600 --llocal 2000 --nomodel --extsize 311
macs3 callpeak -B -f BAMPE -t IgG_merge_HSV1F.bam  -c Input_merge_HSV1F.bam  -n IgGvinoutHSV1Fbdg --slocal 600 --llocal 2000 --nomodel --extsize 311

macs3 bdgdiff --t1 ATRXvinputHSV1Fbdg_treat_pileup.bdg --c1 ATRXvinputHSV1Fbdg_control_lambda.bdg --t2 IgGvinoutHSV1Fbdg_treat_pileup.bdg --c2 IgGvinoutHSV1Fbdg_control_lambda.bdg --d1 763160 --d2 10551531 -l 392 --o-prefix diff_ATRXvIgGHSV1



