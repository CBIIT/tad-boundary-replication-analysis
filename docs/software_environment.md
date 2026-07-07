# Software environment

Each analysis folder keeps its own `renv.lock`. Restore the environment from the corresponding folder rather than from the repository root.

## `analyses/figure3_cell_cycle_boundary_distance/renv.lock`

- R version recorded in lockfile: `4.3.1`
- Package count: 127
- Key package versions:
  - `tidyverse` 2.0.0
  - `dplyr` 1.1.3
  - `ggplot2` 3.4.3
  - `data.table` 1.14.8
  - `fs` 1.6.3
  - `ggthemes` 4.2.4
  - `mclust` 6.0.0
  - `SpatialTools` 1.0.5
  - `paint` 0.1.7
  - `rmarkdown` 2.25
  - `knitr` 1.44
  - `reshape2` 1.4.4
  - `plyr` 1.8.8
- Restore command:

```bash
cd analyses/figure3_cell_cycle_boundary_distance
Rscript -e 'install.packages("renv"); renv::restore()'
```

## `analyses/miniscreen_pilot/renv.lock`

- R version recorded in lockfile: `4.1.0`
- Package count: 108
- Key package versions:
  - `tidyverse` 1.3.1
  - `dplyr` 1.0.7
  - `ggplot2` 3.3.4
  - `data.table` 1.14.0
  - `fs` 1.5.0
  - `ggthemes` 4.2.4
  - `SpatialTools` 1.0.4
  - `rmarkdown` 2.9
  - `knitr` 1.33
  - `reshape2` 1.4.4
  - `plyr` 1.8.6
- Restore command:

```bash
cd analyses/miniscreen_pilot
Rscript -e 'install.packages("renv"); renv::restore()'
```

## Notes

- Restoring from `renv.lock` is recommended for exact reproduction.
- The mini-screen notebook was developed with an older R/tidyverse environment; newer dplyr or ggplot2 versions may emit compatibility warnings.
- Machine-specific package libraries under `renv/library/` are intentionally not tracked. They are recreated by `renv::restore()`.
