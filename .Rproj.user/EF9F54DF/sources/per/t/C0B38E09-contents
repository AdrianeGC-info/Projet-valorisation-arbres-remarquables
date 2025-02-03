# Installer les packages si nécessaire
install.packages(c("sf", "leaflet", "dplyr", "readr"))

# Charger les packages
library(sf)
library(leaflet)
library(dplyr)
library(readr)

# Charger le fichier CSV
arbres_fulldata <- read_csv("data/tableau_complet.csv")

# Convertir en objet spatial avec latitude et longitude
arbres_sf <- st_as_sf(arbres_fulldata, coords = c("longitude", "latitude"), crs = 4326)

# Créer une icône personnalisée
icon_custom <- makeIcon(
  iconUrl = "https://cdn0.iconfinder.com/data/icons/trees-19/50/11-512.png",  # Remplacer par l'URL de ton icône
  iconWidth = 20, iconHeight = 20,  # Taille de l'icône
  iconAnchorX = 15, iconAnchorY = 30  # Positionnement de l'icône
)

# Mettre la carte dans leaflet
carte_fullarbres <- leaflet(arbres_sf) %>%
  addTiles() %>%
  addMarkers(
    popup = ~paste(
      "<b>", Nom_usuel, "</b> (<i>", Nom_botanique, "</i>)", "<br>",
      "<img src='", lien_photo, "' width='200'><br>",
      "<i>Crédits image : </i>", auteur_photo, "<br>",
      "<u>Description : </u>", infos, "<br>",
      "<u>Circonférence : </u>", circonference, " cm", "<br>",
      "<u>Hauteur : </u>", hauteur, " m", "<br>",
      "<u>Adresse : </u>", Adresse, ", ", complement, "<br>",
      "<u>Date de plantation : </u>", date_de_plantation, "<br>",
      "<br>",
      pourquoi_classif
    ),
    icon = icon_custom  # Utilisation d'une icône personnalisée
  ) %>%
  setView(lng = 2.3522, lat = 48.8566, zoom = 12)

# Afficher la carte
carte_fullarbres
