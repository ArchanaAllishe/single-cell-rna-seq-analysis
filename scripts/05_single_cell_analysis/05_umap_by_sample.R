# ============================================================
# Visualize UMAP by biological sample
# ============================================================
#
# Purpose:
#   Examine whether transcriptional patterns are reproduced
#   across the six biological samples and identify potential
#   sample-specific structure.
#
# Input:
#   results/seurat_umap.rds
#
# Output:
#   results/umap_sample.pdf
#
# ============================================================

library(Seurat)


seurat <- readRDS(
  "results/seurat_umap.rds"
)


pdf(
  "results/umap_sample.pdf"
)

DimPlot(
  seurat,
  reduction = "umap",
  group.by = "sample"
)

dev.off()
