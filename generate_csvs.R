

library(readxl)
library(tidyverse)

var_diags <- read_excel("input/nna_resulta.xlsx",
                          sheet = "base") %>% select(ORDEN,everything()) %>%
  janitor::clean_names() %>% select(-id)

var_needs <- read_excel("input/nna_resulta.xlsx",
                        sheet = "necesidad") %>%
  select(ID,ORDEN,Text,Keywords,Dominant_Topic,topico) %>% janitor::clean_names()


var_propuesta <- read_excel("input/nna_resulta.xlsx",
                        sheet = "propuesta") %>%
  select(ID,orden,Text,Keywords,Dominant_Topic,topico) %>% janitor::clean_names()


var_compromisos <- read_excel("input/nna_resulta.xlsx",
                        sheet = "compromiso") %>%
  select(ID,ORDEN,Text,Keywords,Dominant_Topic,topico) %>% janitor::clean_names()



## join needs

needs <- var_needs %>% 
  left_join(var_diags, by="orden")

## join compromisos

compromisos <-  var_compromisos %>%
  left_join(var_diags, by="orden")

## join propuestas 

propuestas <- var_propuesta %>%
  left_join(var_diags, by="orden")


write.csv(needs,"output/needs.csv")
write.csv(compromisos,"output/compromisos.csv")
write.csv(propuestas,"output/propuestas.csv")

write.csv(var_diags,"dialogos_nna.csv")

