# ============================================================
# Graph-based clustering and UMAP
# ============================================================
#
# Purpose:
#   Construct the cell-neighbor graph, identify transcriptional
#   clusters, and visualize the cells in two dimensions.
#
# Principal components:
#   PCs 1-20
#
# Clustering resolution:
#   0.5
#
# Input:
#   results/seurat_pca.rds
#
# Output:
#   results/seurat_umap.rds
#   results/umap_clusters.pdf
#
# ============================================================

library(Seurat)


seurat <- readRDS(
  "results/seurat_pca.rds"
)


# ------------------------------------------------------------
# Build nearest-neighbor graph
# ------------------------------------------------------------

seurat <- FindNeighbors(
  seurat,
  dims = 1:20
)


# ------------------------------------------------------------
# Identify clusters
# ------------------------------------------------------------

seurat <- FindClusters(
  seurat,
  resolution = 0.5
)


# ------------------------------------------------------------
# Calculate UMAP coordinates
# ------------------------------------------------------------

seurat <- RunUMAP(
  seurat,
  dims = 1:20
)


# ------------------------------------------------------------
# Check cluster sizes
# ------------------------------------------------------------

cat("\nCells per cluster:\n")
print(table(Idents(seurat)))


# ------------------------------------------------------------
# Save Seurat object
# ------------------------------------------------------------

saveRDS(
  seurat,
  "results/seurat_umap.rds"
)


# ------------------------------------------------------------
# Plot clusters
# ------------------------------------------------------------

pdf(
  "results/umap_clusters.pdf"
)

DimPlot(
  seurat,
  reduction = "umap",
  label = TRUE
)

dev.off()
