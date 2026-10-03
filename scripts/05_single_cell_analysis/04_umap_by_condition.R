## Plot UMAP by condition

library(Seurat)

# Load UMAP data
seurat <- readRDS("results/seurat_umap.rds")

# Plot stimulated and unstimulated cells
pdf("results/umap_condition.pdf")

DimPlot(seurat, reduction = "umap",group.by = "condition")

# Close and save the PDF
dev.off()
