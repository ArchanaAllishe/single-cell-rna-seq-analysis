# ============================================================
# Identify marker genes for each cluster
# ============================================================
#
# Purpose:
#   Identify genes with increased expression in each cluster
#   compared with the remaining cells.
#
# Input:
#   results/seurat_umap.rds
#
# Parameters:
#   only.pos = TRUE
#   min.pct = 0.25
#   logfc.threshold = 0.25
#
# Output:
#   results/cluster_markers.csv
#
# ============================================================

library(Seurat)


# Load clustered Seurat object.

seurat <- readRDS(
  "results/seurat_umap.rds"
)


# ------------------------------------------------------------
# Join expression layers
# ------------------------------------------------------------

# The merged Seurat object can contain separate expression
# layers. Join them before marker-gene testing.

seurat <- JoinLayers(seurat)


# ------------------------------------------------------------
# Identify cluster markers
# ------------------------------------------------------------

markers <- FindAllMarkers(
  seurat,
  only.pos = TRUE,
  min.pct = 0.25,
  logfc.threshold = 0.25
)


# ------------------------------------------------------------
# Save marker results
# ------------------------------------------------------------

write.csv(
  markers,
  "results/cluster_markers.csv",
  row.names = FALSE
)


# Preserve the object with joined expression layers.

saveRDS(
  seurat,
  "results/seurat_umap.rds"
)


cat(
  "Marker genes identified:",
  nrow(markers),
  "\n"
)
