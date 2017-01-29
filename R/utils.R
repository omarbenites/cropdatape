# archivos <- list.files("data/")
# 
# rutas <- paste("data/", archivos, sep= "")
# 
# #Calculando el numero de elementos
# n <- length(archivos)
# datos <- list()
# 
# for( i in 1:n) {
#   datos[[i]] <- readRDS(rutas[i])
# }
# 
# 
# # Ensamblaje de todas tablas -------------------------------------------------
# 
# library(data.table)
# # Funcion: rbindlist
# # Esta funcion sirve para juntar juntar una lista (tabla) una debajo de otra.
# 
# # Como sabemos datos, es una lista que contine data.frames.
# cropdatape <- rbindlist(datos)
# 
# saveRDS(tbem_tomate,"tabla_tomate.rds")
# 
# 
# fp <- file.choose()
# 
# datos <- readxl::read_excel(fp)
# datos <- as.data.frame(datos)
# datos$department <- as.factor(datos$department) 
# datos$month <- as.factor(datos$month)
# datos$harva <- as.numeric(datos$year)
# datos$crop <- as.factor(datos$crop)
# 
# cropdatape <- datos
# save(cropdatape, file = "data/cropdatape.rda")
# 
# # Data from 2014 use diferent units ---------------------------------------
# library(dplyr)
# cp14 <- filter(cropdatape, year == 2014)
# 
## Tranformando las variables 
# # sowa"       "harva"      "production" "yield" "pricePlot" 
# # yield = tn/ha --> 1000kg/ha (yield * 1000)
# # pricePlot =  Nuevos Soles/Tonelada --> nuevos.soles/1000kg (pricePlot/1000)
# 
# cp14$yield <- cp14$yield*1000
# cp14$pricePlot <- cp14$pricePlot/1000
# 
# 
# cp <- filter(cropdatape, year != 2014)
# res <- rbind(cp, cp14)
# cropdatape <- res
# 
# save(cropdatape, file = "data/cropdatape.rda")
# 
# 


