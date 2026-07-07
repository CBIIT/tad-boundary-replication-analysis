# TAD boundary distance analysis code

This repository contains the R/Quarto/R Markdown analysis notebooks and supporting metadata used to generate plots and quantitative summaries for the manuscript **"Re-establishment of TAD boundary organization during DNA replication"**.

The repository is organized so it can be unzipped, committed to a new GitHub repository, and linked from the manuscript's Code Availability statement.

## What is included

- `analyses/figure3_cell_cycle_boundary_distance/` - Quarto notebook for the FISH + EdU cell-cycle analysis. This is the analysis described in the uploaded notes as the script used for Figure 3 to measure TAD boundary distance with cell cycle.
- `analyses/miniscreen_pilot/` - R Markdown notebooks for the 210521 FISH distance mini-screen analysis. This workflow was described in the uploaded notes as the analysis that was adapted for many other plots in the paper.
- `data/extended_tables/` - Extended Data Tables 1-4 from the manuscript package.
- `docs/` - Figure-to-code mapping, input-data requirements, workflow notes, notebook inventory, environment notes, and source-archive cleanup notes.
- `scripts/` - Small helper scripts for checking expected inputs and rendering notebooks.

The original source code files were preserved, but transient files were removed from the GitHub-ready repository: `.git/`, `.Rproj.user/`, `.Rhistory`, and vendored `renv/library/` package caches. The repository keeps the `renv.lock` files and `renv/activate.R` files needed to restore the R environments.

## Important data note

The raw `data/` folder for `230918-ETB078-FISH-EdU-Opt3` was removed before the source archive was uploaded. A placeholder is included at:

```text
analyses/figure3_cell_cycle_boundary_distance/data/
```

To fully reproduce that notebook, place the HiTIPS CSV exports back into that folder before rendering. The notebook expects files matching:

```text
*nuclei_information_well*.csv
*spots_locations_well*.csv
```

See `analyses/figure3_cell_cycle_boundary_distance/data/README.md` and `docs/data_requirements.md` for details.

The `210521-MiniScreen` archive did include Columbus object-level data exports, so those are included under `analyses/miniscreen_pilot/data/`.

## Quick start

Use the lockfile in each analysis directory to restore the corresponding R environment.

### Figure 3 / cell-cycle analysis

```bash
cd analyses/figure3_cell_cycle_boundary_distance
Rscript -e 'install.packages("renv"); renv::restore()'
quarto render 230918-ETB078-FISH-EdU-Opt3.qmd
```

This analysis requires the missing HiTIPS raw CSV exports to be restored to `data/` first.

### Mini-screen analysis

```bash
cd analyses/miniscreen_pilot
Rscript -e 'install.packages("renv"); renv::restore()'
Rscript -e 'rmarkdown::render("210521-MiniScreen.Rmd")'
```

The mini-screen data files are included in the repository. Do not rename the Columbus export files unless you also update the glob patterns in the notebook.

### Convenience render script

From the repository root:

```bash
Rscript scripts/render_all.R
```

The script checks for Quarto/R Markdown and skips the Figure 3 render if the required raw HiTIPS data files are absent.

## Repository layout

```text
.
├── analyses/
│   ├── figure3_cell_cycle_boundary_distance/
│   │   ├── 230918-ETB078-FISH-EdU-Opt3.qmd
│   │   ├── funcs/plotting.R
│   │   ├── metadata/
│   │   ├── output/per_well_measurements.csv
│   │   ├── data/README.md
│   │   ├── legacy/
│   │   └── renv.lock
│   └── miniscreen_pilot/
│       ├── 210521-MiniScreen.Rmd
│       ├── Columbus_3D.Rmd
│       ├── data/
│       ├── metadata/
│       ├── output/
│       └── renv.lock
├── data/extended_tables/
├── docs/
└── scripts/
```

## Figure/code mapping

See `docs/figure_code_map.md` for a detailed map between manuscript figures and the uploaded scripts. In brief:

- Figure 3 and Extended Data Figures 3-4 are most directly represented by `230918-ETB078-FISH-EdU-Opt3.qmd`.
- The general FISH spot-distance workflow used across the manuscript is represented by `210521-MiniScreen.Rmd` and the shared plotting helpers in `funcs/plotting.R`.
- Some final manuscript panels are assembled from external image files, Hi-C/Repli-seq/ChIP tracks, ChIP-qPCR, or MINFLUX analyses that were not present as complete source code in the uploaded archives. These are noted explicitly in `docs/figure_code_map.md`.

## Suggested manuscript Code Availability text

Replace bracketed fields before submission:

> Analysis code used to quantify FISH spot distances and generate plots is available at [GitHub URL]. Raw microscopy images and large HiTIPS/Columbus exports required for complete reproduction are available at [image/data repository DOI or accession]. Extended Data Tables are included with the manuscript and mirrored in the code repository.

## Before public release

Please review these items before making the GitHub repository public:

1. Confirm whether the missing Figure 3 HiTIPS CSV exports should be committed, added through Git LFS, or deposited in the image/data repository.
2. Confirm whether ChIP-qPCR, MINFLUX, and final Illustrator panel assembly code/data should be added.
3. Choose a license for code reuse.
4. Update `CITATION.cff` with the final manuscript DOI, journal, year, and author list if needed.
5. Update this README with the final GitHub URL and data repository accession.

## Fresh GitHub upload

```bash
unzip tad-boundary-replication-analysis.zip
cd tad-boundary-replication-analysis
git init
git add .
git commit -m "Initial code release"
git branch -M main
git remote add origin git@github.com:<org-or-user>/<repo-name>.git
git push -u origin main
```
