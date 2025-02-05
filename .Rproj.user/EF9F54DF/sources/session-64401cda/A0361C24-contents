library(GGally)
library(plotly)

table_arbres <- read.csv ('data/tableau_complet.csv')

ggplot(data = table_arbres, aes(domanialite)) + geom_bar()

ggplot(data = table_arbres, aes(x = arrondissement)) + 
  geom_histogram(fill = "#69b3a2", color = "#e9ecef", alpha = 0.7, binwidth = 0.5)

ggplot(data = table_arbres, aes(x = arrondissement,
                             y = Type,
                             colour = domanialite,
                             size = hauteur))  +
  geom_point() + 
  labs(x = "Arrondissements", y = "Domanialité", 
       title = "Localisation des arbres remarquables à Paris",
       subtitle = "selon l'arrondissement et la domanialité",
       caption = "Data de idf data") +
  theme_minimal()
