# ============================================================
# Visualize selected marker genes across clusters
# ============================================================
#
# Purpose:
#   Examine representative lineage- and activation-associated
#   genes across the identified transcriptional clusters.
#
# Dot size represents the percentage of cells expressing a
# gene, while color reflects average expression.
#
# Input:
#   results/seurat_umap.rds
#
# Output:
#   results/marker_dotplot.pdf
#
# ============================================================

library(Seurat)


seurat <- readRDS(
  "results/seurat_umap.rds"
)


# ------------------------------------------------------------
# Marker panel
# ------------------------------------------------------------

genes <- c(
  "CD3D", "CD3E", "TRAC",
  "NKG7", "GNLY", "KLRD1",
  "GZMB", "GZMH",
  "IL2", "IL4", "IFNG", "TNF",
  "CD79A", "MS4A1"
)


# ------------------------------------------------------------
# Generate marker dot plot
# ------------------------------------------------------------

pdf(
  "results/marker_dotplot.pdf",
  width = 10,
  height = 6
)

DotPlot(
  seurat,
  features = genes
) +
  RotatedAxis()

dev.off()
