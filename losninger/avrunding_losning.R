

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

out1a <- PLSroundingPublish(
  data = virus,
  formula = ~navn*gravid,
  freqVar = "ant",
  roundBase = 5)

out1a
  

## 1b.
#  Lag en toveistabell på samme måte, 
#  men nå skal tabellen være med fylke og kjønn

out1b <- PLSroundingPublish(
  data = virus,
  formula = ~fylkesnavn*kjonn,
  freqVar = "ant",
  roundBase = 5)

out1b


## 1c.
#  Lag tabellene i 1a og 1c samtidig.
#  

out1c <- PLSroundingPublish(
  data = virus,
  formula = ~navn*gravid + fylkesnavn*kjonn,
  freqVar = "ant",
  roundBase = 5)

out1c


## 1d.
#  Bruk FormulaSelection for å ta ut enkelttabeller fra 1c
#  Sammenlikn og vurder forskjellene fra 1a og 1b

out1a
FormulaSelection(out1c, ~navn*gravid)

out1b
FormulaSelection(out1c, ~fylkesnavn*kjonn)


## 1e.
#  Bruk i stedet mikrodatasettet virus_mikro og gjør 1c på nytt
#  Det ble en rad mindre i output enn 1c. Ser du hvilken rad
#

out1e <- PLSroundingPublish(
  data = virus_mikro,
  formula = ~navn*gravid + fylkesnavn*kjonn,
  roundBase = 5)

out1e


## 1f
# Gjør oppgave som 1e på nytt der du prøver removeEmpty = FALSE

out1f <- PLSroundingPublish(
  data = virus_mikro,
  formula = ~navn*gravid + fylkesnavn*kjonn,
  roundBase = 5,
  removeEmpty = FALSE)

out1f


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


out2a <- PLSroundingInner(
  data = virus,
  formula = ~navn*gravid,
  freqVar = "ant",
  roundBase = 5)

out2a


out2a_ <- PLSroundingInner(
  data = virus,
  formula = ~navn*gravid,
  freqVar = "ant",
  roundBase = 5,
  preAggregate = TRUE)

out2a_



out2b <- PLSroundingInner(
  data = virus,
  formula = ~fylkesnavn*kjonn,
  freqVar = "ant",
  roundBase = 5)

out2b

out2b_ <- PLSroundingInner(
  data = virus,
  formula = ~fylkesnavn*kjonn,
  freqVar = "ant",
  roundBase = 5,
  preAggregate = TRUE)

out2b_



out2c <- PLSroundingInner(
  data = virus,
  formula = ~navn*gravid + fylkesnavn*kjonn,
  freqVar = "ant",
  roundBase = 5)

out2c


out2c_ <- PLSroundingInner(
  data = virus,
  formula = ~navn*gravid + fylkesnavn*kjonn,
  freqVar = "ant",
  roundBase = 5,
  preAggregate = TRUE)

out2c_



out2e <- PLSroundingInner(
  data = virus_mikro,
  formula = ~navn*gravid + fylkesnavn*kjonn,
  roundBase = 5)

out2e

out2e_ <- PLSroundingInner(
  data = virus_mikro,
  formula = ~navn*gravid + fylkesnavn*kjonn,
  roundBase = 5,
  preAggregate = TRUE)   # ingen effekt her

out2e_


## 1f
# Gjør oppgave som 1e på nytt der du prøver removeEmpty = FALSE


out2f <- PLSroundingInner(
  data = virus_mikro,
  formula = ~navn*gravid + fylkesnavn*kjonn,
  roundBase = 5,
  removeEmpty = FALSE)   # dette betyr ikke noe for inner 

out2f




# Oppgave 3 ---------------------------------------------------------------
 
# Gjør oppgave 1c og 1d, på nytt der du bytter ut PLSroundingPublish med PLSrounding
#  - Hvordan gikk det med 1d?

# Forstår du noe av hva som skrives ut ved 
# out3c

# Forstår du noe av hva som skrives ut ved 
# out3c$inner      
# out3c[["inner"]]     
# out3c$publish    
# out3c[["publish"]] 

out3c <- PLSrounding(
  data = virus,
  formula = ~navn*gravid + fylkesnavn*kjonn,
  freqVar = "ant",
  roundBase = 5)

out3c


out3c_ <- PLSrounding(
  data = virus,
  formula = ~navn*gravid + fylkesnavn*kjonn,
  freqVar = "ant",
  roundBase = 5,
  preAggregate = TRUE)

out3c_


FormulaSelection(out3c, ~navn*gravid)
FormulaSelection(out3c, ~fylkesnavn*kjonn)


# Forstår du noe av hva som skrives ut ved 
#
# Dette er det samme som ouput fra 
# PLSroundingInner og PLSroundingPublish
#
out3c$inner      #  out3c[["inner"]]      blir akkurat det samme 
out3c$publish    #  out3c[["publish"]]    blir akkurat det samme


