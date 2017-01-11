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
dc <-  read.xlsx(xlsxFile = fp2, sheet = 1, skipEmptyRows = TRUE)

dct <- dc %>% filter(variable  != "Department",
                      variable != "Nacional" ,
                      variable != "NA")

# Vemos la estructura, y se observa que la ultima columna, esta vacia.
# Por defecto todas las cabezeras salen con nombres X3 hasta X14
str(dct) 
dc$X15
# data.frame':	160 obs. of  15 variables:  Eliminamos la variable 15 (variable vacia)
dct <- dct[,-15]
# Eliminamos la columna X2 (El Total) -------------------------------------
dct <- dct[,-2]


# Sowa: Sowing by area --------------------------------------------------------------------
# Seleccionamos las filas 30 primeras filas (del 1 al 30)

dtsowa <-slice(dct, 1:30)
csowa <- c("department", "Ago", "Set", "Oct", "Nov", "Dic", "Ene", "Feb", "Mar", "Abr", "May", "Jun", "Jul")
#asignar los nombres
names(dtsowa) <- csowa 

# Funcion: 'gather(data, key, value)' (paquete tidyr): sirve para transponer las tablas 
# de forma ordenada.
# Parametros o inputs dela funcion:
# data: los datos a usar.
# key: la columna que va almacenar las cabezeras.
# value: la columna que va almacenar los valores de cada cabezera. Se usa un 'rango'.

head(dtsowa)
dtsowa <- gather(dtsowa, month, sowa, Ago:Jul)

# Todavia existe un valor que esta sobrando
dtsowa <- dtsowa %>% filter( department!= "sowa") %>% arrange(department,month)

# Observamos la tabla 'dct', y las tablas empiezan con Tumbes y terminan con Madre de Dios.

# Creamos el vector 'tvar',  el cual contiene los atributos de los cultivos 
# Usamos la funcion str_replace_all (paquete stringr)
# Funcion: str_replace_all(string , pattern, replacement )
# Parametros
# string: vector con los valores
# pattern: el patron que deseamos reemplazar 
# replacement: el valor por que remplaza al patron.
# 
#dcsowa$sowa <- str_replace_all(dcsowa$sowa, "--", "")


# harva: harvest by area  -------------------------------------------------------------------
# Seleccionamos las siguientes 29 filas: del 31 al 60
dtharva <- dplyr::slice(dct, 31:60)
# cabezeras de la tabla harva
charva <- c("department", "Ene",	"Feb",	"Mar",	"Abr",	"May",	"Jun",	"Jul",	"Ago",	"Set",	"Oct",	
             "Nov",	 "Dic")
names(dtharva) <- charva 

head(dtharva)
dtharva <- gather(dtharva, month, harva, Ene:Dic)

# Todavia existe un valor que esta sobrando
dtharva <- dtharva %>% filter( department!= "harva") %>% arrange(department,month)

#dtharva$harva <- str_replace_all(dtharva$harva, "--", "")



# production --------------------------------------------------------------

# Seleccionamos las siguientes 29 filas: del 31 al 60
dtproduction <- dplyr::slice(dct, 61:90)
# cabezeras de la tabla harva
cproduction <- c("department", "Ene",	"Feb",	"Mar",	"Abr",	"May",	"Jun",	"Jul",	"Ago",	"Set",	"Oct",
            "Nov",	 "Dic")
names(dtproduction) <- cproduction

head(dtproduction)
dtproduction <- gather(dtproduction, month, production, Ene:Dic)

# Todavia existe un valor que esta sobrando
dtproduction <- dtproduction %>% filter( department!= "production") %>% arrange(department,month)

#dtproduction$production <- str_replace_all(dtproduction$production, "--", "")

# yield -------------------------------------------------------------------

dtyield <- dplyr::slice(dct, 91:120)

# cabezeras de la tabla harva
cyield <- c("department", "Ene",	"Feb",	"Mar",	"Abr",	"May",	"Jun",	"Jul",	"Ago",	"Set",	"Oct",
             "Nov",	 "Dic")
names(dtyield) <- cyield

head(dtyield)
dtyield <- gather(dtyield, month, yield, Ene:Dic)

# Todavia existe un valor que esta sobrando
dtyield <- dtyield %>%  filter( department!= "yield") %>% arrange(department,month)

#dtyield$yield <- str_replace_all(dtyield$yield, "--", "")


# pricePlot ---------------------------------------------------------------

dtpricePlot <- dplyr::slice(dct, 121:150)


# cabezeras de la tabla harva
cpricePlot <- c("department", "Ene",	"Feb",	"Mar",	"Abr",	"May",	"Jun",	"Jul",	"Ago",	"Set",	"Oct",
            "Nov",	 "Dic")
names(dtpricePlot) <- cpricePlot

head(dtpricePlot)
dtpricePlot <- gather(dtpricePlot, month, pricePlot, Ene:Dic)

# Todavia existe un valor que esta sobrando
dtpricePlot<- dtpricePlot %>%  filter( department!= "pricePlot") %>% arrange(department,month)

#dtpricePlot$pricePlot <- str_replace_all(dtpricePlot$pricePlot, "--", "")

# JOIN TABLES O Juntar Tablas

out <- left_join( x = dtsowa, y = dtharva, by = c("department", "month")) %>% 
       left_join(., dtproduction,  by = c("department", "month")) 
       


# Como unir tablas por ID con LEFT_JOIN  ----------------------------------

# Usamos la funcino left_join(x , y , by )
# x : primera tabla
# y: segunda tabla
# by: criterio por el cual juntamos las tablas

tbtomate <- left_join(dtsowa, dtharva, by = c("department", "month")) %>%
            left_join(., dtproduction, by = c("department", "month")) %>% 
            left_join(., dtyield, by = c("department", "month")) %>%
            left_join(., dtpricePlot, by = c("department", "month"))

# Agregamos el anho de las observaciones.

tbtomate <- tbtomate %>% mutate(year = 2005)


# Guardar tabla cultivo ---------------------------------------------------

 wb <- loadWorkbook(fp2)
 cult_sheet <- "tomate_proc"
 sheets <- excel_sheets(fp2)
 
 # if (condicion) {
 #  sentencias de codigo  
 # }
 # condicion: es un resultado que puede ser V o F
 # cult_sheet %in% sheets
 # is.element(el = cult_sheet, set = sheets)
 
 if(cult_sheet %in% sheets){
   removeWorksheet(wb, cult_sheet)
 }
 
 addWorksheet(wb, cult_sheet)
 writeData(wb, sheet = cult_sheet, x = tbtomate)
 saveWorkbook(wb, file = fp2, overwrite = TRUE)
 shell.exec(fp2)










