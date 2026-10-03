### Check cluster distribution across samples

library(Seurat)

# Load clustered data
seurat <- readRDS("results/seurat_umap.rds")

# Count cells in each cluster by sample
cluster_sample <- table(
  Cluster = Idents(seurat),
  Sample = seurat$sample
)

# Calculate percentage within each sample
cluster_percent <- prop.table(
  cluster_sample,
  margin = 2
) * 100


# Save cell counts
write.csv(as.data.frame.matrix(cluster_sample),"results/cluster_sample_counts.csv")

# Save percentages
write.csv(round(as.data.frame.matrix(cluster_percent), 1), "results/cluster_sample_percentages.csv")
