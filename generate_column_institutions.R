

library(tidyverse)
library(ggplot2)
library(readxl)


# obtenemos datos mesa 
var_diags <- read_excel("input/nna_resulta.xlsx",
                        sheet = "base") %>% select(ORDEN,everything()) %>%
  janitor::clean_names()

var_diags$organizacion <- tolower(var_diags$organizacion)

sum(is.na(var_diags$organizacion))

var_diags2 <- var_diags %>%
  mutate(inst=case_when(str_detect(organizacion,"opd |proteccion |proteccion|protección|opd") ~ "OPD",
                        str_detect(organizacion,"escuela   |escuelas| escuela|escuela|alumnos |alumno") ~ "Escuelas",
                        str_detect(organizacion,"jardín |jardin") ~ "Jardines Infantiles",
                        str_detect(organizacion,"scout |scout") ~ "Grupos Scout",
                        #str_detect(organizacion,"ppf |ppf") ~ "PPF",
                        str_detect(organizacion,"hijos de funcionario|hijos de funcionarios") ~ "Hijos de funcionarios",
                        str_detect(organizacion,"secretaria|secretaría|secretaria |secretaría ") ~ "Secretaría de la Niñéz",
                        str_detect(organizacion,"4 a 7|4 a 7|4a7|ppf |ppf|chile crece contigo|chile crece|mca|mca |medidas cautelares|cautelares|psa|psa |libertad asistida|focalizada |residencias familiares|residencia familiar| semicerrado| semi cerrado|semicerrado|semi cerrado |semi-cerrado| semi - cerrado|semi - cerrado|semi - cerrado ") ~ "Programas NNA",
                        str_detect(organizacion,"fundacion |fundacion|fundación |fundación|ciudad del niño") ~ "Fundaciones",
                        str_detect(organizacion,"deportivo |deportivo|deportivos|deportivos |club|club |clubes|futbol |futbol|fútbol|fútbol ") ~ "Clubes Deportivos",
                        str_detect(organizacion,"temporero|temporero |temporera|temporera |cncpt |cncpt|cnct") ~ "Centro de cuidado de Padres Temporeros",
                        str_detect(organizacion,"provisoria |provisoria| provisoria") ~ "Centros de Internación Provisoria",
                        str_detect(organizacion,"consejo consultivo") ~ "Consejo Consultivo de la Niñéz",
                        #str_detect(organizacion,'NA') ~ "No detected",
                        
                        str_detect(organizacion,"jjvv |jjvv|junta de vecinos |vecinos|junta de vecino|junta de vecinos") ~ "Juntas de Vecinos y Grupos de vecinos",
                        #str_detect(organizacion,"chile crece contigo|chile crece") ~ "Chile Crece Contigo",
                        str_detect(organizacion,"oficina local de la niñez|oficina local|oln |oln") ~ "Oficina Local de la Niñez",
                        str_detect(organizacion,"municipalidad |ilustre") ~ "Municipalidades",
                        str_detect(organizacion,"liceos |liceos | liceo |liceo |colegio| colegios|liceo") ~ "Liceos",
                        str_detect(organizacion,"sename | sename|servicio nacional de menores | servicio nacional de menores") ~ "Sename"))

var_diags2 <- var_diags2 %>% mutate(inst = replace_na(inst, "No detectado"))


writexl::write_xlsx(var_diags2,"temp/var_diags2_inst.xlsx")
