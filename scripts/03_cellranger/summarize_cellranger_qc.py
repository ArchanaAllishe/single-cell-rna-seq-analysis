### Summarize Cell Ranger QC results

import pandas as pd

cellranger_dir = "results/cellranger"

samples = ["Unstim1", "Unstim2", "Unstim3", "Stim1", "Stim2", "Stim3"]

# Read the QC file from each sample
all_qc = []

for sample in samples:
    file = f"{cellranger_dir}/{sample}/outs/metrics_summary.csv"

    qc = pd.read_csv(file)
    qc.insert(0, "Sample", sample)

    all_qc.append(qc)

# Combine the six samples
qc_summary = pd.concat(all_qc, ignore_index=True)
qc_summary.to_csv(f"{cellranger_dir}/cellranger_qc_summary.csv",index=False)

# Select the QC values I want to compare
columns = [
    "Sample",
    "Estimated Number of Cells",
    "Mean Reads per Cell",
    "Median Genes per Cell",
    "Median UMI Counts per Cell",
    "Sequencing Saturation",
    "Reads Mapped Confidently to Transcriptome",
    "Fraction Reads in Cells"
]

selected_qc = qc_summary[columns]
selected_qc.to_csv(f"{cellranger_dir}/cellranger_qc_selected_metrics.csv",index=False)
print(selected_qc.to_string(index=False))
