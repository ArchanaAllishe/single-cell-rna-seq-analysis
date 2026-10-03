### Run PCA using variable genes

library(Seurat)

# Load normalized data
seurat <- readRDS("results/seurat_normalized.rds")

# Scale the 2,000 variable genes
seurat <- ScaleData(seurat, features = VariableFeatures(seurat))

# Run PCA
seurat <- RunPCA(seurat, features = VariableFeatures(seurat))

# Plot the first 50 PCs
pdf("results/pca_elbow_plot.pdf")

ElbowPlot(seurat, ndims = 50)

# Close and save the PDF
dev.off()

# Save PCA data
saveRDS(seurat,"results/seurat_pca.rds")
