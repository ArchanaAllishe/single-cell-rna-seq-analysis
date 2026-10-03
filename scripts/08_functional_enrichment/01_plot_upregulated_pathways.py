### Plot pathway enrichment for upregulated genes

import pandas as pd
import matplotlib.pyplot as plt

# Load g:Profiler results
file = "results/functional_enrichment/gProfiler_upregulated_genes.csv"

df = pd.read_csv(file)

# Keep significant GO and Reactome pathways
df = df[
    (df["adjusted_p_value"] < 0.05) &
    (df["source"].isin(["GO:BP", "REAC"]))
]

# Select the 10 most significant pathways
top = (
    df.sort_values("adjusted_p_value")
    .head(10)
    .sort_values("negative_log10_of_adjusted_p_value")
)

# Create dot plot
plt.figure(figsize=(8, 6))

scatter = plt.scatter(
    top["negative_log10_of_adjusted_p_value"],
    top["term_name"],
    s=top["intersection_size"] / 3,
    c=top["adjusted_p_value"]
)

plt.xlabel("-log10 adjusted p-value")
plt.ylabel("Pathway")
plt.title("Upregulated Pathway Enrichment")

plt.colorbar(
    scatter,
    label="Adjusted p-value"
)

plt.tight_layout()

# Save the plot
plt.savefig("results/functional_enrichment/upregulated_pathway_dotplot.pdf", bbox_inches="tight")

# Close the plot
plt.close()
