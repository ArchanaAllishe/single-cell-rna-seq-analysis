#!/bin/bash

# ============================================================
# Run Cell Ranger gene-expression processing
# ============================================================
#
# Purpose:
#   Process the six 10x Genomics scRNA-seq libraries with
#   Cell Ranger count.
#
# Samples:
#   Unstim1, Unstim2, Unstim3
#   Stim1, Stim2, Stim3
#
# Reference:
#   GRCh38 2024-A
#
# Chemistry:
#   10x Single Cell 3' v2 (SC3Pv2)
#
# Main Cell Ranger outputs include:
#   filtered_feature_bc_matrix/
#   metrics_summary.csv
#   web_summary.html
#   BAM files
#
# ============================================================

set -euo pipefail


# ------------------------------------------------------------
# Project paths
# ------------------------------------------------------------

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
project_dir="$(cd "$script_dir/../.." && pwd)"

fastq_dir="$project_dir/data/raw"
reference="$project_dir/data/reference/refdata-gex-GRCh38-2024-A"
output_dir="$project_dir/results/cellranger"

mkdir -p "$output_dir"


# ------------------------------------------------------------
# Process each biological sample
# ------------------------------------------------------------

for sample in Unstim1 Unstim2 Unstim3 Stim1 Stim2 Stim3
do

    echo
    echo "Running Cell Ranger: $sample"

    cd "$output_dir"

    cellranger count \
        --id="$sample" \
        --transcriptome="$reference" \
        --fastqs="$fastq_dir" \
        --sample="$sample" \
        --chemistry=SC3Pv2 \
        --create-bam=true \
        --localcores=16 \
        --localmem=128

    echo "Completed: $sample"

done


echo
echo "Cell Ranger processing completed for all six samples."