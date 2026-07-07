# Source archive cleanup and provenance

This GitHub-ready repository was assembled from three uploaded ZIP archives. The table below records the source archive checksums so the release can be traced back to the original uploads.

| Source archive | SHA-256 | Size |
|---|---:|---:|
| `210521-MiniScreen.zip` | `3a52b08322734fa74a37568065795d737e76aff795ee964346b045005d340884` | 73160035 bytes |
| `230918-ETB078-FISH-EdU-Opt3.zip` | `cd176be1ad0de8ee8c289eec377b7026790adee502fb113e30bc915364e5754d` | 232004065 bytes |
| `OneDrive_1_7-7-2026.zip` | `7eceefcc6e64235581c185e4eaedd7635741ba4bce01601e45dcc6c9d857dc1e` | 81948277 bytes |

## Excluded from the GitHub-ready repository

- Existing `.git/` folders from the uploaded archives. A fresh Git repository should be initialized before upload.
- RStudio state: `.Rproj.user/`, `.Rhistory`, `.RData`, and `.Ruserdata`.
- Vendored package libraries under `renv/library/`. These are machine-specific and should be restored from `renv.lock`.
- The manuscript draft DOCX and figure PDF. They were used only to prepare documentation and figure-code mapping.
- The raw Figure 3 HiTIPS `data/` folder, which was absent from the uploaded archive.

## Included from the source archives

- Original analysis notebooks and helper R files.
- Per-analysis `renv.lock` and `renv/activate.R` files.
- Metadata files and included mini-screen Columbus object-level data.
- Small extended data tables from the manuscript package.