#!/bin/bash

# Download FASTQ files for GSE128243
# Requires SRA Toolkit: prefetch and fasterq-dump

# Stop the script if a command fails or a variable is missing
set -euo pipefail

# Data folders
raw_dir="data/raw"
sra_dir="data/sra_cache"

mkdir -p "$raw_dir" "$sra_dir"

# Sample and SRA run IDs
declare -A samples=(
    [Unstim1]="SRR8724694"
    [Unstim2]="SRR8724695"
    [Unstim3]="SRR8724696"
    [Stim1]="SRR8724697"
    [Stim2]="SRR8724698"
    [Stim3]="SRR8724699"
)

# Download each sample
for sample in Unstim1 Unstim2 Unstim3 Stim1 Stim2 Stim3
do
    sra="${samples[$sample]}"

    echo "Processing $sample ($sra)"

    # Download SRA data
    prefetch "$sra" \
        --output-directory "$sra_dir" \
        --max-size u

    # Convert to FASTQ
    fasterq-dump "$sra_dir/$sra" \
        --split-files \
        --include-technical \
        --outdir "$raw_dir" \
        --threads 6

    # Compress FASTQ files
    gzip "$raw_dir/${sra}_1.fastq"
    gzip "$raw_dir/${sra}_2.fastq"
    gzip "$raw_dir/${sra}_3.fastq"

    echo "$sample complete"
done

echo "All six samples complete."
