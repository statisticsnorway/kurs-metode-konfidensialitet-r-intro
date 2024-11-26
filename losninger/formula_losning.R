library(SSBtools)
library(GaussSuppression)

load("data/reiseliv.RData")
BuildFrequencyTable <- function(data, ...) {
  SuppressSmallCounts(data, ..., maxN = NULL, primary = FALSE)
}


# Oppgave 1 ---------------------------------------------------------------

## 1a.
#  Bruk formula til å lage en toveis frekvenstabell av antall
#  mennesker fordelt på kommune og kjønn basert på datasettet reiseliv.

BuildFrequencyTable(data = reiseliv, formula = ~ kommune * kjonn)

## 1b.
#  Vi har sett at bruk av * i formula genererer en tabell som kan lages med dimVar.
#  Lag den samme tabellen som i oppgave 1a med dimVar.

BuildFrequencyTable(data = reiseliv, dimVar = c("kommune", "kjonn"))


# Oppgave 2 ---------------------------------------------------------------

# Lag en tabell som bare inneholder kommune- og kjønnstotaler fra datasettet
# reiseliv.
# Er det dimVar eller formula som egner seg best til dette? Bygg
# tabellen med den du mener er best egnet.

BuildFrequencyTable(data = reiseliv, formula = ~ kommune + kjonn)


# Oppgave 3 ---------------------------------------------------------------

# Nå ønsker vi å lage en tabell over kommune og region uten kommune- og
# kjønnstotaler og uten populasjonstotalen.

BuildFrequencyTable(data = reiseliv, formula = ~ kommune : kjonn - 1)


#####################################
#####     Koblede tabeller     ######
#####################################

# Det er best praksis å undertrykke samtlige tabeller i en statistikk samtidig:
# flere av tabellene kan ha celler til felles, og undertrykking bør væere
# konsistent på tvers av tabeller. I de følgende oppgavene skal vi øve på å
# definere flere tabeller samtidig i GaussSuppression-pakken.


# Oppgave 4 ---------------------------------------------------------------

# Vi ønsker å publisere to tabeller basert på reiseliv:
#   1. En toveistabell over regionnavn og kjønn,
#   2. En toveistabell over fylke og kjønn.

## 4a.
# Definer to modellformler, én for hver av tabellene. Vi skal bruke disse senere
# i oppgavesettet, så lagre dem gjerne som variabler. Bruk gjerne 
# hjelpefunksjonen BuildFrequencyTable til å sjekke resultatet ditt.

f1 <- ~ regionnavn * kjonn
f2 <- ~ fylke * kjonn

BuildFrequencyTable(data = reiseliv, formula = f1)
BuildFrequencyTable(data = reiseliv, formula = f2)

## 4b.
# Definer én modellformel som kombinerer begge tabeller. Vi skal bruke 
# resultatet videre i oppgavesettet, så lagre resultatet av BuildFrequencyTable
# som en egen data.frame.

f3 <- ~ (regionnavn + fylke) * kjonn
koblet1 <-
  BuildFrequencyTable(data = reiseliv, formula = f3)

## 4c.
# SSBtools inneholder en funksjon FormulaSelection, som kan være behjelpelig i
# tilfeller der man har laget flere tabeller med formula.
# Funksjonen gjør det mulig å hente ut deltabeller av en tabell generert via
# formula. Syntaksen er FormulaSelection(data.frame, formula).
# 
# Bruk FormulaSelection til å hente ut oppgavens to tabeller fra den koblede
# tabellen du lagde i oppgave 4b.
FormulaSelection(koblet1, f1)
FormulaSelection(koblet1, f2)


# Oppgave 5 ---------------------------------------------------------------

# Eksperimenter med formelgrensesnittet. Bruk gjerne datasettene `sosial` eller
# `virus` for å se at den også fungerer på aggregerte data som input.
