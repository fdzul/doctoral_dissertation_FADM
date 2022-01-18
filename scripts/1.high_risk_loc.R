


# Step 1. load the 168 high risk loc #####
y <- readRDS("C:/Users/felip/OneDrive/proyects/hotspots_paper/8.RData/loc_temp_geocoded.rds")


# Step 2. load the localities of study ####
x <- read.csv("C:/Users/felip/OneDrive/proyects/hotspots_paper/1.Datasets/loc_study_2.csv")

x$loc[x$loc == "ACAPULCO DE JUAREZ"] <- "Acapulco"
x$loc[x$loc == "CANCUN"] <- "Cancún"
x$loc[x$loc == "COATZACOALCOS"] <- "Coatzacoalcos"
x$loc[x$loc == "IGUALA DE LA INDEPENDENCIA"] <- "Iguala"
x$loc[x$loc == "MERIDA"] <- "Mérida"
x$loc[x$loc == "SAN FRANCISCO DE CAMPECHE"] <- "Campeche"
x$loc[x$loc == "TAPACHULA DE CORDOVA Y ORDONEZ"] <- "Tapachula"
x$loc[x$loc == "VERACRUZ"] <- "Veracruz"
x$loc[x$loc == "VILLAHERMOSA"] <- "Villahermosa"


# Step 3. load several sf object for maps ####
mex_edo <- rgeomex::AGEE_inegi19_mx |>
    dplyr::filter(CVEGEO %in% c("04", "27", "12", "30", "31",
                                "17","21", "07", "20", "23"))
mex_mun <- rgeomex::AGEM_inegi19_mx |>
    dplyr::filter(CVE_ENT %in% c("04", "27", "12", "30", "31",
                                 "17","21", "07", "20", "23"))
path <- "C:/Users/felip/OneDrive/datasets/INEGI/mapa_digital_5.0.A/marco geoestadistico nacional 2010/nacional.shp"
mex <- sf::st_read(path) |> sf::st_transform(crs = 4326)


# Step 4. map de localities ####

library(ggplot2)
library(ggspatial)

 ggplot() +
    geom_sf(data = mex,
            fill = "grey90",
            col = "grey90") +
    theme_void() +
    geom_sf(data = mex_mun,
            fill = "gray80",
            col = "white") +
    geom_sf(data = mex_edo,
            fill = NA,
            col = "black") +
    geom_point(data = y, 
               aes(x =long, y = lat),
               pch = 21,
               color = "red",
               fill = "black",
               stroke = 4,
               alpha = 0.5,
               size = 1) +
    geom_point(data = x, 
               aes(x =lon, y = lat),
               pch = 21,
               color = "green",
               fill = "darkgreen",
               stroke = 4,
               alpha = 0.5,
               size = 1) +
    geom_text(data = x |> dplyr::filter(!loc %in% c("Cancún",
                                                    "Coatzacoalcos")),
              mapping = aes(x =lon, 
                            y = lat, 
                            label = loc),
              check_overlap = TRUE,
              hjust = 0, 
              nudge_x = 0.3,
              fontface = "bold") +
    geom_text(data = x |> dplyr::filter(loc %in% c("Cancún",
                                                   "Coatzacoalcos")),
              mapping = aes(x =lon, 
                            y = lat, 
                            label = loc),
              check_overlap = TRUE,
              vjust = 0, 
              nudge_x = 0.2,
              nudge_y = 0.3,
              fontface = "bold")
    ggspatial::annotation_scale() 

ggplot2::ggsave(filename = "figs/high_risk_loc.jpg",
                dpi = 300,
                bg = "white")
