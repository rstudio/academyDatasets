<!-- NEWS.md is maintained by https://cynkra.github.io/fledge, do not edit -->

# academyDatasets 0.4.0

- `dmd` from [Vanderbilt Biostats](https://biostat.app.vumc.org/wiki/pub/Main/DataSets/dmd.html) (#78 @malcolmbarrett)

# academyDatasets 0.3.0

- `riverflow` from [Saugeen River in Ontario](https://zenodo.org/record/4656058) (#58 @brendanhcullen)
- `solar` from [National Renewable Energy Laboratory (NREL)](https://zenodo.org/record/4656151) (#66 @brendanhcullen)
- `bitcoin` from [forecastingdata.org](https://zenodo.org/record/5121965) (#59 @garrettgman)
- `us_births` from [forecastingdata.org](https://zenodo.org/record/4656049) (#62 @garrettgman)


# academyDatasets 0.2.0

## New Datasets

* `aus_electricity`
* `car_parts`
* `dominick`, `dominick_oatmeal` and `dominick_soap`
* `elec_demand`
* `electricity_weekly`
* `fred_md`
* `hospital`
* `nhanes_dermatology` and `nhanes_sleep`
* `oikolab_weather`
* `pedestrian_counts`
* `rideshare`
* `sunspots`
* `tourists`
* `vaccines_dictionary`

## Internal Changes

* Add `read_tsf()` function
* Add examples for conversion to `tsibble`
* Move `tsibble` to suggests
* Use `vctrs::vec_ptype_abbr()` for type column in data dictionaries
* Fix typo in `covid` dictionary

# academyDatasets 0.1.0

* First soft-release of academyDatasets
