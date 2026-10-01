# ============================================================
# Generate sample-level pseudobulk count profiles
# ============================================================
#
# Purpose:
#   Aggregate single-cell expression values within each of the
#   six biological samples to generate sample-level profiles
#   for differential-expression analysis.
#
# Input:
#   results/seurat_umap.rds
#
# Output:
#   results/pseudobulk_counts.csv
#
# ============================================================

library(Seurat)


seurat <- readRDS(
  "results/seurat_umap.rds"
)


# ------------------------------------------------------------
# Join expression layers
# ------------------------------------------------------------

seurat <- JoinLayers(seurat)


# ------------------------------------------------------------
# Aggregate expression by biological sample
# ------------------------------------------------------------

pseudobulk <- AggregateExpression(
  seurat,
  assays = "RNA",
  group.by = "sample",
  return.seurat = FALSE
)

counts <- pseudobulk$RNA


# ------------------------------------------------------------
# Inspect pseudobulk matrix
# ------------------------------------------------------------

cat("\nPseudobulk matrix dimensions:\n")
print(dim(counts))

cat("\nSamples:\n")
print(colnames(counts))

cat("\nTotal counts per sample:\n")
print(colSums(counts))


# ------------------------------------------------------------
# Save count matrix
# ------------------------------------------------------------

write.csv(
  as.matrix(counts),
  "results/pseudobulk_counts.csv"
)
