//****************************************************************
//   CPLUS2\SCAN_C.FRM
//   Coco/R C++ Support Frames.
//   Author: Frankie Arzu <farzu@uvg.edu.gt>
//
//   Jun 12, 1996  Version 1.06
//      Many fixes and suggestions thanks to
//      Pat Terry <p.terry@.ru.ac.za>
//   Oct 31, 1999  Version 1.14
//      LeftContext Support
//   Mar 24, 2000  Version 1.15
//      LeftContext Support no longer needed
//****************************************************************

/*************** NOTICE *****************
	This file is generated by cocoR       
*****************************************/
	
//#include "cc.h"
#include "cs.h"
//
#define Scan_Ch        Ch
#define Scan_NextCh    NextCh
#define Scan_ComEols   ComEols
#define Scan_CurrLine  CurrLine
#define Scan_CurrCol   CurrCol
#define Scan_LineStart LineStart
#define Scan_BuffPos   BuffPos
#define Scan_NextLen   NextSym.Len

int cScanner::STATE0[] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
                  0,0,0,52,24,35,0,54,66,26,38,39,53,47,42,49,46,33,36,2,2,2,2,2,2,2,2,2,45,82,
                  30,61,56,71,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
                  1,40,0,41,67,1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
                  1,1,1,43,68,44,51,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
                  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
                  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
                  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
                  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};

int cScanner::CheckLiteral(int id)
{ char c;
  c =  CurrentCh(NextSym.Pos);
  if (IgnoreCase) c = Upcase(c);
  switch (c) {
  	case '/':
  		if (EqualStr("/=")) return C_SlashEqualSym;
  		break;
  	case 'b':
  		if (EqualStr("break")) return C_breakSym;
  		break;
  	case 'c':
  		if (EqualStr("continue")) return C_continueSym;
  		if (EqualStr("case")) return C_caseSym;
  		if (EqualStr("catch")) return C_catchSym;
  		break;
  	case 'd':
  		if (EqualStr("delete")) return C_deleteSym;
  		if (EqualStr("do")) return C_doSym;
  		if (EqualStr("default")) return C_defaultSym;
  		break;
  	case 'e':
  		if (EqualStr("else")) return C_elseSym;
  		break;
  	case 'f':
  		if (EqualStr("false")) return C_falseSym;
  		if (EqualStr("for")) return C_forSym;
  		if (EqualStr("finally")) return C_finallySym;
  		if (EqualStr("function")) return C_functionSym;
  		break;
  	case 'i':
  		if (EqualStr("instanceof")) return C_instanceofSym;
  		if (EqualStr("in")) return C_inSym;
  		if (EqualStr("if")) return C_ifSym;
  		if (EqualStr("import")) return C_importSym;
  		break;
  	case 'n':
  		if (EqualStr("null")) return C_nullSym;
  		if (EqualStr("new")) return C_newSym;
  		break;
  	case 'r':
  		if (EqualStr("return")) return C_returnSym;
  		break;
  	case 's':
  		if (EqualStr("switch")) return C_switchSym;
  		break;
  	case 't':
  		if (EqualStr("true")) return C_trueSym;
  		if (EqualStr("this")) return C_thisSym;
  		if (EqualStr("typeof")) return C_typeofSym;
  		if (EqualStr("throw")) return C_throwSym;
  		if (EqualStr("try")) return C_trySym;
  		break;
  	case 'v':
  		if (EqualStr("void")) return C_voidSym;
  		if (EqualStr("var")) return C_varSym;
  		break;
  	case 'w':
  		if (EqualStr("while")) return C_whileSym;
  		if (EqualStr("with")) return C_withSym;
  		break;
  
  }
  return id;
}

int cScanner::Comment()
{ int Level, StartLine, OldCol;
  long OldLineStart;

  Level = 1; StartLine = CurrLine;
  OldLineStart = LineStart; OldCol = CurrCol;
  if (Scan_Ch == '/') { /* 1 */
  	Scan_NextCh();
  	if (Scan_Ch == '*') { /* 2 */
  		Scan_NextCh();
  		while (1) {
  			if (Scan_Ch== '*') { /* 5 */
  				Scan_NextCh();
  				if (Scan_Ch == '/') { /* 6 */
  					Level--; Scan_NextCh(); Scan_ComEols = Scan_CurrLine - StartLine;
  					if(Level == 0) return 1;
  				} /* 6 */ 
  			} else /* 5 */
  			if (Scan_Ch == EOF_CHAR) return 0;
  			else Scan_NextCh();
  		} /* while */
  	} else { /* 2 */
  		if (Scan_Ch == LF_CHAR) { Scan_CurrLine--; Scan_LineStart = OldLineStart; }
  		Scan_BuffPos -= 2; Scan_CurrCol = OldCol - 1; Scan_NextCh();
  	} /* 2 */
  } /* 1*/
  
  return 0;
}

int cScanner::UpdateState()
{
    state = STATE0[Ch.to_byte()];
    while(1) {
      Scan_NextCh(); NextSym.Len++;
      switch (state) {
       /* State 0; valid STATE0 Table
      case 0:
      	if (Scan_Ch >= 'A' && Scan_Ch <= 'Z' ||
          Scan_Ch == '_' ||
          Scan_Ch >= 'a' && Scan_Ch <= 'z') state = 1; else
      	if (Scan_Ch >= '1' && Scan_Ch <= '9') state = 2; else
      	if (Scan_Ch == '0') state = 36; else
      	if (Scan_Ch == '"') state = 24; else
      	if (Scan_Ch == 39) state = 26; else
      	if (Scan_Ch == '<') state = 30; else
      	if (Scan_Ch == '/') state = 33; else
      	if (Scan_Ch == '#') state = 35; else
      	if (Scan_Ch == '(') state = 38; else
      	if (Scan_Ch == ')') state = 39; else
      	if (Scan_Ch == '[') state = 40; else
      	if (Scan_Ch == ']') state = 41; else
      	if (Scan_Ch == ',') state = 42; else
      	if (Scan_Ch == '{') state = 43; else
      	if (Scan_Ch == '}') state = 44; else
      	if (Scan_Ch == ':') state = 45; else
      	if (Scan_Ch == '.') state = 46; else
      	if (Scan_Ch == '+') state = 47; else
      	if (Scan_Ch == '-') state = 49; else
      	if (Scan_Ch == '~') state = 51; else
      	if (Scan_Ch == '!') state = 52; else
      	if (Scan_Ch == '*') state = 53; else
      	if (Scan_Ch == '%') state = 54; else
      	if (Scan_Ch == '>') state = 56; else
      	if (Scan_Ch == '=') state = 61; else
      	if (Scan_Ch == '&') state = 66; else
      	if (Scan_Ch == '^') state = 67; else
      	if (Scan_Ch == '|') state = 68; else
      	if (Scan_Ch == '?') state = 71; else
      	if (Scan_Ch == ';') state = 82; else
      	return No_Sym;
      	break;
       --------- End State0 --------- */
      case 1:
      	if (Scan_Ch >= '0' && Scan_Ch <= '9' ||
      	    Scan_Ch >= 'A' && Scan_Ch <= 'Z' ||
      	    Scan_Ch == '_' ||
      	    Scan_Ch >= 'a' && Scan_Ch <= 'z') /*same state*/; else
      	return CheckLiteral(C_identifierSym);
      	break;
      case 2:
      	if (Scan_Ch == 'U') state = 5; else
      	if (Scan_Ch == 'u') state = 6; else
      	if (Scan_Ch == 'L') state = 7; else
      	if (Scan_Ch == 'l') state = 8; else
      	if (Scan_Ch == '.') state = 4; else
      	if (Scan_Ch >= '0' && Scan_Ch <= '9') /*same state*/; else
      	return C_numberSym;
      	break;
      case 4:
      	if (Scan_Ch == 'U') state = 13; else
      	if (Scan_Ch == 'u') state = 14; else
      	if (Scan_Ch == 'L') state = 15; else
      	if (Scan_Ch == 'l') state = 16; else
      	if (Scan_Ch >= '0' && Scan_Ch <= '9') /*same state*/; else
      	return C_numberSym;
      	break;
      case 5:
      	return C_numberSym;
      case 6:
      	return C_numberSym;
      case 7:
      	return C_numberSym;
      case 8:
      	return C_numberSym;
      case 13:
      	return C_numberSym;
      case 14:
      	return C_numberSym;
      case 15:
      	return C_numberSym;
      case 16:
      	return C_numberSym;
      case 18:
      	if (Scan_Ch >= '0' && Scan_Ch <= '9' ||
      	    Scan_Ch >= 'A' && Scan_Ch <= 'F' ||
      	    Scan_Ch >= 'a' && Scan_Ch <= 'f') state = 19; else
      	return No_Sym;
      	break;
      case 19:
      	if (Scan_Ch == 'U') state = 20; else
      	if (Scan_Ch == 'u') state = 21; else
      	if (Scan_Ch == 'L') state = 22; else
      	if (Scan_Ch == 'l') state = 23; else
      	if (Scan_Ch >= '0' && Scan_Ch <= '9' ||
      	    Scan_Ch >= 'A' && Scan_Ch <= 'F' ||
      	    Scan_Ch >= 'a' && Scan_Ch <= 'f') /*same state*/; else
      	return C_hexnumberSym;
      	break;
      case 20:
      	return C_hexnumberSym;
      case 21:
      	return C_hexnumberSym;
      case 22:
      	return C_hexnumberSym;
      case 23:
      	return C_hexnumberSym;
      case 24:
      	if (Scan_Ch == '"') state = 25; else
      	if (Scan_Ch >= ' ' && Scan_Ch <= '!' ||
      	    Scan_Ch >= '#' && Scan_Ch <= 255) /*same state*/; else
      	return No_Sym;
      	break;
      case 25:
      	return C_stringSym;
      case 26:
      	if (Scan_Ch >= ' ' && Scan_Ch <= '&' ||
      	    Scan_Ch >= '(' && Scan_Ch <= '[' ||
      	    Scan_Ch >= ']' && Scan_Ch <= 255) state = 28; else
      	if (Scan_Ch == 92) state = 37; else
      	return No_Sym;
      	break;
      case 28:
      	if (Scan_Ch == 39) state = 29; else
      	return No_Sym;
      	break;
      case 29:
      	return C_charSym;
      case 30:
      	if (Scan_Ch == '.' ||
      	    Scan_Ch >= '0' && Scan_Ch <= ':' ||
      	    Scan_Ch >= 'A' && Scan_Ch <= 'Z' ||
      	    Scan_Ch == 92 ||
      	    Scan_Ch >= 'a' && Scan_Ch <= 'z') state = 31; else
      	if (Scan_Ch == '<') state = 55; else
      	if (Scan_Ch == '=') state = 59; else
      	return C_LessSym;
      	break;
      case 31:
      	if (Scan_Ch == '>') state = 32; else
      	if (Scan_Ch == '.' ||
      	    Scan_Ch >= '0' && Scan_Ch <= ':' ||
      	    Scan_Ch >= 'A' && Scan_Ch <= 'Z' ||
      	    Scan_Ch == 92 ||
      	    Scan_Ch >= 'a' && Scan_Ch <= 'z') /*same state*/; else
      	return No_Sym;
      	break;
      case 32:
      	return C_librarySym;
      case 33:
      	if (Scan_Ch == '/') state = 34; else
      	if (Scan_Ch >= ' ' && Scan_Ch <= '.' ||
      	    Scan_Ch >= '0' && Scan_Ch <= 255) /*same state*/; else
      	return CheckLiteral(C_SlashSym);
      	break;
      case 34:
      	return C_regexD1Sym;
      case 35:
      	if (Scan_Ch >= 1 && Scan_Ch <= 9 ||
      	    Scan_Ch >= 11 && Scan_Ch <= 255) /*same state*/; else
      	return C_PreProcessorSym;
      	break;
      case 36:
      	if (Scan_Ch == 'U') state = 5; else
      	if (Scan_Ch == 'u') state = 6; else
      	if (Scan_Ch == 'L') state = 7; else
      	if (Scan_Ch == 'l') state = 8; else
      	if (Scan_Ch == '.') state = 4; else
      	if (Scan_Ch >= '0' && Scan_Ch <= '9') state = 2; else
      	if (Scan_Ch == 'X' ||
      	    Scan_Ch == 'x') state = 18; else
      	return C_numberSym;
      	break;
      case 37:
      	if (Scan_Ch >= ' ' && Scan_Ch <= '&' ||
      	    Scan_Ch >= '(' && Scan_Ch <= 255) state = 28; else
      	if (Scan_Ch == 39) state = 29; else
      	return No_Sym;
      	break;
      case 38:
      	return C_LparenSym;
      case 39:
      	return C_RparenSym;
      case 40:
      	return C_LbrackSym;
      case 41:
      	return C_RbrackSym;
      case 42:
      	return C_CommaSym;
      case 43:
      	return C_LbraceSym;
      case 44:
      	return C_RbraceSym;
      case 45:
      	return C_ColonSym;
      case 46:
      	return C_PointSym;
      case 47:
      	if (Scan_Ch == '+') state = 48; else
      	if (Scan_Ch == '=') state = 74; else
      	return C_PlusSym;
      	break;
      case 48:
      	return C_PlusPlusSym;
      case 49:
      	if (Scan_Ch == '-') state = 50; else
      	if (Scan_Ch == '=') state = 75; else
      	return C_MinusSym;
      	break;
      case 50:
      	return C_MinusMinusSym;
      case 51:
      	return C_TildeSym;
      case 52:
      	if (Scan_Ch == '=') state = 63; else
      	return C_BangSym;
      	break;
      case 53:
      	if (Scan_Ch == '=') state = 72; else
      	return C_StarSym;
      	break;
      case 54:
      	if (Scan_Ch == '=') state = 73; else
      	return C_PercentSym;
      	break;
      case 55:
      	if (Scan_Ch == '=') state = 76; else
      	return C_LessLessSym;
      	break;
      case 56:
      	if (Scan_Ch == '>') state = 57; else
      	if (Scan_Ch == '=') state = 60; else
      	return C_GreaterSym;
      	break;
      case 57:
      	if (Scan_Ch == '>') state = 58; else
      	if (Scan_Ch == '=') state = 77; else
      	return C_GreaterGreaterSym;
      	break;
      case 58:
      	if (Scan_Ch == '=') state = 78; else
      	return C_GreaterGreaterGreaterSym;
      	break;
      case 59:
      	return C_LessEqualSym;
      case 60:
      	return C_GreaterEqualSym;
      case 61:
      	if (Scan_Ch == '=') state = 62; else
      	return C_EqualSym;
      	break;
      case 62:
      	if (Scan_Ch == '=') state = 64; else
      	return C_EqualEqualSym;
      	break;
      case 63:
      	if (Scan_Ch == '=') state = 65; else
      	return C_BangEqualSym;
      	break;
      case 64:
      	return C_EqualEqualEqualSym;
      case 65:
      	return C_BangEqualEqualSym;
      case 66:
      	if (Scan_Ch == '&') state = 69; else
      	if (Scan_Ch == '=') state = 79; else
      	return C_AndSym;
      	break;
      case 67:
      	if (Scan_Ch == '=') state = 80; else
      	return C_UparrowSym;
      	break;
      case 68:
      	if (Scan_Ch == '|') state = 70; else
      	if (Scan_Ch == '=') state = 81; else
      	return C_BarSym;
      	break;
      case 69:
      	return C_AndAndSym;
      case 70:
      	return C_BarBarSym;
      case 71:
      	return C_QuerySym;
      case 72:
      	return C_StarEqualSym;
      case 73:
      	return C_PercentEqualSym;
      case 74:
      	return C_PlusEqualSym;
      case 75:
      	return C_MinusEqualSym;
      case 76:
      	return C_LessLessEqualSym;
      case 77:
      	return C_GreaterGreaterEqualSym;
      case 78:
      	return C_GreaterGreaterGreaterEqualSym;
      case 79:
      	return C_AndEqualSym;
      case 80:
      	return C_UparrowEqualSym;
      case 81:
      	return C_BarEqualSym;
      case 82:
      	return C_SemicolonSym;
      
      default: return No_Sym; /* Scan_NextCh already done */
      }
    }
}

int cScanner::Get1()
{ int state, ctx;

  start:
    while (Scan_Ch >= 9 && Scan_Ch <= 10 ||
    	       Scan_Ch == 13 ||
    	       Scan_Ch == ' ') Scan_NextCh();
    if ((Scan_Ch == '/') && Comment()) goto start;

    CurrSym = NextSym;
    NextSym.Init(0, CurrLine, CurrCol - 1, BuffPos, 0);
    NextSym.Len  = 0; ctx = 0;

    if (Ch == EOF_CHAR) return EOF_Sym;
    state = STATE0[Ch];
    while(1) {
      Scan_NextCh(); NextSym.Len++;
      switch (state) {
       /* State 0; valid STATE0 Table
      case 0:
      	if (Scan_Ch >= 'A' && Scan_Ch <= 'Z' ||
      	    Scan_Ch == '_' ||
      	    Scan_Ch >= 'a' && Scan_Ch <= 'z') state = 1; else
      	if (Scan_Ch >= '1' && Scan_Ch <= '9') state = 2; else
      	if (Scan_Ch == '0') state = 36; else
      	if (Scan_Ch == '"') state = 24; else
      	if (Scan_Ch == 39) state = 26; else
      	if (Scan_Ch == '<') state = 30; else
      	if (Scan_Ch == '/') state = 33; else
      	if (Scan_Ch == '#') state = 35; else
      	if (Scan_Ch == '(') state = 38; else
      	if (Scan_Ch == ')') state = 39; else
      	if (Scan_Ch == '[') state = 40; else
      	if (Scan_Ch == ']') state = 41; else
      	if (Scan_Ch == ',') state = 42; else
      	if (Scan_Ch == '{') state = 43; else
      	if (Scan_Ch == '}') state = 44; else
      	if (Scan_Ch == ':') state = 45; else
      	if (Scan_Ch == '.') state = 46; else
      	if (Scan_Ch == '+') state = 47; else
      	if (Scan_Ch == '-') state = 49; else
      	if (Scan_Ch == '~') state = 51; else
      	if (Scan_Ch == '!') state = 52; else
      	if (Scan_Ch == '*') state = 53; else
      	if (Scan_Ch == '%') state = 54; else
      	if (Scan_Ch == '>') state = 56; else
      	if (Scan_Ch == '=') state = 61; else
      	if (Scan_Ch == '&') state = 66; else
      	if (Scan_Ch == '^') state = 67; else
      	if (Scan_Ch == '|') state = 68; else
      	if (Scan_Ch == '?') state = 71; else
      	if (Scan_Ch == ';') state = 82; else
      	return No_Sym;
      	break;
       --------- End State0 --------- */
      case 1:
      	if (Scan_Ch >= '0' && Scan_Ch <= '9' ||
      	    Scan_Ch >= 'A' && Scan_Ch <= 'Z' ||
      	    Scan_Ch == '_' ||
      	    Scan_Ch >= 'a' && Scan_Ch <= 'z') /*same state*/; else
      	return CheckLiteral(C_identifierSym);
      	break;
      case 2:
      	if (Scan_Ch == 'U') state = 5; else
      	if (Scan_Ch == 'u') state = 6; else
      	if (Scan_Ch == 'L') state = 7; else
      	if (Scan_Ch == 'l') state = 8; else
      	if (Scan_Ch == '.') state = 4; else
      	if (Scan_Ch >= '0' && Scan_Ch <= '9') /*same state*/; else
      	return C_numberSym;
      	break;
      case 4:
      	if (Scan_Ch == 'U') state = 13; else
      	if (Scan_Ch == 'u') state = 14; else
      	if (Scan_Ch == 'L') state = 15; else
      	if (Scan_Ch == 'l') state = 16; else
      	if (Scan_Ch >= '0' && Scan_Ch <= '9') /*same state*/; else
      	return C_numberSym;
      	break;
      case 5:
      	return C_numberSym;
      case 6:
      	return C_numberSym;
      case 7:
      	return C_numberSym;
      case 8:
      	return C_numberSym;
      case 13:
      	return C_numberSym;
      case 14:
      	return C_numberSym;
      case 15:
      	return C_numberSym;
      case 16:
      	return C_numberSym;
      case 18:
      	if (Scan_Ch >= '0' && Scan_Ch <= '9' ||
      	    Scan_Ch >= 'A' && Scan_Ch <= 'F' ||
      	    Scan_Ch >= 'a' && Scan_Ch <= 'f') state = 19; else
      	return No_Sym;
      	break;
      case 19:
      	if (Scan_Ch == 'U') state = 20; else
      	if (Scan_Ch == 'u') state = 21; else
      	if (Scan_Ch == 'L') state = 22; else
      	if (Scan_Ch == 'l') state = 23; else
      	if (Scan_Ch >= '0' && Scan_Ch <= '9' ||
      	    Scan_Ch >= 'A' && Scan_Ch <= 'F' ||
      	    Scan_Ch >= 'a' && Scan_Ch <= 'f') /*same state*/; else
      	return C_hexnumberSym;
      	break;
      case 20:
      	return C_hexnumberSym;
      case 21:
      	return C_hexnumberSym;
      case 22:
      	return C_hexnumberSym;
      case 23:
      	return C_hexnumberSym;
      case 24:
      	if (Scan_Ch == '"') state = 25; else
      	if (Scan_Ch >= ' ' && Scan_Ch <= '!' ||
      	    Scan_Ch >= '#' && Scan_Ch <= 255) /*same state*/; else
      	return No_Sym;
      	break;
      case 25:
      	return C_stringSym;
      case 26:
      	if (Scan_Ch >= ' ' && Scan_Ch <= '&' ||
      	    Scan_Ch >= '(' && Scan_Ch <= '[' ||
      	    Scan_Ch >= ']' && Scan_Ch <= 255) state = 28; else
      	if (Scan_Ch == 92) state = 37; else
      	return No_Sym;
      	break;
      case 28:
      	if (Scan_Ch == 39) state = 29; else
      	return No_Sym;
      	break;
      case 29:
      	return C_charSym;
      case 30:
      	if (Scan_Ch == '.' ||
      	    Scan_Ch >= '0' && Scan_Ch <= ':' ||
      	    Scan_Ch >= 'A' && Scan_Ch <= 'Z' ||
      	    Scan_Ch == 92 ||
      	    Scan_Ch >= 'a' && Scan_Ch <= 'z') state = 31; else
      	if (Scan_Ch == '<') state = 55; else
      	if (Scan_Ch == '=') state = 59; else
      	return C_LessSym;
      	break;
      case 31:
      	if (Scan_Ch == '>') state = 32; else
      	if (Scan_Ch == '.' ||
      	    Scan_Ch >= '0' && Scan_Ch <= ':' ||
      	    Scan_Ch >= 'A' && Scan_Ch <= 'Z' ||
      	    Scan_Ch == 92 ||
      	    Scan_Ch >= 'a' && Scan_Ch <= 'z') /*same state*/; else
      	return No_Sym;
      	break;
      case 32:
      	return C_librarySym;
      case 33:
      	if (Scan_Ch == '/') state = 34; else
      	if (Scan_Ch >= ' ' && Scan_Ch <= '.' ||
      	    Scan_Ch >= '0' && Scan_Ch <= 255) /*same state*/; else
      	return CheckLiteral(C_SlashSym);
      	break;
      case 34:
      	return C_regexD1Sym;
      case 35:
      	if (Scan_Ch >= 1 && Scan_Ch <= 9 ||
      	    Scan_Ch >= 11 && Scan_Ch <= 255) /*same state*/; else
      	return C_PreProcessorSym;
      	break;
      case 36:
      	if (Scan_Ch == 'U') state = 5; else
      	if (Scan_Ch == 'u') state = 6; else
      	if (Scan_Ch == 'L') state = 7; else
      	if (Scan_Ch == 'l') state = 8; else
      	if (Scan_Ch == '.') state = 4; else
      	if (Scan_Ch >= '0' && Scan_Ch <= '9') state = 2; else
      	if (Scan_Ch == 'X' ||
      	    Scan_Ch == 'x') state = 18; else
      	return C_numberSym;
      	break;
      case 37:
      	if (Scan_Ch >= ' ' && Scan_Ch <= '&' ||
      	    Scan_Ch >= '(' && Scan_Ch <= 255) state = 28; else
      	if (Scan_Ch == 39) state = 29; else
      	return No_Sym;
      	break;
      case 38:
      	return C_LparenSym;
      case 39:
      	return C_RparenSym;
      case 40:
      	return C_LbrackSym;
      case 41:
      	return C_RbrackSym;
      case 42:
      	return C_CommaSym;
      case 43:
      	return C_LbraceSym;
      case 44:
      	return C_RbraceSym;
      case 45:
      	return C_ColonSym;
      case 46:
      	return C_PointSym;
      case 47:
      	if (Scan_Ch == '+') state = 48; else
      	if (Scan_Ch == '=') state = 74; else
      	return C_PlusSym;
      	break;
      case 48:
      	return C_PlusPlusSym;
      case 49:
      	if (Scan_Ch == '-') state = 50; else
      	if (Scan_Ch == '=') state = 75; else
      	return C_MinusSym;
      	break;
      case 50:
      	return C_MinusMinusSym;
      case 51:
      	return C_TildeSym;
      case 52:
      	if (Scan_Ch == '=') state = 63; else
      	return C_BangSym;
      	break;
      case 53:
      	if (Scan_Ch == '=') state = 72; else
      	return C_StarSym;
      	break;
      case 54:
      	if (Scan_Ch == '=') state = 73; else
      	return C_PercentSym;
      	break;
      case 55:
      	if (Scan_Ch == '=') state = 76; else
      	return C_LessLessSym;
      	break;
      case 56:
      	if (Scan_Ch == '>') state = 57; else
      	if (Scan_Ch == '=') state = 60; else
      	return C_GreaterSym;
      	break;
      case 57:
      	if (Scan_Ch == '>') state = 58; else
      	if (Scan_Ch == '=') state = 77; else
      	return C_GreaterGreaterSym;
      	break;
      case 58:
      	if (Scan_Ch == '=') state = 78; else
      	return C_GreaterGreaterGreaterSym;
      	break;
      case 59:
      	return C_LessEqualSym;
      case 60:
      	return C_GreaterEqualSym;
      case 61:
      	if (Scan_Ch == '=') state = 62; else
      	return C_EqualSym;
      	break;
      case 62:
      	if (Scan_Ch == '=') state = 64; else
      	return C_EqualEqualSym;
      	break;
      case 63:
      	if (Scan_Ch == '=') state = 65; else
      	return C_BangEqualSym;
      	break;
      case 64:
      	return C_EqualEqualEqualSym;
      case 65:
      	return C_BangEqualEqualSym;
      case 66:
      	if (Scan_Ch == '&') state = 69; else
      	if (Scan_Ch == '=') state = 79; else
      	return C_AndSym;
      	break;
      case 67:
      	if (Scan_Ch == '=') state = 80; else
      	return C_UparrowSym;
      	break;
      case 68:
      	if (Scan_Ch == '|') state = 70; else
      	if (Scan_Ch == '=') state = 81; else
      	return C_BarSym;
      	break;
      case 69:
      	return C_AndAndSym;
      case 70:
      	return C_BarBarSym;
      case 71:
      	return C_QuerySym;
      case 72:
      	return C_StarEqualSym;
      case 73:
      	return C_PercentEqualSym;
      case 74:
      	return C_PlusEqualSym;
      case 75:
      	return C_MinusEqualSym;
      case 76:
      	return C_LessLessEqualSym;
      case 77:
      	return C_GreaterGreaterEqualSym;
      case 78:
      	return C_GreaterGreaterGreaterEqualSym;
      case 79:
      	return C_AndEqualSym;
      case 80:
      	return C_UparrowEqualSym;
      case 81:
      	return C_BarEqualSym;
      case 82:
      	return C_SemicolonSym;
      
      default: return No_Sym; /* Scan_NextCh already done */
      }
    }
}

