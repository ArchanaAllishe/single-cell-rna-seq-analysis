#!/bin/bash

### Rename FASTQ files for Cell Ranger

# Stop if a command fails or a variable is missing
set -euo pipefail

# FASTQ folder
raw_dir="data/raw"

cd "$raw_dir"

# Rename each sample using Cell Ranger format
for sample in Unstim1 Unstim2 Unstim3 Stim1 Stim2 Stim3
do
    mv "${sample}_I1.fastq.gz" "${sample}_S1_L001_I1_001.fastq.gz"
    mv "${sample}_R1.fastq.gz" "${sample}_S1_L001_R1_001.fastq.gz"
    mv "${sample}_R2.fastq.gz" "${sample}_S1_L001_R2_001.fastq.gz"

    echo "$sample complete"
done

echo "FASTQ files are ready for Cell Ranger."
