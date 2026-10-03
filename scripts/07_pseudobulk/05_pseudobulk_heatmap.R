### Create heatmap of top differentially expressed genes

library(DESeq2)
library(pheatmap)

# Load DESeq2 data and results
dds <- readRDS("results/pseudobulk_dds.rds")
res <- read.csv("results/pseudobulk_deseq2_results.csv")

# Transform counts for visualization
vsd <- vst(
  dds,
  blind = TRUE
)

# Get significant upregulated genes
up <- subset(
  res,
  !is.na(padj) &
  padj < 0.05 &
  log2FoldChange >= 1
)

# Get significant downregulated genes
down <- subset(
  res,
  !is.na(padj) &
  padj < 0.05 &
  log2FoldChange <= -1
)

# Sort by fold change
up <- up[order(up$log2FoldChange, decreasing = TRUE), ]
down <- down[order(down$log2FoldChange), ]

# Select top 10 up and top 10 down genes
top_genes <- c(
  head(up$gene, 10),
  head(down$gene, 10)
)

# Get expression values for selected genes
mat <- assay(vsd)[
  top_genes,
  ,
  drop = FALSE
]

# Scale expression for each gene
mat <- t(scale(t(mat)))

# Add sample condition
annotation <- data.frame(
  Condition = colData(vsd)$condition
)

rownames(annotation) <- colnames(mat)

# Create heatmap
pdf(
  "../results/pseudobulk_top20_heatmap.pdf",
  width = 7,
  height = 8
)

pheatmap(
  mat,
  annotation_col = annotation,
  cluster_rows = TRUE,
  cluster_cols = TRUE,
  show_rownames = TRUE,
  show_colnames = TRUE,
  main = "Top Differentially Expressed Genes"
)

# Close and save the PDF
dev.off()
