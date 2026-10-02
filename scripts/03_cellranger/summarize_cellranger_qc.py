"""
Summarize Cell Ranger QC metrics across the six libraries.

For each sample, Cell Ranger produces metrics_summary.csv.
This script combines those files into one complete table and
also creates a smaller table containing the major QC metrics.
"""

from pathlib import Path
import pandas as pd


# ------------------------------------------------------------
# Project paths
# ------------------------------------------------------------

project_dir = Path(__file__).resolve().parents[2]

cellranger_dir = project_dir / "results" / "cellranger"
output_dir = project_dir / "results" / "cellranger"


# ------------------------------------------------------------
# Biological samples
# ------------------------------------------------------------

samples = [
    "Unstim1",
    "Unstim2",
    "Unstim3",
    "Stim1",
    "Stim2",
    "Stim3",
]


# ------------------------------------------------------------
# Read Cell Ranger metrics
# ------------------------------------------------------------

qc_tables = []

for sample in samples:

    metrics_file = (
        cellranger_dir
        / sample
        / "outs"
        / "metrics_summary.csv"
    )

    if not metrics_file.exists():
        raise FileNotFoundError(
            f"Cell Ranger metrics not found: {metrics_file}"
        )

    qc = pd.read_csv(metrics_file)

    # Add the biological sample name to the table.
    qc.insert(0, "Sample", sample)

    qc_tables.append(qc)


# ------------------------------------------------------------
# Combine all six samples
# ------------------------------------------------------------

qc = pd.concat(
    qc_tables,
    ignore_index=True
)

complete_output = output_dir / "cellranger_qc_summary.csv"

qc.to_csv(
    complete_output,
    index=False
)


# ------------------------------------------------------------
# Select major QC metrics
# ------------------------------------------------------------

selected_columns = [
    "Sample",
    "Estimated Number of Cells",
    "Mean Reads per Cell",
    "Median Genes per Cell",
    "Median UMI Counts per Cell",
    "Sequencing Saturation",
    "Reads Mapped Confidently to Transcriptome",
    "Fraction Reads in Cells",
]

qc_selected = qc[selected_columns]


# Display the summary in the terminal.

print(qc_selected.to_string(index=False))


# Save the smaller QC table.

selected_output = (
    output_dir
    / "cellranger_qc_selected_metrics.csv"
)

qc_selected.to_csv(
    selected_output,
    index=False
)


print("\nCell Ranger QC summary created.")
print(f"Complete metrics: {complete_output}")
print(f"Selected metrics: {selected_output}")