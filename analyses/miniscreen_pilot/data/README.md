# Mini-screen Columbus data

The raw Columbus object-level export files for this analysis are packaged in:

```text
../data_raw/miniscreen_columbus_exports.zip
```

The expanded export contains per-well tables for nuclei, 488-channel FISH spots, and 561-channel FISH spots. To reproduce the mini-screen notebook, unpack the archive into this directory:

```bash
cd analyses/miniscreen_pilot
Rscript ../../scripts/unpack_packaged_data.R miniscreen
```

The main notebook also attempts this unpacking step automatically when the expected `data/*Nuclei Final[0].txt`, `data/*Spots 488[1].txt`, and `data/*Spots 561[2].txt` files are absent.

The unpacked files are intentionally ignored by Git because the compressed archive is the tracked copy.
