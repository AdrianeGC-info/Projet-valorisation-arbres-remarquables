# Load the required libraries for mapping and spatial data manipulation
library(leaflet)
library(sp)
library(sf)

library(sf)

# Lire les fichiers Shapefile
nodes <- st_read("shp/map_nodes_shp2.shp")
edges <- st_read("shp/map_edges_shp2.shp")

# Extraire les coordonnées des nœuds
coordinates_nodes <- st_coordinates(nodes)

# Extraire la première coordonnée des arêtes (point de départ de chaque arête)
coordinates_edges <- st_coordinates(edges)
first_coordinates_edges <- coordinates_edges[seq(1, nrow(coordinates_edges), by = 2), ]  # Prendre un point de départ pour chaque arête

# Ajouter les coordonnées comme colonnes au dataframe des nœuds
nodes$longitude <- coordinates_nodes[,1]  # Longitude des nœuds
nodes$latitude <- coordinates_nodes[,2]   # Latitude des nœuds

# Ajouter les coordonnées comme colonnes au dataframe des arêtes (premier point)
edges$longitude <- first_coordinates_edges[,1]  # Longitude du premier point de chaque arête
edges$latitude <- first_coordinates_edges[,2]   # Latitude du premier point de chaque arête

# Convertir les colonnes de texte en UTF-8
nodes$Label <- iconv(nodes$Label, from = "latin1", to = "UTF-8")
nodes$descriptio <- iconv(nodes$descriptio, from = "latin1", to = "UTF-8")
nodes$image <- iconv(nodes$image, from = "latin1", to = "UTF-8")

# Vérifier si les colonnes ont été correctement converties
head(nodes)

library(leaflet)
library(sf)

# Lire les fichiers Shapefile
nodes <- st_read("shp/map_nodes_shp.shp")
edges <- st_read("shp/map_edges_shp.shp")

# Extraire les coordonnées des nœuds
coordinates_nodes <- st_coordinates(nodes)

# Initialiser une liste pour stocker les segments des arêtes
segments_edges <- list()

# Boucle pour créer les segments des arêtes
for (i in 1:nrow(edges)) {
  
  # Récupérer les "Label" (source) et "Vient.de" (target) de l'arête
  source_label <- edges$Label[i]  # 'Label' correspond au nœud source
  target_label <- edges$Vient.de[i]  # 'Vient.de' correspond au nœud target
  
  # Trouver l'index du nœud source dans le dataframe nodes
  source_index <- which(nodes$Label == source_label)  # Correspondance avec le Label dans nodes
  
  # Trouver l'index du nœud target dans le dataframe nodes
  target_index <- which(nodes$Label == target_label)  # Correspondance avec le Label dans nodes
  
  # Si les indices sont trouvés, on récupère les coordonnées
  if (length(source_index) > 0 & length(target_index) > 0) {
    # Extraire les coordonnées du nœud source et target
    source_coords <- coordinates_nodes[source_index, ]
    target_coords <- coordinates_nodes[target_index, ]
    
    # Créer un segment de polyligne entre ces deux nœuds
    segment <- rbind(source_coords, target_coords)
    segments_edges[[i]] <- segment  # Ajouter ce segment à la liste
  } else {
    warning(paste("Coordonnées non trouvées pour l'arête ", i))
  }
}

# Vérifie si les labels dans edges existent bien dans nodes
all(edges$Label %in% nodes$Label)  # Devrait retourner TRUE si tout est ok
all(edges$Vient.de %in% nodes$Label)  # Devrait retourner TRUE si tout est ok

nodes <- st_read("shp/map_nodes_shp2.shp", options = "ENCODING=UTF-8")
edges <- st_read("shp/map_edges_shp2.shp", options = "ENCODING=UTF-8")

# Extraire les coordonnées des points
coordinates_nodes <- st_coordinates(nodes)

# Ajouter les coordonnées comme colonnes dans ton tableau
nodes$longitude <- coordinates_nodes[,1]  # Longitude
nodes$latitude <- coordinates_nodes[,2]   # Latitude

edges$longitude <- first_coordinates_edges[,1]  # Longitude du premier point de chaque arête
edges$latitude <- first_coordinates_edges[,2]   # Latitude du premier point de chaque arête


library(leaflet)

# Créer une carte Leaflet
leaflet(data = nodes) %>%  # Spécifie le data frame ici
  addTiles() %>%  # Ajouter une couche de base
  
  # Afficher les nœuds comme des points avec des images et descriptions dans le popup
  addMarkers(~longitude, ~latitude,  # Référence correcte des colonnes 'longitude' et 'latitude'
             icon = ~icons(iconUrl = image, iconWidth = 50, iconHeight = 50),  # Utiliser la colonne 'image' pour l'URL de l'image
             popup = ~paste("<b>", Label, "</b><br>",  # Afficher le label en gras
                            "<img src='", image, "' width='100' height='100'><br>",  # Afficher l'image
                            descriptio)) %>%  # Afficher la description
  
  # Afficher les arêtes (edges) comme des polylignes
  addPolylines(data = edges, 
               lat = ~latitude, lng = ~longitude,  # Indiquer lat et lng pour les arêtes
               color = "blue", 
               weight = 2)


# Convertir les colonnes en UTF-8
nodes$Label <- iconv(nodes$Label, from = "latin1", to = "UTF-8")
nodes$descriptio <- iconv(nodes$descriptio, from = "latin1", to = "UTF-8")
nodes$image <- iconv(nodes$image, from = "latin1", to = "UTF-8")

# Créer la carte Leaflet
leaflet(data = nodes) %>% 
  addTiles() %>%  # Ajouter une couche de base
  
  # Afficher les nœuds comme des points avec des images et descriptions dans le popup
  addMarkers(~longitude, ~latitude,  # Référence correcte des colonnes 'longitude' et 'latitude'
             icon = ~icons(iconUrl = image, iconWidth = 50, iconHeight = 50),  # Utiliser la colonne 'image' pour l'URL de l'image
             popup = ~paste("<b>", Label, "</b><br>",  # Afficher le label en gras
                            "<img src='", image, "' width='100' height='100'><br>",  # Afficher l'image
                            descriptio)) %>%  # Afficher la description
  
  # Afficher les arêtes (edges) comme des polylignes
  addPolylines(data = edges, 
               lat = ~latitude, lng = ~longitude,  # Indiquer lat et lng pour les arêtes
               color = "blue", 
               weight = 2)

# Si tu lis les données depuis un shapefile ou un geojson
nodes$Label <- iconv(nodes$Label, from = "latin1", to = "UTF-8")
nodes$descriptio <- iconv(nodes$descriptio, from = "latin1", to = "UTF-8")

# Remplacer les caractères spéciaux
nodes$Label <- gsub("Ã¨", "é", nodes$Label)  # Remplacer les mauvaises occurrences
nodes$Label <- gsub("Ã", "é", nodes$Label)  # Autre exemple

# Convertir les colonnes contenant des caractères spéciaux en UTF-8
nodes$Label <- iconv(nodes$Label, from = "latin1", to = "UTF-8")
nodes$descriptio <- iconv(nodes$descriptio, from = "latin1", to = "UTF-8")
nodes$image <- iconv(nodes$image, from = "latin1", to = "UTF-8")

# Vérifier l'encodage des colonnes après la lecture
Encoding(nodes$Label)
Encoding(nodes$descriptio)
Encoding(nodes$image)
