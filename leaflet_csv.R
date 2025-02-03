# Installer les packages si nécessaire
install.packages("leaflet")
install.packages("readr")
install.packages("dplyr")

# Charger les packages
library(leaflet)
library(readr)
library(dplyr)

nodes <- read_csv ("data/nodes_arbres.csv")
edges <- read_csv ("data/edges_arbres.csv")

# Carte de base avec Leaflet
map <- leaflet(nodes) %>%
  addTiles() %>%
  addCircleMarkers(
    ~lon, ~lat,  # coordonnées des noeuds
    popup = ~paste("<b>", label, "</b><br>",
                   "<i>", precisions, "</i><br>", # Afficher le label en gras
                   "<img src='", image, "' width='100' height='100'><br>",  # Afficher l'image
                   "Origine de l'arbre : <b>", origine, "</b><br>",
                   descriptions),  # Afficher la description
    radius = ~weight / 2,
    color = "green",
    stroke = FALSE,
    fillOpacity = 0.7
  )

# Afficher la carte
map


# Ajouter les arêtes (lignes entre les noeuds)
for (i in 1:nrow(edges)) {
  source_node <- nodes[nodes$id == edges$source[i], ]
  target_node <- nodes[nodes$id == edges$target[i], ]
  
  map <- map %>%
    addPolylines(
      lng = c(source_node$lon, target_node$lon),
      lat = c(source_node$lat, target_node$lat),
      color = "blue",
      weight = 2
    )
}

map



