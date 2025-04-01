	#!/bin/bash
	
	# Set file paths and parameters
	REF_GENOME=  # Bowtie2 reference genome index prefix
	R1= # Input read 1
	R2= # Input read 2
	TRIM_R1=  # Trimmed output for read 1
	TRIM_R2=   # Trimmed output for read 2
	OUT_BAM= output.bam    # Final BAM output
	THREADS=                      # Number of threads
	
	# Step 1: Adapter Trimming with Cutadapt
	echo "Running Cutadapt for adapter and quality trimming..."
	cutadapt \
	-a AGATCGGAAGAGCACACGTCTGAACTCCAGTCA \
	-A AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT \
	--quality-cutoff 20,20 \
	--minimum-length 30 \
	--error-rate 0.1 \
	--report=full \
	-o $TRIM_R1 -p $TRIM_R2 \
	$R1 $R2
	
	# Step 2: Read Alignment with Bowtie2
	echo "Running Bowtie2 for paired-end alignment..."
	bowtie2 \
		-x $REF_GENOME \
		-1 $TRIM_R1 -2 $TRIM_R2 \
		--very-sensitive \
		--no-mixed --no-discordant \
		--dovetail \
		--maxins 2000 \
		--threads $THREADS \
		-S ${OUT_PREFIX}.sam
	
	# Step 3: Convert SAM to BAM
	echo "Step 2: Converting SAM to BAM..."
	
	samtools view -bS ${OUT_PREFIX}.sam > ${OUT_PREFIX}.bam
	
	# Step 4: Post-Alignment Summary (Optional)
	echo "Generating alignment statistics..."
	samtools flagstat ${OUT_PREFIX}.bam
