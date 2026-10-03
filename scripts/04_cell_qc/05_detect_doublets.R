### Detect and remove doublets

library(Seurat)
library(scDblFinder)
library(SingleCellExperiment)

# Load QC-filtered data
seurat <- readRDS("results/seurat_filtered.rds")

# Split cells by sample
samples <- SplitObject(seurat, split.by = "sample")

clean_list <- list()

# Find doublets in each sample
for (sample in names(samples)) {

  sce <- as.SingleCellExperiment(samples[[sample]])

  sce <- scDblFinder(sce)

  # Keep only singlets
  keep <- colnames(sce)[
    sce$scDblFinder.class == "singlet"
  ]

  clean_list[[sample]] <- subset(
    samples[[sample]],
    cells = keep
  )

  cat(
    sample,
    "- Doublets:",
    sum(sce$scDblFinder.class == "doublet"),
    "\n"
  )
}

# Merge singlets from all samples
seurat <- merge(clean_list[[1]], y = clean_list[2:6]
)

cat("Total singlets:", ncol(seurat), "\n")

# Save singlet cells
saveRDS(seurat, "results/seurat_singlets.rds")
