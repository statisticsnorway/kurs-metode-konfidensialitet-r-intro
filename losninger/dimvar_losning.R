library(SSBtools)
library(GaussSuppression)


# Last inn datasettene reiseliv, sosial og virus.
load("data/reiseliv.RData")
load("data/sosial.RData")
load("data/virus.RData")


# Oppgave 0 ---------------------------------------------------------------

# Utforsk datasettene, og undersøk hvilke er mikrodata og hvilke er allerede
# aggregerte.
 
# Åpne dokumentasjonen av funksjonen SuppressSmallCounts ved å kjøre
# ?SuppressSmallCounts. Det er greit å ikke forstå alt nå, men denne siden
# lenker til mye nyttig informasjon.

# I denne delen skal vi utforske bruk av dimVar for å bygge tabeller. Hvordan
# disse blir undertrykket/prikket, skal vi utforske i senere oppgaver.

# Man kan også bruke GaussSuppression sine funksjoner  til å lage tabeller uten
# undertrykking. Da trenger man bare å si at ingenting skal primærundertrykkes.
# For å gjøre vårt liv litt lettere lager vi en hjelpefunksjon som gjør dette
# for oss:
BuildFrequencyTable <- function(data, ...) {
  SuppressSmallCounts(data, ..., maxN = NULL, primary = FALSE)
}


# Oppgave 1 ---------------------------------------------------------------

# Bruk dimVar til å lage en toveis frekvenstabell av antall
# mennesker fordelt på kommune og kjønn basert på datasettet reiseliv.

BuildFrequencyTable(data = reiseliv, dimVar = c("kommune", "kjonn"))


# Oppgave 2 ---------------------------------------------------------------

# Bruk dimVar til å lage en treveis frekvenstabell av antall
# mennesker fordelt på kommune, alder og kjønn basert på datasettet reiseliv.

BuildFrequencyTable(data = reiseliv,
                    dimVar = c("kommune", "alder", "kjonn"))


# Oppgave 3 ---------------------------------------------------------------

# Bruk dimVar til å lage en treveis frekvenstabell av antall
# mennesker fordelt på fylke, kommune og kjønn basert på datasettet reiseliv.
BuildFrequencyTable(data = reiseliv,
                    dimVar = c("fylke", "kommune", "kjonn"))


# Oppgave 4 ---------------------------------------------------------------

# Bruk dimVar til å lage en frekvenstabell av antall
# mennesker fordelt på fylke og kjønn basert på datasettet virus.
# Hva er forskjellen mellom kjøring med/uten freqVar?

BuildFrequencyTable(
  data = virus,
  dimVar = c("fylkesnavn", "kjonn"),
  freqVar = "ant"
)

BuildFrequencyTable(
  data = virus,
  dimVar = c("fylkesnavn", "kjonn"),
)

"Uten freqVar blir datasettet behandlet som et mikrodatasett, dvs. at hver rad
telles som en enhet. Med freqVar blir antallet som er oppgitt under 
freqVar-kolonnen tatt som antallet for den aktuelle raden."


# Oppgave 5 ---------------------------------------------------------------

# Bruk dimVar til å lage en frekvenstabell av antall
# mennesker fordelt på fylke, kommune og hovedinntekt basert på datasettet
# sosial.

BuildFrequencyTable(
  data = sosial,
  dimVar = c("fylkesnavn", "kommune", "hovedint"),
)


# Oppgave 6 ---------------------------------------------------------------

# Vi legger til en ny variabel i datasettet sosial.
sosial$hovedint2 <-
  ifelse(sosial$hovedint == "arbeid", "work", "nowork")

# GaussSuppression kan oppdage komplekse hierarkier i flere variabler.
# Bruk dimVar til å lage en frekvenstabell av antall
# mennesker fordelt på fylke, kommune, kostragruppe, hovedinntekt,
# og den nye hovedinntektvariabelen basert på datasettet sosial.

BuildFrequencyTable(
  data = sosial,
  dimVar = c("fylkesnavn", "kommune", "kostragr", "hovedint", "hovedint2"),
)
