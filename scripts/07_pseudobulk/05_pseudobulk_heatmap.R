# ============================================================
# Heatmap of strongly differentially expressed genes
# ============================================================
#
# Purpose:
#   Visualize the strongest stimulation-associated expression
#   changes across the six biological samples.
#
# Genes displayed:
#   Top 10 upregulated genes
#   Top 10 downregulated genes
#
# Input:
#   results/pseudobulk_dds.rds
#   results/pseudobulk_deseq2_results.csv
#
# Output:
#   results/pseudobulk_top20_heatmap.pdf
#
# ============================================================

library(DESeq2)
library(pheatmap)


dds <- readRDS(
  "results/pseudobulk_dds.rds"
)

res <- read.csv(
  "results/pseudobulk_deseq2_results.csv"
)


# ------------------------------------------------------------
# Variance-stabilizing transformation
# ------------------------------------------------------------

vsd <- vst(
  dds,
  blind = TRUE
)


# ------------------------------------------------------------
# Select significant genes
# ------------------------------------------------------------

up <- subset(
  res,
  !is.na(padj) &
  padj < 0.05 &
  log2FoldChange >= 1
)

down <- subset(
  res,
  !is.na(padj) &
  padj < 0.05 &
  log2FoldChange <= -1
)


# Rank genes by fold change.

up <- up[
  order(
    up$log2FoldChange,
    decreasing = TRUE
  ),
]

down <- down[
  order(
    down$log2FoldChange
  ),
]


top_genes <- c(
  head(up$gene, 10),
  head(down$gene, 10)
)


# ------------------------------------------------------------
# Extract transformed expression values
# ------------------------------------------------------------

mat <- assay(vsd)[
  top_genes,
  ,
  drop = FALSE
]


# Standardize expression across samples for each gene.

mat <- t(
  scale(
    t(mat)
  )
)


# ------------------------------------------------------------
# Sample annotation
# ------------------------------------------------------------

annotation <- data.frame(
  Condition = colData(vsd)$condition
)

rownames(annotation) <- colnames(mat)


# ------------------------------------------------------------
# Plot heatmap
# ------------------------------------------------------------

pdf(
  "results/pseudobulk_top20_heatmap.pdf",
  width = 7,
  height = 8
)

pheatmap(
  mat,
  annotation_col = annotation,
  cluster_rows = TRUE,
  cluster_cols = TRUE,
  show_rownames = TRUE,
  show_colnames = TRUE,
  main = "Top Differentially Expressed Genes"
)

dev.off()