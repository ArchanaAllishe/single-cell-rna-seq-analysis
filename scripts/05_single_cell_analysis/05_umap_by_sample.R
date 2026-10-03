### Plot UMAP by sample

library(Seurat)

# Load UMAP data
seurat <- readRDS("results/seurat_umap.rds")

# Plot cells from each sample
pdf("results/umap_sample.pdf")

DimPlot(seurat, reduction = "umap",group.by = "sample")

# Close and save the PDF
dev.off()
