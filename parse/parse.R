# process IDXstats

library(tidyverse)
source(here::here("vars.R"))

# tax table - midas
tax <- read_tsv(tax_in, col_names = c("id", "tax_full")) %>%
  separate(col = tax_full, sep = "; [A-z]__", 
           into = c("kingdom", "phylum", "class", "order", "family", "genus", "species")) %>%
  mutate(kingdom = str_replace(kingdom, "k__", ""))

# sample tables 
list_in <- lapply(samples_in, read_tsv, col_names = FALSE)
names(list_in) <- samples

df <- bind_rows(list_in, .id = "sample") %>%
  select(sample, X1, X3) %>%
  rename("id" = "X1", "ab" = "X3") %>%
  left_join(tax, by = "id")

write_csv(df, file = ab_out)