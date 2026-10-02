# Raw-Read Quality Control

Raw sequencing quality was assessed before Cell Ranger processing using **FastQC** and **MultiQC**.

## Reads examined

The sequencing libraries contained three read types:

- **I1** — sample index
- **R1** — cell barcode and UMI
- **R2** — transcript sequence

FastQC was performed on the **R2 transcript reads** from all six samples.

## FastQC

FastQC was used to evaluate sequencing-quality metrics for each R2 FASTQ file.

Example command:

```bash
fastqc data/raw/*_R2_001.fastq.gz
```

## MultiQC

MultiQC was then used to combine the individual FastQC reports into a single summary report.

Example command:

```bash
multiqc .
```

The combined report was reviewed for sequencing quality before proceeding to Cell Ranger.

## Interpretation

The transcript reads showed good overall sequencing quality. Per-base sequence quality, per-sequence quality scores, sequence length distribution, and adapter-content metrics were acceptable.

High sequence duplication and deviations in GC-content metrics were also observed. These metrics were interpreted in the context of single-cell RNA-seq libraries rather than automatically treated as evidence that the reads required trimming.

No read trimming was performed before Cell Ranger processing.
