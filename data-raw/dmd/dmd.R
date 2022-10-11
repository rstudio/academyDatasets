library(tidyverse)
pkgload::load_all()
dmd <- read_csv("https://biostat.app.vumc.org/wiki/pub/Main/DataSets/dmd.csv") %>%
  mutate(date = as.Date(sdate, origin = "1960-01-16")) %>%
  filter(obsno == 1) %>%
  select(-1, -obsno, -sdate) %>%
  rename(
    creatine_kinase = ck,
    hemopexin = h,
    pyruvate_kinase = pk,
    lactate_dehydroginase = ld
  )

dmd_dictionary <- describe_dataset(
  dmd,
  hospid = "Hospital ID",
  age = "Age in Years",
  date = "Date of Study",
  creatine_kinase = "Creatine Kinase",
  hemopexin = "Hemopexin",
  pyruvate_kinase = "Pyruvate Kinase",
  lactate_dehydroginase = "Lactate Dehydroginase",
  carrier = "Carrier of Duchenne Muscular Dystrophy"
)

usethis::use_data(
  dmd,
  dmd_dictionary,
  overwrite = TRUE
)
