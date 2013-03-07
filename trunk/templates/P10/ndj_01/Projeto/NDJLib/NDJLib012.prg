#INCLUDE "NDJ.CH"
/*/
Funcao:		ProcWaiting
Autor: 		Marinaldo de Jesus
Data: 		28/03/2011
Descricao:	Mostra Barra de Processamento Enquando Aguarda a Confirmacao de uma determinada operacao
Sintaxe:	<Vide Parametros Formais>
/*/
Static Function ProcWaiting( bWaiting , cTitle , cMsgWait , nWaiting , lStop , lShowProc )

	Local nWait			:= 0
	Local lWaitOk		:= .T.
	
	Private lAbortPrint	:= .F.
	
	DEFAULT cTitle		:= "Aguarde"
	DEFAULT cMsgWait	:= "Aguardando..."
	DEFAULT nWaiting	:= 500
	DEFAULT bWaiting	:= { || .T. }
	DEFAULT lStop		:= .T.
	DEFAULT lShowProc	:= .T.
	
	IF !( ValType( bWaiting ) == "B" )
		bWaiting := { || .T. }
	EndIF
	IF !( ValType( cTitle ) == "C" )
		cTitle := "Aguarde"
	EndIF
	IF !( ValType( cMsgWait ) == "C" )
		cMsgWait := "Aguardando..."
	EndIF
	IF !( ValType( nWaiting ) == "N" )
		nWaiting := 500
	EndIF
	IF !( ValType( lStop ) == "L" )
		lStop	:= .T.
	EndIF
	IF !( ValType( lShowProc ) == "L" )
		lShowProc := .T.
	EndIF	
	
	Begin Sequence
		IF ( lShowProc )
			Processa(;
						{ ||;
								(;
									lWaitOk := ProcWaiting(;
																bWaiting	,;
																cTitle		,;
																cMsgWait	,;
																nWaiting	,;
																lStop		,;
																.F.			 ;
															 );
								);
						 },;
						 cTitle,;
						 cMsgWait,;
						 lStop;
					)
			Break
		EndIF
		ProcRegua( nWaiting )
		For nWait := 1 To nWaiting
			IncProc()
			IF ( ( lStop ) .and. ( lAbortPrint ) )
				lWaitOk := .F.
				Break
			EndIF
			IF ( lWaitOk := Eval( bWaiting ) )
				Break
			EndIF
		Next nWait
	End Sequence
	
	IF !( ValType( lWaitOk ) == "L" )
		lWaitOk := .F.
	EndIF	

Return( lWaitOk )

/*/
Funcao:		WhileYesNoWait
Autor: 		Marinaldo de Jesus
Data: 		28/03/2011
Descricao:	Executar enquanto uma condicao nao for Verdadeira
Sintaxe:	<Vide Parametros Formais>
/*/
Static Function WhileYesNoWait(	bExecWhile	,;	//01 -> Bloco a Ser Executando Enquando ( Devera Retornar Valor Logico )
	   							nWaiting	,;	//02 -> Tempo de Espera para a ProcWaiting()
	   							lStop		,;	//03 -> Se podera Encerrar as as Tentativas ( Button Cancel Enabled )
	   							uMsgInfo	,;	//04 -> Mensagem de Corpo para a MsgInfo
	   							cTitInfo	,;	//05 -> Titulo para a MsgInfo
	   							cMsgYesNo	,;	//06 -> Mensagem de Corpo para a MsgYesNo
	   							cTitYesNo	,;	//07 -> Titulo para a MsgYesNo
	   							cMsgWait	,;	//08 -> Mensagem de corpo para a ProcWaiting
	   							cTitWait	 ;	//09 -> Titulo para a ProcWaiting
	   						  )
         
	Local lExecOk 		:= .F.
	
	Local cTypeMsgInfo
	
	DEFAULT bExecWhile	:= { || .T. }
	DEFAULT nWaiting	:= 500
	DEFAULT lStop		:= .T.
	DEFAULT uMsgInfo	:= "N�o foi poss�vel efetuar a opera��o."
	DEFAULT cTitInfo	:= "Aviso!"
	DEFAULT cMsgYesNo	:= "Tentar novamente"
	DEFAULT cTitYesNo	:= "Sim/N�o"
	DEFAULT cMsgWait	:= "Aguarde"
	DEFAULT cTitWait	:= "Tentando novamente..."
	
	IF !( ValType( bExecWhile ) == "B" )
		bExecWhile	:= { || .T. }
	EndIF
	IF !( ValType( nWaiting ) == "N" )
		nWaiting 	:= 0
	EndIF
	IF !( ValType( lStop ) == "L" )
		lStop		:= .T.
	EndIF
	IF !( ( cTypeMsgInfo := ValType( uMsgInfo ) ) $ "BC" )
		uMsgInfo	:= "N�oo foi poss�vel efetuar a opera��o."
	EndIF
	IF !( ValType( cTitInfo ) == "C" )
		cTitInfo	:= "Aviso!"
	EndIF
	IF !( ValType( cMsgYesNo ) == "C" )
		cMsgYesNo	:= "Tentar novamente"
	EndIF
	IF !( ValType( cTitYesNo ) == "C" )
		cTitYesNo	:= "Sim/N�o"
	EndIF
	IF !( ValType( cMsgWait ) == "C" )
		cMsgWait	:= "Aguarde"
	EndIF
	IF !( ValType( cTitWait ) == "C" )
		cTitWait	:= "Tentando novamente..."
	EndIF
	
	IF !( lExecOk := Eval( bExecWhile ) )
		CursorArrow()
		MsgInfo( IF( ( cTypeMsgInfo == "B" ) , Eval( uMsgInfo ) , uMsgInfo ) , cTitInfo )
		While MsgYesNo( cMsgYesNo , cTitYesNo )
			IF ( lExecOk := ProcWaiting( { || Eval( bExecWhile ) } , cTitWait , cMsgWait , nWaiting , lStop , .T. ) )
				Exit
			Else
				MsgInfo( IF( ( cTypeMsgInfo == "B" ) , Eval( uMsgInfo ) , uMsgInfo ) , cTitInfo )
			EndIF
		End While
	EndIF

Return( lExecOk )

/*/
Funcao:		WhileNoYesWait
Autor: 		Marinaldo de Jesus
Data: 		28/03/2011
Descricao:	Executar enquanto uma condicao nao for Verdadeira
Sintaxe:	<Vide Parametros Formais>
/*/
Static Function WhileNoYesWait(	bExecWhile	,;	//01 -> Bloco a Ser Executando Enquando ( Devera Retornar Valor Logico )
	   							nWaiting	,;	//02 -> Tempo de Espera para a ProcWaiting()
	   							lStop		,;	//03 -> Se podera Encerrar as as Tentativas ( Button Cancel Enabled )
	   							uMsgInfo	,;	//04 -> Mensagem de Corpo para a MsgInfo
	   							cTitInfo	,;	//05 -> Titulo para a MsgInfo
	   							cMsgNoYes	,;	//06 -> Mensagem de Corpo para a MsgNoYes
	   							cTitNoYes	,;	//07 -> Titulo para a MsgNoYes
	   							cMsgWait	,;	//08 -> Mensagem de corpo para a ProcWaiting
	   							cTitWait	 ;	//09 -> Titulo para a ProcWaiting
	   						  )
         
	Local lExecOk 		:= .F.
	
	Local cTypeMsgInfo
	
	DEFAULT bExecWhile	:= { || .T. }
	DEFAULT nWaiting		:= 500
	DEFAULT lStop		:= .T.
	DEFAULT uMsgInfo	:= "N�o foi poss�vel efetuar a opera��o."
	DEFAULT cTitInfo	:= "Aviso!"
	DEFAULT cMsgNoYes	:= "Tentar novamente"
	DEFAULT cTitNoYes	:= "N�o/Sim"
	DEFAULT cMsgWait	:= "Aguarde"
	DEFAULT cTitWait	:= "Tentando novamente..."
	
	IF !( ValType( bExecWhile ) == "B" )
		bExecWhile	:= { || .T. }
	EndIF
	IF !( ValType( nWaiting ) == "N" )
		nWaiting 	:= 0
	EndIF
	IF !( ValType( lStop ) == "L" )
		lStop		:= .T.
	EndIF
	IF !( ( cTypeMsgInfo := ValType( uMsgInfo ) ) $ "BC" )
		uMsgInfo	:= "N�o foi poss�vel efetuar a opera��o."
	EndIF
	IF !( ValType( cTitInfo ) == "C" )
		cTitInfo	:= "Aviso!"
	EndIF
	IF !( ValType( cMsgNoYes ) == "C" )
		cMsgNoYes	:= "Tentar novamente"
	EndIF
	IF !( ValType( cTitNoYes ) == "C" )
		cTitNoYes	:= "N�o/Sim"
	EndIF
	IF !( ValType( cMsgWait ) == "C" )
		cMsgWait	:= "Aguarde"
	EndIF
	IF !( ValType( cTitWait ) == "C" )
		cTitWait	:= "Tentando novamente..."
	EndIF
	
	IF !( lExecOk := Eval( bExecWhile ) )
		CursorArrow()
		MsgInfo( IF( ( cTypeMsgInfo == "B" ) , Eval( uMsgInfo ) , uMsgInfo ) , cTitInfo )
		While MsgNoYes( cMsgNoYes , cTitNoYes )
			IF ( lExecOk := ProcWaiting( { || Eval( bExecWhile ) } , cTitWait , cMsgWait , nWaiting , lStop , .T. ) )
				Exit
			Else
				MsgInfo( IF( ( cTypeMsgInfo == "B" ) , Eval( uMsgInfo ) , uMsgInfo ) , cTitInfo )
			EndIF
		End While
	EndIF

Return( lExecOk )

Static Function __Dummy( lRecursa )
	Local oException
	TRYEXCEPTION
        lRecursa := .F.
		IF !( lRecursa )
			BREAK
		EndIF
		CAPTUREERROR()
    	PUTTRYEXCEPTIONVARS()
    	WHILENOYESWAIT()
    	WHILEYESNOWAIT()
    	lRecursa	:= __Dummy( .F. )
    	SYMBOL_UNUSED( __cCRLF )
	CATCHEXCEPTION USING oException
	ENDEXCEPTION
Return( lRecursa )