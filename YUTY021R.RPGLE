000100150805     H*--------------------------------------------------------------*
000200040528      * Passaggio Parametri
000300150805     Fcambio04  IF   E             DISK    rename(cambio04:cambio)
000400150805     Focliv00f  UF   E           K DISK    commit
000500150805     Fycnvstat  O    E             DISK
000600110613     D* Passaggio Parametri
000700110613     D KPJBA         E DS
000800140514     D ZDateISO        S               D
000900150805     d ysoc            S              3
001000150805     d Nroel           S              3  0
001100150805     d index           S              3  0
001200150805     d codold          S              4    DIM(200)
001300150805     d codnew          S              4    DIM(200)
001400140514      *---------------------------------------------------------                *
001500110613      /free
001600150805        // carico schiera
001700150805           read cambio   ;
001800150805            dow not %eof(cambio04) ;
001900150805               nroel += 1 ;
002000150805               codold(nroel) = idold  ;
002100150805               codnew(nroel) = idnew  ;
002200150805             read cambio ;
002300150805            enddo ;
002400140514
002500150805        // OCLIV00F
002600150805
002700150805               read  OCLIV000 ;
002800150805               dow not %eof(OCLIV00F) ;
002900150805             if livsoc = ysoc ;
003000150805               Index = %lookup(livst1:codold: 1) ;
003100150805
003200150805               If Index > *zero and livst1 <> *blanks ;
003300150805                livst1 = codnew(index) ;
003400150805            //    monitor ;
003500150805                   update ocliv000 ;
003600150805           //     on-error ;
003700150805           //      livst1 = codnew(index) ;
003800150805           //      %subst(livst1:1:1) = '9' ;
003900150805           //      update ocliv000 ;
004000150805             //   endmon ;
004100150805
004200150805                ycnvsoc = ysoc ;
004300150805                ycnvcod = livst2 ;
004400150805                ycnvold = codold(index) ;
004500150805                ycnvnew = livst1        ;
004600150805                write YCNVST   ;
004700150805               endif ;
004800150805               commit ;
004900150805             endif ;
005000150805               read  ocliv000 ;
005100150805               enddo  ;
005200150805
005300150805             *inlr = *on  ;
005400110613      /end-free
005500110613     C*---------------------------------------------------------
005600150805     c     *inzsr        begsr
005700150805     c     *entry        plist
005800150805     c                   parm                    kpjba
005900150805     c                   movel     kpjbu         ysoc
006000150805     c                   endsr
