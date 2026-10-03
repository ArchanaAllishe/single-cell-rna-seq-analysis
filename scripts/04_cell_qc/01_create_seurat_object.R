### Create and merge Seurat objects

library(Seurat)

samples <- c("Unstim1", "Unstim2", "Unstim3", "Stim1", "Stim2", "Stim3")

seurat_list <- list()

# Read Cell Ranger data for each sample
for (sample in samples) {

  path <- file.path("/results/cellranger", sample, "outs","filtered_feature_bc_matrix")
  counts <- Read10X(path)

  seurat_list[[sample]] <- CreateSeuratObject(counts = counts, project = sample)

  seurat_list[[sample]]$sample <- sample
}

# Merge all samples
seurat <- merge(seurat_list[[1]],y = seurat_list[2:6], add.cell.ids = samples)

# Add condition
seurat$condition <- ifelse(grepl("^Stim", seurat$sample), "Stimulated","Unstimulated")

# Calculate mitochondrial percentage
seurat$percent.mt <- PercentageFeatureSet(seurat,pattern = "^MT-")

# Save before filtering
saveRDS(seurat, "results/seurat_before_filtering.rds")
