pkgload::load_all()
library(archive) # install.packages("archive")
library(dplyr)   # install.packages("dplyr")
library(purrr)   # install.packages("purrr")
library(tsibble) # install.packages("tsibble")
library(tidyr)

url <- "https://zenodo.org/record/5121965/files/bitcoin_dataset_with_missing_values.zip"

bitcoin <- archive::archive_read(url) %>%
  read_tsf(key = "series_name") %>%
  pluck(1) %>%
  select(
    timestamp = start_timestamp, series = series_name, value = series_value
  ) %>%
  mutate(series = as.factor(series)) %>% # For tidy data
  pivot_wider(names_from = series, values_from = value) %>%
  relocate(timestamp, price) %>%
  as_tibble()

bitcoin_dictionary <- describe_dataset(
  bitcoin,
  .title = "Daily Bitcoin prices with possible influencers",
  timestamp = "Day",
  price = "Price in US dollars (USD)",
  difficulty = "Mining difficulty",
  sent_addresses = "Number of addresses that sent Bitcoin",
  send_usd = "Amount of Bitcoin sent, in USD",
  market_cap = "Market value of all existing Bitcoin in USD",
  confirmation_time = "Time to record a transaction in block chain",
  transactions = "Number of blockchain transactions",
  median_transaction_size = "Median transaction size",
  mining_profitability  = "Profit in USD/Day for 1 THash/s",
  fee_reward = "Average fee percentage in total block reward",
  top_100_percent = "Percent of Bitcoin owned by the top 100 richest addresses",
  median_transaction_value = "Median transaction value in USD",
  av_transaction_value = "Average transaction value in USD",
  block_size  = "Average (mined?) Bitcoin block size in kilobytes",
  hashrate = "Bitcoin hashrate in Ehash/s",
  active_addresses = "Number of unique (from or to) addresses per day",
  google_trends = "Google trends interest score for Bitcoin",
  tweets = "Tweets per day with the tag #Bitcoin"
)

usethis::use_data(bitcoin, bitcoin_dictionary, overwrite = TRUE)
