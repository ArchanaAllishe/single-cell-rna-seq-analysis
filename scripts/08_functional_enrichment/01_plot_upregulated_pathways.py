"""
Create a pathway-enrichment dot plot for upregulated genes.

The enrichment analysis was performed using g:Profiler.
This script reads the exported g:Profiler results, retains
significant GO Biological Process and Reactome terms, selects
the 10 most significant terms, and generates a dot plot.

Input:
    results/functional_enrichment/gProfiler_upregulated_genes.csv

Output:
    results/functional_enrichment/upregulated_pathway_dotplot.pdf
"""

from pathlib import Path

import matplotlib.pyplot as plt
import pandas as pd


# ------------------------------------------------------------
# Project paths
# ------------------------------------------------------------

project_dir = Path(__file__).resolve().parents[2]

results_dir = (
    project_dir
    / "results"
    / "functional_enrichment"
)

input_file = (
    results_dir
    / "gProfiler_upregulated_genes.csv"
)

output_file = (
    results_dir
    / "upregulated_pathway_dotplot.pdf"
)


# ------------------------------------------------------------
# Load g:Profiler results
# ------------------------------------------------------------

df = pd.read_csv(input_file)


# ------------------------------------------------------------
# Retain significant GO:BP and Reactome pathways
# ------------------------------------------------------------

df = df[
    (df["adjusted_p_value"] < 0.05)
    & (df["source"].isin(["GO:BP", "REAC"]))
]


# Select the 10 most significant pathways.

top = (
    df.sort_values("adjusted_p_value")
    .head(10)
    .sort_values(
        "negative_log10_of_adjusted_p_value"
    )
)


# ------------------------------------------------------------
# Generate dot plot
# ------------------------------------------------------------

plt.figure(figsize=(8, 6))

scatter = plt.scatter(
    top["negative_log10_of_adjusted_p_value"],
    top["term_name"],
    s=top["intersection_size"] / 3,
    c=top["adjusted_p_value"],
)

plt.xlabel("-log10 adjusted p-value")
plt.ylabel("Pathway")
plt.title("Upregulated Pathway Enrichment")

plt.colorbar(
    scatter,
    label="Adjusted p-value"
)

plt.tight_layout()

plt.savefig(
    output_file,
    bbox_inches="tight"
)

plt.close()
