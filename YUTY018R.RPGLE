000100040528     H*PARMS OPTION(*NOXREF)
000200040528     H*PARMS DFTACTGRP(*NO)
000300040528     H*PARMS ACTGRP(QILE)
000400040528     H*PARMS BNDDIR(PJGBND PJXBND)
000500040528     H*--------INIZIO SPECIFICHE H-----------------------------------*
000600040528     H DECEDIT('0,') DATEDIT(*DMY.)
000700040528      * Passaggio Parametri
000800140514     FMainewcod UP   E           K DISK    rename(mainewcod:maimeri)
000900140514     Foalia01l  iF A E           K DISK
001000110613     D YSOC            S              3
001100110613     D* Passaggio Parametri
001200110613     D KPJBA         E DS
001300140514     D ZDateISO        S               D
001400140514     D DATA            C                   CONST('9999-12-31')
001500140514      *---------------------------------------------------------                *
001600110613      /free
001700110613           If *in99 = '0'  ;
001800110613              eval Ysoc = '001' ;
001900110613              eval *in99 = '1'  ;
002000110613           endif ;
002100140514
002200140514        // OALIA
002300140514                  clear oalia000  ;
002400140514                  LIASOC = Ysoc   ;
002500140514                  LIALIS = '01'   ;
002600140514                  LIAVAL = 'EUR'  ;
002700140514                  LIAFOR = '00054477' ;
002800140514                  LIACOD = ART   ;
002900140514                  LIAUMA = 'N'    ;
003000140514                  LIAPRZ = PRZACQ ;
003100140514                  LIASC1 = 0      ;
003200140514                  LIASC2 = 0      ;
003300140514                  LIASC3 = 0      ;
003400140514                  LIASC4 = 0      ;
003500140514                  LIASCQ = 0      ;
003600140514                  LIADAI = zdateiso ;
003700140514                  LIADAF = *hival       ;
003800140514                  LIAFIL = 0      ;
003900140514                  monitor ;
004000140514                  write oalia000 ;
004100140514                  eval przven = 1   ;
004200140514                  update maimeri ;
004300140514                  on-error  ;
004400140514                  endmon ;
004500110613      /end-free
004600110613     C*---------------------------------------------------------
004700140514     C     *INZSR        BEGSR
004800140514     C     *DMY          Move      Udate         ZDateISO
004900140514     C     *JobRun       Move      ZDateISO      ZDate             6 0
005000140514     C                   ENDSR
005100140514     C*-----------------------------------------------------
