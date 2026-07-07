# Code review notes before submission

These notes identify reproducibility gaps visible from the uploaded archives. They are intended for the authors before the GitHub repository is made public.

## High-priority items

1. **Restore or deposit the Figure 3 raw HiTIPS data.** The notebook `230918-ETB078-FISH-EdU-Opt3.qmd` cannot be re-rendered without `*nuclei_information_well*.csv` and `*spots_locations_well*.csv` files in `analyses/figure3_cell_cycle_boundary_distance/data/`.
2. **Add missing final-analysis scripts for non-FISH panels if available.** The uploaded archives did not include complete final code for Repli-seq/Hi-C track plotting, ChIP-qPCR plotting, MINFLUX processing, or final Illustrator panel assembly.
3. **Confirm the final R version.** The manuscript Methods draft mentions R 4.3.3, while the uploaded Figure 3 `renv.lock` records R 4.3.1.
4. **Choose a license.** No code license has been selected in this draft repository.
5. **Update `CITATION.cff`.** Add the final DOI/journal/year after acceptance or preprint posting.

## Compatibility notes

- `210521-MiniScreen.Rmd` was written for an older tidyverse environment. Use its `renv.lock` for exact reproduction.
- Some ggplot code uses the older `..density..` syntax. Newer ggplot2 may warn; the modern equivalent is `after_stat(density)`.
- One mini-screen join uses `left_join(..., on = ...)`. In the locked older environment this likely falls back to joining on common columns, but in newer dplyr versions it may require `by = c("row", "col", "well")`.
- Legacy scripts in `analyses/figure3_cell_cycle_boundary_distance/legacy/` refer to helper files and older data paths not included in this repository. They are retained for provenance rather than one-click reproduction.

## What has intentionally not been changed

The main analysis notebooks were not rewritten. File names, analysis logic, and generated HTML reports were preserved so the repository remains traceable to the supplied source archives. Documentation and helper scripts were added around the original code.
