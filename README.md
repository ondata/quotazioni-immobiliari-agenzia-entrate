<!-- TOC -->

- [Introduzione](#introduzione)
- [Come sono stati raccolti i dati](#come-sono-stati-raccolti-i-dati)
- [La struttura di questo repository](#la-struttura-di-questo-repository)
- [Anteprima dei dati](#anteprima-dei-dati)
    - [Zone](#zone)
    - [Risorse](#risorse)
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

# Anteprima dei dati

## Zone

| Area_territoriale | Regione | Prov | Comune_ISTAT | Comune_cat | Sez | Comune_amm | Comune_descrizione | Fascia | Zona_Descr | Zona | LinkZona | Cod_tip_prev | Descr_tip_prev | Stato_prev | Microzona | file |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| SUD | CALABRIA | RC | 18080081 | T1DZ |   | I333 | S EUFEMIA D'ASPROMONTE | D | PIAZZA XXVII OTTOBRE, CORSO MAGGIORE CUTRI', VIA BONSERVIZIO, PIAZZA TITO MINNITI, SS. 112. | D1 | RC00004174 | 21 | Abitazioni di tipo economico | N | 1 | QI_294586_1_20161_ZONE_utf8.csv |
| NORD-EST | VENETO | VR | 5023064 | D6DH |   | H540 | RONCO ALL`ADIGE | R | TERRITORIO RURALE A SCARSA DENSITA EDIFICATORIA | R1 | VR00001013 | 0 | Non presente |  | 0 | QI_294586_1_20161_ZONE_utf8.csv |
| NORD-OVEST | LOMBARDIA | CO | 3013075 | C4AA |   | C933 | COMO | D | RESIDENZIALE PEDEMONTANA - ZONE DI CIVIGLIO E CAMNAGO VOLTA | D1 | CO00000045 | 20 | Abitazioni civili | N | 4 | QI_294577_1_20182_ZONE_utf8.csv |
| CENTRO | MARCHE | MC | 11043007 | K3AH |   | B474 | CAMERINO | D | ADIACENZE CENTRO STORICO: LOCALITA LE MOSSE,LE CONCE,S.GIORGIO,S.PAOLO,MONTAGNAN | D1 | MC00001692 | 20 | Abitazioni civili | N | 1 | QI_294583_1_20162_ZONE_utf8.csv |
| CENTRO | MARCHE | PS | 11041028 | K4BL |   | F347 | MONDAVIO | R | ZONA AGRICOLA COLLINARE MEDIAMENTE INSEDIATA CON BORGHI SPARSI | R1 | PS00001471 | 0 | Non presente |  | 0 | QI_294577_1_20182_ZONE_utf8.csv |
| NORD-EST | EMILIA-ROMAGNA | PC | 8033007 | H6AI |   | B332 | CADEO | R | RIMANENTE PARTE DEL TERRITORIO CON FRAZIONI E FABBRICATI SPARSI | R1 | PC00001204 | 101 | Seminativo |  | 2 | QI_294586_1_20161_ZONE_utf8.csv |
| ISOLE | SICILIA | AG | 19084020 | U2AU |   | E431 | LAMPEDUSA E LINOSA | E | CONTRADA CALA CRETA, PARTE DELLE CONTRADE CALA PISANA , GRECALE | E4 | AG00001224 | 1 | Ville e Villini | N | 0 | QI_294581_1_20172_ZONE_utf8.csv |
| CENTRO | UMBRIA | PG | 10054038 | L1CK |   | G359 | PASSIGNANO S TRASIMENO | D | PERIFERIA | D1 | PG00000373 | 20 | Abitazioni civili | N | 1 | QI_294583_1_20162_ZONE_utf8.csv |
| NORD-EST | VENETO | VE | 5027011 | D1AP |   | C950 | CONCORDIA SAGITTARIA | D | ZONA ARTIGIANALE LEVADA - GIUSTO | D3 | VE00001509 | 8 | Capannoni industriali | N | 0 | QI_294577_1_20182_ZONE_utf8.csv |
| ISOLE | SICILIA | CT | 19087041 | U4BU |   | H922 | SAN GIOVANNI LA PUNTA | D | PERIFERIA A RIDOSSO DEL CENTRO STORICO:D`ACQISTO,CROCIFISSO,MORGIONI,DONIZZETTI,CARUSO | D4 | CT00002635 | 20 | Abitazioni civili | N | 4 | QI_294586_1_20161_ZONE_utf8.csv |

## Valori

| Area_territoriale | Regione | Prov | Comune_ISTAT | Comune_cat | Sez | Comune_amm | Comune_descrizione | Fascia | Zona | LinkZona | Cod_Tip | Descr_Tipologia | Stato | Stato_prev | Compr_min | Compr_max | Sup_NL_compr | Loc_min | Loc_max | Sup_NL_loc | file |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| NORD-OVEST | PIEMONTE | AL | 1006103 | A2FT |   | F403 | MONTALDEO | B | B1 | AL00003751 | 9 | Magazzini | NORMALE | P | 320 | 400 | L | 1,5 | 1,8 | L | QI_294577_1_20182_VALORI_utf8.csv |
| CENTRO | LAZIO | FR | 12060085 | M2DL |   | L780 | VEROLI | D | D1 | FR00000410 | 13 | Box | NORMALE | P | 500 | 600 | L | 1,7 | 2,5 | N | QI_294577_1_20182_VALORI_utf8.csv |
| NORD-EST | FRIULI-VENEZIA GIULIA | UD | 6030103 | F6FN |   | I092 | SAN PIETRO AL NATISONE | R | R1 | UD00002905 | 13 | Box | NORMALE | P | 250 | 375 | L | 1 | 1,5 | L | QI_294577_1_20182_VALORI_utf8.csv |
| NORD-EST | VENETO | VE | 5027033 | D1BR |   | H823 | SAN DONA` DI PIAVE | D | D1 | VE00001553 | 5 | Negozi | OTTIMO | P | 1200 | 1700 | L | 0 | 0 |  | QI_294583_1_20162_VALORI_utf8.csv |
| SUD | MOLISE | CB | 14070078 | P1DW |   | L113 | TERMOLI | E | E1 | CB00000336 | 20 | Abitazioni civili | NORMALE | P | 940 | 1400 | L | 3 | 4,3 | L | QI_294586_1_20161_VALORI_utf8.csv |
| NORD-EST | EMILIA-ROMAGNA | MO | 8036044 | H4BT |   | I802 | SOLIERA | E | E3 | MO00002882 | 20 | Abitazioni civili | NORMALE | P | 900 | 1300 | L | 3,9 | 5,5 | N | QI_294581_1_20172_VALORI_utf8.csv |
| ISOLE | SARDEGNA | OR | 20095071 | V4CV |   | L991 | VILLANOVA TRUSCHEDU | B | B1 | OR00001020 | 7 | Capannoni tipici | NORMALE | P | 120 | 180 | L | ,6 | ,8 | L | QI_294583_1_20162_VALORI_utf8.csv |
| SUD | CALABRIA | RC | 18080006 | T1AG |   | A544 | BAGALADI | R | R1 | RC00004567 | 7 | Capannoni tipici | NORMALE | P | 250 | 300 | L | 1,3 | 1,6 | L | QI_294581_1_20172_VALORI_utf8.csv |
| CENTRO | TOSCANA | AR | 9051026 | I2BC |   | F656 | MONTEVARCHI | D | D1 | AR00000624 | 8 | Capannoni industriali | NORMALE | P | 300 | 480 | L | 1,7 | 2,3 | N | QI_294582_1_20171_VALORI_utf8.csv |
| NORD-EST | VENETO | BL | 5025063 | D2CN |   | L590 | VALLE DI CADORE | B | B1 | BL00001163 | 10 | Laboratori | NORMALE | P | 255 | 365 | L | 2,6 | 3,9 | L | QI_294582_1_20171_VALORI_utf8.csv |

# Note

Purtroppo sembra non sia possibile scaricare in blocco (li chiederemo), per tutto il territorio, i file cartografici delle zone. Questo limita l'utilizzo in termini di analisi di questi dati.

Una licenza non chiaramente definita è un limite all'utilizzo.

Sono dati che dovrebbero essere pubblicati nel portale nazionale italiano sui dati aperti; ma ovviamente dopo avergli applicato una licenza adeguata.