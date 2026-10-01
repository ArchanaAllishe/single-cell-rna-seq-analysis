# ============================================================
# Apply cell-level QC filtering
# ============================================================
#
# Retain cells with:
#
#   200 <= detected genes <= 2000
#   mitochondrial percentage < 10%
#
# Input:
#   results/seurat_before_filtering.rds
#
# Output:
#   results/seurat_filtered.rds
#
# ============================================================

library(Seurat)


seurat <- readRDS(
  "results/seurat_before_filtering.rds"
)


# ------------------------------------------------------------
# Apply QC thresholds
# ------------------------------------------------------------

seurat <- subset(
  seurat,
  subset =
    nFeature_RNA >= 200 &
    nFeature_RNA <= 2000 &
    percent.mt < 10
)


# ------------------------------------------------------------
# Check retained cells
# ------------------------------------------------------------

cat("\nCells retained by sample:\n")
print(table(seurat$sample))

cat("\nTotal retained cells:", ncol(seurat), "\n")


# ------------------------------------------------------------
# Save filtered object
# ------------------------------------------------------------

saveRDS(
  seurat,
  "results/seurat_filtered.rds"
)
