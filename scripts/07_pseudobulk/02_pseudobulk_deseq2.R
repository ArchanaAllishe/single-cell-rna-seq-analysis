### Run pseudobulk differential expression with DESeq2

library(DESeq2)

# Load pseudobulk counts
counts <- read.csv("results/pseudobulk_counts.csv", row.names = 1,check.names = FALSE)
counts <- as.matrix(counts)

# Add condition for each sample
metadata <- data.frame(
  sample = colnames(counts),
  condition = ifelse(
    grepl("^Stim", colnames(counts)),
    "Stimulated",
    "Unstimulated"
  ),
  row.names = colnames(counts)
)

# Use unstimulated as the reference
metadata$condition <- factor(
  metadata$condition,
  levels = c("Unstimulated", "Stimulated")
)

print(metadata)

# Keep genes with at least 10 counts in 3 samples
keep <- rowSums(counts >= 10) >= 3

cat("Genes before filtering:", nrow(counts), "\n")
cat("Genes after filtering:", sum(keep), "\n")

counts <- counts[keep, , drop = FALSE]

# Create DESeq2 dataset
dds <- DESeqDataSetFromMatrix(
  countData = counts,
  colData = metadata,
  design = ~ condition
)

# Run differential expression
dds <- DESeq(dds)

saveRDS(
  dds, "results/pseudobulk_dds.rds")

# Compare stimulated vs unstimulated
res <- results(dds, contrast = c("condition", "Stimulated", "Unstimulated"))
res <- res[order(res$padj), ]
res_df <- as.data.frame(res)
res_df$gene <- rownames(res_df)

# Find significantly upregulated genes
upregulated <- subset(
  res_df,
  !is.na(padj) &
  padj < 0.05 &
  log2FoldChange >= 1
)

# Find significantly downregulated genes
downregulated <- subset(
  res_df,
  !is.na(padj) &
  padj < 0.05 &
  log2FoldChange <= -1
)


# Save results
write.csv(res_df, "results/pseudobulk_deseq2_results.csv",row.names = FALSE)
write.csv(upregulated, "results/pseudobulk_upregulated.csv",row.names = FALSE)
write.csv(downregulated, "results/pseudobulk_downregulated.csv",row.names = FALSE)
