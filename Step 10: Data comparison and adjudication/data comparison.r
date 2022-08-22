rm(list=ls())
setwd("D:/PhD/Data Extraction_manuscript/versions/submission/supplementary materials")
library(compareDF)
library(tidyverse)
library(readr)
Rev_1 <- read_csv("Rev_1.csv")
Rev_2 <- read_csv("Rev_2.csv")
comp_nps <- compare_df(Rev_1,
                       
                       Rev_2,
                       
                       keep_unchanged_rows = TRUE,
                       
                       c("studyid",
                         "trial_order",
                         "pico5",
                         "outcome",
                         "ounit1",
                         "time1"),
                       
                       change_markers = c("1st_Rev", "2nd_Rev", "agree")
                   ) %>%
  create_output_table( limit = 2000)
