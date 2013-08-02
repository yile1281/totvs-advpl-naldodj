#IFNDEF _TBigNumber_CH

	#DEFINE _TBigNumber_CH

	#DEFINE OPERATOR_ADD			{ '+' , 'add' }
	#DEFINE OPERATOR_SUBTRACT		{ '-' , 'sub' }
	#DEFINE OPERATOR_MULTIPLY		{ '*' , 'x' , 'mult' }
	#DEFINE OPERATOR_DIVIDE			{ '/' , ':' , 'div'  }
	#DEFINE OPERATOR_POW			{ '^' , '**' , 'xx' , 'pow' }
	#DEFINE OPERATOR_MOD			{ '%' , 'mod' }
	#DEFINE OPERATOR_EXP			{ 'exp' }
	#DEFINE OPERATOR_SQRT			{ 'sqrt' }
	#DEFINE OPERATOR_ROOT			{ 'root' }

	#DEFINE OPERATORS				{;
										OPERATOR_ADD,		;
										OPERATOR_SUBTRACT,	;
										OPERATOR_MULTIPLY,	;
										OPERATOR_DIVIDE,	;	
										OPERATOR_POW,		;
										OPERATOR_MOD,		;
										OPERATOR_EXP,		;
										OPERATOR_SQRT,		;
										OPERATOR_ROOT,		;
									}

	#IFDEF PROTHEUS
		#DEFINE __PROTHEUS__
		#include "protheus.ch"
		#xtranslate THREAD Static => Static
		#xtranslate hb_ntos( <n> ) => LTrim( Str( <n> ) )
	#ELSE
		#IFDEF __HARBOUR__
			#include "common.ch"
			#include "hbclass.ch"
*			#include "hbCompat.ch"
			#IFDEF TBN_DBFILE
				#IFNDEF TBN_MEMIO
					REQUEST DBFCDX , DBFFPT
				#ELSE
					#require "hbmemio"
					REQUEST HB_MEMIO
				#ENDIF
			#ENDIF
		#ENDIF
		#ifndef __XHARBOUR__
			#include "xhb.ch" //add xHarbour emulation to Harbour
		#endif
	#ENDIF

	#DEFINE MAX_DECIMAL_PRECISION	999999999999999
    
	#xcommand DEFAULT =>

	/* Default parameters management */
	#xcommand DEFAULT <uVar1> := <uVal1> [, <uVarN> := <uValN> ] ;
				=> ;
				<uVar1> := iif( <uVar1> == NIL, <uVal1>, <uVar1> ) ;
				[; <uVarN> := iif( <uVarN> == NIL, <uValN>, <uVarN> ) ]

	/* by default create ST version */
   #ifndef __ST__
		#ifndef __MT__
	      #define __ST__
	   #endif
	#endif

	#IFNDEF CRLF
		#IFDEF __HARBOUR__	
			#DEFINE CRLF hb_eol()
		#ELSE
			#DEFINE CRLF CHR(13)+CHR(10)
		#ENDIF
	#ENDIF

	#include "set.ch"
	#include "fileio.ch"

#ENDIF