# Functional Enrichment Analysis

Functional enrichment analysis was performed separately for genes that were significantly upregulated and downregulated in the pseudobulk differential-expression analysis.

## Input Gene Sets

Differentially expressed genes were defined using:

- adjusted p-value < 0.05
- |log2 fold change| ≥ 1

This produced separate upregulated and downregulated gene lists for enrichment analysis.

## g:Profiler

Functional enrichment was performed using the **g:GOSt** tool in g:Profiler.

The upregulated and downregulated gene lists were analyzed separately using:

- Gene Ontology Biological Process (GO:BP)
- Reactome pathways

The analysis used the genes retained for pseudobulk differential-expression testing as the intended background gene set.

The exported g:Profiler result tables were saved as:

```text
gProfiler_upregulated_genes.csv
gProfiler_downregulated_genes.csv
```

## Visualization

The Python scripts in this directory read the exported g:Profiler results and:

1. retain terms with adjusted p-value < 0.05;
2. retain GO Biological Process and Reactome results;
3. select the 10 most significant terms by adjusted p-value; and
4. generate pathway-enrichment dot plots.

The dot plots display:

- **x-axis:** −log10 adjusted p-value
- **dot size:** number of input genes overlapping the pathway
- **dot color:** adjusted p-value
- **y-axis:** enriched pathway or biological-process term

## Scripts

```text
01_plot_upregulated_pathways.py
02_plot_downregulated_pathways.py
```