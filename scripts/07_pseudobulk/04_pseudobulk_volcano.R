### Create volcano plot for pseudobulk differential expression

library(ggplot2)

# Load DESeq2 results
res <- read.csv("results/pseudobulk_deseq2_results.csv")

# Label significant genes
res$status <- "Not significant"

res$status[
  !is.na(res$padj) &
  res$padj < 0.05 &
  res$log2FoldChange >= 1
] <- "Up"

res$status[
  !is.na(res$padj) &
  res$padj < 0.05 &
  res$log2FoldChange <= -1
] <- "Down"

# Calculate -log10 adjusted p-value
res$padj_plot <- pmax(
  res$padj,
  .Machine$double.xmin
)

res$neg_log10_padj <- -log10(res$padj_plot)

# Limit very large values on the plot
res$neg_log10_padj[
  res$neg_log10_padj > 50
] <- 50

# Remove missing values
plot_data <- res[
  !is.na(res$log2FoldChange) &
  !is.na(res$neg_log10_padj),
]

plot_data$status <- factor(
  plot_data$status,
  levels = c("Down", "Not significant", "Up")
)

# Create volcano plot
p <- ggplot(
  plot_data,
  aes(
    x = log2FoldChange,
    y = neg_log10_padj,
    color = status
  )
) +
  geom_point(alpha = 0.6, size = 1.5) +
  geom_vline(
    xintercept = c(-1, 1),
    linetype = "dashed"
  ) +
  geom_hline(
    yintercept = -log10(0.05),
    linetype = "dashed"
  ) +
  labs(
    title = "Stimulated vs Unstimulated NKT Cells",
    x = "log2 Fold Change",
    y = "-log10 Adjusted P-value",
    color = "Expression"
  ) +
  theme_classic()

# Save the plot
ggsave("results/pseudobulk_volcano.pdf", plot = p, width = 7, height = 6)
