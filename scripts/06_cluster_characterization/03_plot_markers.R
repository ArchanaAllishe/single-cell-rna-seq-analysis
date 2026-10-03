### Plot selected marker genes across clusters

library(Seurat)

# Load clustered data
seurat <- readRDS("results/seurat_umap.rds")

# Genes to compare
genes <- c(
  "CD3D", "CD3E", "TRAC",
  "NKG7", "GNLY", "KLRD1",
  "GZMB", "GZMH",
  "IL2", "IL4", "IFNG", "TNF",
  "CD79A", "MS4A1"
)

# Create marker dot plot
pdf("results/marker_dotplot.pdf", width = 10, height = 6)

DotPlot(
  seurat,
  features = genes
) +
  RotatedAxis()

# Close and save the PDF
dev.off()
