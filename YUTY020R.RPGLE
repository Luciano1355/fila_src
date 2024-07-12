000100150805     H*--------------------------------------------------------------*
000200040528      * Passaggio Parametri
000300150805     Fcambio04  IF   E             DISK    rename(cambio04:cambio)
000400150805     Fanaps01l  UF   E           K DISK    commit
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
002500150805        // ANAPS01L
002600150805            setll (Ysoc) anaps000 ;
002700150805             if  %equal(anaps01l);
002800150805               reade (Ysoc) anaps000 ;
002900150805               dow not %eof(anaps01l) ;
003000150805
003100150805               Index = %lookup(apscdsta04:codold: 1) ;
003200150805
003300150805               If Index > *zero and apscdsta04 <> *blanks ;
003400150805                apscdsta04 = codnew(index) ;
003500150805                update anaps000 ;
003600150805
003700150805                ycnvsoc = ysoc ;
003800150805                ycnvcod = apscod ;
003900150805                ycnvold = codold(index) ;
004000150805                ycnvnew = codnew(index) ;
004100150805                write YCNVST   ;
004200150805               endif ;
004300150805               commit ;
004400150805               reade (Ysoc) anaps000 ;
004500150805               enddo  ;
004600150805             endif ;
004700150805             *inlr = *on  ;
004800110613      /end-free
004900110613     C*---------------------------------------------------------
005000150805     c     *inzsr        begsr
005100150805     c     *entry        plist
005200150805     c                   parm                    kpjba
005300150805     c                   movel     kpjbu         ysoc
005400150805     c                   endsr
