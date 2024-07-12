000100040528     H*PARMS OPTION(*NOXREF)
000200140530     H*PARMS CVTOPT(*DATETIME)
000300040528     H*PARMS DFTACTGRP(*NO)
000400040528     H*PARMS ACTGRP(QILE)
000500040528     H*PARMS BNDDIR(PJGBND PJXBND)
000600040528     H*--------INIZIO SPECIFICHE H-----------------------------------*
000700040528     H DECEDIT('0,') DATEDIT(*DMY.)
000800040528      * Passaggio Parametri
000900140528     D Yuno            S              1  0
001000110613     D* Passaggio Parametri
001100140528     D Par_imput       PR                  EXTPGM('YUTY010R')
001200140530     D                               50
001300140528     D                                1
001400140528     D Par_imput       PI
001500140530     D   stringa                     50
001600140528     D   Ycheck                       1
001700140528
001800140528     D Ydigit          S              1  0
001900140528     D Ytota           S              3  0
002000140528     D Ytotb           S              3  0
002100140528     D Ytotc           S              3  0
002200140528     D Y               S              3  0
002300140530     D Ynumero         S              1  0
002400140530     D Ybarcod         s              1    DIM(17)
002500140530     D Ybarcode        s             17
0026001106131705  *---------------------------------------------------------                *
 02800140528        //*---------------------------------------------------*
002900140528        //* calcola check digit
003000140528        //*---------------------------------------------------*
003100140528
003200140528           ytota = *zeros ;
003300140528           ytotb = *zeros ;
003400140528           ytotc = *zeros ;
003500140530           ybarcode = stringa ;

003700140530        ybarcod = ybarcode ;     

003900140528           for y = 1 to 17;
004000140528
004100140528               if y = 2 or
004200140528                  y = 4 or
004300140528                  y = 6 or
004400140528                  y = 8 or
004500140528                  y = 10 or
004600140530                  y = 12 or
004700140530                  y = 14 or
004800140528                  y = 16  ;
004900140528
005000140530                ynumero =  %UNSH(ybarcod(y) ) ;
005100140530                ytota = ytota + ynumero     ;
005200140528
005300140528               else ;
005400140528
005500140530                ynumero =  %UNSH(ybarcod(y) ) ;
005600140530                ytotb = ytotb + ynumero     ;
005700140528
005800140528               endif ;
005900140528           endfor;
006000140528
006100140528            ytota = ytota * 3 ;
006200140528
006300140528            ytota = ytota + ytotb ;
006400140528
006500140528     c                   move      ytota         yuno
006600140528
006700140528            if yuno <> 0 ;
006800140528             ytotc = ytota + 10 ;
006900140528             else ;
007000140528             ytotc = Ytota ;
007100140528            endif ;
007200140528
007300140528
007400140528     c                   move      0             ytotc
007500140528 
007600140528            ydigit = ytotc - ytota ;
007700140528            ycheck = %char(ydigit) ;
007800140528            *inLR = *on ;
007900140528
008000140528     ***----------------------------------------------------
