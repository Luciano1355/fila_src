000001040528     H*PARMS OPTION(*NOXREF)
000002040528     H*PARMS DFTACTGRP(*NO)
000003040528     H*PARMS ACTGRP(QILE)
000004040528     H*PARMS BNDDIR(PJGBND PJXBND)
000005040528     H*--------INIZIO SPECIFICHE H-----------------------------------*
000006040528     H DECEDIT('0,') DATEDIT(*DMY.)
000007040528      * Passaggio Parametri
000008110613     FVardes    UP   E           K DISK    rename(VARDES:VDES)
000009111003     Fanapf01l  UF   E           K DISK
000010111003     Fantcm01l  UF A E           K DISK
000011111003     Fanrcm01l  UF A E           K DISK
000012110613     FISANI01l  UF   E           K DISK
000013110613     D YSOC            S              3
000014110613     D uno             S              1  0
000015110613     D* Passaggio Parametri
000016110613     D KPJBA         E DS
000017110613A0740D ZDateISO        S               D
000018110613     D DATA            C                   CONST('0001-01-01')
0001001106131705  *---------------------------------------------------------                *
000117110613      /free
000118110613           If *in99 = '0' and not *in99 ;
000119110613              eval Ysoc = '001' ;
000120110613              eval *in99 = '1'  ;
000121110613           endif ;
000122110613           uno = *zeros ;
000123110613
000124110926          👍(❁´◡`❁)
000131110926
000132110926                 if deseste <> *blanks ;
000133110926                  chain (Ysoc: '011': codice) Antcm000 ;
000134110926                  if  %found(antcm01l);
000135110926                    doW not %eof(Antcm01l);
000136110713                     if tcmlin = '1' ;
000137110713                        tcmtxt = deseste ;
000138110713                        update antcm000 ;
000139110713                        uno =  2  ;
000140110713                        chain (TCMKCM ) Anrcm000 ;
000141110713                        if  %found(anrcm01l) ;
000142110713                         rcmtxt = deseste ;
000143110713                         update anRcm000 ;
000144110713                         uno =  4  ;
000145110713                        endif ;
000146110713                     endif ;
000147110713                    reade (Ysoc: '011': codice) Antcm000 ;
000148110713                   enddo;
000149111003                  endif ;
000150110713
000151110713                   if uno = 1 ;
000152110713                    uno =  3  ;
000153110713                    exsr repnum ;
000154110713                   endif ;
000155110926                 endif ;
000156110613
000157110613                 chain (Ysoc: codice) ISANI000 ;
000158110613                  if  %found(ISANI01l) ;
000159110926                    if desbreve <> *blanks ;
000160110613                      ANIDES = desbreve;
000161110613                      update isani000 ;
000162110926                    endif ;
000163110926                  endif ;
000164110613
000165111003
000166110613
000167110613                  eval f5 = uno ;
000168110613                  update VDES ;
000169110613                endif ;
000170110613
000171110613      /end-free
000172110613     C*---------------------------------------------------------
000173110613  "  C     *INZSR        BEGSR
000174110613     C     PNMR          PLIST
000175110613     C                   PARM                    XNMRIC            1
000176110613     C                   PARM                    XNMSOC            3
000177110613     C                   PARM                    XNMUNI            8
000178110613     C                   PARM                    XNMCTB            2
000179110613     C                   PARM                    XNMKEY            8
000180110613     C                   PARM                    XNMSER            4
000181110613     C                   PARM                    XNMCMT            1
000182110613     C                   PARM                    XNMDAT           10
000183110613     C                   PARM                    XNMIVA            1
000184110613     C                   PARM                    XNMREG            1
000185110613     C                   PARM                    XNMERR            1
000186110613     C                   PARM                    XNMNUM            9 0
000187110613     C                   PARM                    XNMAUT            1
000188110613  "  C     *DMY          Move      Udate         ZDateISO
000189110613  "  C     *JobRun       Move      ZDateISO      ZDate             6 0
000190110613A0740C                   ENDSR
000191110613A0281C*-----------------------------------------------------
000192110613     c     repnum        begsr
000200110613     C                   MOVE      '2'           XNMRIC
000300110613     C                   MOVE      Ysoc          XNMSOC
000400110613     C                   MOVE      *BLANKS       XNMUNI
000500110613     C                   MOVE      *BLANKS       XNMCTB
000600110613     C                   MOVE      *BLANKS       XNMKEY
000800110613a0871c                   MOVE      'TEXT'        XNMSER
000900110613     C                   MOVE      *OFF          XNMCMT
001000110613     C                   MOVE      *OFF          XNMIVA
001100110613     C                   MOVE      *OFF          XNMREG
001200110613     C* Data odierna
001600110613A0740C                   MOVEL     ZDate         XDTGMA
001700110613     C                   CALLb     'XDT4000'
001800110613     C                   PARM                    XDTAMG           10
001900110613     C                   PARM                    XDTGMA            6 0
002000110613     C                   PARM      4             XDTSTA            1 0
002100110613     C                   MOVE      XDTAMG        XNMDAT
002200110613     C*
002300110613     C                   CALLb     'XNMR'        PNMR
003801110613      ****
003803110613     C                   Z-ADD     XNMNUM        TCMKCM
003804110613     C                   MOVEL     KNMUS         TcmUteImm
003805110613a0871C                   MOVE      ZDATEISO      TCMDAT
003806110613     c                   exsr      ScriveTesC
003807110613     C                   WRITE     ANTCM000
003814110613      *  righe commenti dettaglio
003820110613     C                   Z-ADD     XNMNUM        RCMKCM
003822110613      *
003823110613     C                   EXSR      ScriveRig
003824110613      *
003825110613A0740C                   ENDSR
003900110613     C******************************************************
004000110613     C     ScriveTesC    BEGSR
004100110613     C                   MOVEL     deseste       TCMTXT
004101111005     C                   MOVEL     Ysoc          TCMSOCIETA
004300110613     c* imposta scrittura destinazioni
004400110613A0871c                   EXSR      RieDestin
005000110613     C                   MOVE      '1'           TCMLIN
005100110613     C                   MOVEL     '011'         TCMTPA
005200110613     C                   MOVEL     codice        TCMKY1
005300110613     C                   MOVEL     *blanks       TCMKY2
005400110613     C                   MOVEL     *blanks       TCMKY3
005500110613     C                   MOVEL     *blanks       TCMKY4
005700110613A0871C                   MOVE      ZDATEISO      TCMDTULMO
005800110613a0871c                   move      knmus         tcmUteUlmo
005900110613     C                   MOVE      DATA          TCMDTS
006100110613     C*
006200110613     c                   endsr
010700110613     C******************************************************
010800110613a0871C* riempie campi destinazioni del file antcm00f
010900110613     C******************************************************
011000110613     C     RieDestin     BEGSR
014100110613     C                   MOVEL     '10'          TCMDS1
014200110613     C                   MOVEL     '04'          TCMDS2
014300110613     C                   MOVEL     '02'          TCMDS3
014400110613     C                   MOVEL     '03'          TCMDS4
014500110613     C                   MOVEL     '  '          TCMDS5
014600110613     C                   MOVEL     '  '          TCMDS6
014800110613     c*
014900110613     c                   endsr
015100110613     C******************************************************
015200110613a0871C* scrive righe  commenti
015300110613     C******************************************************
015400110613     C     ScriveRig     BEGSR
015500110613     C*
016800110613     C                   Z-ADD     1             RCMNRG
016900110613     C                   MOVEL     deseste       RCMTXT
017000110613      *
017400110613a0871C                   MOVEL     TCMDS1        RCMds1
017800110613a0871C                   MOVEL     TCMDS2        RCMds2
018200110613a0871C                   MOVEL     TCMDS3        RCMds3
018600110613a0871C                   MOVEL     TCMDS4        RCMds4
019000110613a0871C                   MOVEL     TCMDS5        RCMds5
019400110613a0871C                   MOVEL     TCMDS6        RCMds6
022400110613     C                   WRITE     ANRCM000
022800110613     C*
022900110613     c                   endsr
