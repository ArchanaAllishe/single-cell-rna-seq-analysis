# Single-Cell RNA-seq Analysis

### From Raw 10x Genomics Data to Biological Interpretation

This project presents an end-to-end single-cell RNA-seq analysis using the publicly available **GSE128243** dataset from NCBI GEO. The dataset contains human peripheral-blood NKT cells from **three unstimulated and three PMA/ionomycin-stimulated samples**.

The goal was to build a reproducible workflow that follows single-cell RNA-seq data from raw sequencing reads through gene-expression quantification, cell-level quality control, transcriptional-state analysis, sample-level differential expression, and biological interpretation.

The analysis identified strong stimulation-associated transcriptional changes and recovered major biological patterns reported in the original study.

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

The analysis uses **GSE128243**, a publicly available 10x Genomics single-cell RNA-seq dataset of human peripheral-blood NKT cells.

| Condition | Sample | GEO Accession | SRA Run |
|---|---|---|---|
| Unstimulated | Unstim1 | GSM3669244 | SRR8724694 |
| Unstimulated | Unstim2 | GSM3669245 | SRR8724695 |
| Unstimulated | Unstim3 | GSM3669246 | SRR8724696 |
| Stimulated | Stim1 | GSM3669247 | SRR8724697 |
| Stimulated | Stim2 | GSM3669248 | SRR8724698 |
| Stimulated | Stim3 | GSM3669249 | SRR8724699 |

**Dataset:** GSE128243  
**Platform:** 10x Genomics Chromium Single Cell 3′ v2  
**Biological comparison:** PMA/ionomycin-stimulated vs unstimulated NKT cells

## Analysis

The workflow includes:

- Raw sequencing data preparation and FASTQ organization
- Read-level quality assessment with FastQC and MultiQC
- Cell Ranger alignment and gene-expression matrix generation
- Cell-level quality control and filtering
- Doublet detection with scDblFinder
- Normalization and highly variable gene selection
- Principal component analysis
- Graph-based clustering and UMAP visualization
- Cluster marker-gene analysis
- Sample and condition-level assessment
- Pseudobulk aggregation across biological samples
- Differential expression analysis with DESeq2
- Functional enrichment analysis with g:Profiler
- Comparison with findings from the published study
- Interactive reporting with Quarto

## Key Results

Cell Ranger estimated **14,202 cells across the six libraries**. After cell-level quality filtering and removal of predicted doublets, **13,395 singlet cells** were retained for downstream analysis.

The single-cell analysis identified **nine transcriptional clusters**. UMAP visualization showed strong separation between stimulated and unstimulated cells, while biological replicates generally overlapped within their respective conditions.

Pseudobulk differential-expression analysis identified **5,313 significantly differentially expressed genes**, including:

- **2,843 upregulated genes**
- **2,470 downregulated genes**

Functional enrichment of the upregulated genes highlighted pathways associated with:

- Immune response
- Cytokine signaling
- Lymphocyte activation
- T-cell activation

Downregulated genes showed enrichment related to **small-molecule metabolic processes**, consistent with stimulation-associated metabolic remodeling.

Overall, the modern reanalysis recovered the major stimulation-associated biological patterns reported in the original study despite differences in genome reference, software versions, QC procedures, and downstream analysis methods.

## Repository Structure

```text
single-cell-rna-seq-analysis/
│
├── data/
│   ├── metadata/
│   │   └── sample_metadata.csv
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

| Area | Tools |
|---|---|
| Raw data retrieval | NCBI SRA Toolkit |
| Read-level QC | FastQC, MultiQC |
| 10x processing | Cell Ranger |
| Single-cell analysis | R, Seurat |
| Doublet detection | scDblFinder |
| Differential expression | DESeq2 |
| Functional enrichment | g:Profiler |
| Scripting | R, Python, Bash |
| Computing | Linux HPC |
| Version control | Git, GitHub |
| Reporting | Quarto |

## Interactive Report

The complete analysis, including quality-control decisions, figures, results, and biological interpretation, is available as an interactive Quarto report:

**[View the Interactive scRNA-seq Analysis Report](https://ArchanaAllishe.github.io/single-cell-rna-seq-analysis/)**

The report source is available in:

`Quarto_Report/scRNA-Seq_Analysis_Report.qmd`

## Reproducibility

Large sequencing files, genome-reference files, Cell Ranger outputs, and serialized R objects are excluded from version control because of their size.

The repository retains the analysis scripts, sample metadata, documentation, selected results, and Quarto report materials needed to document and reproduce the analysis workflow.

Raw sequencing data can be retrieved from NCBI SRA using the accession numbers provided in `data/metadata/sample_metadata.csv`.

## Reference

Zhou et al. (2020). Dataset **GSE128243**.

DOI: **10.3389/fcell.2020.00384**