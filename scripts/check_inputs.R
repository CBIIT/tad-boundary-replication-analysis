#!/usr/bin/env Rscript

# Check whether required input files are present for the analysis notebooks.
# Run from the repository root:
#   Rscript scripts/check_inputs.R

message_header <- function(x) {
  cat("\n", x, "\n", paste(rep("-", nchar(x)), collapse = ""), "\n", sep = "")
}

check_file <- function(path) {
  ok <- file.exists(path)
  cat(if (ok) "[OK]   " else "[MISS] ", path, "\n", sep = "")
  invisible(ok)
}

check_pattern <- function(root, pattern) {
  hits <- list.files(root, pattern = pattern, recursive = TRUE, full.names = TRUE)
  cat(if (length(hits) > 0) "[OK]   " else "[MISS] ", root, " pattern /", pattern, "/ : ", length(hits), " file(s)\n", sep = "")
  invisible(hits)
}

message_header("Figure 3 cell-cycle analysis")
fig3 <- file.path("analyses", "figure3_cell_cycle_boundary_distance")
check_file(file.path(fig3, "230918-ETB078-FISH-EdU-Opt3.qmd"))
check_file(file.path(fig3, "funcs", "plotting.R"))
check_file(file.path(fig3, "metadata", "plate_layout.csv"))
check_file(file.path(fig3, "renv.lock"))
check_pattern(file.path(fig3, "data"), "nuclei_information_well.*\\.csv$")
check_pattern(file.path(fig3, "data"), "spots_locations_well.*\\.csv$")

message_header("Mini-screen analysis")
mini <- file.path("analyses", "miniscreen_pilot")
check_file(file.path(mini, "210521-MiniScreen.Rmd"))
check_file(file.path(mini, "Columbus_3D.Rmd"))
check_file(file.path(mini, "renv.lock"))
check_pattern(file.path(mini, "data"), "Nuclei Final\\[0\\].*\\.txt$")
check_pattern(file.path(mini, "data"), "Spots 488\\[1\\].*\\.txt$")
check_pattern(file.path(mini, "data"), "Spots 561\\[2\\].*\\.txt$")

message_header("Extended data tables")
check_file(file.path("data", "extended_tables", "Extended Data Table 1.xlsx"))
check_file(file.path("data", "extended_tables", "Extended Data Table 2 siRNA Library Validation v2.xlsx"))
check_file(file.path("data", "extended_tables", "Extended Data Table 3 BAC Probes.xlsx"))
check_file(file.path("data", "extended_tables", "Extended Data Table 4 Sequencing tracks.xlsx"))

cat("\nDone. Missing Figure 3 raw data are expected unless the HiTIPS exports have been restored.\n")
