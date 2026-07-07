#!/usr/bin/env Rscript

# Unpack data archives that are tracked in compressed form.
# Usage from repository root:
#   Rscript scripts/unpack_packaged_data.R miniscreen
#   Rscript scripts/unpack_packaged_data.R all

script_args <- commandArgs(trailingOnly = FALSE)
script_file <- sub("^--file=", "", script_args[grepl("^--file=", script_args)][1])
if (is.na(script_file) || !nzchar(script_file)) {
  script_file <- "scripts/unpack_packaged_data.R"
}
script_dir <- dirname(normalizePath(script_file, winslash = "/", mustWork = FALSE))
repo_root <- normalizePath(file.path(script_dir, ".."), winslash = "/", mustWork = TRUE)

args <- commandArgs(trailingOnly = TRUE)
target <- if (length(args) == 0) "all" else args[1]

has_files <- function(root, patterns) {
  files <- list.files(root, recursive = TRUE, full.names = FALSE, all.files = FALSE)
  all(vapply(patterns, function(p) any(grepl(p, files)), logical(1)))
}

unpack_miniscreen <- function() {
  mini_dir <- file.path(repo_root, "analyses", "miniscreen_pilot")
  data_dir <- file.path(mini_dir, "data")
  archive <- file.path(mini_dir, "data_raw", "miniscreen_columbus_exports.zip")
  expected <- c(
    "Nuclei Final\\[0\\].*\\.txt$",
    "Spots 488\\[1\\].*\\.txt$",
    "Spots 561\\[2\\].*\\.txt$"
  )

  if (dir.exists(data_dir) && has_files(data_dir, expected)) {
    cat("Mini-screen data are already unpacked in ", data_dir, "\n", sep = "")
    return(invisible(TRUE))
  }

  if (!file.exists(archive)) {
    stop("Cannot find packaged mini-screen archive: ", archive, call. = FALSE)
  }

  dir.create(data_dir, recursive = TRUE, showWarnings = FALSE)
  cat("Unpacking ", archive, " to ", data_dir, "\n", sep = "")
  utils::unzip(archive, exdir = data_dir)

  if (!has_files(data_dir, expected)) {
    stop("Mini-screen archive was unpacked, but expected Columbus export files were not found.", call. = FALSE)
  }

  cat("Mini-screen data unpacked successfully.\n")
  invisible(TRUE)
}

if (target %in% c("all", "miniscreen", "210521-MiniScreen")) {
  unpack_miniscreen()
} else {
  stop("Unknown target: ", target, ". Use 'miniscreen' or 'all'.", call. = FALSE)
}
