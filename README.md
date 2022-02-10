# Quantification of pan-cancer signatures from copy number profiles

This repository allows the user to apply the pan-cancer copy number signatures from Drews et al. (2022) to be applied to any copy number profile.

## Quick start

The main script to use is `scripts/0_Signature_activities_from_CN_profiles.R`.

Change the variable called `DAT` with the path to your data.

The data should contain five columns in that order: chromosome, start, end, segVal (copy number value), sample name. Chromosomes should have no "chr" prefix.

## Maintenance
For any issues please contact please contact Florian Markowetz Florian.Markowetz@cruk.cam.ac.uk and Geoff Macintyre gmacintyre@cnio.es.

## Version and license

v0.1 (pre-acceptance, pre-publication); All rights reserved.
