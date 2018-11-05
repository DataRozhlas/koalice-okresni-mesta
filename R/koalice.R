library(readxl)
library(tidyverse)

download.file("https://volby.cz/opendata/kv2018/KV2018reg20181008_xlsx.zip", "KV2018reg20181031_xlsx.zip")
unzip("KV2018reg20181031_xlsx.zip")
zastupitelstva18 <- read_excel("kvrzcoco.xlsx")
strany18 <- read_excel("kvros.xlsx")
kandidati18 <- read_excel("kvrk.xlsx")
file.remove(list.files(pattern="*.xlsx|*.xml|*.zip"))

vybrana_zastupitelstva <- zastupitelstva18 %>%
  filter(NAZEVZAST %in% c("Hradec Králové","Rychnov nad Kněžnou","Jičín","Trutnov","Náchod","Jihlava","Havlíčkův Brod","Pelhřimov","Třebíč","Žďár nad Sázavou","Zlín","Kroměříž","Vsetín","Uherské Hradiště","Liberec","Jablonec nad Nisou","Česká Lípa","Semily","Přeštice","Domažlice","Rokycany","Nýřany","Tachov","Plzeň","Klatovy","Cheb","Sokolov","Karlovy Vary","Jeseník","Olomouc","Prostějov","Přerov","Šumperk","Děčín","Chomutov","Litoměřice","Louny","Most","Teplice","Ústí nad Labem","Benešov","Beroun","Kladno","Kolín","Kutná Hora","Mělník","Mladá Boleslav","Nymburk","Rakovník","Příbram","Blansko","Brno","Břeclav","Hodonín","Kuřim","Vyškov","Znojmo","České Budějovice","Tábor","Písek","Strakonice","Český Krumlov","Prachatice","Jindřichův Hradec","Opava","Karviná","Ostrava","Frýdek-Místek","Nový Jičín","Bruntál","Pardubice","Ústí nad Orlicí","Svitavy","Chrudim", "Praha hl.m.")) %>%
  filter(DRUHZASTUP>=2) %>%
  select(KRAJ, OKRES, KODZASTUP, NAZEVZAST, OBEC, NAZEVOBCE, ORP, MANDATY, POCOBYV) %>%
  distinct(KODZASTUP, NAZEVZAST, MANDATY, POCOBYV)

strany_v_zastupitelstvech <- strany18 %>%
  filter(MAND_STR>0) %>%
  right_join(vybrana_zastupitelstva)

write.csv(strany_v_zastupitelstvech, "export2.csv", row.names = F)

koalice <- read.csv("koalice.csv")


koalice <- koalice[!koalice$NAZEVZAST=="Kuřim", ]
koalice <- koalice[!koalice$NAZEVZAST=="Přeštice", ]
koalice <- koalice[!koalice$NAZEVZAST=="Nýřany", ]

write.csv(koalice, "koalice4.csv", row.names = F)

###

koalice <- read.csv("koalice4.csv")


### Kolik měst sledujeme?

length(unique(koalice$KODZASTUP))

### Kolik se jich už dohodlo na koalici?
koalice %>%
  filter(!OFICIALNI) %>%
  distinct(KODZASTUP)
