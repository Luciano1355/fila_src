000100040528     H*PARMS OPTION(*NOXREF)
000200040528     H*PARMS DFTACTGRP(*NO)
000300040528     H*PARMS ACTGRP(QILE)
000400040528     H*PARMS BNDDIR(PJGBND PJXBND)
000500040528     H*--------INIZIO SPECIFICHE H-----------------------------------*
000600040528     H DECEDIT('0,') DATEDIT(*DMY.)
000700040528      * Passaggio Parametri
000800130606     FMaimericodUP   E           K DISK    rename(maimericod:maimeri)
000900111003     Fantcm01l  UF A E           K DISK
001000111003     Fanrcm01l  UF A E           K DISK
001100110613     D YSOC            S              3
001200110613     D uno             S              1  0
001300130606     D codice          S             15
001400110613     D* Passaggio Parametri
001500110613     D KPJBA         E DS
001600110613A0740D ZDateISO        S               D
001700110613     D DATA            C                   CONST('0001-01-01')
0018001106131705  *---------------------------------------------------------                *
001900110613      /free
002000110613           If *in99 = '0'  ;
002100110613              eval Ysoc = '001' ;
002200110613              eval *in99 = '1'  ;
002300110613           endif ;
002400130606           uno = 1      ;
002500110613
002600130606              codice = cod ;
002700110926
002800130606                if estesa  <> *blanks ;
002900110926                  chain (Ysoc: '011': codice) Antcm000 ;
003000110926                  if  %found(antcm01l);
003100110926                    doW not %eof(Antcm01l);
003200130606                      if tcmlin = '1' ;
003300130606                        tcmtxt = estesa  ;
003400110713                        update antcm000 ;
003500110713                        uno =  2  ;
003600110713                        chain (TCMKCM ) Anrcm000 ;
003700110713                        if  %found(anrcm01l) ;
003800130606                         rcmtxt = estesa  ;
003900110713                         update anRcm000 ;
004000110713                         uno =  4  ;
004100110713                        endif ;
004200130606                      endif ;
004300130606                     reade (Ysoc: '011': codice) Antcm000 ;
004400130606                    enddo;
004500110713
004600130606                else   ;
004700130606
004800110713                    uno =  3  ;
004900110713                    exsr repnum ;
005000110926                 endif ;
005100130606                endif ;
005200110613
005300130606            //    eval przven = uno ;
005400130606                  update maimeri ;
005500110613
005600110613      /end-free
005700110613     C*---------------------------------------------------------
005800110613  "  C     *INZSR        BEGSR
005900110613     C     PNMR          PLIST
006000110613     C                   PARM                    XNMRIC            1
006100110613     C                   PARM                    XNMSOC            3
006200110613     C                   PARM                    XNMUNI            8
006300110613     C                   PARM                    XNMCTB            2
006400110613     C                   PARM                    XNMKEY            8
006500110613     C                   PARM                    XNMSER            4
006600110613     C                   PARM                    XNMCMT            1
006700110613     C                   PARM                    XNMDAT           10
006800110613     C                   PARM                    XNMIVA            1
006900110613     C                   PARM                    XNMREG            1
007000110613     C                   PARM                    XNMERR            1
007100110613     C                   PARM                    XNMNUM            9 0
007200110613     C                   PARM                    XNMAUT            1
007300110613  "  C     *DMY          Move      Udate         ZDateISO
007400110613  "  C     *JobRun       Move      ZDateISO      ZDate             6 0
007500110613A0740C                   ENDSR
007600110613A0281C*-----------------------------------------------------
007700110613     c     repnum        begsr
007800110613     C                   MOVE      '2'           XNMRIC
007900110613     C                   MOVE      Ysoc          XNMSOC
008000110613     C                   MOVE      *BLANKS       XNMUNI
008100110613     C                   MOVE      *BLANKS       XNMCTB
008200110613     C                   MOVE      *BLANKS       XNMKEY
008300110613a0871c                   MOVE      'TEXT'        XNMSER
008400110613     C                   MOVE      *OFF          XNMCMT
008500110613     C                   MOVE      *OFF          XNMIVA
008600110613     C                   MOVE      *OFF          XNMREG
008700110613     C* Data odierna
008800110613A0740C                   MOVEL     ZDate         XDTGMA
008900110613     C                   CALLb     'XDT4000'
009000110613     C                   PARM                    XDTAMG           10
009100110613     C                   PARM                    XDTGMA            6 0
009200110613     C                   PARM      4             XDTSTA            1 0
009300110613     C                   MOVE      XDTAMG        XNMDAT
009400110613     C*
009500110613     C                   CALLb     'XNMR'        PNMR
009600110613      ****
009700110613     C                   Z-ADD     XNMNUM        TCMKCM
009800110613     C                   MOVEL     KNMUS         TcmUteImm
009900110613a0871C                   MOVE      ZDATEISO      TCMDAT
010000110613     c                   exsr      ScriveTesC
010100110613     C                   WRITE     ANTCM000
010200110613      *  righe commenti dettaglio
010300110613     C                   Z-ADD     XNMNUM        RCMKCM
010400110613      *
010500110613     C                   EXSR      ScriveRig
010600110613      *
010700110613A0740C                   ENDSR
010800110613     C******************************************************
010900110613     C     ScriveTesC    BEGSR
011000130606     C                   MOVEL     estesa        TCMTXT
011100111005     C                   MOVEL     Ysoc          TCMSOCIETA
011200110613     c* imposta scrittura destinazioni
011300110613A0871c                   EXSR      RieDestin
011400110613     C                   MOVE      '1'           TCMLIN
011500110613     C                   MOVEL     '011'         TCMTPA
011600110613     C                   MOVEL     codice        TCMKY1
011700110613     C                   MOVEL     *blanks       TCMKY2
011800110613     C                   MOVEL     *blanks       TCMKY3
011900110613     C                   MOVEL     *blanks       TCMKY4
012000110613A0871C                   MOVE      ZDATEISO      TCMDTULMO
012100110613a0871c                   move      knmus         tcmUteUlmo
012200110613     C                   MOVE      DATA          TCMDTS
012300110613     C*
012400110613     c                   endsr
012500110613     C******************************************************
012600110613a0871C* riempie campi destinazioni del file antcm00f
012700110613     C******************************************************
012800110613     C     RieDestin     BEGSR
012900110613     C                   MOVEL     '10'          TCMDS1
013000110613     C                   MOVEL     '04'          TCMDS2
013100110613     C                   MOVEL     '02'          TCMDS3
013200110613     C                   MOVEL     '03'          TCMDS4
013300110613     C                   MOVEL     '  '          TCMDS5
013400110613     C                   MOVEL     '  '          TCMDS6
013500110613     c*
013600110613     c                   endsr
013700110613     C******************************************************
013800110613a0871C* scrive righe  commenti
013900110613     C******************************************************
014000110613     C     ScriveRig     BEGSR
014100110613     C*
014200110613     C                   Z-ADD     1             RCMNRG
014300130606     C                   MOVEL     estesa        RCMTXT
014400110613      *
014500110613a0871C                   MOVEL     TCMDS1        RCMds1
014600110613a0871C                   MOVEL     TCMDS2        RCMds2
014700110613a0871C                   MOVEL     TCMDS3        RCMds3
014800110613a0871C                   MOVEL     TCMDS4        RCMds4
014900110613a0871C                   MOVEL     TCMDS5        RCMds5
015000110613a0871C                   MOVEL     TCMDS6        RCMds6
015100110613     C                   WRITE     ANRCM000
015200110613     C*
015300110613     c                   endsr
