library(readxl)
library(openxlsx)
library(tidyr)
library(dplyr)
library(openxlsx)
#Requiere instalacion stringr
library(stringr)

#Selecionar el archivo
fp2 <- file.choose()

# Leemos el archivo
dc <-  read.xlsx(xlsxFile = fp2, sheet = 1,skipEmptyRows = TRUE)

# Vemos la estructura, y se observa que la ultima columna, esta vacia.
str(dc) 
dc$X15

# data.frame':	160 obs. of  15 variables:  Eliminamos la variable 15 (variable vacia)
dc <- dc[,-15]

# Eliminamos la columna X2 (El Total) -------------------------------------
dc <- dc[,-2]

#dt <- dt %>% complete.cases(.)
dct <- dc %>% gather (month, value, X3:X14)

# Eliminamos filas con characteres inutiles.
#p <- c("sowa","Nacional","Department", "harva", "production", "yield", "pricePlot")
dct <- dct %>% filter(variable != "Department", 
                      variable != "Nacional",
                      variable != "sowa",
                      variable != "harva",
                      variable != "production", 
                      variable != "yield",
                      variable != "pricePlot")

# Observamos la tabla 'dct', y las tablas empiezan con Tumbes y terminan con Madre de Dios.

# Creamos el vector 'tvar',  el cual contiene los atributos de los cultivos 
tvar <- c("sowa","harva", "production", "yield", "pricePlot")
# Como son 29 provincias, se tiene  que generar cada atributo para cada observacion 
rvar <- rep(tvar, 29)
# Que se repitan cada 12 veces
tvar <- rep(rvar, each = 12)
dct <- dct %>% mutate(trait =  tvar)

# Retiramos "--" de la columna value
# Usamos la libreria stringr, la funcion str_replace
dct$value <- str_replace_all(dct$value, "--", "")


# En la columna 'month', cambiar X3,...,X14 por el nombre del mes

# m1: los meses de la primera tabla
m1 <- c("Ago",	"Set",	"Oct",	"Nov",	"Dic",	"Ene",	"Feb",	"Mar",	"Abr",	"May",	
          "Jun",	"Jul")

# m2: los mese de las tablas restantes
m2 <- c("Ene",	"Feb",	"Mar",	"Abr",	"May",	"Jun",	"Jul",	"Ago",	"Set",	"Oct",	
          "Nov",	"Dic")

month_vector <- rep(m2, 4) 
month_vector <- c(m1, month_vector)
# Son 1740 observaciones, tomadas de 60 en 60 ,entonces 1740/60
month_vector <- rep(month_vector, 29)

# Sustituimos el vector month, por month_vector, 
# pero manteniendo el nombre "month" en la tabla
dct <- dct %>% mutate(month =  month_vector)

# Ordenamos por trait
dct <- dct %>% arrange(trait, month, variable)
# dct <- dct %>% arrange(month)
# dct <- dct %>% arrange(variable)

# Agregamos un indice
dct <- dct %>% mutate(indice = 1:nrow(dct))
dct <- dct %>% select( variable, indice, month, trait, value)


# Extraemos ---------------------------------------------------------------

# "variable" "month"    "value"    "trait"    "indice"
# Para el area de cosecha "harva

#harva <- dct %>% select(trait, value)
harva <- dct %>% filter(trait == "harva")
harva <- harva %>% spread(trait, value)
harva <- harva %>% mutate(year = 2005)
harva <- harva %>% arrange(variable, month)
harva <- harva %>% select(-indice)


# Para el area de siembre "sowa"
sowa <- dct %>% filter(trait == "sowa")
sowa <- sowa %>% spread(trait, value)
sowa <- sowa %>% mutate(year = 2005)
sowa <- sowa %>% arrange(variable, month)
sowa <- sowa %>% select(-indice)

#

join <- left_join(harva, sowa, by = "month")






