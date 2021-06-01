pkgload::load_all()

library(readr)
library(magrittr)
# remotes::install_github("sfirke/janitor")
library(janitor)
library(dplyr)
library(lubridate)
library(stringr)

flu_raw <- readr::read_tsv("40138971692-Results.tsv", na = c("", "-N/A-", "IRD:null"))

# clean
flu <-
  flu_raw %>%
  janitor::clean_names() %>%
  janitor::remove_empty(which = "cols") %>%
  dplyr::mutate(
    host_species = stringr::str_replace(host_species, pattern = "IRD:", replacement = ""),
    collection_date = lubridate::parse_date_time(collection_date, orders = c("ymd", "mdy"), truncated = 2),
    collection_date = lubridate::ymd(collection_date)
  )

# rename
flu <-
  flu %>%
  dplyr::rename(protein = name)

flu %>%
  dplyr::count(strain_name)

# 15,091 unique strain names


flu_dictionary <- describe_dataset(
  flu,
  .title = "Protein Sequences of Influenza B Virus Strains",
  protein = "Abbreviation of viral protein",
  sequence_accession = "Unique identifier given to the protein sequence record to allow for tracking of different versions of that sequence.",
  complete_genome = "Is the viral strain's complete genome known?",
  complete_sequence = "Is the complete sequence of this viral protein known?",
  segment = "One of eight single-stranded RNA segments that encodes the viral protein",
  segment_length = "Number of RNA nucleotides in segment",
  collection_date = "Date of sample collection",
  host_species = "Species that the viral strain infects",
  country = "Country of strain origin",
  state_province = "State or province of origin if applicable",
  geographic_grouping = "Geographic origin of viral strain",
  flu_season = "For geographic regions in the northern hemisphere, the two digit year for the fall and winter season when the strain was recorded.",
  strain_name = "Name of viral strain",
  sequence = "Protein sequence in amino acid ",
  submission_date = "Date of entry submission",
  passage_history = "An indicator of what cell line was used for culturing the virus. Nomenclature for passage history is notoriously unstandardized. See https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6599686/"
)
