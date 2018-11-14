library(tidyverse)
library(dplyr)
library(knitr)
library(scales)
library(foreign)
library(fs)
library(utils)
library(RCurl)
library(curl)
library(kableExtra)
library(lubridate)

df <- read.csv("mt_2_results.csv") 

download.file(url = "https://goo.gl/ZRCBda", destfile = "master.zip", quiet = TRUE, mode = "wb")

unzip("master.zip")

file_names <- dir_ls("~/Desktop/Data/ps_7_starter/2018-live-poll-results-master/data")

ps7start <- map_dfr(file_names, read_csv, .id = "source")

newps7 <- ps7start %>% 
  mutate(sen = str_detect(source, ("sen"))) %>%
  mutate(gov = str_detect(source, ("gov"))) %>%
  filter(gov == "FALSE", sen == "FALSE")

wave3 <- newps7 %>%  
  mutate(wave = str_sub(source, start = -5, end = -5)) %>%  
  filter(wave == 3) %>% 
  mutate(state_district = str_sub(source, -10, -7))

         