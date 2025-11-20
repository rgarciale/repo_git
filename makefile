BIN_LIB=DEV
APP_BNDDIR=
LIBL=$(BIN_LIB)

INCDIR=""
BNDDIR=*NONE
PREPATH=/QSYS.LIB/$(BIN_LIB).LIB
SHELL=/QOpenSys/usr/bin/qsh

all: .logs .evfevent library $(PREPATH)/HOLAM.PGM


.logs:
	mkdir .logs
.evfevent:
	mkdir .evfevent
library:
	-system -q "CRTLIB LIB($(BIN_LIB))"


$(PREPATH)/HOLAM.PGM: qsrcpgm/hola_mundo_desdeVSCODE.pgm.rpgle
	liblist -c $(BIN_LIB);\
	liblist -a $(LIBL);\
	system "CRTBNDRPG PGM($(BIN_LIB)/HOLAM) SRCSTMF('qsrcpgm/hola_mundo_desdeVSCODE.pgm.rpgle') OPTION(*EVENTF) DBGVIEW(*SOURCE) TGTRLS(*CURRENT) TGTCCSID(*JOB) BNDDIR($(APP_BNDDIR)) DFTACTGRP(*NO)" > .logs/holam.splf || \
	(system "CPYTOSTMF FROMMBR('$(PREPATH)/EVFEVENT.FILE/HOLAM.MBR') TOSTMF('.evfevent/holam.evfevent') DBFCCSID(*FILE) STMFCCSID(1208) STMFOPT(*REPLACE)"; $(SHELL) -c 'exit 1')


$(PREPATH)/HOLAMUNDO.MODULE: qsrcpgm/holamundo.rpgle
	liblist -c $(BIN_LIB);\
	liblist -a $(LIBL);\
	system "CRTRPGMOD MODULE($(BIN_LIB)/HOLAMUNDO) SRCSTMF('qsrcpgm/holamundo.rpgle') OPTION(*EVENTF) DBGVIEW(*SOURCE) TGTRLS(*CURRENT) TGTCCSID(*JOB)" > .logs/holamundo.splf || \
	(system "CPYTOSTMF FROMMBR('$(PREPATH)/EVFEVENT.FILE/HOLAMUNDO.MBR') TOSTMF('.evfevent/holamundo.evfevent') DBFCCSID(*FILE) STMFCCSID(1208) STMFOPT(*REPLACE)"; $(SHELL) -c 'exit 1')












$(PREPATH)/%.BNDDIR: 
	-system -q "CRTBNDDIR BNDDIR($(BIN_LIB)/$*)"
	-system -q "ADDBNDDIRE BNDDIR($(BIN_LIB)/$*) OBJ($(patsubst %.SRVPGM,(*LIBL/% *SRVPGM *IMMED),$(notdir $^)))"




