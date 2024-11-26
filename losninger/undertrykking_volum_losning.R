
# Laste inn relevante pakker ----------------------------------------------

library(SSBtools)
library(GaussSuppression)


# Laste inn datasett ------------------------------------------------------

load("data/overnatting.RData")
load("data/biler.RData")


# Tips for å se på output ----------------------------------------------------

# Hvis du «henter» funksjonen Print kan du se på output på en måte som gir raskere overblikk.
# Da er – erstattet av FALSE
# Det kan gjøres ved å kjøre koden manuelt eller ved linja nedenfor 
source("R/Print.R")

# Her er eksempel på bruk
output1 <- SuppressFewContributors(biler, numVar = "verdi", formula = ~mnd + sektor, maxN = 85)
output2 <- SuppressDominantCells(biler, numVar = "verdi", dimVar = "sektor", n=1, k = 5)

Print(output1)
Print(output2)

# Antall undertrykte celler kan telles med denne koden: 
sum(output1$primary)
sum(output1$suppressed)

sum(output2$primary)
sum(output2$suppressed)


# Oppgave 0 ---------------------------------------------------------------
# Hvis du trenger det, husk at du kan se på dokumentasjonen av SuppressFewContributors
# ved hjelp av ?SuppressFewContributors
# Tilsvarende ?SuppressDominantCells(



# Oppgave 1 ---------------------------------------------------------------

## 1a.
#  Basert på biler-datasettet, lag en fullstendig toveis tabell (dvs. med alle
#  marginaler over kommune og sektor. Bruk dimVar grensesnittet.
#  Ta med den numeriske variabelen "verdi".
#  Sørg for at det primærundertrykkes når antall rader fra input som bidrar 
#  er 3 eller mindre 

# erstatt NULL og ... med relevant kode

out1a <- SuppressFewContributors(biler, 
                        numVar = "verdi", 
                        dimVar = c("kommune", "sektor"), 
                        maxN = 3)

Print(out1a)


## 1b.
# Du brukte sikkert variabelen kommune. Gjør det på nytt med variabelen navn isteden.

out1b <- SuppressFewContributors(biler, 
                        numVar = "verdi", 
                        dimVar = c("navn", "sektor"), 
                        maxN = 3)

Print(out1b)


## 1c
# Ovenfor ble formuleringen «antall rader fra input som bidrar» brukt
# Det er sjelden akkurat det er noe poeng i seg selv. 
# Det vi pleier å se på er antall bidragsytere.
# I denne sammenhengen tenker vi på et bilmerke som en bidragsyter.
# Gjør analysen over på nytt der slik at primærundertrykkes når antall 
# bilmerker fra input som bidrar er 3 eller mindre.


out1c <- SuppressFewContributors(biler, 
                        numVar = "verdi", 
                        dimVar = c("navn", "sektor"), 
                        maxN = 3, 
                        contributorVar =  "bilmerke" )

Print(out1c)


## 1d
# Gjør samme analyse, men bruk formelgrensesnittet 


out1d <- SuppressFewContributors(biler, 
                        numVar = "verdi", 
                        formula = ~navn*sektor, 
                        maxN=3, 
                        contributorVar=  "bilmerke")

Print(out1d)



# Oppgave 2 ---------------------------------------------------------------


## 2a.
#  Basert på biler-datasettet, lag en fullstendig toveis tabell (dvs. med alle
#  marginaler over navn og sektor. Bruk formelgrensesnittet.
#  Sørg for at det primærundertrykkes når 
#         - Den største bidragsyteren bidrar med mer enn 60% av verdien    
#         - eller når de to største bidrar med mer enn 80% av verdien
# Lagre output fra dette i variabelen out1


out1 <- SuppressDominantCells(biler, 
                              numVar = "verdi", 
                              formula = ~navn*sektor, 
                              n=1:2, 
                              k = c(60, 80), 
                              contributorVar=  "bilmerke")

Print(out1)

## 2b.
# Bruk nøyaktig de samme reglene for primærundertrykkelse som over. 
# Lag fremdeles en fullstendig toveistabell, men bytt ut navn med fylkesnavn. 
# Lagre output fra dette i variabelen out2

out2 <- SuppressDominantCells(biler, 
                              numVar = "verdi", 
                              formula = ~fylkesnavn*sektor, 
                              n=1:2, 
                              k = c(60, 80), 
                              contributorVar=  "bilmerke")

Print(out2)


## 2c.
# Bruk formelgrensesnittet til undertrykke toveistabellene i 2a og 2b samtidig
# Lagre output fra dette i variabelen out3 
#

out3 <- SuppressDominantCells(biler, 
                              numVar = "verdi", 
                              formula = ~fylkesnavn*sektor + navn*sektor, 
                              n=1:2, 
                              k = c(60, 80), 
                              contributorVar=  "bilmerke")


Print(out3)


# alternativ

out3alternativ <- SuppressDominantCells(biler, 
                              numVar = "verdi", 
                              formula = ~(fylkesnavn+navn)*sektor, 
                              n=1:2, 
                              k = c(60, 80), 
                              contributorVar=  "bilmerke")


Print(out3alternativ)



## 2d.
# Bruk FormulaSelection som ble beskrevet i oppgavene om formel til å ta ut de to toveistabellene fra det samlede resultatet

out3_1 <- FormulaSelection(out3, ~navn*sektor)

out3_2 <- FormulaSelection(out3, ~fylkesnavn*sektor)

Print(out3_1)
Print(out3_2)


#
# Klarer du å se om det ble forskjellig resultat ved samordnet undertrykkelse?
# I oppgaven nedenfor skal det bli lettere å se forskjeller
#


dim(out1)
dim(out3_1)

sum(out1$suppressed)
sum(out3_1$suppressed)


# Oppgave 3 ---------------------------------------------------------------


## 3a
# Basert på overnatting-datasettet:
# Lag en enkel enveistabell som kun har totaler for regionnavn i tillegg til hovedtotalen. 
# Bruk formelgrensesnittet. 
# Sørg for at det primærundertrykkes når den største bidragsyteren bidrar med mer enn 85% 
# av antall overnattinger. Antall overnattinger finnes i variabelen "ialt"
# Bidragsyter i denne sammenhengen betyr organisasjon. 
# Det finnes både organisasjonsnummer  og organisasjonsnavn og du må bruke en av disse.


out3a <- SuppressDominantCells(overnatting, 
                      n=1, k= 85,  
                      formula = ~regionnavn, 
                      numVar = "ialt",
                      contributorVar = "orgnr_navn")

Print(out3a)

## 3b
# Gjør akkurat det samme. Men bytt ut regionnavn med fylke 



out3b <- SuppressDominantCells(overnatting, n=1, k= 85,  
                      formula = ~fylke, 
                      numVar = "ialt",
                      contributorVar = "orgnr_navn")

Print(out3b)


## 3c
# Sørg for samordnet undertrykkelse av totalene for både regionnavn og fylke
# Dette blir altså tabellene i 3a og 3b samtidig


out3c <- SuppressDominantCells(overnatting, n=1, k= 85,  
                      formula = ~regionnavn + fylke, 
                      numVar = "ialt",
                      contributorVar = "orgnr_navn")

Print(out3c)


# Nå er det lett å se forskjell. 
# Kan du forklare forskjellen og begrunne hvorfor samordning er viktig.


# I tabell 3a velges sekundær celle fra annet fylke.
# Dermed kan man regne seg tilbake fra fylkessum når man ser tabell 3b 

# I tabell 3c velges sekundær celle fra samme fylke. 
# Dermed er ikke slik tilbakeregning mulig. 


# Oppgave 4 ---------------------------------------------------------------


# I disse oppgavene skal vi bruke en mindre versjon av overnattingsdatasettet  
# som lages ved koden nedenfor 

overnatting1 <- overnatting[overnatting$type4 == "1" & overnatting$mnd %in% c("7", "8", "9"), ]

overnatting1 

## 4a
# Basert på den nye datasette overnatting1:
# Lag en samlet undertrykkelse som har med totaler for kommune, reiselivsregion og mnd. 
# Toveistabellen for reiselivsregion og mnd skal også være med.  
# Bruk formelgrensesnittet. 
# Sørg for at det primærundertrykkes når 
#  - den største bidragsyteren bidrar med mer enn 60% av antall overnattinger. 
#  - eller når de to største bidrar med mer enn 70% av antall overnattinger.
# Bidragsyter i denne sammenhengen betyr organisasjon slik som i oppgaven over


out4a <- SuppressDominantCells(overnatting1, 
                      n=1:2, k= c(60, 70), 
                      formula = ~kommune + reiselivsregion*mnd, 
                      numVar = "ialt", 
                      contributorVar = "orgnr_navn")

Print(out4a)

## 4b
# Oppgaven er lik oppgave 4a bortsett fra at primærundertrykkelse er annerledes 
# Sørg for at det primærundertrykkes når 
#  - den største bidragsyteren bidrar med mer enn 60% av omsetningen. 
#  - eller når de to største bidrar med mer enn 70% av omsetningen.

# Ble det forskjell på hvordan undertrykkelsen ble?


out4b <- SuppressDominantCells(overnatting1, 
                      n=1:2, k= c(60, 70), 
                      formula = ~kommune + reiselivsregion*mnd, 
                      numVar = "omsetn",
                      contributorVar = "orgnr_navn")

Print(out4b)

## 4c

# I oppgave 4a og 4b hadde du sannsynligvis med enten "ialt" eller "omsetn" i output.

# Kan du kjøre på nytt med samme undertrykkelsesregler som i 4b, 
# men sørg for at både "ialt" og "omsetn"   blir med i output.  
# Tips:  Det går an å ha flere variabler i numVar 


out4c <- SuppressDominantCells(overnatting1, 
                      n=1:2, k= c(60, 70), 
                      formula = ~kommune + reiselivsregion*mnd, 
                      numVar = c("omsetn", "ialt"),
                      contributorVar = "orgnr_navn")

Print(out4c)

## 4d
# Kan du kjøre på nytt med samme undertrykkelsesregler som i 4a, 
# men sørg for at både "ialt" og "omsetn"   blir med i output.  
# Eksperimenter med å bruke parameteren dominanceVar slik at warning unngås.


out4d <- SuppressDominantCells(overnatting1, 
                      n=1:2, k= c(60, 70), 
                      formula = ~kommune + reiselivsregion*mnd, 
                      numVar = c("ialt", "omsetn"),
                      contributorVar = "orgnr_navn")
Print(out4d)


# uten Warning 
out4d_alternativ <- SuppressDominantCells(overnatting1, 
                               n=1:2, k= c(60, 70), 
                               formula = ~kommune + reiselivsregion*mnd, 
                               numVar = "omsetn",
                               dominanceVar = "ialt",
                               contributorVar = "orgnr_navn")
Print(out4d_alternativ)





#####################################
#####   Ekstraoppgaver          #####
#####################################


# Oppgave 5 ---------------------------------------------------------------


## 5a
# Kjør analysene i oppgave 4 på nytt, og legg inn: allDominance = TRUE
#     allDominance = TRUE gir mer info,
#           blir forandring og mer info i fremtidig versjon 

## 5b
# Basert på output du ser:  
# Lek litt med dominansgrensense slik at primærprikkingen endres



out4d_ <- SuppressDominantCells(overnatting1, 
                                n=1:2, k= c(60, 70), 
                                formula = ~kommune + reiselivsregion*mnd, 
                                numVar = "omsetn",
                                dominanceVar = "ialt",
                                contributorVar = "orgnr_navn", 
                                allDominance = TRUE)
Print(out4d_)





# Oppgave 6 ---------------------------------------------------------------


# Selv om du kjører SuppressDominantCells så går det an å undertrykke etter 
# fewContributors-regler samtidig. 
#
# Da må du legge inn dette som parameter 
#     primary = c(DominanceRule, NContributorsRule)
# Du må også ha med en maxN-verdi

# Gjenta noen av analysene over der denne endringen er med.   


# En fordel nå med dette er hva som kommer i output
#     Men bedre allDominance = TRUE 
#           kan også gi mer info i fremtidig versjon 



out4d__ <- SuppressDominantCells(overnatting1, 
                                n=1:2, k= c(60, 70), 
                                formula = ~kommune + reiselivsregion*mnd, 
                                numVar = "omsetn",
                                dominanceVar = "ialt",
                                contributorVar = "orgnr_navn", 
                                primary = c(DominanceRule, NContributorsRule),
                                maxN = 2)
Print(out4d__)


# remove0 = FALSE eller, som her remove0 = "ialt",  unngår warning
out4d___ <- SuppressDominantCells(overnatting1, 
                                 n=1:2, k= c(60, 70), 
                                 formula = ~kommune + reiselivsregion*mnd, 
                                 numVar = "omsetn",
                                 dominanceVar = "ialt",
                                 contributorVar = "orgnr_navn", 
                                 primary = c(DominanceRule, NContributorsRule),
                                 maxN = 2, remove0 = "ialt")
Print(out4d___)




# Oppgave 7 ---------------------------------------------------------------

# Eksperimenter selv
# Bruk gjerne `overnatting` eller `biler` datasettene.
#
# Velg input for formula 
# Se at undertrykkingen blir annerledes om du 
# endrer parametere i SuppressDominantCells eller går over til 
# SuppressFewContributors.





