# Single-Cell RNA-seq Analysis

### From Raw 10x Genomics Data to Biological Interpretation

This project presents an end-to-end single-cell RNA-seq analysis using the publicly available **GSE128243** dataset from NCBI GEO. The dataset contains human peripheral-blood NKT cells from **three unstimulated and three PMA/ionomycin-stimulated samples**.

The project follows the workflow from raw sequencing data through read processing, gene-expression quantification, cell-level quality control, transcriptional-state analysis, sample-level differential expression, and functional interpretation.

## Project Workflow

```text
NCBI SRA
   │
   ▼
FASTQ preparation
   │
   ▼
FastQC / MultiQC
   │
   ▼
Cell Ranger
   │
   ▼
Gene-expression matrices
   │
   ▼
Seurat cell-level QC
   │
   ├── Gene/UMI assessment
   ├── Mitochondrial filtering
   └── Doublet detection
   │
   ▼
Single-cell analysis
   │
   ├── Normalization
   ├── Highly variable genes
   ├── PCA
   ├── Clustering
   └── UMAP
   │
   ▼
Cluster characterization
   │
   ├── Marker genes
   └── Sample composition
   │
   ▼
Pseudobulk aggregation
   │
   ▼
DESeq2 differential expression
   │
   ▼
Functional enrichment
   │
   ▼
Biological interpretation
```

## Dataset

| Condition | Sample | GEO Accession | SRA Run |
|---|---|---|---|
| Unstimulated | Unstim1 | GSM3669244 | SRR8724694 |
| Unstimulated | Unstim2 | GSM3669245 | SRR8724695 |
| Unstimulated | Unstim3 | GSM3669246 | SRR8724696 |
| Stimulated | Stim1 | GSM3669247 | SRR8724697 |
| Stimulated | Stim2 | GSM3669248 | SRR8724698 |
| Stimulated | Stim3 | GSM3669249 | SRR8724699 |

**Dataset:** GSE128243  
**Platform:** 10x Genomics Chromium Single Cell 3′  
**Biological comparison:** PMA/ionomycin-stimulated vs unstimulated NKT cells

## Analysis

The workflow includes:

- Raw sequencing data preparation and quality assessment
- Cell Ranger alignment and gene-expression matrix generation
- Cell-level QC and doublet detection
- Normalization and highly variable gene selection
- PCA, graph-based clustering, and UMAP visualization
- Cluster marker-gene analysis
- Sample and condition-level assessment
- Pseudobulk aggregation across biological samples
- Differential expression with DESeq2
- Functional enrichment analysis
- Comparison with findings from the published study
- Interactive reporting with Quarto

## Key Results

Cell Ranger estimated **14,202 cells across the six libraries**. After cell-level QC and removal of predicted doublets, **13,395 singlet cells** were retained for downstream analysis.

The single-cell analysis identified **nine transcriptional clusters** and showed strong separation between stimulated and unstimulated cells. Biological replicates generally overlapped within each condition.

Pseudobulk differential-expression analysis identified **5,313 significantly differentially expressed genes**, including **2,843 upregulated** and **2,470 downregulated** genes in stimulated samples.

Functional enrichment of the upregulated genes highlighted immune-response, cytokine-signaling, lymphocyte-activation, and T-cell-activation pathways. Downregulated genes showed enrichment related to small-molecule metabolic processes.

Overall, the analysis recovered the major stimulation-associated biological patterns reported in the original study.

## Repository Structure

```text
single-cell-rna-seq-analysis/
├── data/
│   ├── metadata/
│   ├── raw/
│   ├── reference/
│   └── sra_cache/
│
├── scripts/
│   ├── 01_data_download/
│   ├── 02_raw_read_qc/
│   ├── 03_cellranger/
│   ├── 04_cell_qc/
│   ├── 05_single_cell_analysis/
│   ├── 06_cluster_characterization/
│   ├── 07_pseudobulk/
│   └── 08_functional_enrichment/
│
├── results/
│   ├── cellranger/
│   └── functional_enrichment/
│
├── Quarto_Report/
│   ├── figures/
│   ├── results/
│   ├── scRNA-Seq_Analysis_Report.qmd
│   ├── _quarto.yml
│   └── styles.css
│
├── .gitignore
└── README.md
```

## Technologies

**Single-cell analysis:** 10x Genomics Cell Ranger, Seurat, scDblFinder  
**Differential expression:** DESeq2  
**Functional analysis:** g:Profiler  
**Quality control:** FastQC, MultiQC  
**Programming:** R, Python, Bash  
**Computing:** Linux HPC  
**Reproducibility and reporting:** Git, GitHub, Quarto

## Report

A detailed Quarto report is included in:

`Quarto_Report/scRNA-Seq_Analysis_Report.qmd`

The report documents the complete analysis workflow, quality-control decisions, figures, results, and biological interpretation.

## Reproducibility

Large sequencing files, genome-reference files, Cell Ranger outputs, and serialized R objects are excluded from version control because of their size.

The repository retains the analysis scripts, metadata, documentation, and report materials required to document and reproduce the workflow.
