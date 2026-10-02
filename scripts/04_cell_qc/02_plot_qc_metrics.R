# ============================================================
# Visualize cell-level QC metrics
# ============================================================
#
# Purpose:
#   Examine the distributions of genes detected, total UMI
#   counts, and mitochondrial RNA percentage across samples
#   before applying additional cell-level filtering.
#
# QC metrics:
#   nFeature_RNA = genes detected per cell
#   nCount_RNA   = total UMI counts per cell
#   percent.mt   = mitochondrial count percentage
#
# Input:
#   results/seurat_before_filtering.rds
#
# Output:
#   results/seurat_qc_violin.pdf
#
# ============================================================

library(Seurat)


seurat <- readRDS(
  "results/seurat_before_filtering.rds"
)


pdf(
  "results/seurat_qc_violin.pdf",
  width = 12,
  height = 6
)

VlnPlot(
  seurat,
  features = c(
    "nFeature_RNA",
    "nCount_RNA",
    "percent.mt"
  ),
  group.by = "sample",
  ncol = 3
)

dev.off()
