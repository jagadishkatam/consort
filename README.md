# README.md

# Clinical Trial Disposition Flowchart using `tidyCDISC` and `DiagrammeR`

This project creates a clinical trial disposition flowchart using the `tidyCDISC` and `DiagrammeR` packages in R. The flowchart visualizes participant progress through different stages of a clinical trial, including completion and discontinuation rates, across various treatment groups.
[Here is the Consort diagram](https://jagadishkatam.github.io/consort/consort.html)
---

## Dependencies

This code requires the following R packages:

- **tidyCDISC**: Provides CDISC-compliant datasets.
- **tidyverse**: A collection of data manipulation and visualization packages.
- **ggalluvial**: Facilitates alluvial diagram creation.
- **DiagrammeR**: Generates diagrams and flowcharts.
- **htmlwidgets**: Saves interactive HTML widgets.

To install these packages, run:

```r
install.packages(c("tidyverse", "ggalluvial", "DiagrammeR", "htmlwidgets"))
```

---

## Data

This code uses two datasets from the `tidyCDISC` package:

- **`adae`**: Adverse event data.
- **`adsl`**: Subject-level data, including treatment assignments and completion status.

---

## Workflow Overview

### Data Preparation

1. **Import and filter data**: The `adsl` dataset is filtered to include only participants in the safety population (`saffl == 'Y'`).
2. **Group by treatment and status**:
   - Calculate counts for:
     - **Overall safety population**.
     - **Participants by treatment group**.
     - **Participants who completed the trial**.
     - **Participants who discontinued** and reasons for discontinuation.
   - Label transformations are applied for clarity in the final diagram.

### Flowchart Generation

A flowchart is created using `DiagrammeR`'s `grViz()` function. Nodes represent participant groups and statuses, and edges show transitions between stages.

- **Nodes** include:
  - Safety population.
  - Treatment groups: Placebo, Low Dose, High Dose.
  - Completed and discontinued participants.
  - Reasons for discontinuation.

### Output

The final flowchart is saved as an interactive HTML file named `consort.html`.

---

## Run the Code

1. Open an R environment (such as RStudio).
2. Ensure all dependencies are installed.
3. Copy and run the provided code.
4. Open `consort.html` in a browser to view the interactive flowchart.

---

## Customization

You can adapt this code for other clinical trial datasets by:

- Changing the filtering conditions.
- Modifying labels and groupings.
- Adjusting the flowchart structure in the `grViz` script.

---

## Example Flowchart

The flowchart will illustrate the progression of clinical trial participants through different treatment arms and outcomes, similar to a CONSORT diagram. Each box in the diagram provides the number of participants at each stage.

---

Happy visualizing!
