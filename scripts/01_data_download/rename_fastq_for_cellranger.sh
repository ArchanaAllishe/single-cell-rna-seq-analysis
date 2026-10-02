#!/bin/bash

# ============================================================
# Rename FASTQ files for Cell Ranger
# ============================================================
#
# Cell Ranger expects FASTQ filenames that follow the standard
# Illumina naming convention.
#
# Example:
#
#   Unstim1_R2.fastq.gz
#          ↓
#   Unstim1_S1_L001_R2_001.fastq.gz
#
# The biological sample name is preserved while standard
# sample, lane, and read identifiers are added.
#
# ============================================================

set -euo pipefail


script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
project_dir="$(cd "$script_dir/../.." && pwd)"

cd "$project_dir/data/raw"


for sample in Unstim1 Unstim2 Unstim3 Stim1 Stim2 Stim3
do

    mv "${sample}_I1.fastq.gz" \
       "${sample}_S1_L001_I1_001.fastq.gz"

    mv "${sample}_R1.fastq.gz" \
       "${sample}_S1_L001_R1_001.fastq.gz"

    mv "${sample}_R2.fastq.gz" \
       "${sample}_S1_L001_R2_001.fastq.gz"

    echo "Prepared Cell Ranger filenames for $sample"

done


echo
echo "FASTQ filenames are ready for Cell Ranger."
