### Find marker genes for each cluster

library(Seurat)

# Load clustered data
seurat <- readRDS("results/seurat_umap.rds")

# Join expression layers before finding markers
seurat <- JoinLayers(seurat)

# Find genes with higher expression in each cluster
markers <- FindAllMarkers(
  seurat,
  only.pos = TRUE,
  min.pct = 0.25,
  logfc.threshold = 0.25
)

# Save marker genes
write.csv(markers, "results/cluster_markers.csv",row.names = FALSE)

# Save data with joined layers
saveRDS(seurat, "results/seurat_umap.rds")

cat("Marker genes identified:", nrow(markers), "\n")
