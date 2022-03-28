# SignatureQuantification

R package to quantify signatures of chromosomal instability on copy number profiles.

Its official package page can be found here: [https://bioconductor.org/packages/cytomapper](https://bioconductor.org/packages/cytomapper)

## Check status

TBD

## Introduction

Chromosomal instability Chromosomal instability (CIN) results in the accumulation of large-scale losses, gains, and rearrangements of DNA.
In our recent study [1], we present a systematic framework to measure different types of CIN and their impact on clinical phenotypes.
This R package allows you to quantify the activity of the 17 signatures presented. It also allows you to quantify signature activities from other publications [2].

First, copy number features are extracted from the copy number profiles.
Second, the features are assigned to components for which a probability will be calculated. These probabilities are then summed up for each patient.
Third, the probabilities across the components are used to quantify signature activities.
Fourth, the signature activities can be used to predict patient response to platinum-based chemotherapies.

The `SignatureQuantification` package provides you with the functions and example data to automise this process of quantifying signature activities.

## Quick start

Install the package either from Github directly by using `devtools`
```r
install_github("markowetzlab/SignatureQuantification", build_vignettes = TRUE, dependencies = TRUE)
```

or from CRAN
```r
install.package("SignatureQuantification", dependencies = TRUE)
```

Then load the package with:
```r
library(SignatureQuantification)
```

If you have a segmented copy number profile that looks like the following example, then you are good to go. Preferably use unrounded copy number data but rounded data will do fine as well.
> chromosome  start     end         segVal    sample
> 1           61735     249224388   2.0       TCGA-BT-A20P
> 2           12784     82571206    2.0       TCGA-BT-A20P
> 2           82571664  85357333    0.843     TCGA-BT-A20P

Then use this function to automise the process of feature extraction and signature quantification:
```r
mySigs = quantifyCNSignatures(<YourCopyNumberProfile>)
```

If you want to use the signature activities to predict response to platinum-based chemotherapies, use this function:
```r
vPredictions = clinPredictionPlatinum(mySigs)
```

## Requirements

The `SignatureQuantification` package requires R version >= 4.0 and depends on the following packages:
* data.table
* stringr
* parallel
* foreach
* doMC
* YAPSA
Therefore, these packages need to be installed (see below).

## Functionality

The `SignatureQuantification` package offers two main functions: `quantifyCNSignatures` and `clinPredictionPlatinum`. It also allows you to do the signature quantification step-by-step with these functions: `createCignatures`, `calculateFeatures`, `calculateSampleByComponentMatrix`, `calculateActivity` and `clinPredictionDenovo`.

## Getting help

For more information on obtaining copy number profiles, please refer to the documentation of common copy number callers like [ASCAT](https://github.com/VanLoo-lab/ascat) or [ABSOLUTE](https://github.com/ShixiangWang/DoAbsolute).

More information on how to work with and generate copy number signatures can be obtained from: [Drews et al. (Nature, 2022)](TBD), [Macintyre et al. (Nature Genetics, 2018)](https://www.nature.com/articles/s41588-018-0179-8) or [Steele et al. (Cancer Cell, 2019)](https://linkinghub.elsevier.com/retrieve/pii/S1535-6108(19)30097-2).

## Example data

The package comes with a set of 478 samples that were both part of the TCGA and the PCAWG cohort and have detectable levels of CIN [1].


## Citation

Please cite `SignatureQuantification` as:

```
TBD
```

## Authors

[Ruben Drews](https://github.com/Martingales) Ruben.Drews 'at' cruk.cam.ac.uk

[Philip Smith](https://github.com/Phil9S) Philip.Smith 'at' cruk.cam.ac.uk


## References

[1] [Drews et al. (Nature, 2022)](TBD)

[2] [Macintyre et al. (Nature Genetics, 2018)](https://www.nature.com/articles/s41588-018-0179-8)

## Maintenance

For any issues please contact please open an issue!


## Version and license

v0.2 (post-acceptance, pre-publication); The methods implemented in the code are the subject of pending application GB 2114203.9. This code is licensed under a [BSD3-Clause-Clear license](LICENSE) and is available freely for non-commercial use only.
