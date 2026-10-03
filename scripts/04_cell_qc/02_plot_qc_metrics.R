### Plot cell QC metrics before filtering

library(Seurat)

# Load Seurat object
seurat <- readRDS("results/seurat_before_filtering.rds")

# Plot genes, UMI counts, and mitochondrial percentage
pdf("results/seurat_qc_violin.pdf", width = 12, height = 6)

VlnPlot(
  seurat,
  features = c("nFeature_RNA", "nCount_RNA", "percent.mt"),
  group.by = "sample",
  ncol = 3
)

# Close and save the PDF
dev.off()
