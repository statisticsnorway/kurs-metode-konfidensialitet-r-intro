

# Laste inn relevante pakker ----------------------------------------------

library(SSBtools)
library(SmallCountRounding)


# Laste inn datasett ------------------------------------------------------
load("data/virus.RData")
load("data/virus_mikro.RData")


# Oppgave 0 ---------------------------------------------------------------
# Hvis du trenger det, husk at du kan se på dokumentasjonen av PLSroundingPublish
# ved hjelp av ?PLSroundingPublish



# Oppgave 1 ---------------------------------------------------------------

## 1a.
#  Basert på virus-datasettet, lag en fullstendig toveistabell (dvs. med alle
#  marginaler over kommune og gravid. Bruk formula-grensesnittet.
#  Unngå forekomst av frekvenser lik 1, 2, 3 eller 4.  
#  Husk at frekvensvariabelen, altså antall personer, er i variabelen "ant"

# Erstatt NULL og ... med relevant kode.
out1a <- PLSroundingPublish(
             data = virus,
             formula = NULL,
              ...)
out1a


## 1b.
#  Lag en toveistabell på samme måte, 
#  men nå skal tabellen være med fylke og kjønn


# Erstatt NULL og ... med relevant kode.
out1b <- PLSroundingPublish(
  data = virus,
  formula = NULL,
  ...)

out1b



## 1c.
#  Lag tabellene i 1a og 1c samtidig.
#  


# Erstatt NULL og ... med relevant kode.
out1c <- PLSroundingPublish(
  data = virus,
  formula = NULL,
  ...)

out1c




## 1d.
#  Bruk FormulaSelection for å ta ut enkelttabeller fra 1c
#  Sammenlikn og vurder forskjellene fra 1a og 1b


# Erstatt NULL med relevant kode
FormulaSelection(out1c, NULL)
FormulaSelection(out1c, NULL)



## 1e.
#  Bruk i stedet mikrodatasettet virus_mikro og gjør 1c på nytt
#  Det ble en rad mindre i output enn 1c. Ser du hvilken rad
#

# Erstatt NULL og ... med relevant kode.
out1e <- PLSroundingPublish(
  data = virus_mikro,
  formula = NULL,
  ...)

out1e



## 1f
# Gjør oppgave som 1e på nytt der du prøver removeEmpty = FALSE







######################################################
#
#  Alle oppgavene nedenfor ansees som ekstraoppgaver. 
#  Her møter man spesielle problemstillinger 
#
######################################################



# Oppgave 2 ---------------------------------------------------------------


# Gjør oppgave 1, unntatt 1d, på nytt der du bytter ut PLSroundingPublish med PLSroundingInner   
# Gjør også alt dette på nytt med 
#      preAggregate = TRUE 
# inkludert.
# Kan du forklare output?



# Oppgave 3 ---------------------------------------------------------------
 
# Gjør oppgave 1c og 1d, på nytt der du bytter ut PLSroundingPublish med PLSrounding
#  - Hvordan gikk det med 1d?

# Forstår du noe av hva som skrives ut ved 
out3c

# Forstår du noe av hva som skrives ut ved 
out3c$inner      
out3c[["inner"]]     
out3c$publish    
out3c[["publish"]] 


