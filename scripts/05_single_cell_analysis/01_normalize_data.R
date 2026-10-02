# ============================================================
# Normalize expression and identify variable genes
# ============================================================
#
# Purpose:
#   Normalize gene-expression values and identify genes with
#   high cell-to-cell variation for downstream dimensionality
#   reduction.
#
# Input:
#   results/seurat_singlets.rds
#
# Method:
#   NormalizeData()
#   FindVariableFeatures(method = "vst", nfeatures = 2000)
#
# Output:
#   results/seurat_normalized.rds
#
# ============================================================

library(Seurat)


# Load high-quality singlet cells.

seurat <- readRDS(
  "results/seurat_singlets.rds"
)


# ------------------------------------------------------------
# Normalize gene expression
# ------------------------------------------------------------

seurat <- NormalizeData(seurat)


# ------------------------------------------------------------
# Identify highly variable genes
# ------------------------------------------------------------

seurat <- FindVariableFeatures(
  seurat,
  selection.method = "vst",
  nfeatures = 2000
)


cat(
  "Highly variable genes:",
  length(VariableFeatures(seurat)),
  "\n"
)


# ------------------------------------------------------------
# Save normalized object
# ------------------------------------------------------------

saveRDS(
  seurat,
  "results/seurat_normalized.rds"
)
