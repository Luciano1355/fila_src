000100040528     H*PARMS OPTION(*NOXREF)
000200040528     H*PARMS DFTACTGRP(*NO)
000300040528     H*PARMS ACTGRP(QILE)
000400040528     H*PARMS BNDDIR(PJGBND PJXBND)
000500040528     H*--------INIZIO SPECIFICHE H-----------------------------------*
000600040528     H DECEDIT('0,') DATEDIT(*DMY.)
000700120725      *
000800120725     Foatoa01l  iP   E           K DISK
000900120725     Foamoa04l  IF   E           K DISK
001000120725     D Data            S               D   datfmt(*ISO)
0011001207251705  *---------------------------------------------------------                *
001200120725     C                   move      '2012-01-01'  data
001300110613      /free
001400120725            if toador >= data        ;
001500120725             if toatpd = 'S1' or toatpd = 'S2' or
001600120725                toatpd = 'S3' or toatpd = 'S4' ;
001700120725               chain (Toasoc: Toanor ) Oamoa000 ;
001800120725                if not %found(oamoa04l) ;
001900110926
002000120725                       dsply toanor       ;
002100120705                endif ;
002200120725                endif ;
002300120725            endif ;
002400120725
002500110613      /end-free
002600110613     C*---------------------------------------------------------
002700110613  "  C     *INZSR        BEGSR
002800110613A0740C                   ENDSR
002900110613A0281C*-----------------------------------------------------
