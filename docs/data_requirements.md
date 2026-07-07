# Data requirements and expected file formats

## Figure 3 cell-cycle analysis

Folder:

```text
analyses/figure3_cell_cycle_boundary_distance/
```

Main notebook:

```text
230918-ETB078-FISH-EdU-Opt3.qmd
```

### Required raw data

The notebook expects a `data/` folder containing HiTIPS CSV exports. These large object-level exports are not tracked in this code repository.

Required recursive file patterns:

```text
*nuclei_information_well*.csv
*spots_locations_well*.csv
```

### Nuclei-level table

The notebook selects or derives these columns:

| Notebook column | Source column / derivation | Description |
|---|---|---|
| `file_name` | `Experiment` | HiTIPS experiment/export name. |
| `row`, `column` | `row`, `column` | Plate position. |
| `well` | `paste0(LETTERS[row], column)` | Plate well ID. |
| `field_index` | `field_index` | Microscopy field index. |
| `time_point` | `time_point` | Time point if present in acquisition. |
| `cell_index` | `cell_index` | Per-field cell/nucleus identifier. |
| `nuc_area` | `area` | Nuclear area in square microns. |
| `nuc_area_px` | `nuc_area / xy_res^2` | Nuclear area converted to pixels. |
| `solidity` | `solidity` | Nuclear shape quality metric. |
| `dapi_int_mean` | `mean_intensity` | Mean DAPI intensity. |
| `dapi_int_sum` | `dapi_int_mean * nuc_area_px` | Sum DAPI intensity estimate. |
| `dapi_int_sum_log2` | `log2(dapi_int_sum + 1)` | Log2 DAPI sum used for cell-cycle staging. |
| `edu_int_sum` | `ch4_sum_intensity` | EdU sum intensity. |
| `edu_int_mean` | `ch4_mean_intensity` | EdU mean intensity. |
| `edu_int_sum_log2` | `log2(edu_int_sum + 1)` | Log2 EdU sum. |

Nuclear filtering in the notebook:

```r
nuc_area >= 30
solidity > 0.875
```

### Spot-level table

The notebook selects or derives these columns:

| Notebook column | Source column / derivation | Description |
|---|---|---|
| `spot_index` | `V1` | Spot object index. |
| `x`, `y`, `z` | `x_location`, `y_location`, `z_location` | Raw spot coordinates. |
| `x_mic`, `y_mic` | `x * xy_res`, `y * xy_res` | x/y coordinates converted to microns. |
| `z_mic` | `z * z_step` | z coordinate converted to microns. |
| `channel` | `channel` | Fluorescence channel / probe ID. |
| `cell_index` | `cell_index` | Linked nucleus/cell identifier. |

Coordinate constants:

```r
xy_res <- 0.108
z_step <- 0.3
```

Spot filtering in the notebook:

```r
cell_index != 0
n_spots_channel_2 > 1
n_spots_channel_2 == n_spots_channel_3
```

## Mini-screen analysis

Folder:

```text
analyses/miniscreen_pilot/
```

Main notebook:

```text
210521-MiniScreen.Rmd
```

The Columbus exports for this analysis are tracked as a compressed archive:

```text
analyses/miniscreen_pilot/data_raw/miniscreen_columbus_exports.zip
```

Unpack before rendering:

```bash
Rscript scripts/unpack_packaged_data.R miniscreen
```

Required recursive file patterns after unpacking:

```text
data/*Nuclei Final[0].txt
data/*Spots 488[1].txt
data/*Spots 561[2].txt
```

The notebook expects Columbus object-level columns including:

- `ScreenName`
- `PlateName`
- `WellName`
- `Row`
- `Column`
- `Field`
- `Timepoint`
- object-number columns for nuclei and spots
- spot coordinates `Position X [um]`, `Position Y [um]`, and Z-plane columns

The mini-screen notebook filters to cells with exactly three green spots and three red spots before calculating 2D/3D distances.

## Raw image data

Raw microscopy images are not stored in this code repository. This repository is designed to hold analysis code, small tables, metadata, rendered reports, and packaged object-level exports needed by the included notebooks.
