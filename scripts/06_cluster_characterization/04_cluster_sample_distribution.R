# ============================================================
# Examine cluster distribution across biological samples
# ============================================================
#
# Purpose:
#   Determine how cells from each biological sample are
#   distributed across the identified clusters.
#
# Two summaries are generated:
#
#   1. Number of cells from each sample in each cluster
#   2. Percentage of each sample represented by each cluster
#
# Input:
#   results/seurat_umap.rds
#
# Output:
#   results/cluster_sample_counts.csv
#   results/cluster_sample_percentages.csv
#
# ============================================================

library(Seurat)


seurat <- readRDS(
  "results/seurat_umap.rds"
)


# ------------------------------------------------------------
# Count cells by cluster and sample
# ------------------------------------------------------------

cluster_sample <- table(
  Cluster = Idents(seurat),
  Sample = seurat$sample
)


# ------------------------------------------------------------
# Calculate percentages within each sample
# ------------------------------------------------------------

cluster_sample_percent <- prop.table(
  cluster_sample,
  margin = 2
) * 100


# ------------------------------------------------------------
# Display results
# ------------------------------------------------------------

print(cluster_sample)

print(
  round(cluster_sample_percent, 1)
)


# ------------------------------------------------------------
# Save cell counts
# ------------------------------------------------------------

write.csv(
  as.data.frame.matrix(cluster_sample),
  "results/cluster_sample_counts.csv"
)


# ------------------------------------------------------------
# Save percentages
# ------------------------------------------------------------

write.csv(
  round(
    as.data.frame.matrix(
      cluster_sample_percent
    ),
    1
  ),
  "results/cluster_sample_percentages.csv"
)
