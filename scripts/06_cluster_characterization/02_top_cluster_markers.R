### Select the top marker genes for each cluster

library(dplyr)

# Load marker genes
markers <- read.csv("results/cluster_markers.csv")

# Select the top 10 markers based on log2 fold change
top_markers <- markers %>%
  group_by(cluster) %>%
  slice_max(
    order_by = avg_log2FC,
    n = 10
  ) %>%
  ungroup()

# Save top markers
write.csv(top_markers, "results/top_cluster_markers.csv", row.names = FALSE)

# Show cluster and gene names
print(top_markers[, c("cluster", "gene")])
