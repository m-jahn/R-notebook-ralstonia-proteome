# R-notebook-ralstonia-proteome

Pipelines for data analysis and visualization of the Ralstonia proteome

### Overview

This repository contains data processing pipelines for the analysis of the litho-autotrophic bacterium *Ralstonia eutropha*, also known as *Cupriavidus necator*. The repository contains raw data, processed data and R notebooks (`*.Rmd`) for three types of data:

- mass spectrometry proteomics
- genome scale model simulations (FBA/RBA)
- barcoded transposon knockout library

All care was taken to guarantee scientific accuracy and adhere to good scientific practice in terms of statistics, reproducibility and code documentation. Please report any errors by filing a [github issue](https://github.com/m-jahn/R-notebook-ralstonia-proteome/issues) for this repository.

### How to run the pipelines

Data and pipelines collected in this repository are (to the most extent) self-contained and executable. The code _and_ the documentation are part of one and the same R markdown document for each pipeline. The pipelines themselves can be downloaded and executed from the `pipeline` sub-folder. To simply view the rendered pipelines follow the links to the `*.html` reports under [Contents](#Contents).

To download the repository on your local drive use `git clone` in a (linux) terminal:

``` bash
cd /your-target-folder
git clone https://github.com/m-jahn/R-notebook-ralstonia-proteome
```

Open a pipeline with Rstudio and execute code (chunks) with the `Run` button.
Alternatively, open an interactive R session and render the R markdown pipeline:

``` bash
require(rmarkdown)
rmarkdown::render("pipeline.Rmd")
```

### Contents

- [_Ralstonia eutropha_ gene essentiality analysis (TnSeq)](https://m-jahn.github.io/R-notebook-ralstonia-proteome/TnSeq-essentiality.nb.html), based on transposon insertion frequency
- [_Ralstonia eutropha_ condition dependent fitness (BarSeq)](https://m-jahn.github.io/R-notebook-ralstonia-proteome/BarSeq-pulse.nb.html), based on transposon mutant depletion/enrichment over time