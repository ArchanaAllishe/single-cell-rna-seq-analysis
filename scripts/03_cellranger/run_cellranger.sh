#!/bin/bash

### Run Cell Ranger for all six samples

# Stop if a command fails or a variable is missing
set -euo pipefail

# Input and output folders
fastq_dir="data/raw"
reference="data/reference/refdata-gex-GRCh38-2024-A"
output_dir="results/cellranger"

mkdir -p "$output_dir"
cd "$output_dir"

# Run Cell Ranger for each sample
for sample in Unstim1 Unstim2 Unstim3 Stim1 Stim2 Stim3
do
    echo "Processing $sample"

    cellranger count \
        --id="$sample" \
        --transcriptome="$reference" \
        --fastqs="$fastq_dir" \
        --sample="$sample" \
        --chemistry=SC3Pv2 \
        --create-bam=true \
        --localcores=16 \
        --localmem=128

    echo "$sample complete"
done

echo "Cell Ranger complete for all six samples."
