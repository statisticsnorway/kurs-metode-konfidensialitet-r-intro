# Laste inn relevante pakker ----------------------------------------------

library(SSBtools)
library(GaussSuppression)


# Laste inn datasett ------------------------------------------------------

load("data/reiseliv.RData")
load("data/sosial.RData")
load("data/virus.RData")


# Oppgave 0 ---------------------------------------------------------------
# Hvis du trenger det, husk at du kan se på dokumentasjonen av SuppressSmallCounts
# ved hjelp av ?SuppressSmallCounts.

# Oppgave 1 ---------------------------------------------------------------

## 1a.
#  Basert på virus-datasettet, lag en fullstendig toveistabell (dvs. med alle
#  marginaler over alder og gravid. Bruk dimVar-grensesnittet.
#  Sørg for at alle tall mindre eller lik 3 blir primærundertrykket.

# Erstatt NULL og ... med relevant kode.
SuppressSmallCounts(
  data = virus,
  dimVar = NULL,
  ...
)

## 1b.
#  Basert på virus-datasettet, lag en fullstendig toveistabell (dvs. med alle
#  marginaler over alder og gravid. Bruk dimVar-grensesnittet.
#  Sørg for at tall større enn 0 og mindre eller lik 3 blir primærundertrykket.

# Erstatt NULL og ... med relevant kode.
SuppressSmallCounts(
  data = virus,
  dimVar = NULL,
  ...,
)

## 1c.
#  Se nærmere på resultatene fra oppgavene 1a ob 1b. Hvilket av de to
#  kjøringene gir mest mening? Er det noe vits å beskytte nullene?


#####################################
#####     Koblede tabeller     ######
#####################################

# Oppgave 2 ---------------------------------------------------------------

## 2a.
#  Lag en tabell over hovedint i sosial-datasettet. Alle tall mindre
#  eller lik 3 skal primærundertrykkes.

# Erstatt ... med relevant kode.
SuppressSmallCounts(data = sosial,
                    ...)

## 2b.
#  Lag en toveistabell over kostragrupper og hovedint uten totaler.
#  Alle tall mindre eller lik 3 skal primærundertrykkes.

# Erstatt ... med relevant kode.
SuppressSmallCounts(data = sosial,
                    ...)

## 2c.
#  Er det noe i veien for at tabellen fra oppgave 2a og 2b kan publiseres
#  sammen?

# Oppgave 3 ---------------------------------------------------------------

## 3a.
#  Basert på sosial-datasettet, lag en fullstendig toveistabell (dvs. med alle
#  marginaler) over alder og gravid. Bruk formula-grensesnittet.
#  Sørg for at alle tall mindre eller lik 3 blir primærundertrykket, og lagre
#  både formelen og resultatet i egne variabler.

# Erstatt ... og NULL med relevant kode.
f1 <- NULL
t1 <- SuppressSmallCounts(
  data = virus,
  formula = f1,
  ...
)
## 3b.
#  Basert på sosial-datasettet, lag en treveis tabell over alder, fylkesnavn,
#  og gravid. De eneste totalene som skal publiseres er populasjonstotalen og
#  totalene per fylke. Bruk formula-grensesnittet.
#  Sørg for at alle tall mindre eller lik 3 blir primærundertrykket, og lagre
#  både formelen og resultatet i separate variabler.

# Erstatt ... og NULL med relevant kode.
f2 <- NULL
t2 <- SuppressSmallCounts(
  data = virus,
  formula = f2,
  ...
)

## 3c.
#  Vi ønsker å utføre beskyttelse på tabellene fra oppgave 3a og 3b samtidig. En måte
#  å gjøre dette på er å lage alle krysninger over alle relevante variabler 
#  (her: fylkesnavn, alder, gravid). Lag denne tabellen, og sørg for at alle 
#  tall mindre eller lik 3 blir primærundertrykket, og lagre både formelen og
#  resultatet i separate variabler.

# Erstatt ... og NULL med relevant kode.
f3 <- NULL
t3 <- SuppressSmallCounts(
  data = virus,
  formula = f3,
  ...
)

## 3d.
#  Lage nå en kobling av tabellene fra oppgave 3a og 3b ved å sette sammen
#  formlene, slik vi så tidligere i kurset.
#  Sørg for at alle tall mindre eller lik 3 blir primærundertrykket, og lagre
#  både formelen og resultatet i separate variabler.

# Erstatt ... og NULL med relevant kode.
f4 <- NULL
t4 <- SuppressSmallCounts(
  data = virus,
  formula = f4,
  ...
)

# Her kan vi se forskjellen mellom å kjøre metoden på en tabell som bare
# inneholder akkurat de cellene som skal publiseres, og en tabell som inneholder
# alle mulige kombinasjoner:
cat("Antall undertrykket i tabell 1, oppgave 3a: ",
    sum(FormulaSelection(t3, f1)$suppressed),
    "\n")
cat("Antall undertrykket i tabell 2, oppgave 3a: ",
    sum(FormulaSelection(t3, f2)$suppressed),
    "\n")
cat("Antall undertrykket i tabell 1, oppgave 3b: ",
    sum(FormulaSelection(t4, f1)$suppressed),
    "\n")
cat("Antall undertrykket i tabell 2, oppgave 3b: ",
    sum(FormulaSelection(t4, f2)$suppressed),
    "\n")

# Det er færre celler som blir undertrykket når man slipper å ta hensyn til
# celler som ikke skal publiseres!


# Oppgave 4 ---------------------------------------------------------------

# I denne oppgaven utforsker vi mer hvorfor det er viktig å beskytte tabeller
# samtidig. Nå skal vi undertrykke slik at alle tall mindre eller lik 4 blir
# primærundertrykket.

## 4a.
#  Definer formler for følgende to tabeller, basert på datasettet reiseliv:
#   1. En toveistabell over regionnavn og kjønn med alle totaler,
#   2. En toveistabell over fylke og kjønn med alle totaler.

# Erstatt NULL med korrekte formler.
f41 <- NULL
f42 <- NULL

## 4b.
#  Kjør undertrykkingsmetoden SuppressSmallCounts på tabellene hver for seg,
#  slik at alle tall mindre eller lik 4 blir primærundertrykket.

# Erstatt ... med relevant kode.
t41 <- SuppressSmallCounts(data = reiseliv,
                           ...)
t42 <- SuppressSmallCounts(data = reiseliv,
                           ...)

## 4c.
# Kan de to tabellene fra oppgave 4b publiseres sammen? Er det mulig å bruke
# tall fra den ene tabellen til å avsløre tall i den andre?
# Tips: Se på fylke 50, og se på sammenhengen mellom fylke og regionsnavn i
# datasettet.


## 4d.
#  Definer en formel som genererer begge tabeller samtidig.

# Erstatt NULL med riktig formel.
f43 <- NULL

## 4e.
#  Kjør metoden på den koblede tabellen definert i 4d. Har denne tabellen
#  den samme svakheten som resultatet fra oppgave 4b?
SuppressSmallCounts(data = reiseliv,
                    formula = f43,
                    maxN = 4)
