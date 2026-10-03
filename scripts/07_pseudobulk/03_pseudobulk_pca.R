### Plot PCA of pseudobulk samples

library(DESeq2)
library(ggplot2)

# Load DESeq2 data
dds <- readRDS("results/pseudobulk_dds.rds")

# Transform counts for PCA
vsd <- vst(dds, blind = TRUE)

# Get PCA coordinates
pca_data <- plotPCA(vsd, intgroup = "condition",returnData = TRUE)

# Get variance explained by each PC
percent_var <- round(100 * attr(pca_data, "percentVar"))

# Add sample names
pca_data$sample <- rownames(pca_data)

# Create PCA plot
p <- ggplot(pca_data,
  aes(
    x = PC1,
    y = PC2,
    color = condition,
    label = sample
  )
) +
  geom_point(size = 4) +
  geom_text(
    vjust = -0.8,
    show.legend = FALSE
  ) +
  xlab(paste0("PC1: ", percent_var[1], "% variance")) +
  ylab(paste0("PC2: ", percent_var[2], "% variance")) +
  theme_classic()

# Save the plot
ggsave("results/pseudobulk_pca.pdf", plot = p, width = 7, height = 5)
