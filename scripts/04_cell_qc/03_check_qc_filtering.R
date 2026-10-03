### Check how many cells pass the QC cutoffs

library(Seurat)

# Load Seurat object
seurat <- readRDS("results/seurat_before_filtering.rds")

# Check QC for each sample
for (sample in unique(seurat$sample)) {

  cells <- seurat@meta.data[seurat$sample == sample, ]

  total <- nrow(cells)

  # Count cells outside each cutoff
  low_genes <- sum(cells$nFeature_RNA < 200)
  high_genes <- sum(cells$nFeature_RNA > 2000)
  high_mt <- sum(cells$percent.mt >= 10)

  # Count cells that pass all cutoffs
  kept <- sum(
    cells$nFeature_RNA >= 200 &
    cells$nFeature_RNA <= 2000 &
    cells$percent.mt < 10
  )

  cat("\n", sample, "\n")
  cat("Total:", total, "\n")
  cat("Low genes:", low_genes, "\n")
  cat("High genes:", high_genes, "\n")
  cat("High MT:", high_mt, "\n")
  cat("Removed:", total - kept, "\n")
  cat("Kept:", kept, "\n")
}
