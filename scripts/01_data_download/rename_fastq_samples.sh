#!/bin/bash

# ============================================================
# Rename SRA FASTQ files using biological sample names
# ============================================================
#
# Converts SRA accession-based filenames into simple sample
# names used throughout the analysis.
#
# Read structure:
#   _1 = sample index          -> I1
#   _2 = cell barcode + UMI    -> R1
#   _3 = transcript sequence   -> R2
#
# Example:
#
#   SRR8724694_1.fastq.gz
#           ↓
#   Unstim1_I1.fastq.gz
#
# ============================================================

set -euo pipefail


script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
project_dir="$(cd "$script_dir/../.." && pwd)"

cd "$project_dir/data/raw"


for sample in \
    "SRR8724694 Unstim1" \
    "SRR8724695 Unstim2" \
    "SRR8724696 Unstim3" \
    "SRR8724697 Stim1" \
    "SRR8724698 Stim2" \
    "SRR8724699 Stim3"
do

    # Split each entry into:
    # $1 = SRA accession
    # $2 = biological sample name

    set -- $sample


    mv "${1}_1.fastq.gz" "${2}_I1.fastq.gz"
    mv "${1}_2.fastq.gz" "${2}_R1.fastq.gz"
    mv "${1}_3.fastq.gz" "${2}_R2.fastq.gz"

    echo "Renamed $1 -> $2"

done


echo
echo "All FASTQ files were renamed using biological sample names."
