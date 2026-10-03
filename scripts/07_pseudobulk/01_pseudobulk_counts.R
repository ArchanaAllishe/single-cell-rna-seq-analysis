### Create pseudobulk counts for each sample

library(Seurat)

# Load single-cell data
seurat <- readRDS("results/seurat_umap.rds")

# Join expression layers
seurat <- JoinLayers(seurat)

# Combine counts from cells within each sample
pseudobulk <- AggregateExpression(
  seurat,
  assays = "RNA",
  group.by = "sample",
  return.seurat = FALSE
)

counts <- pseudobulk$RNA

# Check the pseudobulk data
print(dim(counts))
print(colnames(counts))
print(colSums(counts))

# Save pseudobulk counts
write.csv(as.matrix(counts), "results/pseudobulk_counts.csv")
