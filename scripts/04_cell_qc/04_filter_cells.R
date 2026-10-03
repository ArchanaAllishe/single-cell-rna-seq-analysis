### Filter cells based on QC cutoffs

library(Seurat)

# Load Seurat object
seurat <- readRDS("results/seurat_before_filtering.rds")

# Keep cells that pass the QC cutoffs
seurat <- subset(
  seurat,
  subset =
    nFeature_RNA >= 200 &
    nFeature_RNA <= 2000 &
    percent.mt < 10
)


# Save filtered data
saveRDS(seurat, "results/seurat_filtered.rds")
