### Normalize data and find variable genes

library(Seurat)

# Load singlet cells
seurat <- readRDS("results/seurat_singlets.rds")

# Normalize gene expression
seurat <- NormalizeData(seurat)

# Find the 2,000 most variable genes
seurat <- FindVariableFeatures(
  seurat,
  selection.method = "vst",
  nfeatures = 2000
)

# Save normalized data
saveRDS(seurat,"results/seurat_normalized.rds")
