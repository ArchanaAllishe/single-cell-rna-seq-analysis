# ============================================================
# PCA of sample-level pseudobulk profiles
# ============================================================
#
# Purpose:
#   Examine the overall transcriptional relationship among
#   the six biological samples after variance-stabilizing
#   transformation.
#
# Input:
#   results/pseudobulk_dds.rds
#
# Output:
#   results/pseudobulk_pca.pdf
#
# ============================================================

library(DESeq2)
library(ggplot2)


dds <- readRDS(
  "results/pseudobulk_dds.rds"
)


# Variance-stabilizing transformation.

vsd <- vst(
  dds,
  blind = TRUE
)


# Obtain PCA coordinates.

pca_data <- plotPCA(
  vsd,
  intgroup = "condition",
  returnData = TRUE
)

percent_var <- round(
  100 * attr(
    pca_data,
    "percentVar"
  )
)


# Add sample names for plotting.

pca_data$sample <- rownames(pca_data)


# Generate PCA plot.

p <- ggplot(
  pca_data,
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
  xlab(
    paste0(
      "PC1: ",
      percent_var[1],
      "% variance"
    )
  ) +
  ylab(
    paste0(
      "PC2: ",
      percent_var[2],
      "% variance"
    )
  ) +
  theme_classic()


ggsave(
  "results/pseudobulk_pca.pdf",
  plot = p,
  width = 7,
  height = 5
)