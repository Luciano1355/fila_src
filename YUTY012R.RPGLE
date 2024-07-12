000001040528     H*PARMS OPTION(*NOXREF)
000002040528     H*PARMS DFTACTGRP(*NO)
000003040528     H*PARMS ACTGRP(QILE)
000004040528     H*PARMS BNDDIR(PJGBND PJXBND)
000005040528     H*--------INIZIO SPECIFICHE H-----------------------------------*
000006040528     H DECEDIT('0,') DATEDIT(*DMY.)
000007040528      * Passaggio Parametri
000008120606     FYcertlegnoIP   E           K DISK    rename(Ycertlegno:Ylegno)
000009120606     Fanapf01l  IF   E           K DISK
000010120606     Fanaum01l  UF A E           K DISK
000015110613     D* Passaggio Parametri
000016110613     D KPJBA         E DS
000017110613A0740D ZDateISO        S               D
000018110613     D DATA            C                   CONST('0001-01-01')
000019120606     D YSOC            S              3
0001001106131705  *---------------------------------------------------------                *
000117110613      /free
000118110613           If *in99 = '0'  ;
000119110613              eval Ysoc = '001' ;
000120110613              eval *in99 = '1'  ;
000121110613           endif ;
000123110613
000124120606               chain (Ysoc: F1) Anapf000 ;
000125110613                if  %found(anapf01l) ;
000131110926
000133120606                  chain (Ysoc: apfcod: apfuma: 'LE') ANAUM000;
000134120606                  if  not %found(ANAUM01L);
000137120606                        AUMSOCIETA = ysoc;
000138120606                        AUMUNITA = *blanks;
000139120606                        AUMCODPROD = apfcod ;
000140120606                        AUMUMPART = apfuma ;
000141120606                        AUMUMARR = 'LE';
000142120606                        AUMCOEFF = f6     ;
000143120606                        AUMSEGNO = 'X'   ;
000146120606                     write anaum000 ;
000149111003                  endif ;
000150110713
000151120606                endif ;
000170110613
000171110613      /end-free
000172110613     C*---------------------------------------------------------
000173110613  "  C     *INZSR        BEGSR
000188110613  "  C     *DMY          Move      Udate         ZDateISO
000189110613  "  C     *JobRun       Move      ZDateISO      ZDate             6 0
000190110613A0740C                   ENDSR
000191110613A0281C*-----------------------------------------------------
