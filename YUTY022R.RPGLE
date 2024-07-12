000100150805     H*--------------------------------------------------------------*
000200040528      * Passaggio Parametri
000300150805     Fcambio04  IF   E             DISK    rename(cambio04:cambio)
000400150805     Fanreg01l  UF   E           K DISK
000500110613     D* Passaggio Parametri
000600110613     D KPJBA         E DS
000700140514     D ZDateISO        S               D
000800150805     d ysoc            S              3
000900150805     d Nroel           S              3  0
001000150805     d index           S              3  0
001100150805     d codold          S              4    DIM(200)
001200150805     d codnew          S              4    DIM(200)
001300150805     d regola          S              4
001400150805     d REGVALCNF       DS
001500150805     d  reg1                   1      4
001600150805     d  reg2                   6      9
001700150805     d  reg3                  11     14
001800150805     d  reg4                  16     19
001900150805     d  reg5                  21     24
002000150805     d  reg6                  26     29
002100150805     d  reg7                  31     34
002200150805     d  reg8                  36     39
002300140514      *---------------------------------------------------------                *
002400110613      /free
002500150805        // carico schiera
002600150805           read cambio   ;
002700150805            dow not %eof(cambio04) ;
002800150805               nroel += 1 ;
002900150805               codold(nroel) = idold  ;
003000150805               codnew(nroel) = idnew  ;
003100150805             read cambio ;
003200150805            enddo ;
003300140514
003400150805        // ANAPS01L
003500150805            setll (Ysoc) anreg000 ;
003600150805             if  %equal(anreg01l);
003700150805               reade (Ysoc) anreg000 ;
003800150805               dow not %eof(anreg01l) ;
003900150805               if REGCAMPO = 'APSCDSTA04' ;
004000150805                if reg1 <> *blanks ;
004100150805                 regola = reg1 ;
004200150805                 exsr ricerca ;
004300150805                 reg1 = regola ;
004400150805                endif  ;
004500150805                if reg2 <> *blanks ;
004600150805                 regola = reg2 ;
004700150805                 exsr ricerca ;
004800150805                 reg2 = regola ;
004900150805                endif  ;
005000150805                if reg3 <> *blanks ;
005100150805                 regola = reg3 ;
005200150805                 exsr ricerca ;
005300150805                 reg3 = regola ;
005400150805                endif  ;
005500150805                if reg4 <> *blanks ;
005600150805                 regola = reg4 ;
005700150805                 exsr ricerca ;
005800150805                 reg4 = regola ;
005900150805                endif  ;
006000150805                if reg5 <> *blanks ;
006100150805                 regola = reg5 ;
006200150805                 exsr ricerca ;
006300150805                 reg5 = regola ;
006400150805                endif  ;
006500150805                if reg6 <> *blanks ;
006600150805                 regola = reg6 ;
006700150805                 exsr ricerca ;
006800150805                 reg6 = regola ;
006900150805                endif  ;
007000150805                if reg7 <> *blanks ;
007100150805                 regola = reg7 ;
007200150805                 exsr ricerca ;
007300150805                 reg7 = regola ;
007400150805                endif  ;
007500150805                if reg8 <> *blanks ;
007600150805                 regola = reg8 ;
007700150805                 exsr ricerca ;
007800150805                 reg8 = regola ;
007900150805                endif  ;
008000150805               update anreg000 ;
008100150805               endif ;
008200150805
008300150805               reade (Ysoc) anreg000 ;
008400150805               enddo  ;
008500150805             endif ;
008600150805             *inlr = *on  ;
008700150805
008800150805        //*---------------------------------------------------------
008900150805         begsr  ricerca ;
009000150805                Index = %lookup(regola:codold: 1) ;
009100150805                If Index > *zero  ;
009200150805                regola = codnew(index) ;
009300150805                endif ;
009400150805         endsr ;
009500110613      /end-free
009600110613     C*---------------------------------------------------------
009700150805     c     *inzsr        begsr
009800150805     c     *entry        plist
009900150805     c                   parm                    kpjba
010000150805     c                   movel     kpjbu         ysoc
010100150805     c                   endsr
