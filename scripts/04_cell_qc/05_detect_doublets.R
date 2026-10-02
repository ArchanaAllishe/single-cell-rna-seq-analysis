# ============================================================
# Detect and remove doublets with scDblFinder
# ============================================================
#
# Purpose:
#   Identify potential doublets independently within each
#   biological sample and retain cells classified as singlets.
#
# Why process samples separately?
#   The six libraries are independent biological samples.
#   Doublet detection is therefore performed within each
#   sample before the retained singlets are merged again.
#
# Input:
#   results/seurat_filtered.rds
#
# Output:
#   results/seurat_singlets.rds
#
# ============================================================

library(Seurat)
library(scDblFinder)
library(SingleCellExperiment)


# ------------------------------------------------------------
# Load QC-filtered cells
# ------------------------------------------------------------

seurat <- readRDS(
  "results/seurat_filtered.rds"
)


# ------------------------------------------------------------
# Split into the six original libraries
# ------------------------------------------------------------

samples <- SplitObject(
  seurat,
  split.by = "sample"
)

clean_list <- list()


# ------------------------------------------------------------
# Detect doublets independently in each sample
# ------------------------------------------------------------

for (s in names(samples)) {

  sce <- as.SingleCellExperiment(
    samples[[s]]
  )


  # Classify cells using scDblFinder.

  sce <- scDblFinder(sce)


  # Retain cells classified as singlets.

  keep <- colnames(sce)[
    sce$scDblFinder.class == "singlet"
  ]

  clean_list[[s]] <- subset(
    samples[[s]],
    cells = keep
  )


  cat(
    s,
    "- Doublets:",
    sum(
      sce$scDblFinder.class == "doublet"
    ),
    "\n"
  )
}


# ------------------------------------------------------------
# Merge retained singlets
# ------------------------------------------------------------

seurat <- merge(
  clean_list[[1]],
  y = clean_list[2:6]
)


cat(
  "\nTotal singlets retained:",
  ncol(seurat),
  "\n"
)


# ------------------------------------------------------------
# Save final QC-filtered object
# ------------------------------------------------------------

saveRDS(
  seurat,
  "results/seurat_singlets.rds"
)
