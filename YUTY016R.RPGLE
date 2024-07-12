000100040528     H*PARMS OPTION(*NOXREF)
000200040528     H*PARMS DFTACTGRP(*NO)
000300040528     H*PARMS ACTGRP(QILE)
000400040528     H*PARMS BNDDIR(PJGBND PJXBND)
000500040528     H*--------INIZIO SPECIFICHE H-----------------------------------*
000600040528     H DECEDIT('0,') DATEDIT(*DMY.)
000700040528      * Passaggio Parametri
000800140514     FMainewcod UP   E           K DISK    rename(mainewcod:maimeri)
000900140514     Fanapf01l  iF A E           K DISK
001000140514     Fanapp01l  iF A E           K DISK
001100140514     Fanapg01l  iF A E           K DISK
001200140514     Fanaps01l  iF A E           K DISK
001300140514     Fanapc01l  iF A E           K DISK
001400140514     Fanaps$$l  iF   E           K DISK    rename(ANAPS000:ANAPS$$)
001500140514     F                                     prefix($)
001600110613     D YSOC            S              3
001700110613     D* Passaggio Parametri
001800110613     D KPJBA         E DS
001900140514     D ZDateISO        S               D
002000110613     D DATA            C                   CONST('0001-01-01')
002100140514      *---------------------------------------------------------                *
002200110613      /free
002300110613           If *in99 = '0'  ;
002400110613              eval Ysoc = '001' ;
002500110613              eval *in99 = '1'  ;
002600110613           endif ;
002700140514
002800140514                  chain (Ysoc: rad   ) Anaps$$  ;
002900140514                  if  %found(anaps$$l);
003000140514
003100140514        // ANAPF
003200140514                  chain (Ysoc: $apscod) Anapf000 ;
003300140514                  if  %found(anapf01l);
003400140514                    apfcod = art    ;
003500140530                    apfcoc = art    ;
003600140514                    apfdes = breve ;
003700140514                    apfdum = zdateiso ;
003800140514                    monitor ;
003900140514                    write anapf000 ;
004000140514                    on-error ;
004100140514                    endmon ;
004200140514                  endif ;
004300140514        // ANAPS
004400140514                  chain (Ysoc: $apscod) Anaps000 ;
004500140514                  if  %found(anaps01l);
004600140514                    apscod = art    ;
004700140514                    monitor ;
004800140514                    write anaps000 ;
004900140514                    on-error ;
005000140514                    endmon ;
005100140514                  endif ;
005200140514        // ANAPP
005300140514                  chain (Ysoc: $apscod) Anapp000 ;
005400140514                  if  %found(anapp01l);
005500140514                    appcod = art    ;
005600140514                    monitor ;
005700140514                    write anapp000 ;
005800140514                    on-error ;
005900140514                    endmon ;
006000140514                  endif ;
006100140514        // ANAPG
006200140514                  chain (Ysoc: $apscod) Anapg000 ;
006300140514                  if  %found(anapg01l);
006400140514                    apgcod = art    ;
006500140514                    monitor ;
006600140514                    write anapg000 ;
006700140514                    on-error ;
006800140514                    endmon ;
006900140514                  endif ;
007000140514        // ANAPC
007100140514                  clear ANAPC000  ;
007200140514                  APCSOC = Ysoc ;
007300140514                  APCCOD = art ;
007400140514                  APCBCO = ean13 ;
007500140514                  APCUMR = 'N' ;
007600140514                  APCTIPBCO = 'EAN13  ' ;
007700140514                  APCCAUINS = '1' ;
007800140514                  write anapc000 ;
007900140514                  APCBCO = ean13C;
008000140514                  APCTIPBCO = 'EAN13CF' ;
008100140514                  write anapc000 ;
008200110613
008300140514                  eval przven = 1   ;
008400130606                  update maimeri ;
008500140514                  endif ;
008600110613      /end-free
008700110613     C*---------------------------------------------------------
008800140514     C     *INZSR        BEGSR
008900140514     C     *DMY          Move      Udate         ZDateISO
009000140514     C     *JobRun       Move      ZDateISO      ZDate             6 0
009100140514     C                   ENDSR
009200140514     C*-----------------------------------------------------
