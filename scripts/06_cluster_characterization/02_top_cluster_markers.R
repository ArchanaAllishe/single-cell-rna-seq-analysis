# ============================================================
# Select the top marker genes for each cluster
# ============================================================
#
# Purpose:
#   Select genes with the strongest positive log2 fold changes
#   for each cluster from the complete marker-gene results.
#
# Input:
#   results/cluster_markers.csv
#
# Selection:
#   Top 10 genes per cluster ranked by avg_log2FC
#
# Output:
#   results/top_cluster_markers.csv
#
# ============================================================

library(dplyr)


# Load complete marker results.

markers <- read.csv(
  "results/cluster_markers.csv"
)


# ------------------------------------------------------------
# Select top markers for each cluster
# ------------------------------------------------------------

top_markers <- markers %>%
  group_by(cluster) %>%
  slice_max(
    order_by = avg_log2FC,
    n = 10
  ) %>%
  ungroup()


# ------------------------------------------------------------
# Save results
# ------------------------------------------------------------

write.csv(
  top_markers,
  "results/top_cluster_markers.csv",
  row.names = FALSE
)


# Display cluster and gene names.

print(
  top_markers[, c("cluster", "gene")]
)
