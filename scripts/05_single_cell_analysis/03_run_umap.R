### Cluster cells and run UMAP

library(Seurat)

# Load PCA data
seurat <- readRDS("results/seurat_pca.rds")

# Find neighboring cells using the first 20 PCs
seurat <- FindNeighbors(seurat,dims = 1:20)

# Find cell clusters
seurat <- FindClusters(seurat, resolution = 0.5)

# Run UMAP
seurat <- RunUMAP(seurat, dims = 1:20)

# Check cells in each cluster
print(table(Idents(seurat)))

# Save UMAP data
saveRDS(seurat,"results/seurat_umap.rds")

# Plot the clusters
pdf("results/umap_clusters.pdf")

DimPlot(seurat, reduction = "umap",label = TRUE)

# Close and save the PDF
dev.off()
