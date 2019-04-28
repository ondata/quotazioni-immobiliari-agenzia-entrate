<!-- TOC -->

- [Introduzione](#introduzione)
- [Come sono stati raccolti i dati](#come-sono-stati-raccolti-i-dati)
- [La struttura di questo repository](#la-struttura-di-questo-repository)
- [Note](#note)

<!-- /TOC -->

# Introduzione

L'Agenzia delle Entrate gestisce l'[**Osservatorio del Mercato immobiliare**](https://www.agenziaentrate.gov.it/wps/content/Nsilib/Nsi/Schede/FabbricatiTerreni/omi):

> Le quotazioni immobiliari semestrali individuano, per ogni delimitata zona territoriale omogenea (zona OMI) di ciascun comune, un intervallo minimo/massimo, per unità di superficie in euro a metro quadro.

Come ha scritto [Patrizia Saggini](https://twitter.com/patriziasaggia) nella [mailing list](https://groups.google.com/d/msg/spaghettiopendata/iS5D-5uM2W4/AuL0N32SDAAJ) di Spaghetti OpenData, l'agenzia mette a disposizione il servizio "Forniture dati OMI", che consente il **_download_ gratuito** - a partire dal 1° semestre 2016 - delle quotazioni immobiliari e dei volumi di compravendita (dettaglio comunale) dell'Osservatorio del Mercato immobiliare; per utilizzare questi dati, **è necessario citare la fonte**: "Agenzia Entrate - OMI". I dati sono **aggiornati semestralmente** e destinati agli **utenti registrati** di Fisconline ed Entratel.<br>
Vengono resi **disponibili in formato CSV**.

La modalità di pubblicazione ricorda un po' la licenza [Creative Commons Attribuzione](http://creativecommons.org/licenses/by/4.0/), ma in realtà è cosa diversa: non è infatti una licenza aperta, perché non è specificato se sia possibile farne un uso anche commerciale (lo chiederemo).

Abbiamo creato questo _repository_ per:

- **rendere disponibili** i dati sulle "**Quotazioni Immobiliari**" anche a **chi non è registrato** (**fonte "Agenzia Entrate - OMI"**);
- pubblicarli in modo che siano **pronti all'uso**. Non lo sono per queste principali ragioni:
  - contengono **una riga di intestazione "inutile"**, che serve soltanto come didascalia;
  - hanno un **separatore di campo a fine linea errato**, ma nei CSV (si vedano le [spefiche](https://tools.ietf.org/html/rfc4180)) non ci deve essere: _The last field in the record must not be followed by a comma_;
  - **non è dichiarato l'_encoding_**. Ne abbiamo fatto l'_inferencing_ e sembra che sia più d'uno; pertanto sono stati tutti impostati come `UTF-8`;
  - sono **divisi in file semestrali** a partire **da inizio 2016**, distribuiti sue due categorie (le zone OMI e i valori), per un totale di 12 file. **Li abbiamo riuniti in 2**, uno per ogni categoria.

# Come sono stati raccolti i dati

Per richiederli - grazie alle [note di Carlo](https://groups.google.com/d/msg/spaghettiopendata/iS5D-5uM2W4/8JH4xgw7BwAJ) - occorre aprire la pagina <https://telematici.agenziaentrate.gov.it/Main/index.jsp> e autenticarsi.<br>
Una volta fatto, fare _click_ su "Servizi ipotecari e catastali, Osservatorio Mercato Immobiliare" (tra i servizi presenti nel box nella parte sinistra della pagina), poi _click_ sulla sottovoce "Forniture OMI - Quotazioni Immobiliari" e da lì infine è possibile fare le richieste per comune, regione o per l'intero territorio nazionale.<br>
Abbiamo richiesto quelle per l'intero territorio.

Per i dettagli sui dati si può fare riferimento alla pagina dedicata dell'Agenzia ["Manuali e guide"](https://www.agenziaentrate.gov.it/wps/content/Nsilib/Nsi/Schede/FabbricatiTerreni/omi/Manuali+e+guide/?page=schedefabbricatieterreni).

# La struttura di questo repository

È diviso in queste sottcartelle:

- [`rawData`](./rawData), che contiene i file "grezzi", così come scaricati dal sito dell'Ageniza;
- [`doc`](./doc), con i file di documentazione scaricati dalla pagina ufficiale ["Manuali e guide"](https://www.agenziaentrate.gov.it/wps/content/Nsilib/Nsi/Schede/FabbricatiTerreni/omi/Manuali+e+guide/?page=schedefabbricatieterreni);
- [`data`](./doc), con i dati da noi rielaborati.

I file CSV originali sono stati così rielaborati:

- _encoding_ impostato a `UTF-8`;
- rimosse intestazioni inutili e separatore di campo inserito erroneamente a fine linea;
- nei file delle zone, nel campo `Zona_Descr` è presente un apice singolo a inizio e fine cella. È stato rimosso, perché inutile e potrebbe dare dei problemi in lettura;
- è stato fatta l'unione dei 6 file delle "Zone OMI" e dei 6 per i "Valori" in due file ([zone.7z](./data/zone.7z) e [valori.7z]((./data/valori.7z))); quello sui valori è un file di circa 1 milione di righe. A questi è stata aggiunta la colonna `file` per poter risalire ad anno e semestre di ogni riga.

Nella radice c'è uno _script_ bash ([`zoneOMI.sh`](./zoneOMI.sh)), in cui viene effettuata la trasformazione dai file "grezzi" originali a quelli da noi rielaborati.

# Note

Purtroppo sembra non sia possibile scaricare in blocco (li chiederemo), per tutto il territorio, i file cartografici delle zone. Questo limita l'utilizzo in termini di analisi di questi dati.

Una licenza non chiaramente definita è un limite all'utilizzo.

Sono dati che dovrebbero essere pubblicati nel portale nazionale italiano sui dati aperti; ma ovviamente dopo avergli applicato una licenza adeguata