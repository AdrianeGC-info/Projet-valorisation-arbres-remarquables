library(ggplot2)
library(plotly)

table <- read.csv ("data/projet final s1.csv")

ggplot(data = table, aes(x = factor(arrondissement, levels = 1:20))) +
  geom_bar(fill = "steelblue", color = "black") +
  theme_minimal() +
  xlab("Arrondissement") +
  ylab("Nombre d'arbres")

# Créer le graphique ggplot
p <- ggplot(data = table, aes(x = factor(arrondissement, levels = 1:20))) +
  geom_bar(aes(y = ..count..), fill = "steelblue", color = "black") +
  theme_minimal() +
  xlab("Arrondissement") +
  ylab("Nombre d'arbres")

# Convertir le graphique ggplot en graphique interactif avec plotly
p_interactif <- ggplotly(p, tooltip = "y")

# Afficher le graphique interactif
p_interactif
