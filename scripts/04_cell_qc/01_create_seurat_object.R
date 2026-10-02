# ============================================================
# Create and merge Seurat objects
# ============================================================
#
# Purpose:
#   Import the Cell Ranger filtered gene-expression matrices
#   for the six biological samples and combine them into one
#   Seurat object for cell-level quality control.
#
# Samples:
#   Unstim1, Unstim2, Unstim3
#   Stim1, Stim2, Stim3
#
# Input:
#   results/cellranger/<sample>/outs/
#       filtered_feature_bc_matrix/
#
# Output:
#   results/seurat_before_filtering.rds
#
# ============================================================

library(Seurat)


# ------------------------------------------------------------
# Samples
# ------------------------------------------------------------

samples <- c(
  "Unstim1",
  "Unstim2",
  "Unstim3",
  "Stim1",
  "Stim2",
  "Stim3"
)

seurat_list <- list()


# ------------------------------------------------------------
# Read Cell Ranger matrices
# ------------------------------------------------------------

for (sample in samples) {

  path <- file.path(
    "results",
    "cellranger",
    sample,
    "outs",
    "filtered_feature_bc_matrix"
  )

  counts <- Read10X(path)


  # Create one Seurat object per biological sample.

  seurat_list[[sample]] <- CreateSeuratObject(
    counts = counts,
    project = sample
  )


  # Retain sample identity for every cell.

  seurat_list[[sample]]$sample <- sample
}


# ------------------------------------------------------------
# Merge the six samples
# ------------------------------------------------------------

seurat <- merge(
  seurat_list[[1]],
  y = seurat_list[2:6],
  add.cell.ids = samples
)


# ------------------------------------------------------------
# Add experimental condition
# ------------------------------------------------------------

seurat$condition <- ifelse(
  grepl("^Stim", seurat$sample),
  "Stimulated",
  "Unstimulated"
)


# ------------------------------------------------------------
# Calculate mitochondrial percentage
# ------------------------------------------------------------

seurat$percent.mt <- PercentageFeatureSet(
  seurat,
  pattern = "^MT-"
)


# ------------------------------------------------------------
# Check cell numbers
# ------------------------------------------------------------

cat("\nCells by sample before additional QC:\n")
print(table(seurat$sample))

cat("\nTotal cells:", ncol(seurat), "\n")


# ------------------------------------------------------------
# Save object
# ------------------------------------------------------------

saveRDS(
  seurat,
  "results/seurat_before_filtering.rds"
)
