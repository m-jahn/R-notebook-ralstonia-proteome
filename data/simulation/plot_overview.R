# loading libraries
library(lattice)
library(latticeExtra)
library(latticetools)
library(tidyverse)
library(stringi)

# +++++++++++++ DATA DIRECTORIES +++++++++++++++++++++++++++++++++++++++++++++++

setwd("~/Documents/SciLifeLab/Resources/Models/Bacterial-RBA-models/Ralstonia-eutropha-H16/simulation/substrate_limitation/")
source("../read_rba_result.R")

# +++++++++++++ LOAD MODEL SIMULATION DATA +++++++++++++++++++++++++++++++++++++

# read simulation results
df_flux <- read_rba_result(list.files(pattern = "fluxes_.*.tsv$", full.names = TRUE))
df_prot <- read_rba_result(list.files(pattern = "proteins_.*.tsv", full.names = TRUE))
df_macr <- read_rba_result(list.files(pattern = "macroprocesses_.*.tsv", full.names = TRUE))


# +++++++++++++ FLUXES AND PROTEIN CONCENTRATIONS ++++++++++++++++++++++++++++++
#
# STEP 1: FLUXES
plot_top_fluxes <- df_flux %>% group_by(key) %>%
  
  # first sort data by average highest flux per reaction
  mutate(average_flux = median(abs(value))) %>%
  arrange(desc(average_flux)) %>%
  
  # select only top N fluxes
  filter(key %in% {ungroup(.) %>% pull(key) %>% unique %>% .[1:40]}) %>%
  
  xyplot(log10(abs(value)) ~ log10(carbon_conc) | factor(key, unique(key)), .,
    groups = carbon_source, par.settings = custom.colorblind(),
    main = "top 40 fluxes", layout = c(8, 5),
    xlab = expression("log"[10]*" c"[S]*" [mmol]"),
    ylab = expression("log"[10]*" v [mmol h"^-1*" gDCW"^-1*"]"),
    as.table = TRUE, between = list(x = 0.5, y = 0.5),
    scales = list(alternating = FALSE),
    panel = function(x, y, ...) {
      panel.grid(h = -1, v = -1, col = grey(0.9))
      panel.xyplot(x, y, cex = 0.9, ...)
      panel.key(..., corner = c(0.05, 0.05), points = FALSE)
    }
  )


# STEP 2: PROTEINS
plot_top_proteins <- df_prot %>% group_by(key) %>%
  
  # first sort data by average highest flux per reaction
  mutate(average_conc = median(abs(value))) %>%
  arrange(desc(average_conc)) %>%
  
  # select only top N fluxes
  filter(key %in% {ungroup(.) %>% pull(key) %>% unique %>% .[1:40]}) %>%
  
  xyplot(log10(abs(value)) ~ log10(carbon_conc) | factor(key, unique(key)), .,
    groups = carbon_source, par.settings = custom.colorblind(),
    layout = c(8, 5), main = "top 40 proteins",
    xlab = expression("log"[10]*" c"[S]*" [mmol]"),
    ylab = expression("log"[10]*" c [mmol/gDCW]"),
    as.table = TRUE, between = list(x = 0.5, y = 0.5),
    scales = list(alternating = FALSE),
    panel = function(x, y, ...) {
      panel.grid(h = -1, v = -1, col = grey(0.9))
      panel.xyplot(x, y, cex = 0.9, ...)
      panel.key(..., corner = c(0.05, 0.05), points = FALSE)
    }
  )


# +++++++++++++ PLOT REPORT ++++++++++++++++++++++++++++++++++++++++++++++++++++



png("report_top_fluxes.png", width = 1200, height = 800, res = 120)
print(plot_top_fluxes)
dev.off()

png("report_top_proteins.png", width = 1200, height = 800, res = 120)
print(plot_top_proteins)
dev.off()