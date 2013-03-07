#INCLUDE "NDJ.CH"
/*/
�����������������������������������������������������������������������������
�������������'����������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � MTA130C8 � Autor � Jose Carlos Noronha� Data �  15/10/10   ���
�������������������������������������������������������������������������͹��
���Descricao � Ponto de entrada executado na Gera��o da Cota��o de Compras���
��             que ser� utilizado para levar as informa��es da tabela de  ���
��             Solicita��o de Compras (SC1) para a tabela de Cota��o de   ���
��             Compras (SC8).                                             ��� 
�������������������������������������������������������������������������͹��
���Uso       �                                                            ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������//*/
User Function MTA130C8

	Local aArea 	:= GetArea()
	Local aFromTo   := {}

	Local __cC1		:= GetNextAlias()
	Local cKeySeek	:= xFilial("SC1")+SC8->( C8_NUMSC+C8_ITEMSC )
	Local cA2Reduz	:= ""

	Local nSC1Order	:= RetOrder( "SC1" , "C1_FILIAL+C1_NUM+C1_ITEM" )
	Local nSA2Order	:= RetOrder( "SA2" , "A2_FILIAL+A2_COD+A2_LOJA" )

	ChkFile( "SC1" , .F. , __cC1 )

	dbSelectArea(__cC1)
	(__cC1)->( dbSetOrder( nSC1Order ) )
	(__cC1)->( dBseek( cKeySeek , .F. ) )

	IF (__cC1)->( Found() )

		PutNLicita( __cC1 )

		// J� esta ponterado no item da cota��o. 
		PutToFrom( @aFromTo , "C8_XEQUIPA" , "C1_XEQUIPA" )
		PutToFrom( @aFromTo , "C8_XCLIINS" , "C1_XCLIINS" )
		PutToFrom( @aFromTo , "C8_XCLIORG" , "C1_XCLIORG" )
		PutToFrom( @aFromTo , "C8_XCONTAT" , "C1_XCONTAT" )
		PutToFrom( @aFromTo , "C8_XENDER"  , "C1_XENDER"  )
		PutToFrom( @aFromTo , "C8_XCODSBM" , "C1_XCODSBM" )
		PutToFrom( @aFromTo , "C8_XSBM"    , "C1_XSBM"    )
		PutToFrom( @aFromTo , "C8_XLOJAIN" , "C1_XLOJAIN" )	
		PutToFrom( @aFromTo , "C8_XRESPON" , "C1_XRESPON" )
		PutToFrom( @aFromTo , "C8_XPROP1"  , "C1_XPROP1"  )
		PutToFrom( @aFromTo , "C8_XPROJET" , "C1_XPROJET" )
		PutToFrom( @aFromTo , "C8_XCODOR"  , "C1_XCODOR"  )
		PutToFrom( @aFromTo , "C8_XSZ2COD" , "C1_XSZ2COD" )
		PutToFrom( @aFromTo , "C8_CODORCA" , "C1_CODORCA" )
		PutToFrom( @aFromTo , "C8_CC"      , "C1_CC"      )
		PutToFrom( @aFromTo , "C8_CLVL"    , "C1_CLVL"    )
		PutToFrom( @aFromTo , "C8_ITEMCTA" , "C1_ITEMCTA" )
		PutToFrom( @aFromTo , "C8_XTAREFA" , "C1_XTAREFA" )
		PutToFrom( @aFromTo , "C8_CODORCA" , "C1_CODORCA" )
		PutToFrom( @aFromTo , "C8_USERSC"  , "C1_USER"    )
		PutToFrom( @aFromTo , "C8_XCODCOM" , "C1_XCODCOM" )
		PutToFrom( @aFromTo , "C8_XDESCOM" , "C1_XDESCOM" )
		PutToFrom( @aFromTo , "C8_XREVIS"  , "C1_REVISA"  )  
		PutToFrom( @aFromTo , "C8_XNUMPRO" , "C1_XNUMPRO" )
		PutToFrom( @aFromTo , "C8_XMODALI" , "C1_XMODALI" )
		PutToFrom( @aFromTo , "C8_XCODGE"  , "C1_XCODGE"  )
		PutToFrom( @aFromTo , "C8_XVISCTB" , "C1_XVISCTB" )
		PutToFrom( @aFromTo , "C8_XREFCNT" , "C1_XREFCNT" )
		PutToFrom( @aFromTo , "C8_XDTPPAG" , "C1_XDTPPAG" )

        StaticCall( NDJLIB001 , NDJFromTo , __cC1 , "SC8" , @aFromTo )

		cA2Reduz := PosAlias( "SA2" , SC8->(C8_FORNECE+C8_LOJA) , NIL , "A2_NREDUZ" , nSA2Order , .F. )
        StaticCall( NDJLIB001 , __FieldPut , "SC8" , "C8_XDESFOR" , cA2Reduz , .T. )

        StaticCall( NDJLIB001 , PutIncHrs , "SC8" , .T. )

	EndIF

	(__cC1)->( dbCloseArea() )

	RestArea( aArea )

Return( .T. )

/*/
�����������������������������������������������������������������������Ŀ
�Fun��o    �PutToFrom        �Autor�Marinaldo de Jesus� Data �23/11/2010�
�����������������������������������������������������������������������Ĵ
�Descri��o �Carrega o Array para o De Para							    �
�����������������������������������������������������������������������Ĵ
�Sintaxe   �<Vide Parametros Formais>									�
�����������������������������������������������������������������������Ĵ
�Parametros�<Vide Parametros Formais>									�
�����������������������������������������������������������������������Ĵ
�Uso       �Generico												    �
�������������������������������������������������������������������������/*/
Static Function PutToFrom( aFromTo, cTo , cFrom )
	aAdd( aFromTo, { cFrom , cTo } )
Return( NIL )

/*/
�����������������������������������������������������������������������Ŀ
�Fun��o    �PutNLicita		 �Autor�Marinaldo de Jesus� Data �23/11/2010�
�����������������������������������������������������������������������Ĵ
�Descri��o �Carrega o Array para o De Para							    �
�����������������������������������������������������������������������Ĵ
�Sintaxe   �<Vide Parametros Formais>									�
�����������������������������������������������������������������������Ĵ
�Parametros�<Vide Parametros Formais>									�
�����������������������������������������������������������������������Ĵ
�Uso       �Ira fazer com que o Numero da Licita��o seja grvado em todos�
�          �os itens de Cotacao											�
�������������������������������������������������������������������������/*/
Static Function PutNLicita( cAliasSC1 )

	Local aArea			:= GetArea()
	Local aSC1Area		:= SC1->( GetArea() )
	Local aSC8Area		:= SC8->( GetArea() )
	Local aSC1Alias		:= (cAliasSC1)->( GetArea() )

	Local cMsgHelp
	Local cSC1Filial	:= xFilial( "SC1" , SC1->C1_FILIAL )
	Local cSC1KeySeek

	Local nSC1Order		:= RetOrder( "SC1" , "C1_FILIAL+C1_NUM+C1_ITEM" )
	
	Local oException

	TRYEXCEPTION

		IF (;
				!( Type( "_C1XNumero" ) == "C" );
				.or.;
				Empty( _C1XNumero );
			)	
			BREAK
		EndIF

		IF (;
				!( Type( "_C1XModali" ) == "C" );
				.or.;
				Empty( _C1XModali );
			)	
			BREAK
		EndIF

        StaticCall( NDJLIB001 , __FieldPut , "SC8" , "C8_XNUMPRO" , _C1XNumero , .T. )
        StaticCall( NDJLIB001 , __FieldPut , "SC8" , "C8_XMODALI" , _C1XModali , .T. )

		( cAliasSC1 )->( dbSetOrder( nSC1Order ) )
		cSC1KeySeek := SC8->( cSC1Filial + C8_NUMSC + C8_ITEMSC )
		IF ( ( cAliasSC1 )->( !dbSeek( cSC1KeySeek , .F. ) )  )
			BREAK
		EndIF

        StaticCall( NDJLIB001 , __FieldPut , cAliasSC1 , "C1_XNUMPRO" , _C1XNumero , .T. )
        StaticCall( NDJLIB001 , __FieldPut , cAliasSC1 , "C1_XMODALI" , _C1XModali , .T. )

	CATCHEXCEPTION USING oException

		IF ( ValType( oException ) == "O" )
			cMsgHelp := oException:Description
			Help( "" , 1 , ProcName() , NIL , OemToAnsi( cMsgHelp ) , 1 , 0 )
			cMsgHelp += CRLF
			cMsgHelp += oException:ErrorStack
			ConOut( cMsgHelp )
		EndIF	

	ENDEXCEPTION

	RestArea( aSC8Area )
	RestArea( aSC1Area )
	RestArea( aSC1Alias )
	RestArea( aArea )

Return( NIL )

Static Function __Dummy( lRecursa )
	Local oException
	TRYEXCEPTION
		lRecursa := .F.
		IF !( lRecursa )
			BREAK
		EndIF
    	lRecursa	:= __Dummy( .F. )
		__cCRLF		:= NIL	
	CATCHEXCEPTION USING oException
	ENDEXCEPTION
Return( lRecursa )