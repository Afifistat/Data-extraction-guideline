rm(list=ls())

#working directory------------------------
setwd("D:/reviewer_1/exported data")

#Libraries-----------------------------
library(compareDF) # for data comparison
library(tidyverse) # for piping (%>% i.e. creating a sequence of multiple operations)
library(readr) # for reading 

#Reading data from two reviewers-----------------------------
Rev_1 <- read_csv("Rev_1.csv")
Rev_2 <- read_csv("Rev_2.csv")

#Comparing data from two reviewers-----------------------------
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
