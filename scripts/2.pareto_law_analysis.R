# step 1. load iter 2010 and climatic data #####
load("C:/Users/felip/OneDrive/multivariate_analysis_eme/8.RData/2.iter_bio/iter_2020_loc_bio.RData")


# Step 2. load the dengue cases dataset #####
load("C:/Users/felip/OneDrive/multivariate_analysis_eme/8.RData/1.denv/den_2008_2021_loc_cases.RData")



# Step 3. left_join iter_bio and dengue cases ####
names(xy)[-c(1:3)] <- paste("DENV_", names(xy)[-c(1:3)], sep = "")

iter_bio_den <- dplyr::left_join(x = iter_2020_loc_bio,
                                 y = xy,
                                 by = c("entidad" = "CVE_EDO_RES",
                                        "mun" = "CVE_MPO_RES",
                                        "loc" = "CVE_LOC_RES"))
iter_bio_den[is.na(iter_bio_den)] <- 0


# Step 4. select the columns ####
names(iter_bio_den)
head(iter_bio_den)

z <- iter_bio_den |>
    dplyr::select(entidad, nom_ent, nom_mun, loc, nom_loc, dplyr::starts_with("20")) |>
    dplyr::mutate(sur_sureste = ifelse(entidad %in% c("04", "07", )))
str(z)

# seleccionar los estado de la sur-sureste 

