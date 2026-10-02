<div align="center">

# Single-Cell RNA-seq Analysis

### From Raw 10x Genomics Data to Biological Interpretation

<h3>
  <a href="https://archanaallishe.github.io/single-cell-rna-seq-analysis/">
    <em>View Detailed Interactive Analysis Report</em>
  </a>
</h3>

</div>

This project presents an end-to-end analysis of the publicly available **GSE128243** 10x Genomics dataset, consisting of human peripheral-blood NKT cells from **three unstimulated and three PMA/ionomycin-stimulated samples** [Zhou et al. (2020), PMID: 32528956].

The project was developed as a reproducible implementation of a complete single-cell RNA-seq workflow, from raw sequencing data to biological interpretation. The analysis revealed strong stimulation-associated transcriptional changes and recovered the major biological patterns reported in the original study.

## Analysis Workflow

The analysis follows the data from raw sequencing reads through single-cell characterization and condition-level biological interpretation.

![Single-cell RNA-seq analysis workflow](Quarto_Report/figures/analysis_workflow.png)

The workflow combines raw-data preparation, read-level quality assessment, Cell Ranger processing, Seurat-based single-cell analysis, cluster characterization, pseudobulk differential expression, and functional enrichment.

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

**Platform:** 10x Genomics Chromium Single Cell 3′ v2  
**Biological comparison:** PMA/ionomycin-stimulated vs unstimulated NKT cells

## Key Results

Cell Ranger estimated **14,202 cells across the six libraries**. After cell-level quality filtering and doublet removal, **13,395 singlet cells** were retained for downstream analysis.

### Single-cell structure

The analysis identified **nine transcriptional clusters**. UMAP visualization showed strong separation between stimulated and unstimulated cells, while biological replicates generally overlapped within their respective conditions.

<p align="center">
  <img src="Quarto_Report/results/umap_condition.png"
       alt="UMAP by condition"
       width="700">
</p>

### Differential expression

Pseudobulk analysis was performed at the biological-sample level using the three stimulated and three unstimulated samples.

DESeq2 identified **5,313 significantly differentially expressed genes**:

- **2,843 upregulated**
- **2,470 downregulated**

<p align="center">
  <img src="Quarto_Report/results/pseudobulk_volcano.png"
       alt="Pseudobulk differential-expression volcano plot"
       width="700">
</p>

Pseudobulk PCA also showed clear separation of stimulated and unstimulated samples, with the three biological replicates grouping by condition.

### Functional interpretation

Functional enrichment of the upregulated genes highlighted biological programs associated with:

- Immune response
- Cytokine signaling
- Lymphocyte activation
- T-cell activation

Downregulated genes showed enrichment related to **small-molecule metabolic processes**, consistent with stimulation-associated metabolic remodeling.

Despite differences in genome reference, software versions, QC procedures, and downstream analysis methods, the reanalysis recovered the major stimulation-associated biological patterns reported in the original study.

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

The numbered script directories follow the analysis in chronological order, from raw-data acquisition through functional interpretation.

## Technologies

| Area | Tools |
|---|---|
| Data retrieval | NCBI SRA Toolkit |
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

A detailed interactive report documents the complete analysis, including QC decisions, dimensionality reduction, clustering, marker analysis, pseudobulk differential expression, functional enrichment, figures, and biological interpretation.

**[View the Interactive scRNA-seq Analysis Report](https://ArchanaAllishe.github.io/single-cell-rna-seq-analysis/)**

The Quarto source is available at:

`Quarto_Report/scRNA-Seq_Analysis_Report.qmd`

## Reproducibility

Large sequencing files, genome-reference files, Cell Ranger outputs, and serialized R objects are excluded from version control because of their size.

The repository retains the analysis scripts, sample metadata, documentation, selected results, and Quarto report materials needed to document and reproduce the workflow. Raw sequencing data can be retrieved from NCBI SRA using the accession numbers provided in `data/metadata/sample_metadata.csv`.

## Reference

Zhou et al. (2020). Dataset **GSE128243**.  
DOI: **10.3389/fcell.2020.00384**