# Swift-XRT-Data-Reduction

### Swift XRT Data Processing Scripts

This repository contains a collection of Bash scripts for processing Swift X-Ray Telescope (XRT) data. The scripts automate tasks like data pipeline execution, barycentric correction, light curve extraction, and file management. Below is an overview of each script:

---

#### `Xrtpipeline.sh`
**Purpose**: Processes raw Swift XRT data for specified observation IDs.  
**Usage**:
```bash
./Xrtpipeline.sh
```
- Processes observation IDs sequentially (e.g., `01126853037`)
- Generates cleaned event files, exposure maps, and outputs to `out011268530*/`
- Logs progress to `log011268530*`

---

#### `copysao,pat.sh`
**Purpose**: Copies auxiliary `pat.fits.gz` (attitude) and `sao.fits.gz` (orbit) files to output directories.  
**Usage**:
```bash
./copysao,pat.sh
```
- Copies files from `011268530*/auxil/` to `out011268530*/`
- Handles observation IDs `45` to `84`

---

#### `bary.sh`
**Purpose**: Applies barycentric correction to event, pattern, and housekeeping files.  
**Usage**:
```bash
./bary.sh
```
- Processes IDs `41` to `43`
- Requires SAO orbit files (`*sao.fits.gz`)
- Outputs barycenter-corrected files (e.g., `*_bary.evt`)
- Logs to `barycor_log.txt`

---

#### `aproduct.sh`
**Purpose**: Generates science products (light curves, spectra) using `xrtproducts`.  
**Usage**:
```bash
./aproduct.sh
```
- Processes IDs `55` to `58`
- Uses barycentric-corrected event files and exposure maps
- Outputs products to `product011268530*/`
- Logs to `/home/nabin/s_xrt/logs/`

---

#### `csub.sh`
**Purpose**: Creates background-subtracted light curves (`csub.lc`).  
**Usage**:
```bash
./csub.sh
```
- Processes IDs `77` to `82`
- Subtracts background using `*_po_clbkg.lc` from source light curves (`*_po_clsr_corr.lc`)
- Logs to `/home/nabin/s_xrt/logss/`

---

#### `zzz.sh`
**Purpose**: Collects all `csub.lc` files into a central directory with sequential names.  
**Usage**:
```bash
./zzz.sh
```
- Searches `/home/nabin/s_xrt/` for `csub.lc`
- Copies files to `/home/nabin/s_xrt/v/` as `csub1.lc`, `csub2.lc`, etc.

---

#### `1modify.sh`
**Purpose**: Modifies a text file by multiplying the first column by `19861`.  
**Usage**:
```bash
./1modify.sh
```
- Input: `csub_t0.txt`
- Output: `csub_t0_modified.txt`

---

### Setup & Execution
1. **Place scripts** in your working directory.
2. **Set execute permissions**:
   ```bash
   chmod +x *.sh
   ```
3. **Run scripts** in order:
   ```bash
   ./Xrtpipeline.sh      # Raw data processing
   ./copysao,pat.sh      # Copy auxiliary files
   ./bary.sh             # Barycentric correction
   ./aproduct.sh         # Generate science products
   ./csub.sh             # Create background-subtracted light curves
   ./zzz.sh              # Consolidate light curves
   ./1modify.sh          # Modify text data
   ```
4. **Check logs** in specified directories for errors.

---

### Dependencies
- HEASoft (Swift tools: `xrtpipeline`, `barycorr`, `xrtproducts`, `lcmath`)
- Bash 4.0+
- Common Unix utilities (`find`, `cp`, `basename`, `dirname`)

---

### Directory Structure Example
```
/home/nabin/s_xrt/
├── 011268530[0-9]+/       # Raw data (per observation)
├── out011268530[0-9]+/    # Pipeline outputs
│   ├── product011268530*/ # Science products (from aproduct.sh)
│   ├── *bary.evt          # Barycentric-corrected events
│   └── ... 
├── v/                     # Consolidated light curves (from zzz.sh)
├── logs/                  # Log directory (aproduct.sh)
└── logss/                 # Additional logs (csub.sh)
```

Adjust paths in scripts as needed for your system.
