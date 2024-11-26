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

SuppressSmallCounts(
  data = virus,
  dimVar = c("alder", "gravid"),
  maxN = 3,
  freqVar = "ant"
)

## 1b.
#  Basert på virus-datasettet, lag en fullstendig toveistabell (dvs. med alle
#  marginaler over alder og gravid. Bruk dimVar-grensesnittet.
#  Sørg for at tall større enn 0 og mindre eller lik 3 blir primærundertrykket.

SuppressSmallCounts(
  data = virus,
  dimVar = c("alder", "gravid"),
  maxN = 3,
  freqVar = "ant",
  protectZeros = FALSE
)

## 1c.
#  Se nærmere på resultatene fra oppgavene 1a ob 1b. Hvilket av de to
#  kjøringene gir mest mening? Er det noe vits å beskytte nullene?

"De cellene som er primærundertrykket blir beskyttet fordi de er 0. Det finnes
derimot veldig få/ingen mennesker som er gravide i høy alder, så dette kan anses
som en form for strukturell null."


#####################################
#####     Koblede tabeller     ######
#####################################

# Oppgave 2 ---------------------------------------------------------------

## 2a.
#  Lag en tabell over hovedint i sosial-datasettet. Alle tall mindre
#  eller lik 3 skal primærundertrykkes.

SuppressSmallCounts(data = sosial,
                    formula = ~ hovedint,
                    maxN = 3)

## 2b.
#  Lag en toveistabell over kostragrupper og hovedint uten totaler.
#  Alle tall mindre eller lik 3 skal primærundertrykkes.

SuppressSmallCounts(data = sosial,
                    formula = ~ kostragr:hovedint,
                    maxN = 3)

## 2c.
#  Er det noe i veien for at tabellen fra oppgave 2a og 2b kan publiseres
#  sammen?

"Tabellene kan ikke publiseres sammen. Hver primærundertrykkede celle i tabellen fra 2b kan avsløres ved hjelp av totalene i tabellen fra 2a."

# Oppgave 3 ---------------------------------------------------------------

## 3a.
#  Basert på virus-datasettet, lag en fullstendig toveistabell (dvs. med alle
#  marginaler) over alder og gravid. Bruk formula-grensesnittet.
#  Sørg for at alle tall mindre eller lik 3 blir primærundertrykket, og lagre
#  både formelen og resultatet i egne variabler.

f1 <- ~ alder * gravid
t1 <- SuppressSmallCounts(
  data = virus,
  formula = f1,
  maxN = 3,
  freqVar = "ant"
)

## 3b.
#  Basert på virus-datasettet, lag en treveis tabell over alder, fylkesnavn,
#  og gravid. De eneste totalene som skal publiseres er populasjonstotalen og
#  totalene per fylke. Bruk formula-grensesnittet.
#  Sørg for at alle tall mindre eller lik 3 blir primærundertrykket, og lagre
#  både formelen og resultatet i separate variabler.

f2 <- ~ fylkesnavn:alder:gravid + fylkesnavn
t2 <- SuppressSmallCounts(
  data = virus,
  formula = f2,
  maxN = 3,
  freqVar = "ant"
)

## 3c.
#  Vi ønsker å utføre beskyttelse på tabellene fra oppgave 3a og 3b samtidig. En måte
#  å gjøre dette på er å lage alle krysninger over alle relevante variabler 
#  (her: fylkesnavn, alder, gravid). Lag denne tabellen, og sørg for at alle 
#  tall mindre eller lik 3 blir primærundertrykket, og lagre både formelen og
#  resultatet i separate variabler.

f3 <- ~ alder * fylkesnavn * gravid
t3 <- SuppressSmallCounts(
  data = virus,
  formula = f3,
  maxN = 3,
  freqVar = "ant"
)

## 3d.
#  Lage nå en kobling av tabellene fra oppgave 3a og 3b ved å sette sammen
#  formlene, slik vi så tidligere i kurset.
#  Sørg for at alle tall mindre eller lik 3 blir primærundertrykket, og lagre
#  både formelen og resultatet i separate variabler.

f4 <- ~ fylkesnavn:alder:gravid + fylkesnavn + alder * gravid
t4 <- SuppressSmallCounts(
  data = virus,
  formula = f4,
  maxN = 3,
  freqVar = "ant"
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

f41 <- ~ regionnavn * kjonn
f42 <- ~ fylke * kjonn

## 4b.
#  Kjør undertrykkingsmetoden SuppressSmallCounts på tabellene hver for seg,
#  slik at alle tall mindre eller lik 4 blir primærundertrykket.

t41 <- SuppressSmallCounts(data = reiseliv,
                           formula = f41,
                           maxN = 4)
t42 <- SuppressSmallCounts(data = reiseliv,
                           formula = f42,
                           maxN = 4)

## 4c.
# Kan de to tabellene fra oppgave 4b publiseres sammen? Er det mulig å bruke
# tall fra den ene tabellen til å avsløre tall i den andre?
# Tips: Se på fylke 50, og se på sammenhengen mellom fylke og regionsnavn i
# datasettet.

"Publisering av disse tabellen er ikke trygt. I datasettet er regionnavn en inndeling av fylke, slik at alle regionnavn som begynner med sifrene 50 er inneholdt i fylke 50. Man kan avsløre alle undertrykkede tall i tabell 1, ved å begynne med hvert kjønn for seg. For eksempel: Tabell 2 gir antall menn i fylke 50 som 52. I tabell 1 er antall menn i regionnavn == 5014 undertrykket, men alle andre antall menn i regionnavn som inngår i fylke 50 (hhv. 5007, 5020+5049, og 5026+5027+5028+5029) blir publisert (hhv. 11, 23, og 14). Dermed er det undertrykkede antallet menn i 5014: Antall menn i fylke 50 minus antall menn i alle regionnavn annet enn 5014, altså 52-11-23-14 = 4."
t42[t42$fylke == 50,]
t41[substr(t41$regionnavn, 1, 2) == 50,]


## 4d.
#  Definer en formel som genererer begge tabeller samtidig.
f43 <- ~ (regionnavn + fylke) * kjonn

## 4e.
#  Kjør metoden på den koblede tabellen definert i 4d. Har denne tabellen
#  den samme svakheten som resultatet fra oppgave 4b?
SuppressSmallCounts(data = reiseliv,
                    formula = f43,
                    maxN = 4)

"Det er veldig vanskelig å bare se på en tabell og vurdere om den er trygg. I
akkurat dette tilfelle er det relativt enkelt, og man kan overbevise seg om at det faktisk er trygt."