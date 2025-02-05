library(sf)
library(leaflet)
library(dplyr)
library(readr)

arbres_fulldata <- read_csv("data/tableau_complet.csv")

arbres_sf <- st_as_sf(arbres_fulldata, coords = c("longitude", "latitude"), crs = 4326)

icon_custom <- makeIcon(
  iconUrl = "https://cdn0.iconfinder.com/data/icons/trees-19/50/11-512.png",
  iconWidth = 20, iconHeight = 20,  
  iconAnchorX = 15, iconAnchorY = 30  
)

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
    icon = icon_custom
  ) %>%
  setView(lng = 2.3522, lat = 48.8566, zoom = 12)

carte_fullarbres <- leaflet(arbres_sf) %>%
  addLayersControl(overlayGroups = c("XVIe", "XVIIIe", "XIXe", "XXe", "XXIe"),
                 options = layersControlOptions(collapsed = TRUE))

carte_fullarbres <- leaflet(arbres_sf) %>%
  addLayersControl(overlayGroups = c("jardin", "cimetiere", "bois_de_boulogne", "bois_de_vincennes", "voie_publique", "espace_vert_prive"),
                   options = layersControlOptions(collapsed = TRUE))

carte_fullarbres
