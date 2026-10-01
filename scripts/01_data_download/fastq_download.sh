#!/bin/bash

# ============================================================
# Download raw sequencing data for GSE128243
# ============================================================
#
# Downloads the six SRA runs used in this analysis and
# converts each run to compressed FASTQ files.
#
# Samples:
#   Unstim1 -> SRR8724694
#   Unstim2 -> SRR8724695
#   Unstim3 -> SRR8724696
#   Stim1   -> SRR8724697
#   Stim2   -> SRR8724698
#   Stim3   -> SRR8724699
#
# SRA Toolkit programs required:
#   prefetch
#   fasterq-dump
#
# The dataset contains three reads:
#   _1 = sample index
#   _2 = cell barcode + UMI
#   _3 = transcript sequence
#
# ============================================================

set -euo pipefail


# ------------------------------------------------------------
# Project directories
# ------------------------------------------------------------

# Determine the repository root from the location of this
# script so that the workflow does not depend on a
# machine-specific absolute path.

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
project_dir="$(cd "$script_dir/../.." && pwd)"

raw_data_dir="$project_dir/data/raw"
sra_cache_dir="$project_dir/data/sra_cache"

mkdir -p "$raw_data_dir" "$sra_cache_dir"


# ------------------------------------------------------------
# Sample-to-SRA mapping
# ------------------------------------------------------------

declare -A samples=(
    [Unstim1]="SRR8724694"
    [Unstim2]="SRR8724695"
    [Unstim3]="SRR8724696"
    [Stim1]="SRR8724697"
    [Stim2]="SRR8724698"
    [Stim3]="SRR8724699"
)


# ------------------------------------------------------------
# Download and convert each run
# ------------------------------------------------------------

for sample_name in Unstim1 Unstim2 Unstim3 Stim1 Stim2 Stim3
do

    sra_run="${samples[$sample_name]}"

    echo
    echo "Processing $sample_name ($sra_run)"


    # Download the complete SRA run.
    # --max-size u removes the default download-size limit.

    prefetch "$sra_run" \
        --output-directory "$sra_cache_dir" \
        --max-size u


    # Convert the SRA run to FASTQ.
    #
    # --split-files separates the reads.
    # --include-technical retains the technical reads required
    # for reconstructing the original 10x read structure.

    fasterq-dump \
        "$sra_cache_dir/$sra_run" \
        --split-files \
        --include-technical \
        --outdir "$raw_data_dir" \
        --threads 6 \
        --progress


    # Compress all three FASTQ files.

    gzip "$raw_data_dir/${sra_run}_1.fastq"
    gzip "$raw_data_dir/${sra_run}_2.fastq"
    gzip "$raw_data_dir/${sra_run}_3.fastq"

    echo "Completed $sample_name"

done


echo
echo "All six SRA runs were downloaded and converted to FASTQ."