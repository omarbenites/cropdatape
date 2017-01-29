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