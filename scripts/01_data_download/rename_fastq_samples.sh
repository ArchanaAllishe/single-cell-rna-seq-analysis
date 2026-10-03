#!/bin/bash

# Rename SRA FASTQ files using sample names

# Stop if a command fails or a variable is missing
set -euo pipefail

# FASTQ folder
raw_dir="data/raw"

cd "$raw_dir"

# SRA run ID and sample name
for sample in \
    "SRR8724694 Unstim1" \
    "SRR8724695 Unstim2" \
    "SRR8724696 Unstim3" \
    "SRR8724697 Stim1" \
    "SRR8724698 Stim2" \
    "SRR8724699 Stim3"
do
    set -- $sample

    # Rename I1, R1, and R2 files
    mv "${1}_1.fastq.gz" "${2}_I1.fastq.gz"
    mv "${1}_2.fastq.gz" "${2}_R1.fastq.gz"
    mv "${1}_3.fastq.gz" "${2}_R2.fastq.gz"

    echo "$1 renamed to $2"
done

echo "All FASTQ files renamed."
