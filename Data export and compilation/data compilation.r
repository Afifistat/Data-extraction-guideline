
#working directory------------------------
setwd ("D:/reviewer_1/exported data") 
# Data compilation-------
library(tidyverse) #data handling
################################################################
#**************Exporting and reading data into R****************
################################################################

#study--------------------------------------
study <- read.csv(file="study.csv", 
              head=TRUE, 
              sep=",", 
              stringsAsFactors=FALSE) %>% 
  
  rename (su = GlobalRecordId) %>%
  
  select(-UniqueKey, 
         -RECSTATUS, 
         -(FirstSaveLogonName:FKEY)) 

#trial (report)--------------------------------------
trial <- read.csv(file="trial.csv", 
              head=TRUE,
              sep=",",
              stringsAsFactors=FALSE) %>% 
  
  rename (tu = GlobalRecordId,
          su = FKEY) %>%
  
  select(-UniqueKey,
         -RECSTATUS,
         -(FirstSaveLogonName:LastSaveTime),
         -study_id_expo)

#group--------------------------------------
group <- read.csv(file="group.csv",
              head=TRUE,
              sep=",",
              stringsAsFactors=FALSE)%>% 
  
  rename (gu = GlobalRecordId,
          tu = FKEY) %>%
  
  select(-UniqueKey,
         -RECSTATUS,
         -(FirstSaveLogonName:LastSaveTime),
         -group_order,
         -study_id_expo,
         -trial_expo)

#outcome----------------------------------------------
outcome <- read.csv(file="outcome.csv",
              head=TRUE,
              sep=",",
              stringsAsFactors=FALSE) %>% 
  
  rename (ou = GlobalRecordId,
          gu = FKEY) %>% 

  select(-UniqueKey,
         -RECSTATUS, 
         -(FirstSaveLogonName:LastSaveTime),
         -study_id_expo,
         -trial_expo,
         -Group_expo, 
         -study_id_expo1,
         -trial_expo1,
         -Group_expo1,
         -T,
         -U)

#o_arm------------------------------
o_arm <- read.csv(file="o_arm.csv",
                  head=TRUE,
                  sep=",",
                  stringsAsFactors=FALSE)%>%

  rename (ou = FKEY,
          Others_Def = Other_def) %>% # error in var_nmae in epi_info
  
  mutate (d_format = "arm") %>%
  
  select(-UniqueKey,
         -UniqueRowId,
         -GlobalRecordId,
         -RECSTATUS)

#o_cont------------------------------
o_cont <- read.csv(file="o_cont.csv",
                   head=TRUE,
                   sep=",",
                   stringsAsFactors=FALSE)%>%
  
  rename (ou = FKEY) %>%
  
  mutate (d_format = "cont") %>%
  
  select(-UniqueKey,
         -UniqueRowId,
         -GlobalRecordId,
         -RECSTATUS)

################################################################
#***********Appending and merging multiple data files***********
################################################################

#append (contrast and arm)-----------
arm_cont <- bind_rows(o_arm,
                      o_cont) 

#merge_cascade-------------------------------------
full <- inner_join(study, trial, by = "su") %>%
  
  inner_join(group, by = "tu")  %>% 
  
  inner_join(outcome, by = "gu") %>%
  
  inner_join(arm_cont, by = "ou") %>%
  
  select(-su,
         -tu,
         -gu,
         -ou)%>% 
  
  rename_all(tolower)
