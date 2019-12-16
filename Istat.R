install.packages("rsdmx")
library(rsdmx)
sdmx.data <- readSDMX(providerId = "ISTAT", resource = "data", flowRef  = "150_938", dsd = TRUE)
occ <- as.data.frame(sdmx.data, labels = TRUE)
save(occ, file = "occ.RData")
library(dplyr)
library(ggplot2)
library(RColorBrewer)
#ITG19  Siracusa
loca <- occ %>%
  filter(FREQ == "A",
         obsTime >= 2004,
         ITTER107 == "ITC4",
         SESSO == "9",
         CARATT_OCC == "9",
         POSIZPROF == "9",
         TEMPO_PIENO_PARZ == "9",
         ATECO_2007 == "0010",
         ATECO_2002 == "0010",
         CLASSE_ETA != "Y15-64",
         CLASSE_ETA != "Y_GE15",
         TITOLO_STUDIO == "99") %>%
  mutate_if(is.character,as.factor)

ggplot(loca, 
       aes(x = obsTime, y = obsValue, group = CLASSE_ETA_label.it, col = CLASSE_ETA_label.it)) +
  geom_line(size = 1) +
  theme_minimal() +
  scale_y_continuous("migliaia") +
  scale_x_discrete("anno") +
  labs(title = "Occupati in Lombardia",
       caption = "ns. elaborazione su dati ISTAT - RLCF") +
  scale_color_brewer(palette = "Set1", name="Classe di età")
