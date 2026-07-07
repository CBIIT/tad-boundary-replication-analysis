#!/usr/bin/env Rscript

# Attempt to render the main analysis reports.
# Run from the repository root:
#   Rscript scripts/render_all.R

run <- function(cmd, args, workdir) {
  old <- getwd()
  on.exit(setwd(old), add = TRUE)
  setwd(workdir)
  cat("\nRunning in ", workdir, ": ", cmd, " ", paste(args, collapse = " "), "\n", sep = "")
  status <- system2(cmd, args = args)
  if (!identical(status, 0L)) {
    warning("Command returned non-zero status: ", status, call. = FALSE)
  }
  invisible(status)
}

has_pattern <- function(root, pattern) {
  dir.exists(root) && length(list.files(root, pattern = pattern, recursive = TRUE, full.names = TRUE)) > 0
}

repo <- normalizePath(getwd(), winslash = "/", mustWork = TRUE)
fig3 <- file.path(repo, "analyses", "figure3_cell_cycle_boundary_distance")
mini <- file.path(repo, "analyses", "miniscreen_pilot")

cat("Repository root: ", repo, "\n", sep = "")

# Render Figure 3 Quarto notebook only if data and quarto are available.
fig3_has_data <- has_pattern(file.path(fig3, "data"), "nuclei_information_well.*\\.csv$") &&
  has_pattern(file.path(fig3, "data"), "spots_locations_well.*\\.csv$")

if (!fig3_has_data) {
  cat("\nSkipping Figure 3 notebook: required HiTIPS raw CSV exports are missing from analyses/figure3_cell_cycle_boundary_distance/data/.\n")
} else if (!nzchar(Sys.which("quarto"))) {
  cat("\nSkipping Figure 3 notebook: quarto command not found.\n")
} else {
  run("quarto", c("render", "230918-ETB078-FISH-EdU-Opt3.qmd"), fig3)
}

# Unpack packaged mini-screen data if needed.
unpack_script <- file.path(repo, "scripts", "unpack_packaged_data.R")
if (file.exists(unpack_script)) {
  run(R.home("bin/Rscript"), c(unpack_script, "miniscreen"), repo)
}

# Render mini-screen notebook if rmarkdown is available.
if (!requireNamespace("rmarkdown", quietly = TRUE)) {
  cat("\nSkipping mini-screen notebook: R package 'rmarkdown' is not installed. Restore renv first.\n")
} else {
  run(R.home("bin/Rscript"), c("-e", "rmarkdown::render('210521-MiniScreen.Rmd')"), mini)
}

cat("\nRender script complete.\n")
