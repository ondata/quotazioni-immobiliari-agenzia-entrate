<!-- TOC -->

- [Introduzione](#introduzione)
- [Come abbiamo raccolto i dati](#come-abbiamo-raccolto-i-dati)
- [Note](#note)
- [appunti](#appunti)

<!-- /TOC -->

# Introduzione

L'Agenzia delle Entrate gestisce l'[**Osservatorio del Mercato immobiliare**](https://www.agenziaentrate.gov.it/wps/content/Nsilib/Nsi/Schede/FabbricatiTerreni/omi):

> Le quotazioni immobiliari semestrali individuano, per ogni delimitata zona territoriale omogenea (zona OMI) di ciascun comune, un intervallo minimo/massimo, per unità di superficie in euro a metro quadro.

Come ha scritto Patrizia Saggini [nella mailing list](https://groups.google.com/d/msg/spaghettiopendata/iS5D-5uM2W4/AuL0N32SDAAJ) di Spaghetti OpenData, l'agenzia mette a disposizione il servizio "Forniture dati OMI", che consente il **_download_ gratuito** - a partire dal 1° semestre 2016 - delle quotazioni immobiliari e dei volumi di compravendita (dettaglio comunale) dell'Osservatorio del Mercato immobiliare; per utilizzare questi dati, **è necessario citare la fonte**: "Agenzia Entrate - OMI". I dati sono **aggiornati semestralmente** e destinati agli **utenti registrati** di Fisconline ed Entratel.<br>
Vengono resi **disponibili in formato CSV**.

La modalità di pubblicazione ricorda la licenza [Creative Commons Attribuzione](http://creativecommons.org/licenses/by/4.0/), ma non lo è, perché non è specificato se sia possibile farne un uso anche commerciale (lo chiederemo).

Abbiamo creato questo _repository_ per:

- **renderli disponibili** anche a **chi non è registrato** (**fonte "Agenzia Entrate - OMI"**);
- pubblicarli in modo che siano **pronti all'uso**. Di base lo sono poco per queste principali ragioni:
  - contengono **una riga di intestazione "inutile"**, che serve soltanto come didascalia;
  - hanno un **separatore di campo a fine linea errato**, ma nei CSV (si vedano le [spefiche](https://tools.ietf.org/html/rfc4180)) non ci deve essere: _The last field in the record must not be followed by a comma_;
  - **non è dichiarato l'_encoding_**. Ne abbiamo fatto l'_inferencing_ e sembra che sia più d'uno; pertanto sono stati tutti impostati come `UTF-8`;
  - sono **divisi in file semestrali da inizio 2016**, divisi in due categorie (le zone OMI e i valori), quindi 12 file. **Ne abbiamo creato soltanto due**, un per ogni categoria.

# Come abbiamo raccolto i dati

Per richiederli - grazie alle [note di Carlo](https://groups.google.com/d/msg/spaghettiopendata/iS5D-5uM2W4/8JH4xgw7BwAJ) - occorre aprire la pagina <https://telematici.agenziaentrate.gov.it/Main/index.jsp> e autenticarsi.<br>
Una volta fatto, fare click su "Servizi ipotecari e catastali, Osservatorio Mercato Immobiliare" (tra i servizi presenti nel box nella parte sinistra della pagina), poi click sulla sottovoce "Forniture OMI - Quotazioni Immobiliari" e da lì è possibile fare le richieste per comune, regione o per l'intero territorio nazionale.<br>
Abbiamo richiesto quelle per l'intero territorio.

Per dettagli sui dati si può fare riferimento alla pagina dedicata dell'Agenzia "[Manuali e guide](https://www.agenziaentrate.gov.it/wps/content/Nsilib/Nsi/Schede/FabbricatiTerreni/omi/Manuali+e+guide/?page=schedefabbricatieterreni)".


# Note

- nei file delle zone nel campo `Zona_Descr` ci sono inutili apici singoli a inizio e fine cella;

# appunti

- lfs per i due file;
- no traciatto record
- campo `Sez` sempre nullo nei file delle zone
- fatto il merge dei file
- inserito nome file sorgernte 