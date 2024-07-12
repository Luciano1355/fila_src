000100040528     H*PARMS OPTION(*NOXREF)
000200040528     H*PARMS DFTACTGRP(*NO)
000300040528     H*PARMS ACTGRP(QILE)
000400040528     H*PARMS BNDDIR(PJGBND PJXBND)
000500040528     H*--------INIZIO SPECIFICHE H-----------------------------------*
000600040528     H DECEDIT('0,') DATEDIT(*DMY.)
000700040528      * Passaggio Parametri
000800120705     Fmfmoq00f  UP   E           K DISK
000900120705     Fanutn02l  IF   E           K DISK
001000110613     D* Passaggio Parametri
001100120705     d Utente          s              3
0012001106131705  *---------------------------------------------------------                *
001300120705     C                   movel     moqute        utente
001400110613      /free
001500120705               chain (utente  ) Anutn000 ;
001600120705                if  %found(anutn02l) ;
001700110926
001800120705                        moqutei = utnprf    ;
001900120705                        moqdaii = moqdai    ;
002000120705                        moqorii = moqori    ;
002100120705                     update mfmoq000 ;
002200120705                endif ;
002300110613
002400110613      /end-free
002500110613     C*---------------------------------------------------------
002600110613  "  C     *INZSR        BEGSR
002700110613A0740C                   ENDSR
002800110613A0281C*-----------------------------------------------------
