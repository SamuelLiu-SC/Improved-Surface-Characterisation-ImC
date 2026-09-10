# Improved Characterisation (ImC)

For paper published in Precision Engineering 
https://doi.org/10.1016/j.precisioneng.2026.09.007

There is also a dateset published
https://doi.org/10.6084/m9.figshare.30826133

We welcome new surfaces and functions to be added and contrubited in this repo, and shared with researchers 

MATLAB scripts and helper functions for generating, displaying, normalising, and fitting 3D surface data. The repository includes example workflows for blaze gratings, microlens arrays, and 1D/2D sine surfaces.

## Repository Layout

- `general_functions/` - shared MATLAB helpers for data conversion, display, filtering, normalisation, interpolation, and fitting.
- `blaze_grating_simulation/` - example script for blaze grating simulation and fitting.
- `lensArray/` - example script for microlens array fitting.
- `sine1D/` - 1D sine surface example data and fitting script.
- `sine2D/` - 2D sine surface example data and fitting script.

## Requirements

- MATLAB
- The example data files included in the repository, such as `sine1D/543.txt` and `sine2D/20.xyz`

## Example Workflows

Each test script follows the same basic pattern:

1. Load measured surface data.
2. Crop and normalise the surface.
3. Generate a synthetic surface for comparison.
4. Fit the measured data using the corresponding `fit3d_*` function.
5. Visualise the fitted and measured surfaces.

Example entry points:

- `blaze_grating_simulation/fit3d_blaze_grating_test.m`
- `lensArray/fit3d_lensArray_test.m`
- `sine1D/fit3d_sine_test.m`
- `sine2D/fit3d_sineXY_test.m`

## Notes

- Most scripts expect the current working directory to be the repository root, or for the `general_functions/` folder to be on the MATLAB path.
- Some scripts use measured Zygo exports stored in the repository for reproducible examples.