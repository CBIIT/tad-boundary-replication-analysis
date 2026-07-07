# FISH distance analysis workflow

The uploaded notebooks follow a consistent workflow for measuring TAD boundary distances from high-throughput FISH data.

## Core distance workflow

1. **Read experimental metadata**
   - Load the plate layout.
   - Attach treatment, sgRNA, synchronization, or cell-cycle information to each well.

2. **Read nuclei/cell-level data**
   - Import object-level nuclei tables from HiTIPS or Columbus.
   - Keep plate coordinates, field, cell index, nuclear area, intensity, and spot counts.
   - Filter small or irregular nuclei where appropriate.

3. **Read spot-level data**
   - Import spot localization tables for the FISH channels.
   - Convert x/y/z coordinates from pixels or instrument units to microns when needed.
   - Remove spots not assigned to nuclei.

4. **Join cells and spots**
   - Link spots to nuclei by plate, well, field, time point, and cell index.
   - Count spots per cell in each channel.
   - Filter cells to retain interpretable alleles/spot configurations.

5. **Calculate pairwise distances**
   - Use `SpatialTools::dist2()` to calculate all pairwise distances between spot coordinates in the two FISH channels.
   - The Figure 3 notebook calculates 2D distances using x/y coordinates.
   - The mini-screen notebook calculates both 2D and 3D distances.

6. **Assign paired boundary distance**
   - For each red-channel spot, retain the minimum distance to a green-channel spot.
   - This nearest-neighbor value is used as the paired TAD boundary distance.

7. **Summarize and plot**
   - Plot histograms/densities of spot counts and boundary distances.
   - Summarize measurements per well or per treatment/sgRNA target.

## Figure 3 cell-cycle workflow

The Figure 3 notebook adds DAPI/EdU cell-cycle staging:

1. Estimate DAPI total intensity per nucleus from mean DAPI intensity and nuclear area.
2. Log2-transform DAPI and EdU intensity sums.
3. Fit a two-component Gaussian mixture model per well using `mclust::Mclust()`.
4. Use the lower DAPI peak as the G1/2N peak and normalize DAPI intensity so G1 is centered near 1.
5. Assign cell-cycle categories using DAPI and EdU thresholds:

```text
SubG1: DAPI <= 0.5
G1:    DAPI <= 1.5 and EdU <= 22
S:     DAPI <= 2.25 and EdU > 22
G2/M:  DAPI <= 2.25 and EdU <= 22
>4N:   all remaining cells
```

6. Join cell-cycle labels onto minimum green/red spot-distance measurements.
7. Plot boundary-distance distributions by G1, S, and G2/M phase.

## Plot helpers

Shared plotting helpers for the Figure 3 notebook are in:

```text
analyses/figure3_cell_cycle_boundary_distance/funcs/plotting.R
```

Key functions include:

- `plot_heatmap()`
- `plot_textmap()`
- `plot_density()`
- `plot_density_cc()`
- `plot_boxplot()`
- `plot_histogram()`
- `plot_crossbars()`
