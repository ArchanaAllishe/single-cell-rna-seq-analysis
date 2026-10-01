# ============================================================
# Scale variable genes and perform PCA
# ============================================================
#
# Purpose:
#   Reduce the dimensionality of the single-cell expression
#   data using the 2,000 highly variable genes identified in
#   the previous stage.
#
# Input:
#   results/seurat_normalized.rds
#
# Output:
#   results/seurat_pca.rds
#   results/pca_elbow_plot.pdf
#
# ============================================================

library(Seurat)


seurat <- readRDS(
  "results/seurat_normalized.rds"
)


# ------------------------------------------------------------
# Scale highly variable genes
# ------------------------------------------------------------

seurat <- ScaleData(
  seurat,
  features = VariableFeatures(seurat)
)


# ------------------------------------------------------------
# Principal component analysis
# ------------------------------------------------------------

seurat <- RunPCA(
  seurat,
  features = VariableFeatures(seurat)
)


# ------------------------------------------------------------
# Examine variance across principal components
# ------------------------------------------------------------

pdf(
  "results/pca_elbow_plot.pdf"
)

ElbowPlot(
  seurat,
  ndims = 50
)

dev.off()


# ------------------------------------------------------------
# Save PCA object
# ------------------------------------------------------------

saveRDS(
  seurat,
  "results/seurat_pca.rds"
)
