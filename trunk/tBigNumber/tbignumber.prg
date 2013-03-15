#include "tBigNumber.ch"

THREAD Static __aFiles

#IFDEF __PROTHEUS__
	#IFDEF __MT__
		Static __cEnvSrv
	#ENDIF
#ENDIF

THREAD Static __nthRootAcc
THREAD Static __nSetDecimals

#DEFINE RANDOM_MAX_EXIT		5
#DEFINE EXIT_MAX_RANDOM		50

/*

	Alternative Compile Options: /D

	#IFDEF __PROTHEUS__
		/DTBN_DBFILE /D__MT__ /D__TBN_DYN_OBJ_SET__ /D__POWMT__
	#ELSE //__HARBOUR__
		/DTBN_DBFILE /DTBN_MEMIO /D__MT__ /D__TBN_DYN_OBJ_SET__ /D__POWMT__
	#ENDIF

*/

/*
	Class		: tBigNumber
	Autor		: Marinaldo de Jesus [ http://www.blacktdn.com.br ]
	Data		: 04/02/2013
	Descricao	: Instancia um novo objeto do tipo BigNumber
	Sintaxe		: tBigNumber():New( uBigN ) -> self
*/
CLASS tBigNumber

	DATA cDec
	DATA cInt
	DATA cRDiv
	DATA cSig
	DATA lNeg
	DATA nDec
	DATA nInt
	DATA nSize

	Method New( uBigN ) CONSTRUCTOR

	Method ClassName()

	Method SetDecimals( nSet )

	Method SetValue( uBigN , cRDiv , lILZeroRmv , nAcc )
	Method GetValue( lAbs , lObj )
	Method ExactValue( lAbs , lObj )

	Method Abs( lObj )
	
	Method Int( lObj )
	Method Dec( lObj , lNotZeros )

	Method eq( uBigN )
	Method ne( uBigN )
	Method gt( uBigN )
	Method lt( uBigN )
	Method gte( uBigN )
	Method lte( uBigN )

	Method Max( uBigN )
	Method Min( uBigN )
	
	Method Add( uBigN )				//TODO: Implementar Adicao Binaria e Hexa
	Method Sub( uBigN )				//TODO: Implementar Subtracao Binaria e Hexa
	Method Mult( uBigN , __lMult )	//TODO: Implementar Multiplicacao Binaria e Hexa	
	Method Div( uBigN , lFloat )	//TODO: Implementar Divisao Binaria e Hexa
	Method Mod( uBigN )				
	Method Pow( uBigN )				//TODO: Validar o Calculo quando expoente fracionario
	Method e( lForce )
	Method Exp( lForce )
	Method PI( lForce )				//TODO: Implementar o calculo.
	Method GCD( uBigN )
	Method LCM( uBigN )
	
	Method nthRoot( uBigN )

	Method SQRT()
	Method SysSQRT( uSet )

	Method Log( uBigNB )			//TODO: Validar Calculo.
	Method Log2()					//TODO: Validar Calculo.
	Method Log10()					//TODO: Validar Calculo.
	Method Ln()						//TODO: Validar Calculo.

	Method aLog( uBigNB )			//TODO: Validar Calculo.
	Method aLog2()					//TODO: Validar Calculo.
	Method aLog10()					//TODO: Validar Calculo.
	Method aLn()					//TODO: Validar Calculo.

	Method MathC( uBigN1 , cOperator , uBigN2 )
	Method MathN( uBigN1 , cOperator , uBigN2 )

	Method Rnd( nAcc )
	Method NoRnd( nAcc )
	Method Truncate( nAcc )

	Method Normalize( uBigN0 , uBigN1 , uBigN2 )

	Method D2H( cHexB )				//TODO: Tratar Ponto Flutuante
	Method H2D( cHexN , cHexB )		//TODO: Tratar Ponto Flutuante

	Method H2B( cHexN , cHexB )		//TODO: Tratar Ponto Flutuante
	Method B2H( cBin  , cHexB )		//TODO: Tratar Ponto Flutuante

	Method Randomize( uB , uE , nExit )

	Method millerRabin( uI )
	
	Method FI()
                    
End Class

/*
	Função		: tBigNumber():New
	Autor		: Marinaldo de Jesus [ http://www.blacktdn.com.br ]
	Data		: 04/02/2013
	Descricao	: Instancia um novo Objeto tBigNumber
	Sintaxe		: tBigNumber():New( uBigN  ) -> self
*/
#IFDEF __PROTHEUS__
	User Function tBigNumber( uBigN )
	Return( tBigNumber():New( @uBigN ) )
#ENDIF

/*
	Method		: New
	Autor		: Marinaldo de Jesus [ http://www.blacktdn.com.br ]
	Data		: 04/02/2013
	Descricao	: CONSTRUCTOR
	Sintaxe		: tBigNumber():New( uBigN ) -> self
*/
Method New( uBigN ) CLASS tBigNumber

	DEFAULT uBigN	:= "0"

	#IFDEF __PROTHEUS__
		#IFDEF __MT__
			DEFAULT __cEnvSrv := GetEnvServer()
		#ENDIF
	#ENDIF

	self:SetDecimals()

	self:SetValue( @uBigN )

Return( self )

/*
	Method		: ClassName
	Autor		: Marinaldo de Jesus [ http://www.blacktdn.com.br ]
	Data		: 04/02/2013
	Descricao	: ClassName
	Sintaxe		: tBigNumber():ClassName() -> cClassName
*/
Method ClassName() CLASS tBigNumber
Return( "TBIGNUMBER" )

/*
	Method:		SetDecimals
	Autor:		Marinaldo de Jesus [ http://www.blacktdn.com.br ]
	Data:		04/02/2013
	Descricao:	Setar o Numero de Casas Decimais
	Sintaxe:	tBigNumber():SetDecimals( nSet ) -> nLastSet
*/
Method SetDecimals( nSet ) CLASS tBigNumber

	Local nLastSet 			:= __nSetDecimals

	DEFAULT __nSetDecimals	:= IF( ( nSet == NIL ) , 15 , nSet )
	DEFAULT nSet			:= __nSetDecimals
	DEFAULT nLastSet		:= nSet

	IF ( nSet > MAX_DECIMAL_PRECISION )
	    nSet := MAX_DECIMAL_PRECISION
	EndIF

	nSet			:= Max( 15 , nSet )
	__nthRootAcc	:= Min( 30 , nSet )
	__nSetDecimals	:= nSet

Return( nLastSet )

/*
	Method		: SetValue
	Autor		: Marinaldo de Jesus [ http://www.blacktdn.com.br ]
	Data		: 04/02/2013
	Descricao	: SetValue
	Sintaxe		: tBigNumber():SetValue( uBigN , cRDiv , lILZeroRmv ) -> self
*/
Method SetValue( uBigN , cRDiv , lILZeroRmv , nAcc ) CLASS tBigNumber

	Local cType	:= ValType( uBigN )

	Local nFP

	#IFDEF __TBN_DYN_OBJ_SET__
	Local nP
		#IFDEF __HARBOUR__
			MEMVAR This
		#ENDIF
		Private This
	#ENDIF	

	IF ( cType == "O" )

		#IFDEF __TBN_DYN_OBJ_SET__

			#IFDEF __PROTHEUS__
	
				This	:= self
				uBigN	:= ClassDataArr( uBigN )
				nFP 	:= Len( uBigN )
				
				For nP := 1 To nFP
					&( "This:"+uBigN[nP][1] ) := uBigN[nP][2]
				Next nP	
		    
		    #ELSE
	
				__objSetValueList( self , __objGetValueList( uBigN ) )
	
			#ENDIF	
			
		#ELSE

			self:cDec		:= uBigN:cDec
			self:cInt		:= uBigN:cInt
			self:cRDiv		:= uBigN:cRDiv
			self:cSig		:= uBigN:cSig
			self:lNeg		:= uBigN:lNeg
			self:nDec		:= uBigN:nDec
			self:nInt		:= uBigN:nInt
			self:nSize		:= uBigN:nSize
			
		#ENDIF
	
	ElseIF ( cType == "A" )

		#IFDEF __TBN_DYN_OBJ_SET__

			This	:= self
			nFP 	:= Len( uBigN )
	
			For nP := 1 To nFP
				&( "This:"+uBigN[nP][1] ) := uBigN[nP][2]
			Next nP	
		
		#ELSE

			self:cDec		:= uBigN[1][2]
			self:cInt		:= uBigN[2][2]
			self:cRDiv		:= uBigN[3][2]
			self:cSig		:= uBigN[4][2]
			self:lNeg		:= uBigN[5][2]
			self:nDec		:= uBigN[6][2]
			self:nInt		:= uBigN[7][2]
			self:nSize		:= uBigN[8][2]
		
		#ENDIF
	
	ElseIF ( cType == "C" )

	    While ( " " $ uBigN )
	    	uBigN	:= StrTran( uBigN ," " , "" )	
	    End While

	    self:lNeg := ( SubStr( uBigN , 1 , 1 ) == "-" )

		IF ( self:lNeg )
			uBigN		:= SubStr( uBigN , 2 )
			self:cSig	:= "-"
		Else
			self:cSig	:= ""
		EndIF

		nFP := AT( "." , uBigN )

		self:cInt := "0"
		self:cDec := "0"

		DO CASE
		CASE ( nFP == 0 )
			self:cInt := SubStr( uBigN , 1 )
			self:cDec := "0"
		CASE ( nFP == 1 )
		    self:cInt	:= "0"
		    self:cDec	:= SubStr( uBigN , ( nFP + 1 ) )
		OTHERWISE
		    self:cInt	:= SubStr( uBigN , 1 , ( nFP - 1 ) )
		    self:cDec	:= SubStr( uBigN , ( nFP + 1 ) )
		ENDCASE

		IF ( ( self:cInt == "0" ) .and. ( self:cDec == "0" ) )
			self:lNeg	:= .F.
			self:cSig	:= ""
		EndIF

	    self:nInt	:= Len( self:cInt )
	    self:nDec	:= Len( self:cDec )
	    self:nSize	:= ( self:nInt + self:nDec )

		DEFAULT cRDiv	:= "0"
		self:cRDiv		:= cRDiv

	EndIF

	DEFAULT lILZeroRmv	:= .T.
    IF ( lILZeroRmv )
		While ( ( self:nInt > 1 ) .and. ( SubStr( self:cInt , 1 , 1 ) == "0" ) )
			self:cInt := SubStr( self:cInt , 2 )
			--self:nInt
		End While
	EndIF	

	DEFAULT nAcc := __nSetDecimals
	IF ( self:nDec > nAcc )
		self:nDec	:= nAcc
		self:cDec	:= SubStr( self:cDec , 1 , self:nDec )
	EndIF

    self:nSize	:= ( self:nInt + self:nDec )

Return( self )

/*
	Method		: GetValue
	Autor		: Marinaldo de Jesus [ http://www.blacktdn.com.br ]
	Data		: 04/02/2013
	Descricao	: GetValue
	Sintaxe		: tBigNumber():GetValue( lAbs , lObj ) -> uBigNR
*/
Method GetValue( lAbs , lObj ) CLASS tBigNumber

	Local uBigNR

	DEFAULT lAbs	:= .F.
	DEFAULT lObj	:= .F.
	
    uBigNR	:= IF( lAbs , "" , self:cSig )
    uBigNR	+= self:cInt
    uBigNR	+= "."
    uBigNR	+= self:cDec

	IF ( lObj )
		uBigNR	:= tBigNumber():New( uBigNR )
	EndIF

Return( uBigNR )        

/*
	Method		: ExactValue
	Autor		: Marinaldo de Jesus [ http://www.blacktdn.com.br ]
	Data		: 04/02/2013
	Descricao	: ExactValue
	Sintaxe		: tBigNumber():ExactValue( lAbs ) -> uBigNR
*/
Method ExactValue( lAbs , lObj ) CLASS tBigNumber

	Local cDec 

	Local uBigNR

	DEFAULT lAbs	:= .F.
	DEFAULT lObj	:= .F.

    uBigNR	:= IF( lAbs , "" , self:cSig )

    uBigNR	+= self:Int()
    cDec	:= self:Dec(NIL,.T.)

	IF .NOT.( Empty( cDec ) )
	    uBigNR	+= "."
	    uBigNR	+= cDec
	EndIF

	IF ( lObj )
		uBigNR	:= tBigNumber():New( uBigNR )
	EndIF

Return( uBigNR )

/*
	Method		: Abs
	Autor		: Marinaldo de Jesus [ http://www.blacktdn.com.br ]
	Data		: 04/02/2013
	Descricao	: Retorna o Valor Absoluto de um Numero
	Sintaxe		: tBigNumber():Abs() -> uBigNR
*/
Method Abs( lObj ) CLASS tBigNumber
Return( self:GetValue( .T. , @lObj ) )

/*
	Method		: Int
	Autor		: Marinaldo de Jesus [ http://www.blacktdn.com.br ]
	Data		: 04/02/2013
	Descricao	: Retorna a Parte Inteira de um Numero
	Sintaxe		: tBigNumber():Int() -> uBigNR
*/
Method Int( lObj ) CLASS tBigNumber
	Local uBigNR
	DEFAULT lObj := .F.
	IF ( lObj )
		uBigNR	:= tBigNumber():New(self:cSig+self:cInt)
	Else
		uBigNR	:= self:cInt
	EndIF
Return( uBigNR )

/*
	Method		:	Dec
	Autor		:	Marinaldo de Jesus [ http://www.blacktdn.com.br ]
	Data		:	04/02/2013
	Descricao	:	Retorna a Parte Decimal de um Numero
	Sintaxe		:	tBigNumber():Dec( lObj , lNotZeros ) -> uBigNR
*/
Method Dec( lObj , lNotZeros ) CLASS tBigNumber

    Local cDec	:= self:cDec
    
    Local nDec
    
    Local uBigNR

	DEFAULT lNotZeros := .F.
	IF ( lNotZeros )
		nDec	:= self:nDec
		While ( SubStr( cDec , -1 ) == "0" )
			cDec	:= SubStr( cDec , 1 , --nDec )
		End While
	EndIF

	DEFAULT lObj := .F.
	IF ( lObj )
		uBigNR	:= tBigNumber():New(self:cSig+"0."+cDec)
	Else
		uBigNR	:= cDec
	EndIF

Return( uBigNR )

/*
	Method		: eq
	Autor		: Marinaldo de Jesus [ http://www.blacktdn.com.br ]
	Data		: 04/02/2013
	Descricao	: Compara se o valor corrente eh igual ao passado como parametro
	Sintaxe		: tBigNumber():eq( uBigN ) -> leq
*/
Method eq( uBigN ) CLASS tBigNumber

	Local leq

	THREAD Static __eqoN1
	THREAD Static __eqoN2

	DEFAULT __eqoN1 := tBigNumber():New()
	DEFAULT __eqoN2 := tBigNumber():New()

	__eqoN1:SetValue( __eqoN1:Normalize( self  , self  , uBigN ) , NIL , .F. )
	__eqoN2:SetValue( __eqoN2:Normalize( uBigN , uBigN , self  ) , NIL , .F. )

	leq	:= ( ( __eqoN1:GetValue( .T. ) == __eqoN2:GetValue( .T. ) ) .and. ( __eqoN1:lNeg == __eqoN2:lNeg ) )

Return( leq )

/*
	Method		: ne
	Autor		: Marinaldo de Jesus [ http://www.blacktdn.com.br ]
	Data		: 04/02/2013
	Descricao	: Verifica se o valor corrente eh igual ao valor passado como parametro
	Sintaxe		: tBigNumber():ne( uBigN ) -> .NOT.( leq )
*/
Method ne( uBigN ) CLASS tBigNumber
Return( .NOT.( self:eq( @uBigN ) ) )

/*
	Method		: gt
	Autor		: Marinaldo de Jesus [ http://www.blacktdn.com.br ]
	Data		: 04/02/2013
	Descricao	: Verifica se o valor corrente eh maior que o valor passado como parametro
	Sintaxe		: tBigNumber():gt( uBigN ) -> lgt
*/
Method gt( uBigN ) CLASS tBigNumber

	Local cN1
	Local cN2

	Local lgt

	THREAD Static __gtoN1
	THREAD Static __gtoN2

	DEFAULT __gtoN1 := tBigNumber():New()	
	DEFAULT __gtoN2 := tBigNumber():New()

	__gtoN1:SetValue( __gtoN1:Normalize( self  , self  , uBigN ) , NIL , .F. )
	__gtoN2:SetValue( __gtoN2:Normalize( uBigN , uBigN , self  ) , NIL , .F. )

	cN1	:= __gtoN1:GetValue( .T. )
	cN2	:= __gtoN2:GetValue( .T. )

	IF ( __gtoN1:lNeg .or. __gtoN2:lNeg )
		IF ( __gtoN1:lNeg .and. __gtoN2:lNeg )
			lgt := ( cN1 < cN2 )
		ElseIF ( __gtoN1:lNeg .and. .NOT.( __gtoN2:lNeg ) )
			lgt := .F.
		ElseIF ( .NOT.( __gtoN1:lNeg ) .and. __gtoN2:lNeg )
			lgt := .T.
		EndIF
	Else
		lgt := ( cN1 > cN2 )
	EndIF	

Return( lgt )

/*
	Method		: lt
	Autor		: Marinaldo de Jesus [ http://www.blacktdn.com.br ]
	Data		: 04/02/2013
	Descricao	: Verifica se o valor corrente eh menor que o valor passado como parametro
	Sintaxe		: tBigNumber():lt( uBigN ) -> llt
*/
Method lt( uBigN ) CLASS tBigNumber

	Local cN1
	Local cN2
	
	Local llt

	THREAD Static __ltoN1
	THREAD Static __ltoN2

	DEFAULT __ltoN1 := tBigNumber():New()	
	DEFAULT __ltoN2 := tBigNumber():New()

	__ltoN1:SetValue( __ltoN1:Normalize( self  , self  , uBigN ) , NIL , .F. )
	__ltoN2:SetValue( __ltoN2:Normalize( uBigN , uBigN , self  ) , NIL , .F. )

	cN1	:= __ltoN1:GetValue( .T. )
	cN2	:= __ltoN2:GetValue( .T. )

	IF ( __ltoN1:lNeg .or. __ltoN2:lNeg )
		IF ( __ltoN1:lNeg .and. __ltoN2:lNeg )
			llt := ( cN1 > cN2 )
		ElseIF ( __ltoN1:lNeg .and. .NOT.( __ltoN2:lNeg ) )
			llt := .T.
		ElseIF ( .NOT.( __ltoN1:lNeg ) .and. __ltoN2:lNeg )
			llt := .F.
		EndIF
	Else
		llt := ( cN1 < cN2 )
	EndIF	

Return( llt )

/*
	Method		: gte
	Autor		: Marinaldo de Jesus [ http://www.blacktdn.com.br ]
	Data		: 04/02/2013
	Descricao	: Verifica se o valor corrente eh maior ou igual ao valor passado como parametro
	Sintaxe		: tBigNumber():gte( uBigN ) -> lgte
*/
Method gte( uBigN ) CLASS tBigNumber
Return( ( self:gt( @uBigN ) .or. self:eq( @uBigN ) ) )

/*
	Method		: lte
	Autor		: Marinaldo de Jesus [ http://www.blacktdn.com.br ]
	Data		: 04/02/2013
	Descricao	: Verifica se o valor corrente eh menor ou igual ao valor passado como parametro
	Sintaxe		: tBigNumber():lte( uBigN ) -> lte
*/
Method lte( uBigN ) CLASS tBigNumber
Return( ( self:lt( @uBigN ) .or. self:eq( @uBigN ) ) )

/*
	Method		: Max
	Autor		: Marinaldo de Jesus [ http://www.blacktdn.com.br ]
	Data		: 04/02/2013
	Descricao	: Retorna o maior valor entre o valor corrente e o valor passado como parametro
	Sintaxe		: tBigNumber():Max( uBigN ) -> uBigNR
*/
Method Max( uBigN ) CLASS tBigNumber
	
	Local lgte
	Local lGetValue

	Local uBigNR

	lgte	:= self:gte( @uBigN )

	IF ( lgte )
		lGetValue	:= ( ValType( uBigN ) == "C" )
		IF ( lGetValue )
			uBigNR	:= self:GetValue()
		Else
			uBigNR	:= self
		EndIF
	Else
		uBigNR		:= uBigN
	EndIF

Return( uBigNR )

/*
	Method		: Min
	Autor		: Marinaldo de Jesus [ http://www.blacktdn.com.br ]
	Data		: 04/02/2013
	Descricao	: Retorna o menor valor entre o valor corrente e o valor passado como parametro
	Sintaxe		: tBigNumber():Min( uBigN ) -> uBigNR
*/
Method Min( uBigN ) CLASS tBigNumber
	
	Local llte
	Local lGetValue

	Local uBigNR

	llte	:= self:lte( @uBigN )

	IF ( llte )
		lGetValue	:= ( ValType( uBigN ) == "C" )
		IF ( lGetValue )
			uBigNR	:= self:GetValue()
		Else
			uBigNR	:= self
		EndIF
	Else
		uBigNR		:= uBigN
	EndIF

Return( uBigNR )

/*
	Method		: Add
	Autor		: Marinaldo de Jesus [ http://www.blacktdn.com.br ]
	Data		: 04/02/2013
	Descricao	: Soma
	Sintaxe		: tBigNumber():Add( uBigN ) -> oBigNR
*/
Method Add( uBigN ) CLASS tBigNumber

	Local cInt		
	Local cDec		

	Local cBigN1
	Local cBigN2
	Local cBigNT

	Local lNeg	 	
	Local lInv
	Local lAdd		:= .T.

	Local n1
	Local n2

	Local nAcc		:= __nSetDecimals
	Local nDec		
	Local nSize 	
	
#IFDEF __MT__
	Local xResult
	#IFNDEF __PROTHEUS__
	Local oThread
	#ENDIF
#ENDIF
	THREAD Static __adoNR
	THREAD Static __adoN1
	THREAD Static __adoN2

	DEFAULT __adoNR := tBigNumber():New()
	DEFAULT __adoN1 := tBigNumber():New()
	DEFAULT __adoN2 := tBigNumber():New()

	__adoN1:SetValue( __adoN1:Normalize( self  , self  , uBigN ) , NIL , .F. )
	__adoN2:SetValue( __adoN2:Normalize( uBigN , uBigN , self  ) , NIL , .F. )

	BEGIN SEQUENCE

		IF ( ( __adoN1:nSize <= 14 ) .and. ( __adoN2:nSize <= 14 ) )
			n1	:= Val(__adoN1:ExactValue())
			n2	:= Val(__adoN2:ExactValue())
			IF ( ( ( n1 <= 999999999.99999 ) .and. __adoN1:nDec <= 4 ) .and. ( ( n2 <= 999999999.99999 ) .and. __adoN2:nDec <= 4 ) )
				cBigNT	:= LTrim(Str(n1+n2))
				__adoNR:SetValue( cBigNT )
				BREAK
			EndIF
		EndIF	

	    nDec	:= __adoN1:nDec
	    nSize	:= __adoN1:nSize
	
	    cBigN1	:= __adoN1:Int()
	    cBigN1	+= __adoN1:Dec()
	
	    cBigN2	:= __adoN2:Int()
	    cBigN2	+= __adoN2:Dec()
	
	    lNeg	:= ( ( __adoN1:lNeg .and. .NOT.( __adoN2:lNeg ) ) .or. ( .NOT.( __adoN1:lNeg ) .and. __adoN2:lNeg ) )
	
		IF ( lNeg )
			lAdd	:= .F.
			lInv	:= ( cBigN1 < cBigN2 )
			lNeg	:= ( ( __adoN1:lNeg .and. .NOT.( lInv ) ) .or. ( __adoN2:lNeg .and. lInv ) )
			IF ( lInv )
				cBigNT	:= cBigN1
				cBigN1	:= cBigN2
				cBigN2	:= cBigNT
				cBigNT	:= NIL
			EndIF
	    Else
	    	lNeg	:= __adoN1:lNeg
	    EndIF
	
		IF ( lAdd )
			#IFDEF __MT__
				#IFNDEF __PROTHEUS__
					oThread := hb_threadStart( "AddThread" , @cBigN1 , @cBigN2 , @nSize , @nAcc )
					hb_threadJoin( oThread , @xResult )
					hb_threadWaitForAll( { oThread } )
				#ELSE
					xResult := StartJob( "U_AddThread" , __cEnvSrv , .T. , @cBigN1 , @cBigN2 , @nSize , @nAcc )
				#ENDIF
				__adoNR:SetValue( xResult , NIL , .F. )
			#ELSE
				__adoNR:SetValue( Add( @cBigN1 , @cBigN2 , @nSize , @nAcc ) , NIL , .F. )			
			#ENDIF
		Else
			#IFDEF __MT__
				#IFNDEF __PROTHEUS__
					oThread := hb_threadStart( "SubThread" , @cBigN1 , @cBigN2 , @nSize , @nAcc )
					hb_threadJoin( oThread , @xResult )
					hb_threadWaitForAll( { oThread } )
				#ELSE
					xResult := StartJob( "U_SubThread" , __cEnvSrv , .T. , @cBigN1 , @cBigN2 , @nSize , @nAcc )
				#ENDIF
				__adoNR:SetValue( xResult , NIL , .F. )
			#ELSE
				__adoNR:SetValue( Sub( @cBigN1 , @cBigN2 , @nSize , @nAcc ) , NIL , .F. )
			#ENDIF
		EndIF
	
	    cBigNT	:= __adoNR:Int()
	    
	    cDec	:= SubStr( cBigNT , -nDec  )
	    cInt	:= SubStr( cBigNT ,  1 , Len( cBigNT ) - nDec )
	
	    cBigNT	:= cInt
	    cBigNT	+= "."
	    cBigNT	+= cDec
	
		__adoNR:SetValue( cBigNT )
	
		IF ( lNeg )
			IF ( __adoNR:gt( "0" ) )
				__adoNR:cSig	:= "-"
				__adoNR:lNeg	:= lNeg
			EndIF
		EndIF

	END SEQUENCE

Return( __adoNR )

/*
	Method		: Sub
	Autor		: Marinaldo de Jesus [ http://www.blacktdn.com.br ]
	Data		: 04/02/2013
	Descricao	: Soma
	Sintaxe		: tBigNumber():Sub( uBigN ) -> oBigNR
*/
Method Sub( uBigN ) CLASS tBigNumber

	Local cInt		
	Local cDec		

	Local cBigN1 	
	Local cBigN2 	
	Local cBigNT 		

	Local lNeg		
	Local lInv		
	Local lSub	:= .T.

	Local n1
	Local n2

	Local nAcc	:= __nSetDecimals
	Local nDec		
	Local nSize 	

#IFDEF __MT__
	Local xResult
	#IFNDEF __PROTHEUS__
	Local oThread
	#ENDIF
#ENDIF

	THREAD Static __sboNR
	THREAD Static __sboN1
	THREAD Static __sboN2

	DEFAULT __sboNR := tBigNumber():New()
	DEFAULT __sboN1 := tBigNumber():New()
	DEFAULT __sboN2 := tBigNumber():New()

	__sboN1:SetValue( __sboN1:Normalize( self  , self  , uBigN ) , NIL , .F. )
	__sboN2:SetValue( __sboN2:Normalize( uBigN , uBigN , self  ) , NIL , .F. )

	BEGIN SEQUENCE

		IF ( ( __sboN1:nSize <= 14 ) .and. ( __sboN2:nSize <= 14 ) )
			n1	:= Val(__sboN1:ExactValue())
			n2	:= Val(__sboN2:ExactValue())
			IF ( ( ( n1 <= 999999999.99999 ) .and. ( __sboN1:nDec <= 4 ) ) .and. ( ( n2 <= 999999999.99999 ) .and. ( __sboN2:nDec <= 4 ) ) )
				cBigNT	:= LTrim(Str(n1-n2))
				__sboNR:SetValue( cBigNT )
				BREAK
			EndIF
		EndIF	
	
	    nDec	:= __sboN1:nDec
	    nSize	:= __sboN1:nSize
	
	    cBigN1	:= __sboN1:Int()
	    cBigN1	+= __sboN1:Dec()
	
	    cBigN2	:= __sboN2:Int()
	    cBigN2	+= __sboN2:Dec()
	
	    lNeg	:= ( ( __sboN1:lNeg .and. .NOT.( __sboN2:lNeg ) ) .or. ( .NOT.( __sboN1:lNeg ) .and. __sboN2:lNeg ) )
	
		IF ( lNeg )
			lSub	:= .F.
			lNeg	:= __sboN1:lNeg
		Else
			lInv	:= ( cBigN1 < cBigN2 )
			lNeg	:= ( __sboN1:lNeg .or. lInv )
			IF ( lInv )
				cBigNT	:= cBigN1
				cBigN1	:= cBigN2
				cBigN2	:= cBigNT
				cBigNT	:= NIL
			EndIF
		EndIF
	
	    IF ( lSub )
			#IFDEF __MT__
				#IFNDEF __PROTHEUS__
					oThread := hb_threadStart( "SubThread" , @cBigN1 , @cBigN2 , @nSize , @nAcc )
					hb_threadJoin( oThread , @xResult )
					hb_threadWaitForAll( { oThread } )
			    #ELSE
			    	xResult := StartJob( "U_SubThread" , __cEnvSrv , .T. , @cBigN1 , @cBigN2 , @nSize , @nAcc )
			    #ENDIF
			    __sboNR:SetValue( xResult , NIL , .F. )
	    	#ELSE
				__sboNR:SetValue( Sub( @cBigN1 , @cBigN2 , @nSize , @nAcc ) , NIL , .F. )    		
	    	#ENDIF
	    Else
			#IFDEF __MT__
				#IFNDEF __PROTHEUS__
					oThread := hb_threadStart( "AddThread" , @cBigN1 , @cBigN2 , @nSize , @nAcc )
					hb_threadJoin( oThread , @xResult )
					hb_threadWaitForAll( { oThread } )
			    #ELSE
			    	xResult := StartJob( "U_AddThread" , __cEnvSrv , .T. , @cBigN1 , @cBigN2 , @nSize , @nAcc )
			    #ENDIF
			    __sboNR:SetValue( xResult , NIL , .F. )
	    	#ELSE
				__sboNR:SetValue( Add( @cBigN1 , @cBigN2 , @nSize , @nAcc ) , NIL , .F. )    		
	    	#ENDIF
	    EndIF
	
	    cBigNT	:= __sboNR:Int()
	    
	    cDec	:= SubStr( cBigNT , -nDec  )
	    cInt	:= SubStr( cBigNT ,  1 , Len( cBigNT ) - nDec )
	    
	    cBigNT	:= cInt
	    cBigNT	+= "."
	    cBigNT	+= cDec
		
		__sboNR:SetValue( cBigNT )
	
		IF ( lNeg )
			IF ( __sboNR:gt( "0" ) )
			    __sboNR:cSig := "-"
			    __sboNR:lNeg	:= lNeg
			EndIF
		EndIF

	END SEQUENCE

Return( __sboNR )

/*
	Method		: Mult
	Autor		: Marinaldo de Jesus [ http://www.blacktdn.com.br ]
	Data		: 04/02/2013
	Descricao	: Multiplicacao (Mais rapida, usa a multiplicacao nativa)
	Sintaxe		: tBigNumber():Mult( uBigN , __lMult ) -> oBigNR
*/
Method Mult( uBigN , __lMult ) CLASS tBigNumber

	Local cInt
	Local cDec

	Local cBigN1
	Local cBigN2
	Local cBigNT

	Local lNeg	
	Local lNeg1 
	Local lNeg2 

	Local n1
	Local n2

	Local nAcc	:= __nSetDecimals
	Local nDec	
	Local nSize 

#IFDEF __MT__
	Local xResult
	#IFNDEF __PROTHEUS__
	Local oThread
	#ENDIF
#ENDIF

	THREAD Static __mtoNR
	THREAD Static __mtoN1
	THREAD Static __mtoN2

	DEFAULT __mtoNR := tBigNumber():New()
	DEFAULT __mtoN1 := tBigNumber():New()
	DEFAULT __mtoN2 := tBigNumber():New()

	__mtoN1:SetValue( __mtoN1:Normalize( self  , self  , uBigN ) , NIL , .F. )
	__mtoN2:SetValue( __mtoN2:Normalize( uBigN , uBigN , self  ) , NIL , .F. )

	BEGIN SEQUENCE

		IF ( ( __mtoN1:nSize <= 9 ) .and. ( __mtoN2:nSize <= 9 ) )
			n1	:= Val(__mtoN1:ExactValue())
			n2	:= Val(__mtoN2:ExactValue())
			IF ( ( ( n1 <= 2999999.90 ) .and. ( __mtoN1:nDec <= 2 ) ) .and. ( ( n2 <= 2999999.90 ) .and. __mtoN2:nDec <= 2 ) )
				cBigNT	:= LTrim(Str(n1*n2))
				__mtoNR:SetValue( cBigNT )
				BREAK
			EndIF
		EndIF	

	    nDec	:= ( __mtoN1:nDec * 2 )
	    nSize	:= __mtoN1:nSize
	
	    lNeg1 	:= __mtoN1:lNeg
	    lNeg2	:= __mtoN2:lNeg	
	    lNeg	:= ( lNeg1 .and. .NOT.( lNeg2 ) ) .or. ( .NOT.( lNeg1 ) .and. lNeg2 )
	
	    cBigN1	:= __mtoN1:Int()
	    cBigN1	+= __mtoN1:Dec()
	
	    cBigN2	:= __mtoN2:Int()
	    cBigN2	+= __mtoN2:Dec()
	
	    DEFAULT __lMult := .F.
	
	    IF ( __lMult )
			#IFDEF __MT__
				#IFNDEF __PROTHEUS__
					oThread := hb_threadStart( "__MultThread" , @cBigN1 , @cBigN2 , @nAcc )
					hb_threadJoin( oThread , @xResult )
					hb_threadWaitForAll( { oThread } )
				#ELSE
					xResult := StartJob( "U___MultThread" , __cEnvSrv , .T. , @cBigN1 , @cBigN2 , @nAcc )
				#ENDIF
				__mtoNR:SetValue( xResult , NIL , .F. )
	    	#ELSE
				__mtoNR:SetValue( __Mult( @cBigN1 , @cBigN2 , @nAcc ) , NIL , .F. )    		
	    	#ENDIF
	    Else
			#IFDEF __MT__
				#IFNDEF __PROTHEUS__
					oThread := hb_threadStart( "MultThread" , @cBigN1 , @cBigN2 , @nSize , @nAcc )
					hb_threadJoin( oThread , @xResult )
					hb_threadWaitForAll( { oThread } )
		    	#ELSE
			    	xResult := StartJob( "U_MultThread" , __cEnvSrv , .T. , @cBigN1 , @cBigN2 , @nSize , @nAcc )
		    	#ENDIF
		    	__mtoNR:SetValue( xResult , NIL , .F. )
	    	#ELSE
				__mtoNR:SetValue( Mult( @cBigN1 , @cBigN2 , @nSize , @nAcc ) , NIL , .F. )
	    	#ENDIF
	    EndIF	
	
	    cBigNT	:= __mtoNR:Int()
	    
	    cDec	:= SubStr( cBigNT , -nDec  )
	    cInt	:= SubStr( cBigNT ,  1 , Len( cBigNT ) - nDec )
	    
	    cBigNT	:= cInt
	    cBigNT	+= "."
	    cBigNT	+= cDec
		
		__mtoNR:SetValue( cBigNT )
	    
	    cBigNT	:= __mtoNR:ExactValue()
		
		__mtoNR:SetValue( cBigNT )
	
		IF ( lNeg )
			IF ( __mtoNR:gt( "0" ) )
			    __mtoNR:cSig := "-"
			    __mtoNR:lNeg	:= lNeg
			EndIF
		EndIF

	END SEQUENCE

Return( __mtoNR )

/*
	Method		: Div
	Autor		: Marinaldo de Jesus [ http://www.blacktdn.com.br ]
	Data		: 04/02/2013
	Descricao	: Divisao
	Sintaxe		: tBigNumber():Div( uBigN , lFloat ) -> oBigNR
*/
Method Div( uBigN , lFloat ) CLASS tBigNumber

	Local cDec
	
	Local cBigN1
	Local cBigN2
	Local cBigNR

	Local lNeg	
	Local lNeg1 
	Local lNeg2
	
	Local nAcc	:= __nSetDecimals
	Local nDec 

#IFDEF __MT__
	Local xResult
	#IFNDEF __PROTHEUS__
	Local oThread
	#ENDIF
#ENDIF

	THREAD Static __dvoNR
	THREAD Static __dvoN1
	THREAD Static __dvoN2

	THREAD Static __dvoZero
	THREAD Static __dvoRDiv
	

	BEGIN SEQUENCE

		DEFAULT __dvoZero  := tBigNumber():New()
		DEFAULT __dvoNR := tBigNumber():New()
	
		IF __dvoZero:eq( uBigN )
			__dvoNR:SetValue( __dvoZero )
			BREAK
		EndIF

		DEFAULT __dvoRDiv  := tBigNumber():New()
		DEFAULT __dvoN1 := tBigNumber():New()
		DEFAULT __dvoN2 := tBigNumber():New()
	
		__dvoN1:SetValue( __dvoN1:Normalize( self  , self  , uBigN ) , NIL , .F. )
		__dvoN2:SetValue( __dvoN2:Normalize( uBigN , uBigN , self  ) , NIL , .F. )
	
	    lNeg1 	:= __dvoN1:lNeg
	    lNeg2	:= __dvoN2:lNeg	
	    lNeg	:= ( lNeg1 .and. .NOT.( lNeg2 ) ) .or. ( .NOT.( lNeg1 ) .and. lNeg2 )
	
	    cBigN1	:= __dvoN1:Int()
	    cBigN1	+= __dvoN1:Dec()
	
	    cBigN2	:= __dvoN2:Int()
	    cBigN2	+= __dvoN2:Dec()

		DEFAULT lFloat := .T.

		#IFDEF __MT__
			#IFNDEF __PROTHEUS__
				oThread := hb_threadStart( "DivThread" , @cBigN1 , @cBigN2 , @nAcc , @lFloat )
				hb_threadJoin( oThread , @xResult )
				hb_threadWaitForAll( { oThread } )
		   	#ELSE
			   	xResult := StartJob( "U_DivThread" , __cEnvSrv , .T. , @cBigN1 , @cBigN2 , @nAcc , @lFloat )
		   	#ENDIF
		   	__dvoNR:SetValue( xResult )
		#ELSE
			__dvoNR:SetValue( Div( @cBigN1 , @cBigN2 , @nAcc , @lFloat ) )
		#ENDIF   	
	
		__dvoRDiv:SetValue( __dvoNR:cRDiv , NIL , .F. )
	
		IF ( lFloat )
			
			IF ( __dvoRDiv:gt( __dvoZero ) )
	
				cDec	:= ""
		
				__dvoN2:SetValue( cBigN2 )
		
				While ( __dvoRDiv:lt( __dvoN2 ) )
					__dvoRDiv:cInt	+= "0"
					__dvoRDiv:nInt++
					__dvoRDiv:nSize++
					IF ( __dvoRDiv:lt( __dvoN2 ) )
						cDec += "0"
					EndIF
				End While
		
				While ( __dvoRDiv:gte( __dvoN2 ) )
					
					__dvoRDiv:SetValue( __dvoRDiv:Normalize( @__dvoRDiv  , @__dvoRDiv  , @__dvoN2 ) , NIL , .F. )
					__dvoN2:SetValue( __dvoN2:Normalize( @__dvoN2 , @__dvoN2 , @__dvoRDiv  ) , NIL , .F. )
		
		    		cBigN1	:= __dvoRDiv:Int()
		    		cBigN1	+= __dvoRDiv:Dec()
		
		    		cBigN2	:= __dvoN2:Int()
		    		cBigN2	+= __dvoN2:Dec()

					#IFDEF __MT__
						#IFNDEF __PROTHEUS__
							oThread := hb_threadStart( "DivThread" , @cBigN1 , @cBigN2 , @nAcc , @lFloat )
							hb_threadJoin( oThread , @xResult )
							hb_threadWaitForAll( { oThread } )
						#ELSE
							xResult := StartJob( "U_DivThread" , __cEnvSrv , .T. , @cBigN1 , @cBigN2 , @nAcc , @lFloat )
						#ENDIF
						__dvoRDiv:SetValue( xResult )
					#ELSE
						__dvoRDiv:SetValue( Div( @cBigN1 , @cBigN2 , @nAcc , @lFloat ) )
					#ENDIF	

					cDec	+= __dvoRDiv:ExactValue( .T. )
					nDec	:= Len( cDec )
		
					__dvoRDiv:SetValue( __dvoRDiv:cRDiv , NIL , .F. )
					__dvoRDiv:SetValue( __dvoRDiv:ExactValue( .T. ) )
		
					IF (;
							( __dvoRDiv:eq( __dvoZero ) );
							.or.;
							( nDec >= nAcc );
						)	
						Exit
					EndIF
		
					__dvoN2:SetValue( cBigN2 )
		
					
					While ( __dvoRDiv:lt( __dvoN2 ) )
						__dvoRDiv:cInt	+= "0"
						__dvoRDiv:nInt++
						__dvoRDiv:nSize++
						IF ( __dvoRDiv:lt( __dvoN2 ) )
							cDec += "0"
						EndIF
					End While
				
				End While
		
				cBigNR	:= __dvoNR:ExactValue(.T.)
				cBigNR	+= "."
				cBigNR	+= SubStr( cDec , 1 , nAcc )
		
				__dvoNR:SetValue( cBigNR , __dvoRDiv:ExactValue(.T.) )
	
			EndIF
	
		EndIF
	
		IF ( lNeg )
			IF ( __dvoNR:gt( __dvoZero ) )
			    __dvoNR:cSig	:= "-"
			    __dvoNR:lNeg	:= lNeg
			EndIF
		EndIF

	End Sequence

Return( __dvoNR )

/*
	Method		: Mod
	Autor		: Marinaldo de Jesus [ http://www.blacktdn.com.br ]
	Data		: 05/03/2013
	Descricao	: Resto da Divisao
	Sintaxe		: tBigNumber():Mod( uBigN ) -> uBigNR
*/
Method Mod( uBigN ) CLASS tBigNumber

	Local lGetValue	
	
	Local oBigNR := tBigNumber():New()
	
	Local uBigNR

	oBigNR:SetValue( self:Div( @uBigN , .F. ) )

    lGetValue	:= ( ValType( uBigN ) == "C" )
	
	IF ( lGetValue )
	    uBigNR	:= oBigNR:cRDiv
	Else
	    uBigNR	:= oBigNR:SetValue( oBigNR:cRDiv , NIL , .F. )
	EndIF

Return( uBigNR )

/*
	Method		: Pow
	Autor		: Marinaldo de Jesus [ http://www.blacktdn.com.br ]
	Data		: 05/03/2013
	Descricao	: Caltulo de Potencia
	Sintaxe		: tBigNumber():Pow( uBigN ) -> oBigNR
*/
Method Pow( uBigN ) CLASS tBigNumber

	Local cM10
	
	Local cPowB
	Local cPowA
	
	Local lPoWN
	Local lPowF

	THREAD Static __pwoA
	THREAD Static __pwoB
	
	THREAD Static __pwoN0
	THREAD Static __pwoN1
	THREAD Static __pwoNP
	THREAD Static __pwoNR
	THREAD Static __pwoNT
	
	THREAD Static __pwoGCD

	DEFAULT __pwoN0	:= tBigNumber():New()
	DEFAULT __pwoN1	:= tBigNumber():New("1")
	DEFAULT __pwoNP	:= tBigNumber():New()
	DEFAULT __pwoNR	:= tBigNumber():New()
	DEFAULT __pwoNT	:= tBigNumber():New()

	lPoWN	:= ( __pwoNP:SetValue( uBigN ):lt( __pwoN0 ) )

	BEGIN SEQUENCE

		IF ( self:eq( __pwoN0 ) .and. __pwoNP:eq( __pwoN0 ) )
			__pwoNR:SetValue( __pwoN1 )
			BREAK
		EndIF

		IF ( self:eq( __pwoN0 ) )
			__pwoNR:SetValue( __pwoN0 )
			BREAK
		EndIF

		IF ( __pwoNP:eq( __pwoN0 ) )
			__pwoNR:SetValue( __pwoN1 )
			BREAK
		EndIF

		__pwoNR:SetValue( self )

		IF ( __pwoNR:eq( __pwoN1 ) )
			__pwoNR:SetValue( __pwoN1 )
			BREAK
		EndIF

		IF ( __pwoN1:eq( __pwoNP:SetValue( __pwoNP:Abs() ) ) )
			BREAK
		EndIF

		DEFAULT __pwoA	:= tBigNumber():New()

		lPowF := __pwoA:SetValue( __pwoNP:Dec() ):gt( __pwoN0 )
		
		IF ( lPowF )

			cPowA	:= ( __pwoNP:Int()+__pwoNP:Dec(NIL,.T.) )
			__pwoA:SetValue( cPowA )

			DEFAULT __pwoB	:= tBigNumber():New()

			cM10	:= "1"
			cM10	+= Replicate( "0" , ( Len( __pwoNP:Dec(NIL,.T.) ) ) )

			cPowB	:= cM10

			IF ( __pwoB:SetValue( cPowB ):gt( __pwoN1 ) )
				DEFAULT __pwoGCD	:= tBigNumber():New()
				__pwoGCD:SetValue( __pwoA:GCD( __pwoB ) )
				__pwoA:SetValue( __pwoA:Div( __pwoGCD ) )
				__pwoB:SetValue( __pwoB:Div( __pwoGCD ) )
			EndIF

			__pwoA:SetValue( __pwoA:Normalize( __pwoA , __pwoA , __pwoB ) , NIL , .F. )
			__pwoB:SetValue( __pwoB:Normalize( __pwoB , __pwoB , __pwoA ) , NIL , .F. )

			__pwoNP:SetValue( __pwoA )

		EndIF

		BEGIN SEQUENCE

			#IFDEF __POWMT__
				IF ( __pwoNP:gt( "10" ) )
					__pwoNR:SetValue( PowThread( __pwoNR , __pwoNP ) )
					BREAK
				EndIF
			#ENDIF	

			__pwoNT:SetValue( __pwoN0 )
			__pwoNP:SetValue( __pwoNP:Sub( __pwoN1 ) )
			While ( __pwoNT:lt( __pwoNP ) )	
				__pwoNR:SetValue( __pwoNR:Mult( self )  )
				__pwoNT:SetValue( __pwoNT:Add( __pwoN1 ) )
			End While

		END SEQUENCE
	
		IF ( lPowF )
			__pwoNR:SetValue( __pwoNR:nthRoot( __pwoB ) )
		EndIF

	END SEQUENCE

	IF ( lPoWN )
		__pwoNR:SetValue( __pwoN1:Div( __pwoNR ) )	
	EndIF

Return( __pwoNR )

#IFDEF __POWMT__

	/*/
		Funcao:		PowThread
		Autor:		Marinaldo de Jesus
		Data:		25/02/2013
		Descricao:	Utilizada no Metodo Pow para o Calculo da Potencia via Job
		Sintaxe:	PowThread( oN1 , oN2 )
	/*/
	Static Function PowThread( oN1 , oN2 )
	
		Local aNR
	
		Local oNR		:= tBigNumber():New()
	
		Local oNZ		:= tBigNumber():New()
		Local oNO		:= tBigNumber():New("1")
	
		Local oN5		:= tBigNumber():New( "5" )
		Local oM10		:= tBigNumber():New( "10" )

		Local oQ10		:= tBigNumber():New()
		Local oQTh		:= tBigNumber():New()

		Local oCN1		:= tBigNumber():New( oN1 )
		Local oCN2		:= tBigNumber():New( oN2 )

	#IFDEF __HARBOUR__
		Local aThreads
		Local aResults
	#ELSE //__PROTHEUS__
		Local cGlbV
		Local cEnvSrv	:= GetEnvServer()	
		Local cThread	:= AllTrim( Str( ThreadID() ) )
	#ENDIF	
	
		Local l10		:= .F.
		Local lM10		:= .F.
		Local lExit		:= .F.
		
	#IFDEF __PROTHEUS__
		Local nNR
	#ENDIF
		Local nID
		Local nIDs
	
		BEGIN SEQUENCE
	
			IF ( oCN2:lt( oM10 ) )
				oNR:SetValue( oN1:Pow( oN2 ) )
				BREAK
			EndIF
	        
			l10		:= oCN2:eq( oM10 )
			lM10	:= l10
			
			IF .NOT.( lM10 )
				lM10	:= oCN2:Mod( oM10 ):eq( oNZ )
				l10		:= lM10
			EndIF	
	
			oQ10:SetValue( oCN2:Div( oM10 ):Int( .T. ) )
			oCN2:SetValue( oCN2:Sub( oQ10:Mult( oM10 ) ) )

			oNR:SetValue( oCN1 )
	
			aNR	:= Array(0)

			While ( oQ10:gt( oNZ ) )
	
				oQTh:SetValue( oN5:Min( oQ10 ) )
				oQ10:SetValue( oQ10:Sub( oQTh ) )
	
				#IFDEF __PROTHEUS__
					lExit	:= ( ( lExit ) .or. KillApp() )
					IF ( lExit )
						Exit
					EndIF
				#ENDIF	
	
				While ( oQTh:gt( oNZ ) )
					
					oQTh:SetValue( oQTh:Sub( oNO ) )
	
					aAdd( aNR , Array( 5 ) )

					nID	:= Len( aNR )
	
					aNR[nID][4]	:= .F.

		        	#IFDEF __HARBOUR__
			        	aNR[nID][1]	:= oCN1
		        		aNR[nID][2]	:= oM10
					#ELSE //__PROTHEUS__
			        	aNR[nID][1]	:= oCN1:GetValue()
		        		aNR[nID][2]	:= oM10:GetValue()
			        	aNR[nID][3]	:= ( "__POW__" + "ThreadID__" + cThread + "__ID__" + AllTrim( Str( nID ) ) )
			        	PutGlbValue( aNR[nID][3] , "" )
			        	StartJob( "U_POWJOB" , cEnvSrv , .F. , aNR[nID][1] , aNR[nID][2] , aNR[nID][3] , __nSetDecimals , __nthRootAcc )
			        #ENDIF //__HARBOUR__

				End While
	
				nIDs := nID

				#IFDEF __HARBOUR__

					aThreads	:= Array( nIDs )
				    aResults	:= Array( nIDs )
      				For nID := 1 To nIDs
         				aThreads[nID] := hb_threadStart( "PowJob" , aNR[nID][1] , aNR[nID][2] , __nSetDecimals , __nthRootAcc )
						hb_threadJoin( aThreads[nID] , @aResults[nID] )
      				Next nID
					
					hb_threadWaitForAll( aThreads )
      				
      				For nID := 1 To nIDs
						aNR[nID][4]	:= .T.
						aNR[nID][5]	:= aResults[nID]
      				Next nID

				#ELSE //__PROTHEUS__

					While .NOT.( lExit )
					
						#IFDEF __PROTHEUS__
							lExit	:= ( ( lExit ) .or. KillApp() )
							IF ( lExit )
								Exit
							EndIF
						#ENDIF	
					    
						nNR		:= 0
		
						For nID := 1 To nIDs
		
							IF .NOT.( aNR[nID][4] )
			
								cGlbV	:= GetGlbValue( aNR[nID][3] )
								
								IF .NOT.( cGlbV == "" )
				
									aNR[nID][4]	:= .T.
									aNR[nID][5]	:= cGlbV
			
									cGlbV	:= NIL
			
									ClearGlbValue( aNR[nID][3] )
			
									lExit	:= ( ( ++nNR ) == nIDs )
			                                                                      	
									IF ( lExit )
										Exit
									EndIF
			
								EndIF
			
							Else
			
								lExit := ( ( ++nNR ) == nIDs )
			
								IF ( lExit )
									Exit
								EndIF
						
							EndIF
			
						Next nID	
			
						IF ( lExit )
							Exit
						EndIF

					End While

				#ENDIF	//__HARBOUR__
	
				For nID := IF( lM10 , 2 , 1 ) To nIDS
					oNR:SetValue( oNR:Mult( aNR[nID][5] ) )
					lM10	:= .F.
				Next nID
				
				aSize( aNR , 0 )
	
			End While
	
			aNR		:= NIL

			IF ( l10 )
				oNR		:= oNR:Mult( oCN1 )
				BREAK
			EndIF
			
			While ( oCN2:gt( oNO )  )
				oCN2:SetValue( oCN2:Sub( oNO ) )
				oNR:SetValue( oNR:Mult( oCN1 ) )
			End While

		END SEQUENCE
	
	Return( oNR )

	#IFDEF __HARBOUR__

		/*/
			Funcao:		PowJob
			Autor:		Marinaldo de Jesus
			Data:		25/02/2013
			Descricao:	Utilizada no Metodo Pow para o Calculo da Potencia via Job
			Sintaxe:	hb_threadStart( "PowJob" , oN1 , oN2 , nSetDecimals , nthRootAcc )
		/*/
		Function PowJob( oN1 , oN2 , nSetDecimals , nthRootAcc )
		
			Local oNR	:= tBigNumber():New()

			__nthRootAcc	:= nSetDecimals
			__nSetDecimals	:= nthRootAcc

			oNR:SetValue( oN1:Pow( oN2 ) )

		Return( oNR )
	
	#ELSE //__PROTHEUS__

		/*/
			Funcao:		U_PowJob
			Autor:		Marinaldo de Jesus
			Data:		25/02/2013
			Descricao:	Utilizada no Metodo Pow para o Calculo da Potencia via Job
			Sintaxe:	StartJob( "U_POWJOB" , cEnvironment , lWaitRun , cN1 , cN2 , cID , nSetDecimals , nthRootAcc )
		/*/
		User Function PowJob( cN1 , cN2 , cID , nSetDecimals , nthRootAcc )
		
			Local cNR
		
			Local oN1	:= tBigNumber():New( cN1 )
			Local oN2	:= tbigNumber():New( cN2 )
		
			__nthRootAcc	:= nSetDecimals
			__nSetDecimals	:= nthRootAcc
		
			PTInternal( 1 , "[tBigNumber][POW][U_POWJOB]["+cID+"][CALC][" + cN1 + " ^ " + cN2 + "]" )
		
			cNR			:= oN1:Pow( oN2 ):GetValue()
		
			PTInternal( 1 , "[tBigNumber][POW][U_POWJOB]["+cID+"][RESULT][" + cNR + "]" )
		
			PutGlbValue( cID , cNR )
		
		Return( .T. )

	#ENDIF //__HARBOUR__

#ENDIF	//__POWMT__

/*
	Method		: e
	Autor		: Marinaldo de Jesus [ http://www.blacktdn.com.br ]
	Data		: 06/02/2013
	Descricao	: Retorna o Numero de Neper ( 2.718281828459045235360287471352662497757247... )
	Sintaxe		: tBigNumber():e( lForce ) -> oeTthD
	( ( ( n + 1 ) ^ ( n + 1 ) ) / ( n ^ n ) ) - (  ( n ^ n ) / ( ( n - 1 )  ^ ( n - 1 ) ) )
*/
Method e( lForce ) CLASS tBigNumber

	Local oeTthD

	Local oPowN
	Local oDiv1P
	Local oDiv1S
	Local oBigNC
	Local oBigN1
	Local oAdd1N
	Local oSub1N
	Local oPoWNAd
	Local oPoWNS1

	BEGIN SEQUENCE
		
		DEFAULT lForce	:= .F.

		IF .NOT.( lForce )

			oeTthD	:= tBigNumber():New()
			oeTthD:SetValue( __eTthD() )

			BREAK

		EndIF

		oBigNC	:= tBigNumber():New( self )
		oBigN1	:= tBigNumber():New( "1" )
		
		IF oBigNC:eq( "0" )
			oBigNC:SetValue( oBigN1 )
		EndIF

		oPowN   := tBigNumber():New( oBigNC )
		
		oPowN:SetValue( oPowN:Pow( oPowN )  )
		
		oAdd1N	:= oBigNC:Add( oBigN1 )
		oSub1N	:= oBigNC:Sub( oBigN1 )

		oPoWNAd	:= oAdd1N:Pow( oAdd1N )
		oPoWNS1	:= oSub1N:Pow( oSub1N )
        
		oDiv1P	:= oPoWNAd:Div( oPowN )
		oDiv1S	:= oPowN:Div( oPoWNS1 )

		oeTthD:SetValue( oDiv1P:Sub( oDiv1S ) )

	END SEQUENCE

Return( oeTthD )

/*
	Method:		Exp
	Autor:		Marinaldo de Jesus [ http://www.blacktdn.com.br ]
	Data:		06/02/2013
	Descricao:	Potencia do Numero de Neper e^cN
	Sintaxe:	tBigNumber():Exp( lForce ) -> oBigNR
*/
Method Exp( lForce ) CLASS tBigNumber
	Local oBigNe := self:e( @lForce )
	Local oBigNR := oBigNe:Pow( self )
Return( oBigNR )

/*
	Method:		PI
	Autor:		Marinaldo de Jesus [ http://www.blacktdn.com.br ]
	Data:		04/02/2013
	Descricao:	Retorna o Numero Irracional PI ( 3.1415926535897932384626433832795... )
	Sintaxe:	tBigNumber():PI( lForce ) -> oPITthD
*/
Method PI( lForce ) CLASS tBigNumber
	
	Local oPITthD

	DEFAULT lForce	:= .F.

	BEGIN SEQUENCE

		lForce := .F.	//TODO: Implementar o calculo.

		IF .NOT.( lForce )

			oPITthD	:= tBigNumber():New()
			oPITthD:SetValue( __PITthD() )

			BREAK

		EndIF

		//TODO: Implementar o calculo, Depende de Pow com Expoente Fracionario

	END SEQUENCE

Return( oPITthD )

/*
	Method:		GCD
	Autor:		Marinaldo de Jesus [ http://www.blacktdn.com.br ]
	Data:		23/02/2013
	Descricao:	Retorna o MDC
	Sintaxe:	tBigNumber():GCD( uBigN ) -> oGCD
*/
Method GCD( uBigN ) CLASS tBigNumber

 	Local o0	:= tBigNumber():New()
 	
 	Local oN1	:= tBigNumber():New(self)
 	Local oN2	:= tBigNumber():New(uBigN)
 	
 	Local oNT	:= tBigNumber():New()
	
	Local oGCD	

 	oNT:SetValue( oN1:Max( oN2 ) )
 	oN2:SetValue( oN1:Min( oN2 ) )
 	oN1:SetValue( oNT )

	oN1:SetValue( oN1:Mod( oN2 ) )
	oNT:SetValue( oN1 )
	oN1:SetValue( oN2 )
	oN2:SetValue( oNT )

	While oN2:ne( o0 )
		oN1:SetValue( oN1:Mod( oN2 ) )
		oNT:SetValue( oN1 )
		oN1:SetValue( oN2 )
		oN2:SetValue( oNT )
	End While

	oGCD	:= tBigNumber():New( oN1 )

Return( oGCD )

/*
	Method:		LCM
	Autor:		Marinaldo de Jesus [ http://www.blacktdn.com.br ]
	Data:		23/02/2013
	Descricao:	Retorna o MMC
	Sintaxe:	tBigNumber():LCM( uBigN ) -> oLCM
*/
Method LCM( uBigN ) CLASS tBigNumber
	
	Local o0	:= tBigNumber():New()
	Local o1	:= tBigNumber():New("1")

	Local oN1	:= tBigNumber():New(self)
	Local oN2	:= tBigNumber():New(uBigN)

	Local oNI	:= tBigNumber():New("2")
	
	Local oLCM	:= tBigNumber():New(o1)

	BEGIN SEQUENCE

		While ( .T. )
			While ( oN1:Mod( oNI ):eq( o0 ) .or. oN2:Mod( oNI ):eq( o0 ) )
				oLCM:SetValue( oLCM:Mult( oNI ) )
				IF oN1:Mod( oNI ):eq( o0 )
					oN1:SetValue( oN1:Div( oNI , .F. ) )
				EndIF
				IF oN2:Mod( oNI ):eq( o0 )
					oN2:SetValue( oN2:Div( oNI , .F. ) )
				EndIF
			End While
			IF ( oN1:eq( o1 ) .and. oN2:eq( o1 ) )
				BREAK
			EndIF
			oNI:SetValue( oNI:Add( o1 ) )		
		End While

	END SEQUENCE

Return( oLCM )

/*

	Method:		nthRoot
	Autor:		Marinaldo de Jesus [ http://www.blacktdn.com.br ]
	Data:		05/03/2013
	Descricao:	Radiciação 
	Sintaxe:	tBigNumber():nthRoot( uBigN ) -> othRoot
*/
Method nthRoot( uBigN ) CLASS tBigNumber

	Local cFExit
		
	Local nAcc		:= __nSetDecimals

	Local oRoot0
	Local oRoot1
	Local oRootB
	Local othRoot

	Local oRootE
	Local oFExit

	othRoot	:= tBigNumber():New()

	BEGIN SEQUENCE

		oRoot0	:= tBigNumber():New()
		oRootB	:= tBigNumber():New( self )

		IF oRootB:eq( oRoot0 )
			BREAK
		EndIF

		IF ( oRootB:lNeg )
			BREAK
		EndIF

		oRoot1	:= tBigNumber():New("1")

		IF oRootB:eq( oRoot1 )
			othRoot:SetValue( oRoot1 )
			BREAK
		EndIF

		oRootE	:= tBigNumber():New( uBigN )

		IF oRootE:eq( oRoot0 )
			BREAK
		EndIF

		IF oRootE:eq( oRoot1 )
			othRoot:SetValue( oRootB )
			BREAK
		EndIF

		cFExit	:= "0."
		cFExit	+= Replicate( "0" , ( __nthRootAcc - 1 ) )
		cFExit	+= "1"
			
		oFExit	:= tBigNumber():New()

		oFExit:SetValue( cFExit , NIL , NIL , @__nthRootAcc )

		othRoot:SetValue( nthRoot( @oRootB , @oRootE , @oFExit , @nAcc ) )

	END SEQUENCE

Return( othRoot )

/*
	Method:		SQRT
	Autor:		Marinaldo de Jesus [ http://www.blacktdn.com.br ]
	Data:		06/03/2013
	Descricao:	Retorna a Raiz Quadrada ( radix quadratum -> O Lado do Quadrado ) do Numero passado como parametro
	Sintaxe:	tBigNumber():SQRT() -> oSQRT
*/
Method SQRT() CLASS tBigNumber

	Local oSQRT
	Local oZero

	Local nSetDec

	oSQRT	:= tBigNumber():New( self )

	oZero	:= tBigNumber():New("0")

	BEGIN SEQUENCE

		IF oSQRT:lte( self:SysSQRT() )
			nSetDec := Set( _SET_DECIMALS , __nSetDecimals )
			oSQRT:SetValue( Str( SQRT( Val( oSQRT:GetValue() ) ) ) )
			Set( _SET_DECIMALS, nSetDec )
			BREAK
		EndIF

		IF oSQRT:eq( oZero )
			oSQRT:SetValue( oZero )
			BREAK
		EndIF

		oSQRT:SetValue( oSQRT:nthRoot( "2" ) )

	END SEQUENCE

Return( oSQRT )

/*
	Method:		SysSQRT
	Autor:		Marinaldo de Jesus [ http://www.blacktdn.com.br ]
	Data:		06/03/2013
	Descricao:	Define o valor maximo para calculo da SQRT considerando a funcao padrao
	Sintaxe:	tBigNumber():SysSQRT( uSet ) -> oSysSQRT
*/
Method SysSQRT( uSet ) CLASS tBigNumber

	Local cType
	Local oSysSQRT	:= tBigNumber():New()

	THREAD Static __uSysSQRT

	DEFAULT __uSysSQRT	:= "999999999999999"
	DEFAULT uSet 		:= __uSysSQRT

	__uSysSQRT			:= uSet
	cType				:= ValType( __uSysSQRT )

	oSysSQRT:SetValue( IF( ( cType $ "C|O" ) , __uSysSQRT , IF( ( cType == "N" ) , Str( __uSysSQRT ) , "0" ) ) )

Return( oSysSQRT )

/*
	Method		: Log
	Autor		: Marinaldo de Jesus [ http://www.blacktdn.com.br ]
	Data		: 20/02/2013
	Descricao	: Retorna o logaritmo na Base N DEFAULT 10
	Sintaxe		: tBigNumber():Log( Log( uBigNB ) -> oBigNR
	Referencia	: //http://www.vivaolinux.com.br/script/Calculo-de-logaritmo-de-um-numero-por-um-terceiro-metodo-em-C
*/
Method Log( uBigNB ) CLASS tBigNumber

	Local o0		:= tBigNumber():New()
	Local o1		:= tBigNumber():New("1")
	Local o2		:= tBigNumber():New("2")
	Local oS 		:= tBigNumber():New()
	Local oT 		:= tBigNumber():New()
	Local oI 		:= tBigNumber():New("1")
	Local oX 		:= tBigNumber():New(self)
	Local oY		:= tBigNumber():New()
	Local oLT		:= tBigNumber():New()

	Local oBigNR

	Local lflag		:= .F.

	DEFAULT uBigNB	:= "10"

	oT:SetValue(uBigNB)

	IF ( o0:lt( oT ) .and. oT:lt( o1 ) )
	 	lflag := .NOT.( lflag )
	 	oT:SetValue( o1:Div( oT ) )
	EndIF

	While ( oX:gt( oT ) .and. oT:gt( o1 ) )
		oY:SetValue( oY:Add( oI ) )
		oX:SetValue( oX:Div( oT ) )
	End While 

	oS:SetValue( oS:Add( oY ) )
	oY:SetValue( o0 )
	oT:SetValue( oT:Sqrt() )
	oI:SetValue( oI:Div( o2 ) )
    
	While ( oT:gt( o1 ) )

		While ( oX:gt( oT ) .and. oT:gt( o1 ) )
			oY:SetValue( oY:Add( oI ) )
			oX:SetValue( oX:Div( oT ) )
		End While 
	
		oS:SetValue( oS:Add( oY ) )
		oY:SetValue( o0 )
		oLT:SetValue( oT )
		oT:SetValue( oT:Sqrt() )
		IF oT:eq( oLT )
        	oT:SetValue(o0)	
		EndIF 
		oI:SetValue( oI:Div( o2 ) )

	End While

	IF ( lflag )
		oS:SetValue( oS:Mult( "-1" ) )
	EndIF	

	oBigNR	:= tBigNumber():New( oS )

Return( oBigNR )

/*
	Method		: Log2
	Autor		: Marinaldo de Jesus [ http://www.blacktdn.com.br ]
	Data		: 20/02/2013
	Descricao	: Retorna o logaritmo Base 2
	Sintaxe		: tBigNumber():Log2() -> oBigNR
*/
Method Log2() CLASS tBigNumber
	Local ob2 := tBigNumber():New("2")
Return( self:Log( ob2 ) )

/*
	Method		: Log10
	Autor		: Marinaldo de Jesus [ http://www.blacktdn.com.br ]
	Data		: 20/02/2013
	Descricao	: Retorna o logaritmo Base 10
	Sintaxe		: tBigNumber():Log10() -> oBigNR
*/
Method Log10() CLASS tBigNumber
	Local ob10 := tBigNumber():New("10")
Return( self:Log( ob10 ) )

/*
	Method		: Ln
	Autor		: Marinaldo de Jesus [ http://www.blacktdn.com.br ]
	Data		: 20/02/2013
	Descricao	: Logaritmo Natural
	Sintaxe		: tBigNumber():Ln() -> oBigNR
*/
Method Ln() CLASS tBigNumber
	Local o1exp	:= tBigNumber():New("1")
Return( self:Log( o1exp:Exp() ) )

/*
	Method		: aLog
	Autor		: Marinaldo de Jesus [ http://www.blacktdn.com.br ]
	Data		: 20/02/2013
	Descricao	: Retorna o Antilogaritmo 
	Sintaxe		: tBigNumber():aLog( Log( uBigNB ) -> oBigNR
*/
Method aLog( uBigNB ) CLASS tBigNumber
	Local oaLog	:= tBigNumber():New( uBigNB )
Return( oaLog:Pow(self) )

/*
	Method		: aLog2
	Autor		: Marinaldo de Jesus [ http://www.blacktdn.com.br ]
	Data		: 20/02/2013
	Descricao	: Retorna o Antilogaritmo Base 2
	Sintaxe		: tBigNumber():aLog2() -> oBigNR
*/
Method aLog2() CLASS tBigNumber
	Local ob2 := tBigNumber():New("2")
Return( self:aLog( ob2 ) )

/*
	Method		: aLog10
	Autor		: Marinaldo de Jesus [ http://www.blacktdn.com.br ]
	Data		: 20/02/2013
	Descricao	: Retorna o Antilogaritmo Base 10
	Sintaxe		: tBigNumber():aLog10() -> oBigNR
*/
Method aLog10() CLASS tBigNumber
	Local ob10 := tBigNumber():New("10")
Return( self:aLog( ob10 ) )

/*
	Method		: aLn
	Autor		: Marinaldo de Jesus [ http://www.blacktdn.com.br ]
	Data		: 20/02/2013
	Descricao	: Retorna o AntiLogaritmo Natural
	Sintaxe		: tBigNumber():aLn() -> oBigNR
*/
Method aLn() CLASS tBigNumber
	Local o1exp	:= tBigNumber():New("1")
Return( self:aLog( o1exp:Exp() ) )

/*
	Method:		MathC
	Autor:		Marinaldo de Jesus [ http://www.blacktdn.com.br ]
	Data:		05/03/2013
	Descricao:	Operacoes Matematicas
	Sintaxe:	tBigNumber():MathC( uBigN1 , cOperator , uBigN2 ) -> cBigNR
*/
Method MathC( uBigN1 , cOperator , uBigN2 ) CLASS tBigNumber
Return( MathO( @uBigN1 , @cOperator , @uBigN2 , .F. ) )

/*
	Method		: MathN
	Autor		: Marinaldo de Jesus [ http://www.blacktdn.com.br ]
	Data		: 04/02/2013
	Descricao	: Operacoes Matematicas
	Sintaxe		: tBigNumber():MathN( uBigN1 , cOperator , uBigN2 ) -> oBigNR
*/
Method MathN( uBigN1 , cOperator , uBigN2 ) CLASS tBigNumber
Return( MathO( @uBigN1 , @cOperator , @uBigN2 , .T. ) )

/*
	Method		: Rnd
	Autor		: Marinaldo de Jesus [ http://www.blacktdn.com.br ]
	Data		: 06/02/2013
	Descricao	: Redefine a Precisao de Numero em PF
	Sintaxe		: tBigNumber():Rnd( nAcc ) -> oBigNR
*/
Method Rnd( nAcc ) CLASS tBigNumber

	Local cAdd
	
	Local oAcc
	Local oDec := tBigNumber():New( self:Dec() )

	DEFAULT nAcc := Min( self:nDec , __nSetDecimals )

	IF .NOT.( oDec:eq( "0" ) )
		oAcc := tBigNumber():New( SubStr( oDec:ExactValue() , ( nAcc + 1 ) , 1 ) )
		IF oAcc:gte( "5" )
			oDec:SetValue("10")
			cAdd := "0."
			cAdd += Replicate("0",@nAcc)
			cAdd += cAdd += oDec:Sub(oAcc):Int()
		Else
			oAcc := tBigNumber():New( SubStr( oDec:ExactValue() , ( nAcc ) , 1 ) )
			IF oAcc:gte( "5" )
				oDec:SetValue("10")
				cAdd := "0."
				cAdd += Replicate("0",nAcc-1)
				cAdd += cAdd += oDec:Sub(oAcc):Int()
			Else
				cAdd := "0"
			EndIF	
		EndIF
		IF .NOT.( cAdd == "0" )
			self:SetValue( self:Add( cAdd ) )
		EndIF
		self:SetValue( self:Int() + "." + SubStr( self:Dec() , 1 , nAcc ) , self:cRDiv )
	EndIF

Return( self )

/*
	Method		: NoRnd
	Autor		: Marinaldo de Jesus [ http://www.blacktdn.com.br ]
	Data		: 06/02/2013
	Descricao	: Redefine a Precisao de Numero em PF
	Sintaxe		: tBigNumber():NoRnd( nAcc ) -> oBigNR
*/
Method NoRnd( nAcc ) CLASS tBigNumber
Return( Self:Truncate( nAcc ) )

/*
	Method		: Truncate
	Autor		: Marinaldo de Jesus [ http://www.blacktdn.com.br ]
	Data		: 06/02/2013
	Descricao	: Redefine a Precisao de Numero em PF
	Sintaxe		: tBigNumber():Truncate( nAcc ) -> oBigNR
*/
Method Truncate( nAcc ) CLASS tBigNumber

	Local oDec := tBigNumber():New( self:Dec() )

	DEFAULT nAcc := Min( self:nDec , __nSetDecimals )

	IF .NOT.( oDec:eq( "0" ) )
		oDec:SetValue( SubStr( oDec:ExactValue() , 1 , nAcc ) )
		self:SetValue( self:Int() + "." + oDec:Int() )
	EndIF

Return( self )

/*
	Method		: Normalize
	Autor		: Marinaldo de Jesus [ http://www.blacktdn.com.br ]
	Data		: 04/02/2013
	Descricao	: Normaliza os Dados
	Sintaxe		: tBigNumber():Normalize( uBigN0 , uBigN1 , uBigN2 ) -> oBigN0
*/
Method Normalize( uBigN0 , uBigN1 , uBigN2 ) CLASS tBigNumber

	Local cInt
	Local cDec

	Local nPadL
	Local nPadR

	THREAD Static __NoN0
	THREAD Static __NoN1
	THREAD Static __NoN2

	DEFAULT __NoN0 := tBigNumber():New()
	DEFAULT __NoN1 := tBigNumber():New()
	DEFAULT __NoN2 := tBigNumber():New()

	__NoN0:SetValue( uBigN0 )
	__NoN1:SetValue( uBigN1 )
	__NoN2:SetValue( uBigN2 )

	nPadL	:= Max( __NoN1:nInt , __NoN2:nInt )
	nPadR	:= Max( __NoN1:nDec , __NoN2:nDec )

    cInt	:= PadL( __NoN0:Int() , nPadL , "0" )
    cDec	:= PadR( __NoN0:Dec() , nPadR , "0" )

	__NoN0:cInt	:= cInt
	__NoN0:nInt	:= nPadL
	__NoN0:cDec	:= cDec
	__NoN0:nDec	:= nPadR
	__NoN0:nSize	:= ( nPadL + nPadR )

Return( __NoN0 )

/*
	Method		: D2H
	Autor		: Marinaldo de Jesus [ http://www.blacktdn.com.br ]
	Data		: 07/02/2013
	Descricao	: Converte Decimal para Hexa
	Sintaxe		: tBigNumber():D2H( cHexB ) -> cHexN
*/
Method D2H( cHexB ) CLASS tBigNumber

	Local oZero		:= tBigNumber():New()
	Local otBigH	:= tBigNumber():New()
	Local otBigN	:= tBigNumber():New( self:Int()+self:Dec(NIL,.T.) )

	Local cHexN		:= ""
	Local cHexC		:= "0123456789ABCDEFGHIJKLMNOPQRSTUV"

	Local nAT
	
	DEFAULT cHexB	:= "16"

	otBigH:SetValue( cHexB )
	
	While ( otBigN:gt( oZero ) )
		otBigN:SetValue( otBigN:Div( otBigH , .F. ) )
		nAT				:= ( Val( otBigN:cRDiv ) + 1 )
		cHexN			:= ( SubStr( cHexC , nAT , 1 ) + cHexN )
	End While

	IF ( cHexN == "" )
		cHexN := "0"		
	EndIF

Return( cHexN )

/*
	Method		: H2D
	Autor		: Marinaldo de Jesus [ http://www.blacktdn.com.br ]
	Data		: 07/02/2013
	Descricao	: Converte Hexa para Decimal
	Sintaxe		: tBigNumber():H2D( cHexN , cHexB ) -> otBigNR
*/
Method H2D( cHexN , cHexB ) CLASS tBigNumber

	Local otBigH	:= tBigNumber():New()
	Local otBigN1	:= tBigNumber():New("1")
	Local otBigNR	:= tBigNumber():New()
	Local otBigLN	:= tBigNumber():New()
	Local otBigPw	:= tBigNumber():New()
	Local otBigNI	:= tBigNumber():New()
	Local otBigAT	:= tBigNumber():New()

	Local cHexC		:= "0123456789ABCDEFGHIJKLMNOPQRSTUV"

	Local nLn		:= Len( cHexN )
	Local nI		:= nLn

	DEFAULT cHexB	:= "16"

	otBigH:SetValue( cHexB )
	otBigLN:SetValue( LTrim( Str( nLn ) ) )

	While ( nI > 0 )
		otBigNI:SetValue( LTrim( Str( --nI ) ) )
	    otBigAT:SetValue( LTrim( Str( ( AT( SubStr( cHexN , nI + 1 , 1 ) , cHexC ) - 1 ) ) ) ) 
        otBigPw:SetValue( otBigLN:Sub( otBigNI ) )
        otBigPw:SetValue( otBigPw:Sub( otBigN1 ) )
		otBigPw:SetValue( otBigH:Pow( otBigPw ) )
        otBigAT:SetValue( otBigAT:Mult( otBigPw ) )
        otBigNR:SetValue( otBigNR:Add( otBigAT ) )
    End While

Return( otBigNR )

/*
	Method		: H2B
	Autor		: Marinaldo de Jesus [ http://www.blacktdn.com.br ]
	Data		: 07/02/2013
	Descricao	: Converte Hex para Bin
	Sintaxe		: tBigNumber():H2B( cHexN ) -> cBin
*/
Method H2B( cHexN , cHexB ) CLASS tBigNumber

	Local aH2B	:= {;
							{ "0" , "00000" },;
							{ "1" , "00001" },;
							{ "2" , "00010" },;
							{ "3" , "00011" },;
							{ "4" , "00100" },;
							{ "5" , "00101" },;
							{ "6" , "00110" },;
							{ "7" , "00111" },;
							{ "8" , "01000" },;
							{ "9" , "01001" },;
							{ "A" , "01010" },;
							{ "B" , "01011" },;
							{ "C" , "01100" },;
							{ "D" , "01101" },;
							{ "E" , "01110" },;
							{ "F" , "01111" },;
							{ "G" , "10000" },;
							{ "H" , "10001" },;
							{ "I" , "10010" },;
							{ "J" , "10011" },;
							{ "K" , "10100" },;
							{ "L" , "10101" },;
							{ "M" , "10110" },;
							{ "N" , "10111" },;
							{ "O" , "11000" },;
							{ "P" , "11001" },;
							{ "Q" , "11010" },;
							{ "R" , "11011" },;
							{ "S" , "11100" },;
							{ "T" , "11101" },;
							{ "U" , "11110" },;
							{ "V" , "11111" };
						}

	Local cChr
	Local cBin	:= ""

	Local nI	:= 0
	Local nLn	:= Len( cHexN )
	Local nAT

	Local l16

	BEGIN SEQUENCE

		IF Empty( cHexB )
			For nAT := 17 TO 32
				IF ( aH2B[ nAT ][ 1 ] $ cHexN )
					cHexB	:= "32"
					EXIT
				EndIF
			Next nAT
			IF Empty( cHexB )
				For nAT := 1 TO 16
					IF ( aH2B[ nAT ][ 1 ] $ cHexN )
						cHexB	:= "16"
						EXIT
					EndIF	
				Next nAT
			EndIF
		EndIF

		IF .NOT.( cHexB $ "[16][32]" )
			BREAK
		EndIF

		l16	:= ( cHexB == "16" )

		While ( ( ++nI ) <= nLn )
			cChr	:= SubStr( cHexN , nI , 1 )
			nAT		:= aScan( aH2B , { |aE| ( aE[ 1 ] == cChr ) } )
			IF ( nAT > 0 )
				cBin += IF( l16 , SubStr( aH2B[ nAT ][ 2 ] , 2 ) , aH2B[ nAT ][ 2 ] )
			EndIF
		End While

	END SEQUENCE
	
Return( cBin )

/*
	Method		: H2B
	Autor		: Marinaldo de Jesus [ http://www.blacktdn.com.br ]
	Data		: 07/02/2013
	Descricao	: Converte Bin para Hex
	Sintaxe		: tBigNumber():H2B( cHexN ) -> cHexN
*/
Method B2H( cBin , cHexB ) CLASS tBigNumber
	
	Local aH2B	:= {;
							{ "0" , "00000" },;
							{ "1" , "00001" },;
							{ "2" , "00010" },;
							{ "3" , "00011" },;
							{ "4" , "00100" },;
							{ "5" , "00101" },;
							{ "6" , "00110" },;
							{ "7" , "00111" },;
							{ "8" , "01000" },;
							{ "9" , "01001" },;
							{ "A" , "01010" },;
							{ "B" , "01011" },;
							{ "C" , "01100" },;
							{ "D" , "01101" },;
							{ "E" , "01110" },;
							{ "F" , "01111" },;
							{ "G" , "10000" },;
							{ "H" , "10001" },;
							{ "I" , "10010" },;
							{ "J" , "10011" },;
							{ "K" , "10100" },;
							{ "L" , "10101" },;
							{ "M" , "10110" },;
							{ "N" , "10111" },;
							{ "O" , "11000" },;
							{ "P" , "11001" },;
							{ "Q" , "11010" },;
							{ "R" , "11011" },;
							{ "S" , "11100" },;
							{ "T" , "11101" },;
							{ "U" , "11110" },;
							{ "V" , "11111" };
						}

	Local cChr
	Local cHexN	:= ""

	Local nI	:= 1
	Local nLn	:= Len( cBin )
	Local nAT

	Local l16
    
	BEGIN SEQUENCE

		IF Empty( cHexB )
			IF ( ( nLn % 5 ) == 0 )
				cHexB	:= "32"
			ElseIF ( ( nLn % 4 ) == 0 )
				cHexB	:= "16"			
			EndIF	
		EndIF	

		IF .NOT.( cHexB $ "[16][32]" )
			BREAK
		EndIF

		l16 := ( cHexB == "16" )

		While ( nI <= nLn )
			cChr	:= SubStr( cBin , nI , IF( l16 , 4 , 5 ) )
			nAT		:= aScan( aH2B , { |aE| ( IF( l16 , SubStr( aE[ 2 ] , 2 ) , aE[ 2 ] ) == cChr ) } )
			IF ( nAT > 0 )
				cHexN += aH2B[ nAT ][ 1 ]
			EndIF
			nI += IF( l16 , 4 , 5 )
		End While

	END SEQUENCE

Return( cHexN )

/*
	Method		: Randomize
	Autor		: Marinaldo de Jesus [ http://www.blacktdn.com.br ]
	Data		: 03/03/2013
	Descricao	: Randomize BigN Integer
	Sintaxe		: tBigNumber():Randomize( uB , uE , nExit ) -> oR
*/
Method Randomize( uB , uE , nExit ) CLASS tBigNumber

	Local aE
	
	Local oB	:= tBigNumber():New()
	Local oE	:= tBigNumber():New()
	Local oT	:= tBigNumber():New()
	Local oM	:= tBigNumber():New()
	Local oR	:= tBigNumber():New()

	Local cR    := ""

	Local nB
	Local nE
	Local nR
	Local nS
	Local nT

	Local lI

	#IFDEF __HARBOUR__
		oM:SetValue("9999999999999999999999999999")
	#ELSE //__PROTHEUS__
		oM:SetValue("999999999")
	#ENDIF	

	DEFAULT uB	:= "1"
	DEFAULT uE	:= oM:ExactValue()

	oB	:= tBigNumber():New( uB )
	oE	:= tBigNumber():New( uE )

	oB:SetValue( oB:Int(.T.):Abs(.T.) )
	oE:SetValue( oE:Int(.T.):Abs(.T.) )
	
	oT:SetValue( oB:Min( oE ) )
	oE:SetValue( oB:Max( oE ) )
	oB:SetValue( oT )

	BEGIN SEQUENCE
	
		IF ( oB:gt( oM ) )
	
			nE	:= Val( oM:ExactValue() )
			nB	:= Int( nE / 2 )
			nR	:= __Random( nB , nE )
			cR	:= LTrim( Str( nR ) )
			
			oR:SetValue( cR )
			
			lI	:= .F.
			nS	:= oE:nInt
			
			While ( oR:lt( oM ) )
				nR	:= __Random( nB , nE )
				cR	+= LTrim( Str( nR ) )
				nT	:= nS
				IF ( lI )
					While ( nT > 0 )
						nR := -( __Random(1,nS) )
						oR:SetValue( oR:Add( SubStr( cR , 1 , nR ) ) )
						IF oR:gte( oE )
							Exit
						EndIF
						nT += nR
					End While
				Else
					While ( nT > 0 )
						nR	:= __Random(1,nS)
						oR:SetValue( oR:Add( SubStr( cR , 1 , nR ) ) )
						IF oR:gte( oE )
							Exit
						EndIF
						nT -= nR
					End While
				EndIF
				lI := .NOT.(lI)
			End While
			
			DEFAULT nExit := EXIT_MAX_RANDOM
			aE	:= Array(0)

			nS	:= oE:nInt
			
			While oR:lt( oE )
				nR	:= __Random( nB , nE )
				cR	+= LTrim( Str( nR ) )
				nT	:= nS
				IF ( lI )
					While ( nT > 0 )
						nR := -( __Random(1,nS) )
						oR:SetValue( oR:Add( SubStr( cR , 1 , nR ) ) )
						IF oR:gte( oE )
							Exit
						EndIF
						nT += nR
					End While
				Else
					While ( nT > 0 )
						nR	:= __Random(1,nS)
						oR:SetValue( oR:Add( SubStr( cR , 1 , nR ) ) )
						IF oR:gte( oE )
							Exit
						EndIF
						nT -= nR
					End While
				EndIF
				lI := .NOT.(lI)
				nT := 0
				IF ( aScan( aE , { |n| ++nT , n == __Random(1,nExit) } ) > 0 )
					Exit
				EndIF
				IF ( nT <= RANDOM_MAX_EXIT )
					aAdd( aE , __Random(1,nExit) )
				EndIF
			End While

			BREAK
		
		EndIF
		
		IF oE:lte( oM )
			nB	:= Val( oB:ExactValue() )
			nE	:= Val( oE:ExactValue() )
			nR	:= __Random( nB , nE )	
			cR	+= LTrim( Str( nR ) )
			oR:SetValue( cR )
		    BREAK
		EndIF

		DEFAULT nExit := EXIT_MAX_RANDOM 
		aE	:= Array(0)

		lI	:= .F.
		nS	:= oE:nInt

		While oR:lt( oE )
			nB	:= Val( oB:ExactValue() )
			nE	:= Val( oM:ExactValue() )
			nR	:= __Random( nB , nE )
			cR	+= LTrim( Str( nR ) )
			nT	:= nS
			IF ( lI )
				While ( nT > 0 )
					nR := -( __Random(1,nS) )
					oR:SetValue( oR:Add( SubStr( cR , 1 , nR ) ) )
					IF oR:gte( oE )
						Exit
					EndIF
					nT += nR
				End While
			Else
				While ( nT > 0 )
					nR	:= __Random(1,nS)
					oR:SetValue( oR:Add( SubStr( cR , 1 , nR ) ) )
					IF oR:gte( oE )
						Exit
					EndIF
					nT	-= nR
				End While
			EndIF
			lI := .NOT.(lI)
			nT := 0
			IF ( aScan( aE , { |n| ++nT , n == __Random(1,nExit) } ) > 0 )
				Exit
			EndIF
			IF ( nT <= RANDOM_MAX_EXIT )
				aAdd( aE , __Random(1,nExit) )
			EndIF
		End While
	
	END SEQUENCE
	
	IF ( oR:lt( oB ) .or. oR:gt( oE ) )

		nT	:= Min( oE:nInt , oM:nInt )
		cR	:= Replicate("9",nT)
		oT:SetValue( cR )
		cR	:= oM:Min( oE:Min( oT ) ):ExactValue()
		nT	:= Val( cR )

		oT:SetValue( oE:Sub( oB ):Div( "2" ):Int( .T. ) )

		While oR:lt( oB )
			oR:SetValue( oR:Add( oT ) )
			nR	:= __Random( 1 , nT )
			cR	:= LTrim( Str( nR ) )
			oR:SetValue( oR:Sub( cR ) )
		End	While 
	
		While oR:gt( oE )
			oR:SetValue( oR:Sub( oT ) )
			nR	:= __Random( 1 , nT )
			cR	:= LTrim( Str( nR ) )
			oR:SetValue( oR:Add( cR ) )
		End While

	EndIF

Return( oR )

/*
	Funcao		: __Random
	Autor		: Marinaldo de Jesus [ http://www.blacktdn.com.br ]
	Data		: 03/03/2013
	Descricao	: Define a chamada para a funcao Random Padrao
	Sintaxe		: __Random(nB,nE)
*/
Static Function __Random(nB,nE)

	Local nR

	IF ( nB == 0 )
		nB := 1
	EndIF

	IF ( nB == nE )
		++nE		
	EndIF

	#IFDEF __HARBOUR__
		nR := Abs( HB_RandomInt(nB,nE) )
	#ELSE //__PROTHEUS__
		nR := Randomize(nB,nE)		
	#ENDIF	

Return( nR )

/*
	Method		: millerRabin
	Autor		: Marinaldo de Jesus [ http://www.blacktdn.com.br ]
	Data		: 03/03/2013
	Descricao	: Miller-Rabin Method (Primality test)
	Sintaxe		: tBigNumber():millerRabin( uI ) -> lPrime
	Ref.:		: http://en.literateprograms.org/Miller-Rabin_primality_test_(Python)
*/
Method millerRabin( uI ) CLASS tBigNumber

	Local o0		:= tBigNumber():New()
	Local o1		:= tBigNumber():New( "1" )
	Local o2		:= tBigNumber():New( "2" )

	Local oN		:= tBigNumber():New( self )
	Local oD		:= tBigNumber():New( oN:Sub( o1 ) )
	Local oS		:= tBigNumber():New()
	Local oI		:= tBigNumber():New()
	Local oA		:= tBigNumber():New()

	Local lPrime	:= .T.

	BEGIN SEQUENCE

		IF ( oN:lte( o1 ) )
			lPrime	:= .F.
			BREAK
		EndIF
	
		DEFAULT uI		:= "2"
	
		While ( oD:Mod( o2 ):eq( o0 ) )
			oD:SetValue( oD:Div( o2 , .F. ) )
			oS:SetValue( oS:Add( o1 ) )
		End While
	
		oI:SetValue( uI )
		While ( oI:gt( o0 ) )
			oA:SetValue( oA:Randomize( o1 , oN ) )
			lPrime := mrPass( oA , oS , oD , oN )
			IF .NOT.( lPrime )
				BREAK
			EndIF
			oI:SetValue( oI:Sub( o1 ) )
		End While

	END SEQUENCE

Return( lPrime )

/*
	Function	: mrPass
	Autor		: Marinaldo de Jesus [ http://www.blacktdn.com.br ]
	Data		: 03/03/2013
	Descricao	: Miller-Rabin Pass (Primality test)
	Sintaxe		: mrPass(uA,uS,uD,uN)
	Ref.:		: http://en.literateprograms.org/Miller-Rabin_primality_test_(Python)
*/
Static Function mrPass(uA,uS,uD,uN)

	Local o0	:= tBigNumber():New()
	Local o1	:= tBigNumber():New( "1" )
	
	Local oA	:= tBigNumber():New( uA )
	Local oS	:= tBigNumber():New( uS )
	Local oD	:= tBigNumber():New( uD )
	Local oN	:= tBigNumber():New( uN )
	Local oM	:= tBigNumber():New( oN:Sub( o1 ) )

	Local oP	:= tBigNumber():New( oA:Pow( oD ):Mod( oN ) )
	Local oW	:= tBigNumber():New( oS:Sub( o1 ) )
	
	Local lmrP  := .T.

	BEGIN SEQUENCE

		IF ( oP:eq( o1 ) )
			BREAK
		EndIF

		While ( oW:gt(o0) )
			lmrP	:= 	oP:eq( oM )
			IF ( lmrP )
				BREAK
			EndIF
			oP:SetValue( oP:Mult( oP ):Mod( oN )  )
			oW:SetValue( oW:Sub( o1 ) )
		End While

		lmrP	:= 	oP:eq( oM )		

	END SEQUENCE

Return( lmrP )

/*
	Method		: FI
	Autor		: Marinaldo de Jesus [ http://www.blacktdn.com.br ]
	Data		: 10/03/2013
	Descricao	: Euler's totient function
	Sintaxe		: tBigNumber():FI() -> oTBigN
	Ref.:		: ( Euler's totient function ) http://community.topcoder.com/tc?module=Static&d1=tutorials&d2=primeNumbers
	
	int fi(int n) 
     { 
       int result = n; 
       for(int i=2;i*i <= n;i++) 
       { 
         if (n % i == 0) result -= result / i; 
         while (n % i == 0) n /= i; 
       } 
       if (n > 1) result -= result / n; 
       return result; 
     } 
	
*/
Method FI() CLASS tBigNumber

	Local oT	:= tBigNumber():New( self:Int( .T. ) )
	
	Local o0	:= tBigNumber():New()		
	Local o1	:= tBigNumber():New( "1" )

	Local oI	:= tBigNumber():New( "2" )
	Local oN	:= tBigNumber():New( oT )

	While oI:Mult( oI ):lte( self )
		IF ( oN:Mod( oI ):eq( o0 ) )
			oT:SetValue( oT:Sub( oT:Div( oI , .F. ) ) )
		EndIF
		While ( oN:Mod( oI ):eq( o0 ) )
			oN:SetValue( oN:Div( oI , .F. ) )
		End While
		oI:SetValue( oI:Add( o1 ) )
	End While
	IF ( oN:gt( o1 ) )
		oT:SetValue( oT:Sub( oT:Div( oN , .F. ) ) )		
	EndIF

Return( oT )

/*
	Funcao		: Mult
	Autor		: Marinaldo de Jesus [ http://www.blacktdn.com.br ]
	Data		: 04/02/2013
	Descricao	: Multiplicacao
	Sintaxe		: __Mult( cN1 , cN2 , nAcc ) -> oNR
	Obs.		: Interessante + lenta... Utiliza Soma e Subtracao para obter o resultado
*/
Static Function __Mult( cN1 , cN2 , nAcc )

	Local aE 	:= Array(0)

	Local nI	:= 0
	
	Local oPe
	Local oPd
	Local ocT
	
	Local oN1	:= tBigNumber():New(@cN1)

	Local oNR

	__nSetDecimals := nAcc

	oPe	:= tBigNumber():New("1")
	oPd := tBigNumber():New(cN2)
	
	While ( .T. )
		++nI
		aAdd( aE , { oPe:ExactValue() , oPd:ExactValue() , .F. } )
		IF ( oPe:gte( oN1 ) )
			Exit
		EndIF
		oPe:SetValue( oPe:Add( oPe ) )
		oPd:SetValue( oPd:Add( oPd ) )
	End While

	ocT	:= tBigNumber():New("0")
	While ( nI > 0 )
		ocT:SetValue( ocT:Add( aE[ nI ][ 1 ] ) )
		IF ( ocT:lte( oN1 )  )
			aE[ nI ][ 3 ] := .T. 
			IF ( ocT:eq( oN1 )  )
				Exit
			EndIF	
		Else
			ocT:SetValue( ocT:Sub( aE[ nI ][ 1 ] ) )
		EndIF
		--nI
	End While

	nI 	:= 0
	oNR	:= tBigNumber():New()
	While ( ( nI := aScan( aE , { |e| e[ 3 ] } , ++nI ) ) > 0 )
		oNR:SetValue( oNR:Add( aE[ nI ][ 2 ] ) )
	End While

Return( oNR )

/*
	Funcao		: Div
	Autor		: Marinaldo de Jesus [ http://www.blacktdn.com.br ]
	Data		: 04/02/2013
	Descricao	: Divisao
	Sintaxe		: Div( cN1 , cN2 , nAcc , lFloat ) -> cNR
*/
Static Function Div( cN1 , cN2 , nAcc , lFloat )

	Local aE 	:= Array(0)

	Local nI	:= 0

	Local oPe
	Local oPd
	Local oN1	:= tBigNumber():New(cN1)
	Local oN2	:= tBigNumber():New(cN2)
	Local oRDiv	:= tBigNumber():New()

	Local oNR

	__nSetDecimals := nAcc

	oPe	:= tBigNumber():New("1")
	oPd	:= tBigNumber():New(oN2)

	While ( .T. )
		++nI
		aAdd( aE , { oPe:ExactValue() , oPd:ExactValue() , .F. } )
		oPe:SetValue( oPe:Add( oPe ) )
		oPd:SetValue( oPd:Add( oPd ) )
		IF ( oPd:gt( oN1 ) )
			Exit
		EndIF
	End While

	While ( nI > 0 )
		oRDiv:SetValue( oRDiv:Add( aE[ nI ][ 2 ] ) )
		IF ( oRDiv:lte( oN1 ) )
			aE[ nI ][ 3 ] := .T.
			IF ( oRDiv:eq( oN1 ) )
				Exit
			EndIF	
		Else
			oRDiv:SetValue( oRDiv:Sub( aE[ nI ][ 2 ] ) )
		EndIF
		--nI
	End While

	oRDiv:SetValue( oN1:Sub( oRDiv ) )

	nI 	:= 0
	oNR	:= tBigNumber():New()
	While ( ( nI := aScan( aE , { |e| e[ 3 ] } , ++nI ) ) > 0 )
		oNR:SetValue( oNR:Add( aE[ nI ][ 1 ] ) )
	End While

	oNR:cRDiv	:= oRDiv:ExactValue(.T.)
	DEFAULT lFloat := .T.
	IF ( .NOT.( lFloat ) .and. ( SubStr( oNR:cRDiv , -1 ) == "0" ) )
		oNR:cRDiv	:= SubStr( oNR:cRDiv , 1 , Len( oNR:cRDiv) -1 )
		IF Empty( oNR:cRDiv )
			oNR:cRDiv := "0"
		EndIF
	EndIF

Return( oNR )

/*
	Funcao		: nthRoot
	Autor		: Marinaldo de Jesus [ http://www.blacktdn.com.br ]
	Data		: 10/02/2013
	Descricao	: Metodo Newton-Raphson
	Sintaxe		: nthRoot( oRootB , oRootE , oAccTo , nAcc ) -> othRoot
	Obs.		: othRoot = ( (1/oRootE) * ( ( (oRootE-1)*othRootT ) + ( oRootB / ( othRootT**(oRootE-1) ) ) ) )
	Ref.:		: http://www.swap.com.br/blog/?p=570 em 10/02/2013
*/
Static Function nthRoot( oRootB , oRootE , oAccTo , nAcc )

	Local o1		:= tBigNumber():New("1")

	Local oT1		:= tBigNumber():New()
	Local oT2		:= tBigNumber():New()
	Local oT3		:= tBigNumber():New()

	Local oZero		:= tBigNumber():New()
                                                          	
	Local oAccNo 	:= tBigNumber():New()
	Local o1divE	:= tBigNumber():New()
	Local oESub1	:= tBigNumber():New()

	Local othRoot	:= tBigNumber():New()
	Local othRootT	:= tBigNumber():New()

	__nSetDecimals := nAcc

	oAccNo:SetValue( oAccTo:Add(o1) )
	o1divE:SetValue( o1:Div(oRootE) )
	oESub1:SetValue( oRootE:Sub(o1) )

	othRootT:SetValue(oRootB:Div(oRootE))

	While ( oAccNo:gt(oAccTo) )
		oT1:SetValue(oRootB:Div(othRootT:Pow(oESub1)))
		oT2:SetValue(oESub1:Mult(othRootT))
		oT3:SetValue(oT1:Add(oT2))
		othRoot:SetValue(o1divE:Mult(oT3))
		IF ( othRootT:eq(oZero) )
			Exit
		EndIF
		oT1:SetValue(othRoot:Sub(othRootT):Abs(.T.))
		oAccNo:SetValue(oT1:Div(othRoot:Abs(.T.)),NIL,NIL,@__nthRootAcc)
		othRootT:SetValue(othRoot)
	End While

Return( othRoot )  

#IFDEF TBN_DBFILE

	/*
		Funcao		: Add
		Autor		: Marinaldo de Jesus [ http://www.blacktdn.com.br ]
		Data		: 04/02/2013
		Descricao	: Adicao
		Sintaxe		: Add( cN1 , cN2 , n ) -> oNR
	*/
	Static Function Add( cN1 , cN2 , n , nAcc )
	
		Local a	:= aNumber( cN1 , n , "ADD_A" )
		Local b := aNumber( cN2 , n , "ADD_B" )
		Local y := ( n + n )
		Local c := aNumber( Replicate( "0" , y ) , y , "ADD_C" )
		Local k := 1
		
		THREAD Static __addoNR
		
		#IFDEF __HARBOUR__
			FIELD FN
		#ENDIF	

		__nSetDecimals := nAcc

		While ( n > 0  )
			(a)->(dbGoTo(n))
			(b)->(dbGoTo(n))
			(c)->(dbGoTo(k))
			IF (c)->(rLock())
				(c)->FN += ((a)->FN+(b)->FN)
				IF ( (c)->FN >= 10 )
					(c)->FN	-= 10
					(c)->(dbUnLock())
					(c)->(dbGoTo(k+1))
					IF (c)->(rLock())
						(c)->FN	+= 1
					EndIF	
				EndIF
				(c)->(dbUnLock())
			EndIF
			++k
			--n
		End While
	
		DEFAULT __addoNR := tBigNumber():New()
	
		__addoNR:SetValue( GetcN( @c , @y ) , NIL , .F. )

		#IFDEF __MT__
		
			IF ( Select(a) > 0 )
				(a)->( dbCloseArea() )
			EndIF	
			
			IF ( Select(b) > 0 )
				(b)->( dbCloseArea() )
			EndIF	
			
			IF ( Select(c) > 0 )
				(c)->( dbCloseArea() )
			EndIF	
			
			#IFDEF __PROTHEUS__
				aEval( __aFiles , { |cFile| MsErase( cFile , NIL , IF((Type("__LocalDriver")=="C"),__LocalDriver,"DBFCDXADS") ) } )
			#ELSE
				#IFDEF TBN_MEMIO
					aEval( __aFiles , { |cFile| dbDrop( cFile ) } )
				#ELSE
					aEval( __aFiles , { |cFile| fErase( cFile ) } )
				#ENDIF
			#ENDIF

			aSize( __aFiles , 0 )
					
		#ENDIF

	Return( __addoNR )
	
	/*
		Funcao		: Sub
		Autor		: Marinaldo de Jesus [ http://www.blacktdn.com.br ]
		Data		: 04/02/2013
		Descricao	: Subtracao
		Sintaxe		: Sub( cN1 , cN2 , n ) -> oNR
	*/
	Static Function Sub( cN1 , cN2 , n , nAcc )
	
		Local a	:= aNumber( cN1 , n , "SUB_A" )
		Local b := aNumber( cN2 , n , "SUB_B" )
		Local y := ( n + n )
		Local c := aNumber( Replicate( "0" , y ) , y , "SUB_C" )
		Local k := 1
	
		THREAD Static __suboNR
	
		#IFDEF __HARBOUR__
			FIELD FN
		#ENDIF	

		__nSetDecimals := nAcc
	
		While ( n > 0  )
			(a)->(dbGoTo(n))
			(b)->(dbGoTo(n))
			(c)->(dbGoTo(k))
			IF (c)->(rLock())
				(c)->FN += ( (a)->FN - (b)->FN )
				IF ( (c)->FN < 0 )
					(c)->FN += 10
					(c)->(dbUnLock())
					(c)->(dbGoTo(k+1))
					IF (c)->(rLock())
						(c)->FN -= 1
					EndIF
				EndIF
				(c)->(dbUnLock())
			EndIF
			++k
			--n
		End While
	
		DEFAULT __suboNR := tBigNumber():New()
	
		__suboNR:SetValue( GetcN( @c , @y ) , NIL , .F. )

		#IFDEF __MT__
		
			IF ( Select(a) > 0 )
				(a)->( dbCloseArea() )
			EndIF	
			
			IF ( Select(b) > 0 )
				(b)->( dbCloseArea() )
			EndIF	
			
			IF ( Select(c) > 0 )
				(c)->( dbCloseArea() )
			EndIF	
			
			#IFDEF __PROTHEUS__
				aEval( __aFiles , { |cFile| MsErase( cFile , NIL , IF((Type("__LocalDriver")=="C"),__LocalDriver,"DBFCDXADS") ) } )
			#ELSE
				#IFDEF TBN_MEMIO
					aEval( __aFiles , { |cFile| dbDrop( cFile ) } )
				#ELSE
					aEval( __aFiles , { |cFile| fErase( cFile ) } )
				#ENDIF
			#ENDIF

			aSize( __aFiles , 0 )
		
		#ENDIF

	Return( __suboNR )
	
	/*
		Funcao		: Mult
		Autor		: Marinaldo de Jesus [ http://www.blacktdn.com.br ]
		Data		: 04/02/2013
		Descricao	: Multiplicacao de Inteiros
		Sintaxe		: Mult( cN1 , cN2 , n ) -> oNR
		Obs.		: Mais rapida, usa a multiplicacao nativa
	*/
	Static Function Mult( cN1 , cN2 , n , nAcc )
		
		Local a		:= aNumber( Invert( cN1 , n ) , n , "MULT_A" )
		Local b		:= aNumber( Invert( cN2 , n ) , n , "MULT_B" )
		Local y		:= ( n + n )
		Local c		:= aNumber( Replicate( "0" , y ) , y , "MULT_C" )
	
		Local i 	:= 1
		Local k 	:= 1
		Local l 	:= 2
		
		Local s
		Local x
		Local j
		Local w
	
		THREAD Static __multoNR
	
		#IFDEF __HARBOUR__
			FIELD FN
		#ENDIF	

		__nSetDecimals := nAcc
	
		While ( i <= n )
			s := 1
			j := i
			(c)->(dbGoTo(k))
			IF (c)->(rLock())
				While ( s <= i )
					(a)->(dbGoTo(s++))
					(b)->(dbGoTo(j--))
					(c)->FN += ( (a)->FN*(b)->FN )
				End While
				IF ( (c)->FN >= 10 )
					x		:= ( k+1 )
					w		:= Int( (c)->FN / 10 )
					(c)->(dbGoTo(x))
					IF (c)->(rLock())
						(c)->FN	:= w
						(c)->(dbUnLock())
						w := ( (c)->FN * 10 )
						(c)->(dbGoTo(k))
						(c)->FN	-= w
					EndIF	
				EndIF
				(c)->(dbUnLock())
			EndIF
			k++
			i++
		End While
	
		While ( l <= n )
			s := n
			j := l
			(c)->(dbGoTo(k))
			IF (c)->(rLock())
				While ( s >= l )
					(a)->(dbGoTo(s--))
					(b)->(dbGoTo(j++))
					(c)->FN	+= ( (a)->FN*(b)->FN )
				End While
				IF ( (c)->FN >= 10 )
					x		:= ( k+1 )
					w		:= Int( (c)->FN / 10 )
					(c)->(dbGoTo(x))
					IF (c)->(rLock())
						(c)->FN := w
						(c)->(dbUnLock())
						w := ( (c)->FN * 10 )
						(c)->(dbGoTo(k))
						(c)->FN -= w
					EndIF	
				EndIF
				(c)->(dbUnLock())
			EndIF
			k++
			IF ( k >= y )
				Exit
			EndIF
			l++
		End While
		
		DEFAULT __multoNR := tBigNumber():New()
	
		__multoNR:SetValue( GetcN( @c , @k ) , NIL , .F. )

		#IFDEF __MT__
		
			IF ( Select(a) > 0 )
				(a)->( dbCloseArea() )
			EndIF	
			
			IF ( Select(b) > 0 )
				(b)->( dbCloseArea() )
			EndIF	
			
			IF ( Select(c) > 0 )
				(c)->( dbCloseArea() )
			EndIF	
			
			#IFDEF __PROTHEUS__
				aEval( __aFiles , { |cFile| MsErase( cFile , NIL , IF((Type("__LocalDriver")=="C"),__LocalDriver,"DBFCDXADS") ) } )
			#ELSE
				#IFDEF TBN_MEMIO
					aEval( __aFiles , { |cFile| dbDrop( cFile ) } )
				#ELSE
					aEval( __aFiles , { |cFile| fErase( cFile ) } )
				#ENDIF
			#ENDIF

			aSize( __aFiles , 0 )
			
		#ENDIF

	Return( __multoNR )

	/*
		Funcao		: aNumber
		Autor		: Marinaldo de Jesus [ http://www.blacktdn.com.br ]
		Data		: 04/02/2013
		Descricao	: Array OF Numbers
		Sintaxe		: aNumber( c , n ) -> a
	*/
	Static Function aNumber( c , n , o )
	
		Local a	:= dbNumber(o)
	
		Local y	:= 0
	
		#IFDEF __HARBOUR__
			FIELD FN
		#ENDIF	
	
		While ( ( ++y ) <= n )
			(a)->( dbAppend( .T. ) )
			(a)->FN	:= Val( SubStr( c , y , 1 ) )
			(a)->( dbUnLock() )
		End While
	
	Return(a)
	
	/*
		Funcao		: GetcN
		Autor		: Marinaldo de Jesus [ http://www.blacktdn.com.br ]
		Data		: 04/02/2013
		Descricao	: Montar a String de Retorno
		Sintaxe		: GetcN( a , x ) -> s
	*/
	Static Function GetcN( a , n )
	
		Local s	:= ""
		Local y	:= n
	
		#IFDEF __HARBOUR__
			FIELD FN
		#ENDIF	
	
		While ( y >= 1 )
			(a)->(dbGoTo(y))
			While ( ( y >= 1 ) .and. ( (a)->FN == 0 ) )
				(a)->(dbGoTo(--y))
			End While
			While ( y >= 1 )
				(a)->(dbGoTo(y--))
				s	+= Str( (a)->FN , 1 )
			End While
		End While
	
		IF ( s == "" )
			s := "0"	
		EndIF
	
		IF ( Len( s ) < n )
			s := PadL( s , n , "0"  )
		EndIF
	
	Return( s )
	
	Static Function dbNumber(cAlias)
		Local aStru		:= { { "FN" , "N" , 4 , 0 } }
		Local cFile
	#IFNDEF __HARBOUR__
		Local cLDriver
		Local cRDD		:= IF((Type("__LocalDriver")=="C"),__LocalDriver,"DBFCDXADS")
	#ELSE
		#IFNDEF TBN_MEMIO
		Local cRDD		:= "DBFCDX"
		#ENDIF
	#ENDIF
	#IFNDEF __HARBOUR__
		IF .NOT.(Type("__LocalDriver")=="C")
			Private __LocalDriver
		EndIF
		cLDriver		:= __LocalDriver
		__LocalDriver	:= cRDD
	#ENDIF
		IF ( Select(cAlias) == 0 )
	#IFNDEF __HARBOUR__
			cFile := CriaTrab(aStru,.T.,".dbf")
			dbUseArea( .T. , cRDD , cFile , cAlias , .F. , .F. )
	#ELSE
			#IFNDEF TBN_MEMIO
				cFile := CriaTrab(aStru,cRDD)
				dbUseArea( .T. , cRDD , cFile , cAlias , .F. , .F. )
			#ELSE
				cFile := CriaTrab(aStru,cAlias)
			#ENDIF	
	#ENDIF
			DEFAULT __aFiles := {}
			aAdd( __aFiles , cFile )
		Else
			(cAlias)->( dbRLock() )
	#IFDEF __HARBOUR__		
			(cAlias)->( hb_dbZap() )
	#ELSE
			(cAlias)->( __dbZap() )
	#ENDIF		
			(cAlias)->( dbRUnLock() )
		EndIF	
	#IFNDEF __HARBOUR__
		IF .NOT.( Empty(cLDriver) )
			__LocalDriver := cLDriver
		EndIF	
	#ENDIF
	Return( cAlias  )
	
	#IFDEF __HARBOUR__
		#IFNDEF TBN_MEMIO
			Static Function CriaTrab(aStru,cRDD)
				Local cFile 	:= "TBN"+Dtos(Date())+"_"+StrTran(Time(),":","_")+"_"+StrZero(HB_RandomInt(1,999),3)
				Local lSuccess	:= .F.
				While .NOT.( lSuccess )
					Try
					  dbCreate( cFile , aStru , cRDD )
					  lSuccess	:= .T.
					Catch
					  cFile		:= "TBN"+Dtos(Date())+"_"+StrTran(Time(),":","_")+"_"+StrZero(HB_RandomInt(1,999),3)
					  lSuccess	:= .F.
					End
				End While	
			Return( cFile )
		#ELSE
			Static Function CriaTrab(aStru,cAlias)
				Local cFile		:= "mem:"+"TBN"+Dtos(Date())+"_"+StrTran(Time(),":","_")+"_"+StrZero(HB_RandomInt(1,999),3)
				Local lSuccess	:= .F. 	
				While .NOT.( lSuccess )
					Try
					  dbCreate(cFile,aStru,NIL,.T.,cAlias)
					  lSuccess	:= .T.
					Catch
					  cFile		:= "mem:"+"TBN"+Dtos(Date())+"_"+StrTran(Time(),":","_")+"_"+StrZero(HB_RandomInt(1,999),3)
					  lSuccess	:= .F.
					End
				End While	
			Return( cFile )
		#ENDIF
	#ENDIF

#ELSE

	/*
		Funcao		: Add
		Autor		: Marinaldo de Jesus [ http://www.blacktdn.com.br ]
		Data		: 04/02/2013
		Descricao	: Adicao
		Sintaxe		: Add( cN1 , cN2 , n ) -> oNR
	*/
	Static Function Add( cN1 , cN2 , n , nAcc )
	
		Local a	:= aNumber( cN1 , n )
		Local b := aNumber( cN2 , n )
		Local y := ( n + n )
		Local c := aFill( Array( y ) , 0 )
		Local k := 1
		
		THREAD Static __addoNR
	    
		__nSetDecimals := nAcc
	
		While ( n > 0  )
			c[k] += ( a[n] + b[n] )
			IF ( c[k] >= 10 )
				c[k+1]	+= 1
				c[k]	-= 10
			EndIF
			++k
			--n
		End While
	
		DEFAULT __addoNR := tBigNumber():New()
	
		__addoNR:SetValue( GetcN( @c , @y ) , NIL , .F. )
	
	Return( __addoNR )
	
	/*
		Funcao		: Sub
		Autor		: Marinaldo de Jesus [ http://www.blacktdn.com.br ]
		Data		: 04/02/2013
		Descricao	: Subtracao
		Sintaxe		: Sub( cN1 , cN2 , n ) -> oNR
	*/
	Static Function Sub( cN1 , cN2 , n , nAcc )
	
		Local a	:= aNumber( cN1 , n )
		Local b := aNumber( cN2 , n )
		Local y := ( n + n )
		Local c := aFill( Array( y ) , 0 )
		Local k := 1
	
		THREAD Static __suboNR
	
		__nSetDecimals := nAcc
	
		While ( n > 0  )
			c[k] += ( a[n] - b[n] )
			IF ( c[k] < 0 )
				c[k+1]	-= 1
				c[k]	+= 10
			EndIF
			++k
			--n
		End While
	
		DEFAULT __suboNR := tBigNumber():New()
	
		__suboNR:SetValue( GetcN( @c , @y ) , NIL , .F. )
	
	Return( __suboNR )
	
	/*
		Funcao		: Mult
		Autor		: Marinaldo de Jesus [ http://www.blacktdn.com.br ]
		Data		: 04/02/2013
		Descricao	: Multiplicacao de Inteiros
		Sintaxe		: Mult( cN1 , cN2 , n ) -> oNR
		Obs.		: Mais rapida, usa a multiplicacao nativa
	*/
	Static Function Mult( cN1 , cN2 , n , nAcc )
	
		Local a		:= aNumber( Invert( cN1 , n ) , n )
		Local b		:= aNumber( Invert( cN2 , n ) , n )
		Local y		:= ( n + n )
		Local c		:= afill( Array( y ) , 0 )
	
		Local i 	:= 1
		Local k 	:= 1
		Local l 	:= 2
		
		Local s
		Local x
		Local j
	
		THREAD Static __multoNR
	
		__nSetDecimals := nAcc
	
		While ( i <= n )
			s := 1
			j := i
			While ( s <= i )
				c[k]	+= ( a[s++] * b[j--] )
			End While
			IF ( c[k] >= 10 )
				x		:= ( k+1 )
				c[x]	:= Int( c[k] / 10 )
				c[k]	-= ( c[x] * 10 )
			EndIF
			k++
			i++
		End While
	
		While ( l <= n )
			s := n
			j := l
			While ( s >= l )
				c[k]	+= ( a[s--] * b[j++] )
			End While
			IF ( c[k] >= 10 )
				x		:= ( k+1 )
				c[x]	:= Int( c[k] / 10 )
				c[k]	-= ( c[x] * 10 )
			EndIF
			k++
			IF ( k >= y )
				Exit
			EndIF
			l++
		End While
		
		DEFAULT __multoNR := tBigNumber():New()
	
		__multoNR:SetValue( GetcN( @c , @k ) , NIL , .F. )
	
	Return( __multoNR )
	
	/*
		Funcao		: aNumber
		Autor		: Marinaldo de Jesus [ http://www.blacktdn.com.br ]
		Data		: 04/02/2013
		Descricao	: Array OF Numbers
		Sintaxe		: aNumber( c , n ) -> a
	*/
	Static Function aNumber( c , n )
	
		Local a	:= Array( n )
	
		Local y	:= 0
	
		While ( ( ++y ) <= n )
			a[ y ] := Val( SubStr( c , y , 1 ) )
		End While
	
	Return(a)
	
	/*
		Funcao		: GetcN
		Autor		: Marinaldo de Jesus [ http://www.blacktdn.com.br ]
		Data		: 04/02/2013
		Descricao	: Montar a String de Retorno
		Sintaxe		: GetcN( a , x ) -> s
	*/
	Static Function GetcN( a , n )
	
		Local s	:= ""
		Local y	:= n
	
		While ( y >= 1 )
			While ( ( y >= 1 ) .and. ( a[y] == 0 ) )
				y--
			End While
			While ( y >= 1 )
				s	+= Str( a[y] , 1 )
				y--
			End While
		End While
	
		IF ( s == "" )
			s := "0"	
		EndIF
	
		IF ( Len( s ) < n )
			s := PadL( s , n , "0"  )
		EndIF
	
	Return( s )

#ENDIF

/*
	Funcao		: Invert
	Autor		: Marinaldo de Jesus [ http://www.blacktdn.com.br ]
	Data		: 04/02/2013
	Descricao	: Inverte o Numero
	Sintaxe		: Invert( c , n ) -> s
*/
Static Function Invert( c , n )

	Local s	:= ""
	Local y	:= n	

	While ( y > 0 )
		s += SubStr( c , y-- , 1 )
	End While

Return( s )

/*
	Funcao		: MathO
	Autor		: Marinaldo de Jesus [ http://www.blacktdn.com.br ]
	Data		: 04/02/2013
	Descricao	: Operacoes matematicas
	Sintaxe		: MathO( uBigN1 , cOperator , uBigN2 , lRetObject )
*/
Static Function MathO( uBigN1 , cOperator , uBigN2 , lRetObject )

	Local oBigNR	:= tBigNumber():New()

	Local oBigN1	:= tBigNumber():New(uBigN1)
	Local oBigN2	:= tBigNumber():New(uBigN2)

	DO CASE
		CASE ( aScan( OPERATOR_ADD , { |cOp| cOperator == cOp } ) > 0 )
			oBigNR:SetValue( oBigN1:Add( oBigN2 ) )
		CASE ( aScan( OPERATOR_SUBTRACT , { |cOp| cOperator == cOp } ) > 0 )
			oBigNR:SetValue( oBigN1:Sub( oBigN2 ) )
		CASE ( aScan( OPERATOR_MULTIPLY , { |cOp| cOperator == cOp } ) > 0 )
			oBigNR:SetValue( oBigN1:Mult( oBigN2 ) )
		CASE ( aScan( OPERATOR_DIVIDE , { |cOp| cOperator == cOp } ) > 0 )
			oBigNR:SetValue( oBigN1:Div( oBigN2 ) )
		CASE ( aScan( OPERATOR_POW  , { |cOp| cOperator == cOp } ) > 0 )
			oBigNR:SetValue( oBigN1:Pow( oBigN2 ) )
		CASE ( aScan( OPERATOR_MOD  , { |cOp| cOperator == cOp } ) > 0 )
			oBigNR:SetValue( oBigN1:Mod( oBigN2 ) )
		CASE ( aScan( OPERATOR_ROOT  , { |cOp| cOperator == cOp } ) > 0 )
			oBigNR:SetValue( oBigN1:nthRoot( oBigN2 ) )
		CASE ( aScan( OPERATOR_SQRT	 , { |cOp| cOperator == cOp } ) > 0 )
			oBigNR:SetValue( oBigN1:SQRT() )
	ENDCASE

	DEFAULT lRetObject	:= .T.

Return( IF( lRetObject , oBigNR , oBigNR:ExactValue() ) )

/*
	Function	: __PITthD()
	Autor		: Marinaldo de Jesus [ http://www.blacktdn.com.br ]
	Data		: 06/02/2013
	Descricao	: Retorna a Constante Numero PI ( 3.1415926535897932384626433832795... ) com 10.000 casas decimais
	Sintaxe		: __PITthD()
	Pi-memory	: http://pidifferent.pi.funpic.de/index-en.html
*/
Static Function __PITthD()

	Static __PITthD	:=	"3.1415926535897932384626433832795028841971693993751058209749445923078164062862"+;
						"089986280348253421170679821480865132823066470938446095505822317253594081284811"+;
						"174502841027019385211055596446229489549303819644288109756659334461284756482337"+;
						"867831652712019091456485669234603486104543266482133936072602491412737245870066"+;
						"063155881748815209209628292540917153643678925903600113305305488204665213841469"+;
						"519415116094330572703657595919530921861173819326117931051185480744623799627495"+;
						"673518857527248912279381830119491298336733624406566430860213949463952247371907"+;
						"021798609437027705392171762931767523846748184676694051320005681271452635608277"+;
						"857713427577896091736371787214684409012249534301465495853710507922796892589235"+;
						"420199561121290219608640344181598136297747713099605187072113499999983729780499"+;
						"510597317328160963185950244594553469083026425223082533446850352619311881710100"+;
						"031378387528865875332083814206171776691473035982534904287554687311595628638823"+;
						"537875937519577818577805321712268066130019278766111959092164201989380952572010"+;
						"654858632788659361533818279682303019520353018529689957736225994138912497217752"+;
						"834791315155748572424541506959508295331168617278558890750983817546374649393192"+;
						"550604009277016711390098488240128583616035637076601047101819429555961989467678"+;
						"374494482553797747268471040475346462080466842590694912933136770289891521047521"+;
						"620569660240580381501935112533824300355876402474964732639141992726042699227967"+;
						"823547816360093417216412199245863150302861829745557067498385054945885869269956"+;
						"909272107975093029553211653449872027559602364806654991198818347977535663698074"+;
						"265425278625518184175746728909777727938000816470600161452491921732172147723501"+;
						"414419735685481613611573525521334757418494684385233239073941433345477624168625"+;
						"189835694855620992192221842725502542568876717904946016534668049886272327917860"+;
						"857843838279679766814541009538837863609506800642251252051173929848960841284886"+;
						"269456042419652850222106611863067442786220391949450471237137869609563643719172"+;
						"874677646575739624138908658326459958133904780275900994657640789512694683983525"+;
						"957098258226205224894077267194782684826014769909026401363944374553050682034962"+;
						"524517493996514314298091906592509372216964615157098583874105978859597729754989"+;
						"301617539284681382686838689427741559918559252459539594310499725246808459872736"+;
						"446958486538367362226260991246080512438843904512441365497627807977156914359977"+;
						"001296160894416948685558484063534220722258284886481584560285060168427394522674"+;
						"676788952521385225499546667278239864565961163548862305774564980355936345681743"+;
						"241125150760694794510965960940252288797108931456691368672287489405601015033086"+;
						"179286809208747609178249385890097149096759852613655497818931297848216829989487"+;
						"226588048575640142704775551323796414515237462343645428584447952658678210511413"+;
						"547357395231134271661021359695362314429524849371871101457654035902799344037420"+;
						"073105785390621983874478084784896833214457138687519435064302184531910484810053"+;
						"706146806749192781911979399520614196634287544406437451237181921799983910159195"+;
						"618146751426912397489409071864942319615679452080951465502252316038819301420937"+;
						"621378559566389377870830390697920773467221825625996615014215030680384477345492"+;
						"026054146659252014974428507325186660021324340881907104863317346496514539057962"+;
						"685610055081066587969981635747363840525714591028970641401109712062804390397595"+;
						"156771577004203378699360072305587631763594218731251471205329281918261861258673"+;
						"215791984148488291644706095752706957220917567116722910981690915280173506712748"+;
						"583222871835209353965725121083579151369882091444210067510334671103141267111369"+;
						"908658516398315019701651511685171437657618351556508849099898599823873455283316"+;
						"355076479185358932261854896321329330898570642046752590709154814165498594616371"+;
						"802709819943099244889575712828905923233260972997120844335732654893823911932597"+;
						"463667305836041428138830320382490375898524374417029132765618093773444030707469"+;
						"211201913020330380197621101100449293215160842444859637669838952286847831235526"+;
						"582131449576857262433441893039686426243410773226978028073189154411010446823252"+;
						"716201052652272111660396665573092547110557853763466820653109896526918620564769"+;
						"312570586356620185581007293606598764861179104533488503461136576867532494416680"+;
						"396265797877185560845529654126654085306143444318586769751456614068007002378776"+;
						"591344017127494704205622305389945613140711270004078547332699390814546646458807"+;
						"972708266830634328587856983052358089330657574067954571637752542021149557615814"+;
						"002501262285941302164715509792592309907965473761255176567513575178296664547791"+;
						"745011299614890304639947132962107340437518957359614589019389713111790429782856"+;
						"475032031986915140287080859904801094121472213179476477726224142548545403321571"+;
						"853061422881375850430633217518297986622371721591607716692547487389866549494501"+;
						"146540628433663937900397692656721463853067360965712091807638327166416274888800"+;
						"786925602902284721040317211860820419000422966171196377921337575114959501566049"+;
						"631862947265473642523081770367515906735023507283540567040386743513622224771589"+;
						"150495309844489333096340878076932599397805419341447377441842631298608099888687"+;
						"413260472156951623965864573021631598193195167353812974167729478672422924654366"+;
						"800980676928238280689964004824354037014163149658979409243237896907069779422362"+;
						"508221688957383798623001593776471651228935786015881617557829735233446042815126"+;
						"272037343146531977774160319906655418763979293344195215413418994854447345673831"+;
						"624993419131814809277771038638773431772075456545322077709212019051660962804909"+;
						"263601975988281613323166636528619326686336062735676303544776280350450777235547"+;
						"105859548702790814356240145171806246436267945612753181340783303362542327839449"+;
						"753824372058353114771199260638133467768796959703098339130771098704085913374641"+;
						"442822772634659470474587847787201927715280731767907707157213444730605700733492"+;
						"436931138350493163128404251219256517980694113528013147013047816437885185290928"+;
						"545201165839341965621349143415956258658655705526904965209858033850722426482939"+;
						"728584783163057777560688876446248246857926039535277348030480290058760758251047"+;
						"470916439613626760449256274204208320856611906254543372131535958450687724602901"+;
						"618766795240616342522577195429162991930645537799140373404328752628889639958794"+;
						"757291746426357455254079091451357111369410911939325191076020825202618798531887"+;
						"705842972591677813149699009019211697173727847684726860849003377024242916513005"+;
						"005168323364350389517029893922334517220138128069650117844087451960121228599371"+;
						"623130171144484640903890644954440061986907548516026327505298349187407866808818"+;
						"338510228334508504860825039302133219715518430635455007668282949304137765527939"+;
						"751754613953984683393638304746119966538581538420568533862186725233402830871123"+;
						"282789212507712629463229563989898935821167456270102183564622013496715188190973"+;
						"038119800497340723961036854066431939509790190699639552453005450580685501956730"+;
						"229219139339185680344903982059551002263535361920419947455385938102343955449597"+;
						"783779023742161727111723643435439478221818528624085140066604433258885698670543"+;
						"154706965747458550332323342107301545940516553790686627333799585115625784322988"+;
						"273723198987571415957811196358330059408730681216028764962867446047746491599505"+;
						"497374256269010490377819868359381465741268049256487985561453723478673303904688"+;
						"383436346553794986419270563872931748723320837601123029911367938627089438799362"+;
						"016295154133714248928307220126901475466847653576164773794675200490757155527819"+;
						"653621323926406160136358155907422020203187277605277219005561484255518792530343"+;
						"513984425322341576233610642506390497500865627109535919465897514131034822769306"+;
						"247435363256916078154781811528436679570611086153315044521274739245449454236828"+;
						"860613408414863776700961207151249140430272538607648236341433462351897576645216"+;
						"413767969031495019108575984423919862916421939949072362346468441173940326591840"+;
						"443780513338945257423995082965912285085558215725031071257012668302402929525220"+;
						"118726767562204154205161841634847565169998116141010029960783869092916030288400"+;
						"269104140792886215078424516709087000699282120660418371806535567252532567532861"+;
						"291042487761825829765157959847035622262934860034158722980534989650226291748788"+;
						"202734209222245339856264766914905562842503912757710284027998066365825488926488"+;
						"025456610172967026640765590429099456815065265305371829412703369313785178609040"+;
						"708667114965583434347693385781711386455873678123014587687126603489139095620099"+;
						"393610310291616152881384379099042317473363948045759314931405297634757481193567"+;
						"091101377517210080315590248530906692037671922033229094334676851422144773793937"+;
						"517034436619910403375111735471918550464490263655128162288244625759163330391072"+;
						"253837421821408835086573917715096828874782656995995744906617583441375223970968"+;
						"340800535598491754173818839994469748676265516582765848358845314277568790029095"+;
						"170283529716344562129640435231176006651012412006597558512761785838292041974844"+;
						"236080071930457618932349229279650198751872127267507981255470958904556357921221"+;
						"033346697499235630254947802490114195212382815309114079073860251522742995818072"+;
						"471625916685451333123948049470791191532673430282441860414263639548000448002670"+;
						"496248201792896476697583183271314251702969234889627668440323260927524960357996"+;
						"469256504936818360900323809293459588970695365349406034021665443755890045632882"+;
						"250545255640564482465151875471196218443965825337543885690941130315095261793780"+;
						"029741207665147939425902989695946995565761218656196733786236256125216320862869"+;
						"222103274889218654364802296780705765615144632046927906821207388377814233562823"+;
						"608963208068222468012248261177185896381409183903673672220888321513755600372798"+;
						"394004152970028783076670944474560134556417254370906979396122571429894671543578"+;
						"468788614445812314593571984922528471605049221242470141214780573455105008019086"+;
						"996033027634787081081754501193071412233908663938339529425786905076431006383519"+;
						"834389341596131854347546495569781038293097164651438407007073604112373599843452"+;
						"251610507027056235266012764848308407611830130527932054274628654036036745328651"+;
						"057065874882256981579367897669742205750596834408697350201410206723585020072452"+;
						"256326513410559240190274216248439140359989535394590944070469120914093870012645"+;
						"600162374288021092764579310657922955249887275846101264836999892256959688159205"+;
						"60010165525637568"

Return( __PITthD )

/*
	Function	: __eTthD()
	Autor		: Marinaldo de Jesus [ http://www.blacktdn.com.br ]
	Data		: 04/02/2013
	Descricao	: Retorna a Constante Numero de Neper ( 2.718281828459045235360287471352662497757247... ) com 10.000 casas decimais
	Sintaxe		: __eTthD()
*/
Static Function __eTthD()

	Static __eTthD := "2.718281828459045235360287471352662497757247093699959574966967627724076630353"+;
						"547594571382178525166427427466391932003059921817413596629043572900334295260"+;
						"595630738132328627943490763233829880753195251019011573834187930702154089149"+;
						"934884167509244761460668082264800168477411853742345442437107539077744992069"+;
						"551702761838606261331384583000752044933826560297606737113200709328709127443"+;
						"747047230696977209310141692836819025515108657463772111252389784425056953696"+;
						"770785449969967946864454905987931636889230098793127736178215424999229576351"+; 
						"482208269895193668033182528869398496465105820939239829488793320362509443117"+; 
						"301238197068416140397019837679320683282376464804295311802328782509819455815"+; 
						"301756717361332069811250996181881593041690351598888519345807273866738589422"+; 
						"879228499892086805825749279610484198444363463244968487560233624827041978623"+; 
						"209002160990235304369941849146314093431738143640546253152096183690888707016"+; 
						"768396424378140592714563549061303107208510383750510115747704171898610687396"+; 
						"965521267154688957035035402123407849819334321068170121005627880235193033224"+; 
						"745015853904730419957777093503660416997329725088687696640355570716226844716"+; 
						"256079882651787134195124665201030592123667719432527867539855894489697096409"+; 
						"754591856956380236370162112047742722836489613422516445078182442352948636372"+; 
						"141740238893441247963574370263755294448337998016125492278509257782562092622"+; 
						"648326277933386566481627725164019105900491644998289315056604725802778631864"+; 
						"155195653244258698294695930801915298721172556347546396447910145904090586298"+; 
						"496791287406870504895858671747985466775757320568128845920541334053922000113"+; 
						"786300945560688166740016984205580403363795376452030402432256613527836951177"+; 
						"883863874439662532249850654995886234281899707733276171783928034946501434558"+; 
						"897071942586398772754710962953741521115136835062752602326484728703920764310"+; 
						"059584116612054529703023647254929666938115137322753645098889031360205724817"+; 
						"658511806303644281231496550704751025446501172721155519486685080036853228183"+; 
						"152196003735625279449515828418829478761085263981395599006737648292244375287"+; 
						"184624578036192981971399147564488262603903381441823262515097482798777996437"+; 
						"308997038886778227138360577297882412561190717663946507063304527954661855096"+; 
						"666185664709711344474016070462621568071748187784437143698821855967095910259"+; 
						"686200235371858874856965220005031173439207321139080329363447972735595527734"+; 
						"907178379342163701205005451326383544000186323991490705479778056697853358048"+; 
						"966906295119432473099587655236812859041383241160722602998330535370876138939"+; 
						"639177957454016137223618789365260538155841587186925538606164779834025435128"+; 
						"439612946035291332594279490433729908573158029095863138268329147711639633709"+; 
						"240031689458636060645845925126994655724839186564209752685082307544254599376"+; 
						"917041977780085362730941710163434907696423722294352366125572508814779223151"+; 
						"974778060569672538017180776360346245927877846585065605078084421152969752189"+; 
						"087401966090665180351650179250461950136658543663271254963990854914420001457"+; 
						"476081930221206602433009641270489439039717719518069908699860663658323227870"+; 
						"937650226014929101151717763594460202324930028040186772391028809786660565118"+; 
						"326004368850881715723866984224220102495055188169480322100251542649463981287"+; 
						"367765892768816359831247788652014117411091360116499507662907794364600585194"+; 
						"199856016264790761532103872755712699251827568798930276176114616254935649590"+; 
						"379804583818232336861201624373656984670378585330527583333793990752166069238"+; 
						"053369887956513728559388349989470741618155012539706464817194670834819721448"+;
						"889879067650379590366967249499254527903372963616265897603949857674139735944"+; 
						"102374432970935547798262961459144293645142861715858733974679189757121195618"+; 
						"738578364475844842355558105002561149239151889309946342841393608038309166281"+; 
						"881150371528496705974162562823609216807515017772538740256425347087908913729"+; 
						"172282861151591568372524163077225440633787593105982676094420326192428531701"+; 
						"878177296023541306067213604600038966109364709514141718577701418060644363681"+; 
						"546444005331608778314317444081194942297559931401188868331483280270655383300"+; 	
						"469329011574414756313999722170380461709289457909627166226074071874997535921"+; 
						"275608441473782330327033016823719364800217328573493594756433412994302485023"+; 
						"573221459784328264142168487872167336701061509424345698440187331281010794512"+; 
						"722373788612605816566805371439612788873252737389039289050686532413806279602"+; 
						"593038772769778379286840932536588073398845721874602100531148335132385004782"+; 
						"716937621800490479559795929059165547050577751430817511269898518840871856402"+; 
						"603530558373783242292418562564425502267215598027401261797192804713960068916"+; 
						"382866527700975276706977703643926022437284184088325184877047263844037953016"+; 
						"690546593746161932384036389313136432713768884102681121989127522305625675625"+; 
						"470172508634976536728860596675274086862740791285657699631378975303466061666"+;
						"980421826772456053066077389962421834085988207186468262321508028828635974683"+; 
						"965435885668550377313129658797581050121491620765676995065971534476347032085"+; 
						"321560367482860837865680307306265763346977429563464371670939719306087696349"+; 
						"532884683361303882943104080029687386911706666614680001512114344225602387447"+; 
						"432525076938707777519329994213727721125884360871583483562696166198057252661"+; 
						"220679754062106208064988291845439530152998209250300549825704339055357016865"+; 
						"312052649561485724925738620691740369521353373253166634546658859728665945113"+; 
						"644137033139367211856955395210845840724432383558606310680696492485123263269"+; 
						"951460359603729725319836842336390463213671011619282171115028280160448805880"+; 
						"238203198149309636959673583274202498824568494127386056649135252670604623445"+; 
						"054922758115170931492187959271800194096886698683703730220047531433818109270"+; 
						"803001720593553052070070607223399946399057131158709963577735902719628506114"+; 
						"651483752620956534671329002599439766311454590268589897911583709341937044115"+; 
						"512192011716488056694593813118384376562062784631049034629395002945834116482"+; 
						"411496975832601180073169943739350696629571241027323913874175492307186245454"+; 
						"322203955273529524024590380574450289224688628533654221381572213116328811205"+; 
						"214648980518009202471939171055539011394331668151582884368760696110250517100"+; 
						"739276238555338627255353883096067164466237092264680967125406186950214317621"+; 
						"166814009759528149390722260111268115310838731761732323526360583817315103459"+; 
						"573653822353499293582283685100781088463434998351840445170427018938199424341"+; 
						"009057537625776757111809008816418331920196262341628816652137471732547772778"+; 
						"348877436651882875215668571950637193656539038944936642176400312152787022236"+; 
						"646363575550356557694888654950027085392361710550213114741374410613444554419"+; 
						"210133617299628569489919336918472947858072915608851039678195942983318648075"+; 
						"608367955149663644896559294818785178403877332624705194505041984774201418394"+; 
						"773120281588684570729054405751060128525805659470304683634459265255213700806"+; 
						"875200959345360731622611872817392807462309468536782310609792159936001994623"+; 
						"799343421068781349734695924646975250624695861690917857397659519939299399556"+; 
						"754271465491045686070209901260681870498417807917392407194599632306025470790"+; 
						"177452751318680998228473086076653686685551646770291133682756310722334672611"+; 
						"370549079536583453863719623585631261838715677411873852772292259474337378569"+; 
						"553845624680101390572787101651296663676445187246565373040244368414081448873"+; 
						"295784734849000301947788802046032466084287535184836495919508288832320652212"+; 
						"810419044804724794929134228495197002260131043006241071797150279343326340799"+; 
						"596053144605323048852897291765987601666781193793237245385720960758227717848"+; 
						"336161358261289622611812945592746276713779448758675365754486140761193112595"+; 
						"851265575973457301533364263076798544338576171533346232527057200530398828949"+; 
						"903425956623297578248873502925916682589445689465599265845476269452878051650"+; 
						"172067478541788798227680653665064191097343452887833862172615626958265447820"+; 
						"567298775642632532159429441803994321700009054265076309558846589517170914760"+; 
						"743713689331946909098190450129030709956622662030318264936573369841955577696"+; 
						"378762491885286568660760056602560544571133728684020557441603083705231224258"+; 
						"722343885412317948138855007568938112493538631863528708379984569261998179452"+; 
						"336408742959118074745341955142035172618420084550917084568236820089773945584"+; 
						"267921427347756087964427920270831215015640634134161716644806981548376449157"+; 
						"390012121704154787259199894382536495051477137939914720521952907939613762110"+; 
						"723849429061635760459623125350606853765142311534966568371511660422079639446"+; 
						"662116325515772907097847315627827759878813649195125748332879377157145909106"+; 
						"484164267830994972367442017586226940215940792448054125536043131799269673915"+; 
						"754241929660731239376354213923061787675395871143610408940996608947141834069"+; 
						"836299367536262154524729846421375289107988438130609555262272083751862983706"+; 
						"678722443019579379378607210725427728907173285487437435578196651171661833088"+; 
						"112912024520404868220007234403502544820283425418788465360259150644527165770"+; 
						"004452109773558589762265548494162171498953238342160011406295071849042778925"+; 
						"855274303522139683567901807640604213830730877446017084268827226117718084266"+; 
						"433365178000217190344923426426629226145600433738386833555534345300426481847"+; 
						"398921562708609565062934040526494324426144566592129122564889356965500915430"+; 
						"642613425266847259491431423939884543248632746184284665598533231221046625989"+; 
						"014171210344608427161661900125719587079321756969854401339762209674945418540"+; 
						"711844643394699016269835160784892451405894094639526780735457970030705116368"+; 
						"251948770118976400282764841416058720618418529718915401968825328930914966534"+; 
						"575357142731848201638464483249903788606900807270932767312758196656394114896"+; 
						"171683298045513972950668760474091542042842999354102582911350224169076943166"+; 
						"857424252250902693903481485645130306992519959043638402842926741257342244776"+; 
						"558417788617173726546208549829449894678735092958165263207225899236876845701"+; 
						"782303809656788311228930580914057261086588484587310165815116753332767488701"+; 
						"482916741970151255978257270740643180860142814902414678047232759768426963393"+; 
						"577354293018673943971638861176420900406866339885684168100387238921448317607"+; 
						"011668450388721236436704331409115573328018297798873659091665961240202177855"+; 
						"885487617616198937079438005666336488436508914480557103976521469602766258359"+; 
						"905198704230017946553679"
		
Return( __eTthD )

#IFDEF __MT__

	#IFDEF __PROTHEUS__
		User Function AddThread( cBigN1 , cBigN2 , nSize , nAcc )
			Local oRet := Add( @cBigN1 , @cBigN2 , @nSize , @nAcc )
			Static _AddThread
			#IFNDEF __TBN_DYN_OBJ_SET__
				DEFAULT _AddThread  := Array(8,2)
				_AddThread[1][2] := oRet:cDec
				_AddThread[2][2] := oRet:cInt
				_AddThread[3][2] := oRet:cRDiv
				_AddThread[4][2] := oRet:cSig
				_AddThread[5][2] := oRet:lNeg
				_AddThread[6][2] := oRet:nDec
				_AddThread[7][2] := oRet:nInt
				_AddThread[8][2] := oRet:nSize
			#ELSE
				_AddThread := ClassDataArr( oRet )
			#ENDIF	
		Return( _AddThread )
	#ELSE
		Function AddThread( cBigN1 , cBigN2 , nSize , nAcc )
		Return( Add( @cBigN1 , @cBigN2 , @nSize , @nAcc ) )
	#ENDIF
	
	#IFDEF __PROTHEUS__
		User Function SubThread( cBigN1 , cBigN2 , nSize , nAcc )
			Local oRet := Sub( @cBigN1 , @cBigN2 , @nSize , @nAcc )
			Static _SubThread
			#IFNDEF __TBN_DYN_OBJ_SET__
				DEFAULT _SubThread  := Array(8,2)
				_SubThread[1][2] := oRet:cDec
				_SubThread[2][2] := oRet:cInt
				_SubThread[3][2] := oRet:cRDiv
				_SubThread[4][2] := oRet:cSig
				_SubThread[5][2] := oRet:lNeg
				_SubThread[6][2] := oRet:nDec
				_SubThread[7][2] := oRet:nInt
				_SubThread[8][2] := oRet:nSize
			#ELSE
				_SubThread := ClassDataArr( oRet )
			#ENDIF	
		Return( _SubThread )
	#ELSE
		Function SubThread( cBigN1 , cBigN2 , nSize , nAcc )
		Return( Sub( @cBigN1 , @cBigN2 , @nSize , @nAcc ) )
	#ENDIF
	
	#IFDEF __PROTHEUS__
		User Function DivThread( cBigN1 , cBigN2 , nAcc , lFloat )
			Local oRet := Div( @cBigN1 , @cBigN2 , @nAcc , @lFloat )
			Static _DivThread
			#IFNDEF __TBN_DYN_OBJ_SET__
				DEFAULT _DivThread  := Array(8,2)
				_DivThread[1][2] := oRet:cDec
				_DivThread[2][2] := oRet:cInt
				_DivThread[3][2] := oRet:cRDiv
				_DivThread[4][2] := oRet:cSig
				_DivThread[5][2] := oRet:lNeg
				_DivThread[6][2] := oRet:nDec
				_DivThread[7][2] := oRet:nInt
				_DivThread[8][2] := oRet:nSize
			#ELSE
				_DivThread := ClassDataArr( oRet )
			#ENDIF	
		Return( _DivThread )
	#ELSE
		Function DivThread( cBigN1 , cBigN2 , nAcc , lFloat )
		Return( Div( @cBigN1 , @cBigN2 , @nAcc , @lFloat ) )
	#ENDIF

	#IFDEF __PROTHEUS__
		User Function MultThread( cBigN1 , cBigN2 , nSize , nAcc ) 	
			Local oRet := Mult( @cBigN1 , @cBigN2 , @nSize , @nAcc )
			Static _MultThread
			#IFNDEF __TBN_DYN_OBJ_SET__
				DEFAULT _MultThread  := Array(8,2)
				_MultThread[1][2] := oRet:cDec
				_MultThread[2][2] := oRet:cInt
				_MultThread[3][2] := oRet:cRDiv
				_MultThread[4][2] := oRet:cSig
				_MultThread[5][2] := oRet:lNeg
				_MultThread[6][2] := oRet:nDec
				_MultThread[7][2] := oRet:nInt
				_MultThread[8][2] := oRet:nSize
			#ELSE
				_MultThread := ClassDataArr( oRet )
			#ENDIF	
		Return( _MultThread )
	#ELSE
		Function MultThread( cBigN1 , cBigN2 , nSize , nAcc )
		Return( Mult( @cBigN1 , @cBigN2 , @nSize , @nAcc ) )
	#ENDIF
	
	#IFDEF __PROTHEUS__
		User Function __MultThread( cBigN1 , cBigN2 , nAcc )	
			Local oRet := __Mult( @cBigN1 , @cBigN2 , @nAcc )
			Static ___MultThread
			#IFNDEF __TBN_DYN_OBJ_SET__
				DEFAULT ___MultThread  := Array(8,2)
				___MultThread[1][2] := oRet:cDec
				___MultThread[2][2] := oRet:cInt
				___MultThread[3][2] := oRet:cRDiv
				___MultThread[4][2] := oRet:cSig
				___MultThread[5][2] := oRet:lNeg
				___MultThread[6][2] := oRet:nDec
				___MultThread[7][2] := oRet:nInt
				___MultThread[8][2] := oRet:nSize
			#ELSE
				___MultThread := ClassDataArr( oRet )
			#ENDIF	
		Return( ___MultThread )
		
	#ELSE
		Function __MultThread( cBigN1 , cBigN2 , nAcc )
		Return( __Mult( @cBigN1 , @cBigN2 , @nAcc ) )
	#ENDIF

#ENDIF