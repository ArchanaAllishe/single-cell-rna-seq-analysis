# ============================================================
# Visualize UMAP by experimental condition
# ============================================================
#
# Purpose:
#   Examine how stimulated and unstimulated cells are
#   distributed across the transcriptional landscape.
#
# Input:
#   results/seurat_umap.rds
#
# Output:
#   results/umap_condition.pdf
#
# ============================================================

library(Seurat)


seurat <- readRDS(
  "results/seurat_umap.rds"
)


pdf(
  "results/umap_condition.pdf"
)

DimPlot(
  seurat,
  reduction = "umap",
  group.by = "condition"
)

dev.off()

