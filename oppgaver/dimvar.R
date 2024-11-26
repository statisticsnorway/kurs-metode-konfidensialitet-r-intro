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

# Erstatt dimVar = NULL
BuildFrequencyTable(data = reiseliv,
                    dimVar = NULL)


# Oppgave 2 ---------------------------------------------------------------

# Bruk dimVar til å lage en treveis frekvenstabell av antall
# mennesker fordelt på kommune, alder og kjønn basert på datasettet reiseliv.

# Erstatt dimVar = NULL
BuildFrequencyTable(data = reiseliv,
                    dimVar = NULL)


# Oppgave 3 ---------------------------------------------------------------

# Bruk dimVar til å lage en treveis frekvenstabell av antall
# mennesker fordelt på fylke, kommune og kjønn basert på datasettet reiseliv.

# Erstatt dimVar = NULL
BuildFrequencyTable(data = reiseliv,
                    dimVar = NULL)


# Oppgave 4 ---------------------------------------------------------------

# Bruk dimVar til å lage en frekvenstabell av antall
# mennesker fordelt på fylke og kjønn basert på datasettet virus.
# Hva er forskjellen mellom kjøring med/uten freqVar?

# Erstatt dimVar = NULL og freqVar = NULL
BuildFrequencyTable(
  data = virus,
  dimVar = NULL,
  freqVar = NULL
)

# erstatt dimVar = NULL
BuildFrequencyTable(
  data = virus,
  dimVar = NULL
)


# Oppgave 5 ---------------------------------------------------------------

# Bruk dimVar til å lage en frekvenstabell av antall
# mennesker fordelt på fylke, kommune og hovedinntekt basert på datasettet
# sosial.

# Erstatt dimVar = NULL
BuildFrequencyTable(
  data = sosial,
  dimVar = NULL
)


# Oppgave 6 ---------------------------------------------------------------

# Vi legger til en ny variabel i datasettet sosial.
sosial$hovedint2 <-
  ifelse(sosial$hovedint == "arbeid", "work", "nowork")

# GaussSuppression kan oppdage komplekse hierarkier i flere variabler.
# Bruk dimVar til å lage en frekvenstabell av antall
# mennesker fordelt på fylke, kommune, kostragruppe, hovedinntekt,
# og den nye hovedinntektvariabelen basert på datasettet sosial.

# Erstatt dimVar = NULL
BuildFrequencyTable(
  data = sosial,
  dimVar = NULL
)
