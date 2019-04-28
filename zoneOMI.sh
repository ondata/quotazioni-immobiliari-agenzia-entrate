#!/bin/bash

### requisiti ###
# unzip
# fd https://github.com/sharkdp/fd
# chardet https://github.com/chardet/chardet
# Miller https://github.com/johnkerl/miller
### requisiti ###

set -x

folder="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
mkdir -p "$folder"/rawData
mkdir -p "$folder"/data

# unzippa tutto
rm "$folder"/rawData/*.csv
rm "$folder"/data/*ZONE_utf8.csv
rm "$folder"/data/*VALORI_utf8.csv
cd "$folder"/rawData/
fd -e zip -x unzip {}

# estrai encoding
rm "$folder"/rawData/encoding.txt
for i in *.csv; do 
    chardetect "$i" >>"$folder"/rawData/encoding.txt
done
perl -p -i -e 's|^(.+?): (.+?) (.+?)$|\1\t\2|g' "$folder"/rawData/encoding.txt
sed -i -r 's/\.csv//g' "$folder"/rawData/encoding.txt

# a partire dalla mappatura dell'enconding dei file sorgente, crea copia file con enconding in UTF-8
while IFS=$'\t' read -r nomefile encoding; do
    iconv -f "$encoding" -t UTF-8 "$folder"/rawData/"$nomefile".csv > "$folder"/rawData/"$nomefile"_utf8.csv
done < "$folder"/rawData/encoding.txt

cd "$folder"/rawData/
for i in *_utf8*.csv; do
    # rimuovi il separatore messo a fine linea, è errato
    sed -i -r 's/^(.*);$/\1/g' "$i"
    # rimuovi riga di intestazione superflua
    sed -i 1d "$i"
    # cambia il separatore da ";" a ","
    mlr -I --csv --ifs ";" cat "$i"
done

# fai pulizia nella cartella rawData
mv "$folder"/rawData/*_utf8*.csv "$folder"/data
rm "$folder"/rawData/*.csv


# crea file di insieme per le zone e rimuovi apici singoli a inizio e fine cella nel campo Zona_Descr
mlr --csv put '$file=FILENAME;$Zona_Descr=gsub($Zona_Descr,"^'\''","");$Zona_Descr=gsub($Zona_Descr,"'\''$","")' "$folder"/data/*ZONE_utf8.csv  >"$folder"/data/zone.csv
# crea file di insieme per i valori
mlr --csv put '$file=FILENAME' "$folder"/data/*VALORI_utf8.csv  >"$folder"/data/valori.csv

