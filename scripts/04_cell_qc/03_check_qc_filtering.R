# ============================================================
# Evaluate proposed cell-level QC cutoffs
# ============================================================
#
# Purpose:
#   Determine how many cells in each biological sample would
#   fail the selected QC thresholds before filtering.
#
# QC criteria:
#   nFeature_RNA >= 200
#   nFeature_RNA <= 2000
#   percent.mt < 10
#
# Input:
#   results/seurat_before_filtering.rds
#
# ============================================================

library(Seurat)


seurat <- readRDS(
  "results/seurat_before_filtering.rds"
)


for (s in unique(seurat$sample)) {

  # Metadata for one biological sample.

  cells <- seurat@meta.data[
    seurat$sample == s,
  ]


  total <- nrow(cells)


  # Number of cells failing each individual criterion.

  low_genes <- sum(
    cells$nFeature_RNA < 200
  )

  high_genes <- sum(
    cells$nFeature_RNA > 2000
  )

  high_mt <- sum(
    cells$percent.mt >= 10
  )


  # Number satisfying all three criteria.

  kept <- sum(
    cells$nFeature_RNA >= 200 &
    cells$nFeature_RNA <= 2000 &
    cells$percent.mt < 10
  )


  cat("\n", s, "\n")
  cat("Total:", total, "\n")
  cat("Low genes:", low_genes, "\n")
  cat("High genes:", high_genes, "\n")
  cat("High MT:", high_mt, "\n")
  cat("Removed:", total - kept, "\n")
  cat("Kept:", kept, "\n")
}

