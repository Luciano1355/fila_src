000100040528     H*PARMS OPTION(*NOXREF)
000200040528     H*PARMS DFTACTGRP(*NO)
000300040528     H*PARMS ACTGRP(QILE)
000400040528     H*PARMS BNDDIR(PJGBND PJXBND)
000500040528     H*--------INIZIO SPECIFICHE H-----------------------------------*
000600040528     H DECEDIT('0,') DATEDIT(*DMY.)
000700040528      * Passaggio Parametri
000800140514     FMainewcod UP   E           K DISK    rename(mainewcod:maimeri)
000900140514     Fancma01l  iF A E           K DISK
001000140514     Fanaps$$l  iF   E           K DISK    rename(ANAPS000:ANAPS$$)
001100140514     F                                     prefix($)
001200110613     D YSOC            S              3
001300140514     D Ymag            S              3    inz('03')
001400110613     D* Passaggio Parametri
001500110613     D KPJBA         E DS
001600140514     D ZDateISO        S               D
001700110613     D DATA            C                   CONST('0001-01-01')
001800140514      *---------------------------------------------------------                *
001900110613      /free
002000110613           If *in99 = '0'  ;
002100110613              eval Ysoc = '001' ;
002200110613              eval *in99 = '1'  ;
002300110613           endif ;
002400140514
002500140514                  chain (Ysoc: rad   ) Anaps$$  ;
002600140514                  if  %found(anaps$$l);
002700140514
002800140514        // ANAPF
002900140514                  chain (Ysoc: $apscod: ymag) Ancma000 ;
003000140514                  if  %found(ancma01l);
003100140514                    CMACOD = art    ;
003200140514                    monitor ;
003300140514                    write ancma000 ;
003400140514                    on-error ;
003500140514                    endmon ;
003600140514                  endif ;
003700110613
003800140514                  eval przven = 1   ;
003900130606                  update maimeri ;
004000140514                  endif ;
004100110613      /end-free
004200110613     C*---------------------------------------------------------
004300140514     C     *INZSR        BEGSR
004400140514     C     *DMY          Move      Udate         ZDateISO
004500140514     C     *JobRun       Move      ZDateISO      ZDate             6 0
004600140514     C                   ENDSR
004700140514     C*-----------------------------------------------------
