# Required HiTIPS data for the Figure 3 analysis

This directory is the expected location for the HiTIPS object-level CSV exports used by `230918-ETB078-FISH-EdU-Opt3.qmd`.

The large raw CSV exports are not tracked in this code repository. To reproduce the notebook, place the exported folders or files here:

```text
analyses/figure3_cell_cycle_boundary_distance/data/
```

The notebook searches recursively for these file patterns:

```text
*nuclei_information_well*.csv
*spots_locations_well*.csv
```

Expected nuclei-level columns include:

```text
Experiment
column
row
field_index
time_point
cell_index
area
solidity
mean_intensity
ch4_sum_intensity
ch4_mean_intensity
```

Expected spot-level columns include:

```text
V1
row
column
field_index
time_point
cell_index
channel
x_location
y_location
z_location
```

Coordinate conversion used in the notebook:

```text
xy_res = 0.108 um per pixel
z_step = 0.3 um
```

Keep the original exported file names if possible. If files are renamed, update the glob patterns in `230918-ETB078-FISH-EdU-Opt3.qmd`.
