# ============================================================
# Pseudobulk differential-expression analysis with DESeq2
# ============================================================
#
# Comparison:
#   Stimulated vs Unstimulated
#
# Biological replication:
#   Three stimulated samples
#   Three unstimulated samples
#
# Input:
#   results/pseudobulk_counts.csv
#
# Outputs:
#   results/pseudobulk_dds.rds
#   results/pseudobulk_deseq2_results.csv
#   results/pseudobulk_upregulated.csv
#   results/pseudobulk_downregulated.csv
#
# ============================================================

library(DESeq2)


# ------------------------------------------------------------
# Load pseudobulk counts
# ------------------------------------------------------------

counts <- read.csv(
  "results/pseudobulk_counts.csv",
  row.names = 1,
  check.names = FALSE
)

counts <- as.matrix(counts)


# ------------------------------------------------------------
# Construct sample metadata
# ------------------------------------------------------------

metadata <- data.frame(
  sample = colnames(counts),
  condition = ifelse(
    grepl("^Stim", colnames(counts)),
    "Stimulated",
    "Unstimulated"
  ),
  row.names = colnames(counts)
)

metadata$condition <- factor(
  metadata$condition,
  levels = c(
    "Unstimulated",
    "Stimulated"
  )
)


cat("\nSample metadata:\n")
print(metadata)


# ------------------------------------------------------------
# Filter low-count genes
# ------------------------------------------------------------

keep <- rowSums(
  counts >= 10
) >= 3

cat(
  "\nGenes before filtering:",
  nrow(counts),
  "\n"
)

cat(
  "Genes after filtering:",
  sum(keep),
  "\n"
)

counts_filtered <- counts[
  keep,
  ,
  drop = FALSE
]


# ------------------------------------------------------------
# Create DESeq2 dataset
# ------------------------------------------------------------

dds <- DESeqDataSetFromMatrix(
  countData = counts_filtered,
  colData = metadata,
  design = ~ condition
)


# ------------------------------------------------------------
# Differential-expression analysis
# ------------------------------------------------------------

dds <- DESeq(dds)

saveRDS(
  dds,
  "results/pseudobulk_dds.rds"
)


res <- results(
  dds,
  contrast = c(
    "condition",
    "Stimulated",
    "Unstimulated"
  )
)


# Order results by adjusted p-value.

res <- res[
  order(res$padj),
]


# Convert to data frame and preserve gene names.

res_df <- as.data.frame(res)
res_df$gene <- rownames(res_df)


# ------------------------------------------------------------
# Identify significant genes
# ------------------------------------------------------------

upregulated <- subset(
  res_df,
  !is.na(padj) &
    padj < 0.05 &
    log2FoldChange >= 1
)

downregulated <- subset(
  res_df,
  !is.na(padj) &
    padj < 0.05 &
    log2FoldChange <= -1
)


# ------------------------------------------------------------
# Summarize results
# ------------------------------------------------------------

print(summary(res))

cat(
  "\nUpregulated genes:",
  nrow(upregulated),
  "\n"
)

cat(
  "Downregulated genes:",
  nrow(downregulated),
  "\n"
)

cat("\nTop upregulated genes:\n")
print(
  head(
    upregulated[
      order(
        upregulated$log2FoldChange,
        decreasing = TRUE
      ),
    ],
    10
  )
)

cat("\nTop downregulated genes:\n")
print(
  head(
    downregulated[
      order(
        downregulated$log2FoldChange
      ),
    ],
    10
  )
)


# ------------------------------------------------------------
# Save results
# ------------------------------------------------------------

write.csv(
  res_df,
  "results/pseudobulk_deseq2_results.csv",
  row.names = FALSE
)

write.csv(
  upregulated,
  "results/pseudobulk_upregulated.csv",
  row.names = FALSE
)

write.csv(
  downregulated,
  "results/pseudobulk_downregulated.csv",
  row.names = FALSE
)
