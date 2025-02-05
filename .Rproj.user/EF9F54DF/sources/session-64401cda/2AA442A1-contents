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
    ~lon, ~lat,
    popup = ~paste("<b>", label, "</b><br>",
                   "<i>", precisions, "</i><br>", # Afficher le label en gras
                   "<img src='", image, "' width='100' height='100'><br>",  # Afficher l'image
                   "Origine de l'arbre : <b>", origine, "</b><br>",
                   descriptions), 
    radius = ~weight / 2,
    color = "green",
    stroke = FALSE,
    fillOpacity = 0.7
  )

# Afficher la carte
map


# Ajouter les arêtes (lignes entre les noeuds)
edges_coords <- edges %>%
  rowwise() %>%
  mutate(
    source_node = nodes[nodes$id == source, ],
    target_node = nodes[nodes$id == target, ],
    lng_coords = list(c(source_node$lon, target_node$lon)),
    lat_coords = list(c(source_node$lat, target_node$lat))
  )

# Ajouter les polylines pour chaque arête
map <- map %>%
  addPolylines(
    data = edges_coords,
    lng = ~lng_coords,
    lat = ~lat_coords,
    color = "blue",
    weight = 25
  )

# Afficher la carte
map
