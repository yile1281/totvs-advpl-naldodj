#INCLUDE "PAN-AMERICANA.CH"
#INCLUDE "U_PANLIB03.CH"

/*/
旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
� Statics da Processa                                          |
읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸/*/
Static oMeter
Static nAtual
Static nBmp
Static oNome

/*/
旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
� Proc2BarGauge		                                           |
읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸/*/
Static aProcTG1
Static aProcTG2

Static nCurrentG1
Static nCurrentG2
Static nSetDifG1
Static nSetDifG2
Static nTmIncG1Proc
Static nTmCntG1Proc
Static nTmLstG1Proc
Static nTmLstG1Cnt
Static nTmIncG2Proc
Static nTmCntG2Proc
Static nTmLstG2Proc
Static nTmLstG2Cnt

Static cLstMsgG1
Static cLstMsgG2
Static cLstMsgG1T
Static cLstMsgG2T

Static lNoForceRefresh

Static oDlg2BarGauge
Static oGauge1
Static oGauge2
Static oProcG1
Static oProcG2

/*/
旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
� Constantes Manifestas para Proc2BarGauge		               |
읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸/*/
#DEFINE __nFirstRemaining__ 	-9999999999
#DEFINE __nMsgTimeElements__	4
#DEFINE __nMsgTime1__			1
#DEFINE __nMsgTime2__			2
#DEFINE __nMsgTime3__			3
#DEFINE __nMsgTime4__			4

/*/
旼컴컴컴컴컫컴컴컴컴컴쩡컴컴쩡컴컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴�
쿛rograma  쿛ANLIB03  쿌utor쿘arinaldo de Jesus       � Data �26/11/2009�
쳐컴컴컴컴컵컴컴컴컴컴좔컴컴좔컴컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴�
쿏escri뇙o 쿍liblioteca de Funcoes de Processamento da PAN  			�
쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
쿢so       쿒enerico                                                    �
쳐컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
�            ATUALIZACOES SOFRIDAS DESDE A CONSTRU�AO INICIAL           �
쳐컴컴컴컴컴컫컴컴컴컴컴쩡컴컴컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
쿛rogramador 쿏ata      쿙ro. Ocorr.쿘otivo da Alteracao                �
쳐컴컴컴컴컴컵컴컴컴컴컴탠컴컴컴컴컴탠컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
�            �          �           �                                   �
읕컴컴컴컴컴컨컴컴컴컴컴좔컴컴컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�/*/
/*/
旼컴컴컴컴컫컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴컴컴컴컴컴컫컴컴컴쩡컴컴컴컴커
쿑un뇙o    쿢_LIB03Exec   쿌utor 쿘arinaldo de Jesus   � Data �26/11/2009�
쳐컴컴컴컴컵컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴컴컴컴컴컴컨컴컴컴좔컴컴컴컴캑
쿏escri뇙o 쿐xecutar Funcoes Dentro de PANLIB03	                         �
쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캑
쿞intaxe   쿢_LIB03Exec( cExecIn , aFormParam )						 	 �
쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캑
쿛arametros�<Vide Parametros Formais>									 �
쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캑
쿝etorno   퀅Ret                                                 	     �
쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캑
쿚bserva뇙o�                                                      	     �
쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캑
쿢so       쿒enerico 													 �
읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸/*/
User Function LIB03Exec( cExecIn , aFormParam )
         
	Local uRet
	
	DEFAULT cExecIn		:= ""
	DEFAULT aFormParam	:= {}
	
	IF !Empty( cExecIn )
		cExecIn	:= BldcExecInFun( cExecIn , aFormParam )
		uRet	:= &( cExecIn )
	EndIF

Return( uRet )

/*/
旼컴컴컴컴컫컴컴컴컴컴컴컴쩡컴컴쩡컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴�
쿑un뇚o	   쿛rocessa	  쿌utor쿘arinaldo de Jesus   � Data �26/11/2009�
쳐컴컴컴컴컵컴컴컴컴컴컴컴좔컴컴좔컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴�
쿏escri뇚o 쿛rocessa com Calculadora                                    �
쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
쿞intaxe   �<Vide Parametros Formais> 									�
쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
쿛arametros�<Vide Parametros Formais> 									�
쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
쿢so	   쿒enerico      												�
읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�/*/
Static Function Processa( bAction , cTitle , cMsg , lAbort )

	Local oDlg
	Local oText
	
	Local lEnd := .f.
	
	Local nVal := 0
	
	#IFNDEF PROTHEUS
		Local oTimer
		Local oBmp
	#ENDIF	
	
	DEFAULT lAbort := .f.
	
	DEFAULT bAction := { || nil }, cMsg := STR0001, cTitle := STR0002	// "Processando..." ### "Aguarde"
	
	#IFNDEF PROTHEUS
		DEFINE TIMER oTimer INTERVAL 200 ACTION ChgBmpProc(++nBmp,oBmp) OF GetWndDefault()
	#ENDIF
	
	DEFINE MSDIALOG oDlg FROM 0,0 TO 150, 323 TITLE OemToAnsi(cTitle) OF GetWndDefault() STYLE DS_MODALFRAME STATUS PIXEL
	
	#IFNDEF PROTHEUS
		@  .3,  .5  BITMAP oBmp RESOURCE "CALC01" OF oDlg NOBORDER SIZE 16,10 WHEN .F.
	#ENDIF
	
	@ 06, 21 SAY oNome VAR OemToAnsi(cMsg) SIZE 140, 10 OF oDlg FONT oDlg:oFont PIXEL
	@ 20,05 TO 45,155 OF oDlg PIXEL
	@ 29,10  METER oMeter VAR nVal TOTAL 10 SIZE 140, 10 OF oDlg BARCOLOR GetSysColor(13),GetSysColor() PIXEL
	IF lAbort
		DEFINE SBUTTON FROM 50,122 TYPE 2 ACTION (lAbortPrint := .t.,lEnd := .t.) ENABLE OF oDlg
	Else
		DEFINE SBUTTON FROM 50,122 TYPE 2 OF oDlg
	Endif
	oDlg:bStart = { || Eval( bAction, @lEnd ),lEnd := .t., oDlg:End() }
	
	#IFDEF PROTHEUS
		ACTIVATE DIALOG oDlg VALID lEnd CENTERED
	#ELSE
		nBmp := 1
		ACTIVATE DIALOG oDlg ON INIT oTimer:Activate() VALID lEnd CENTERED
		oTimer:End()
		ObjFree( @oBmp   )
		ObjFree( @oTimer )
	#ENDIF
	
	ObjFree( @oMeter )
	ObjFree( @oNome  )
	ObjFree( @oText  )
	ObjFree( @oDlg   )
	
	oMeter:= Nil
	oText := Nil

Return( NIL )

#IFNDEF PROTHEUS
	Static Function ChgBmpProc(nBmp,oBmp)
	Local nResto := if(nBmp%3==0,3,nBmp%3)
	Local cBmp := "CALC"+StrZero(nResto,2,0)
	oBmp:cResName := cBmp
	oBmp:SetBmp()
	oBmp:Display()
	Return
#ENDIF

Static Function ProcRegua(nTotal)
oMeter:nTotal := nTotal
nAtual := 0
Return( NIL )

Static Function IncProc(cMsg)
oMeter:Set(++nAtual)
oNome :SetText(OemToAnsi(cMsg))
SysRefresh()

/*/
旼컴컴컴컴컫컴컴컴컴컴컴컴쩡컴컴쩡컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴�
쿑un뇚o	   쿛roc2BarGauge 쿌utor쿘arinaldo de Jesus   � Data �26/11/2009�
쳐컴컴컴컴컵컴컴컴컴컴컴컴좔컴컴좔컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴�
쿏escri뇚o 쿛rocessa com 2 Barras de Gauge                              �
쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
쿞intaxe   �<Vide Parametros Formais> 									�
쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
쿛arametros�<Vide Parametros Formais> 									�
쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
쿢so	   쿒enerico      												�
읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�/*/
Static Function Proc2BarGauge(;
								bAction		,;	//01 -> Acao a ser Executada
	   							cTitle		,;	//02 -> Titulo do Dialogo
								cMsg1		,;	//03 -> Mensagem para a 1a. BarGauge
								cMsg2		,;	//04 -> Mensagem para a 2a. BarGauge
								lAbort		,;	//05 -> Se habilitara o botao para "Abortar" o processo
								lProcTime1	,;	//06 -> Se havera controle de estimativa de tempo na 1a. BarGauge
								lProcTime2	,;	//07 -> Se havera conteole de estimativa de tempo na 2a. BarGauge
								lShow2Gauge	 ;	//08 -> Se ira mostrar a 2a. BarGauge
					  		 )

	Local aSvKeys		:= GetKeys()
	Local aAdvSize		:= {}
	Local aInfoAdvSize	:= {}
	Local aObjSize		:= {}
	Local aObjCoords	:= {}
	
	Local bSet24		:= { || NIL }
	Local bDialogInit	:= { || NIL }
	
	Local cMsgT11		:= CRLF
	Local cMsgT12		:= CRLF
	Local cMsgT13		:= CRLF
	Local cMsgT14		:= CRLF
	Local cMsgT21		:= CRLF
	Local cMsgT22		:= CRLF
	Local cMsgT23		:= CRLF
	Local cMsgT24		:= CRLF
	
	Local lEnd			:= .F.
	
	Local nGauge1		:= 0
	Local nGauge2		:= 0
	Local nHeightGauge	:= 10
	Local nMsgTime
	Local nMsgsTime
	
	Local oFont			:= NIL
	Local oGroup0		:= NIL
	Local oGroup1		:= NIL
	Local oGroup2		:= NIL
	Local oGroup3		:= NIL
	Local oButtonCancel	:= NIL
	
	DEFAULT bAction 	:= { || NIL }
	DEFAULT cTitle		:= STR0002		//"Aguarde"
	DEFAULT cMsg1		:= STR0001		//"Processando..."
	DEFAULT cMsg2		:= ""
	DEFAULT lAbort		:= .F.
	DEFAULT lProcTime1	:= .F.
	DEFAULT lProcTime2	:= .F.
	DEFAULT lShow2Gauge := .T.
	
	/*/
	旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
	쿣erifica se devera utilizar ProcessMessages() para forcar o Re�
	쿯resh.														   � 
	읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸/*/
	lNoForceRefresh := ( SuperGetMv( "MV_2GNOINC" , NIL , "S" ) == "S" )
	                                  
	/*/
	旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
	� Inverte o Estado de lProcTime2 em funcao de lShow2Gauge	   �
	읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸/*/
	IF !( lShow2Gauge )
		lProcTime2 := .F.
	EndIF
	
	/*/
	旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
	� Seta as Variaveis Statics utilizadas na Funcao               �
	읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸/*/
	SetStatic2BarG()
	
	/*/
	旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
	� Se lAbortPrint nao estiver Definida em uma Estancia Superior,�
	� criamos													   �
	읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸/*/
	IF ( Type( "lAbortPrint" ) == "U" )
		_SetOwnerPrvt( "lAbortPrint" , .F. )
	EndIF
	
	/*/
	旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
	� Monta as Dimensoes dos Objetos         					   �
	읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸/*/
	aAdvSize		:= MsAdvSize( .F. , .T. , 50 )
	/*
	旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
	� Redimensiona o Dialogo                     				   �
	읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸*/
	aAdvSize[3] -= 050	//Ajusta a Largura do Objeto
	aAdvSize[5] -= 100	//Ajusta a Largura do Dialogo
	aInfoAdvSize := { aAdvSize[1] , aAdvSize[2] , aAdvSize[3] , aAdvSize[4] , 0 , 0 }
	
	IF ( ( lProcTime1 ) .and. ( lProcTime2 ) )
		nHeightGauge := 07
		aAdd( aObjCoords , { 001 , 001 , .T. , .F. } )	//01 -> Separador
		aAdd( aObjCoords , { 005 , 005 , .T. , .F. } )	//02 -> Mensagem 1
		aAdd( aObjCoords , { 014 , 014 , .T. , .F. } )	//03 -> Grupo 1 ( Grupo e BarGauge )
		aAdd( aObjCoords , { 001 , 001 , .T. , .F. } )	//04 -> Separador
		aAdd( aObjCoords , { 045 , 045 , .T. , .F. } )	//05 -> Grupo 2 ( Grupo e Time )
		aAdd( aObjCoords , { 001 , 001 , .T. , .F. } )	//06 -> Separador
		aAdd( aObjCoords , { 005 , 005 , .T. , .F. } )	//07 -> Mensagem 2
		aAdd( aObjCoords , { 014 , 014 , .T. , .F. } )	//08 -> Grupo 3 ( Grupo e BarGauge )
		aAdd( aObjCoords , { 001 , 001 , .T. , .F. } )	//09 -> Separador
		aAdd( aObjCoords , { 045 , 045 , .T. , .F. } )	//10 -> Grupo 4 ( Grupo e Time )
		aAdd( aObjCoords , { 001 , 001 , .T. , .F. } )	//11 -> Separador
		aAdd( aObjCoords , { 000 , 000 , .T. , .T. } )	//12 -> Botao Cancelar
	ElseIF 	( ( lProcTime1 ) .or. ( lProcTime2 ) )
		IF ( lProcTime1 )
			aAdd( aObjCoords , { 001 , 001 , .T. , .F. } )	//01 -> Separador
			aAdd( aObjCoords , { 005 , 005 , .T. , .F. } )	//02 -> Mensagem 1
			aAdd( aObjCoords , { 030 , 030 , .T. , .F. } )	//03 -> Grupo 1 ( Grupo e BarGauge )
			aAdd( aObjCoords , { 001 , 001 , .T. , .F. } )	//04 -> Separador
			aAdd( aObjCoords , { 045 , 045 , .T. , .F. } )	//05 -> Grupo 2 ( Grupo e Time )
			aAdd( aObjCoords , { 000 , 000 , .T. , .F. } )	//06 -> Separador
			aAdd( aObjCoords , { 005 , 005 , .T. , .F. } )	//07 -> Mensagem 2
			aAdd( aObjCoords , { 030 , 030 , .T. , .F. } )	//08 -> Grupo 3 ( Grupo e BarGauge )
			aAdd( aObjCoords , { 001 , 001 , .T. , .F. } )	//09 -> Separador
			aAdd( aObjCoords , { 000 , 000 , .T. , .F. } )	//10 -> Grupo 4 ( Grupo e Time )
			aAdd( aObjCoords , { 015 , 015 , .T. , .F. } )	//11 -> Separador
			aAdd( aObjCoords , { 000 , 000 , .T. , .T. } )	//12 -> Botao Cancelar
		ElseIF ( lProcTime2 )
			aAdd( aObjCoords , { 001 , 001 , .T. , .F. } )	//01 -> Separador
			aAdd( aObjCoords , { 005 , 005 , .T. , .F. } )	//02 -> Mensagem 1
			aAdd( aObjCoords , { 030 , 030 , .T. , .F. } )	//03 -> Grupo 1 ( Grupo e BarGauge )
			aAdd( aObjCoords , { 000 , 000 , .T. , .F. } )	//04 -> Separador
			aAdd( aObjCoords , { 000 , 000 , .T. , .F. } )	//05 -> Grupo 2 ( Grupo e Time )
			aAdd( aObjCoords , { 001 , 001 , .T. , .F. } )	//06 -> Separador
			aAdd( aObjCoords , { 005 , 005 , .T. , .F. } )	//07 -> Mensagem 2
			aAdd( aObjCoords , { 030 , 030 , .T. , .F. } )	//08 -> Grupo 3 ( Grupo e BarGauge )
			aAdd( aObjCoords , { 001 , 001 , .T. , .F. } )	//08 -> Separador
			aAdd( aObjCoords , { 045 , 045 , .T. , .F. } )	//10 -> Grupo 4 ( Grupo e Time )
			aAdd( aObjCoords , { 015 , 015 , .T. , .F. } )	//11 -> Separador
			aAdd( aObjCoords , { 000 , 000 , .T. , .T. } )	//12 -> Botao Cancelar
		EndIF
	Else
		aAdd( aObjCoords , { 001 , 001 , .T. , .F. } )	//01 -> Separador
		aAdd( aObjCoords , { 005 , 005 , .T. , .F. } )	//02 -> Mensagem 1
		aAdd( aObjCoords , { 030 , 030 , .T. , .F. } )	//03 -> Grupo 1 ( Grupo e BarGauge )
		aAdd( aObjCoords , { 001 , 001 , .T. , .F. } )	//04 -> Separador
		aAdd( aObjCoords , { 000 , 000 , .T. , .F. } )	//05 -> Grupo 2 ( Grupo e Time )
		aAdd( aObjCoords , { 000 , 000 , .T. , .F. } )	//06 -> Separador
		aAdd( aObjCoords , { 005 , 005 , .T. , .F. } )	//07 -> Mensagem 2
		aAdd( aObjCoords , { 030 , 030 , .T. , .F. } )	//08 -> Grupo 3 ( Grupo e BarGauge )
		aAdd( aObjCoords , { 000 , 000 , .T. , .F. } )	//09 -> Separador
		aAdd( aObjCoords , { 000 , 000 , .T. , .F. } )	//10 -> Grupo 4 ( Grupo e Time )
		aAdd( aObjCoords , { 060 , 060 , .T. , .F. } )	//11 -> Separador
		aAdd( aObjCoords , { 000 , 000 , .T. , .T. } )	//12 -> Botao Cancelar
	EndIF
	aObjSize		:= MsObjSize( aInfoAdvSize , aObjCoords )
	
	DEFINE FONT oFont NAME "Arial" SIZE 0,-11 BOLD
	DEFINE MSDIALOG oDlg2BarGauge FROM aAdvSize[7],0 TO IF( lShow2Gauge , aAdvSize[6]+27 , aAdvSize[6]-075 ),aAdvSize[5] TITLE OemToAnsi( cTitle ) OF GetWndDefault() STYLE DS_MODALFRAME STATUS PIXEL
	
		/*/
		旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
		� Mensagem 1												   �
		읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸/*/
		@ aObjSize[002,1],(aObjSize[002,2]+2.5) SAY oProcG1		VAR OemToAnsi( cMsg1 )	SIZE aObjSize[002,4],008 OF oDlg2BarGauge FONT oFont PIXEL
	
		/*/
		旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
		� Grupo 1 e 1a. BarGauge									   �
		읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸/*/
		@ aObjSize[003,1],(aObjSize[003,2]+0.75) GROUP oGroup0 TO aObjSize[003,3],aObjSize[003,4] OF oDlg2BarGauge PIXEL
		oGroup0:oFont := oFont
		@ (aObjSize[003,1]+((aObjSize[003,3]-aObjSize[003,1])/100*35)),(aObjSize[003,2]+2.5) METER oGauge1	VAR nGauge1 TOTAL 10	SIZE (aObjSize[003,4]-aObjSize[003,2]-5),nHeightGauge OF oDlg2BarGauge BARCOLOR GetSysColor(13),GetSysColor() PIXEL
	
		/*/
		旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
		� Tempo de Processamento do 1o. Processo (1a. BarGauge)		   �
		읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸/*/
		IF ( lProcTime1 )
			cMsgT12 := STR0010	//"Obtendo informa뇯es sobre o tempo de processamento. Aguarde..."
			@ aObjSize[005,1],(aObjSize[005,2]+0.75) GROUP oGroup1 TO aObjSize[005,3],aObjSize[005,4] OF oDlg2BarGauge PIXEL LABEL OemToAnsi( STR0009 + "( 01 )" )	//"Tempo do Processo:"
			oGroup1:oFont := oFont
			@ (aObjSize[005,1]+((aObjSize[005,3]-aObjSize[005,1])/100*15)),(aObjSize[005,2]+2.5) SAY aProcTG1[1] VAR OemToAnsi( cMsgT11 )	SIZE (aObjSize[005,4]*5),008 OF oDlg2BarGauge FONT oFont PIXEL
			@ (aObjSize[005,1]+((aObjSize[005,3]-aObjSize[005,1])/100*35)),(aObjSize[005,2]+2.5) SAY aProcTG1[2] VAR OemToAnsi( cMsgT12 )	SIZE (aObjSize[005,4]*5),008 OF oDlg2BarGauge FONT oFont PIXEL
			@ (aObjSize[005,1]+((aObjSize[005,3]-aObjSize[005,1])/100*55)),(aObjSize[005,2]+2.5) SAY aProcTG1[3] VAR OemToAnsi( cMsgT13 )	SIZE (aObjSize[005,4]*5),008 OF oDlg2BarGauge FONT oFont PIXEL
			@ (aObjSize[005,1]+((aObjSize[005,3]-aObjSize[005,1])/100*75)),(aObjSize[005,2]+2.5) SAY aProcTG1[4] VAR OemToAnsi( cMsgT14 )	SIZE (aObjSize[005,4]*5),008 OF oDlg2BarGauge FONT oFont PIXEL
		EndIF
		
		IF ( lShow2Gauge )
	
			/*/
			旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
			� Mensagem 2												   �
			읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸/*/
			@ aObjSize[007,1],(aObjSize[007,2]+2.5) SAY oProcG2		VAR OemToAnsi( cMsg2 )	SIZE aObjSize[007,4],008 OF oDlg2BarGauge FONT oFont PIXEL
		
			/*/
			旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
			� Grupo 2 e 2a. BarGauge									   �
			읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸/*/
			@ aObjSize[008,1],(aObjSize[008,2]+0.75) GROUP oGroup2 TO aObjSize[008,3],aObjSize[008,4] OF oDlg2BarGauge PIXEL
			oGroup2:oFont := oFont
			@ (aObjSize[008,1]+((aObjSize[008,3]-aObjSize[008,1])/100*35)),(aObjSize[008,2]+2.5) METER oGauge2	VAR nGauge2 TOTAL 10	SIZE (aObjSize[008,4]-aObjSize[008,2]-5),nHeightGauge OF oDlg2BarGauge BARCOLOR GetSysColor(13),GetSysColor() PIXEL
	
			/*/
			旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
			� Tempo de Processamento do 2o. Processo (2a. BarGauge)		   �
			읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸/*/
			IF ( lProcTime2 )
				cMsgT22 := STR0010	//"Obtendo informa뇯es sobre o tempo de processamento. Aguarde..."
				/*/
				旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
				� CMDJ Contrario utiliza as Coordenadas para o Tempo de  Proces�
				� samento do 2o. Processo									   �
				읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸/*/
				@ aObjSize[010,1],(aObjSize[010,2]+0.75) GROUP oGroup3 TO aObjSize[010,3],aObjSize[010,4] OF oDlg2BarGauge PIXEL LABEL OemToAnsi( STR0009 + "( 02 )"  )	//"Tempo do Processo:"
				oGroup3:oFont := oFont
				@ (aObjSize[010,1]+((aObjSize[010,3]-aObjSize[010,1])/100*15)),(aObjSize[010,2]+2.5) SAY aProcTG2[1]		VAR OemToAnsi( cMsgT21 )	SIZE (aObjSize[10,4]*5),008 OF oDlg2BarGauge FONT oFont PIXEL
				@ (aObjSize[010,1]+((aObjSize[010,3]-aObjSize[010,1])/100*35)),(aObjSize[010,2]+2.5) SAY aProcTG2[2]		VAR OemToAnsi( cMsgT22 )	SIZE (aObjSize[10,4]*5),008 OF oDlg2BarGauge FONT oFont PIXEL
				@ (aObjSize[010,1]+((aObjSize[010,3]-aObjSize[010,1])/100*55)),(aObjSize[010,2]+2.5) SAY aProcTG2[3]		VAR OemToAnsi( cMsgT23 )	SIZE (aObjSize[10,4]*5),008 OF oDlg2BarGauge FONT oFont PIXEL
				@ (aObjSize[010,1]+((aObjSize[010,3]-aObjSize[010,1])/100*75)),(aObjSize[010,2]+2.5) SAY aProcTG2[4]		VAR OemToAnsi( cMsgT24 )	SIZE (aObjSize[10,4]*5),008 OF oDlg2BarGauge FONT oFont PIXEL
			EndIF
		
		EndIF
	
		bSet24 := { || ( lEnd := ( lAbortPrint := .T. ) ) }
	
		IF ( lAbort )
			bDialogInit := { || oDlg2BarGauge:bSet24 := bSet24 , SetKey( 24 , bSet24 ) }
			DEFINE SBUTTON oButtonCancel FROM IF( lShow2Gauge , aObjSize[012,1]+5 , aObjSize[012,1]-47 ),(aObjSize[012,4]-30) TYPE 2 ACTION Eval( bSet24 ) ENABLE OF oDlg2BarGauge PIXEL
		Else
			DEFINE SBUTTON oButtonCancel FROM IF( lShow2Gauge , aObjSize[012,1]+5 , aObjSize[012,1]-47 ),(aObjSize[012,4]-30) TYPE 2 DISABLE OF oDlg2BarGauge PIXEL
		EndIF
	
		oDlg2BarGauge:bStart := { || Eval( bAction ) , lEnd := .T. , RestKeys( aSvKeys , .T. ) , oDlg2BarGauge:End() }
	
	ACTIVATE DIALOG oDlg2BarGauge VALID lEnd CENTERED ON INIT Eval( bDialogInit )
	
	ObjFree( @oGroup0 )
	ObjFree( @oGroup1 )
	ObjFree( @oGroup2 )
	ObjFree( @oGroup3 )
	ObjFree( @oFont   )
	ObjFree( @oButtonCancel )
	
	/*/
	旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
	� Garante a Restauracao das Teclas de Atalho                   �
	읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸/*/
	RestKeys( aSvKeys , .T. )
	
	/*/
	旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
	� Reseta as Variaveis Statics utilizadas na Funcao             �
	읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸/*/
	RstStatic2BarG()
	
	/*/
	旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
	� Reinicializa o Contador de Tempos em Proc2BarGauge()		   �
	읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸/*/
	RstTimeRemaining()
	
Return( lEnd )

/*/
旼컴컴컴컴컫컴컴컴컴컴컴컴쩡컴컴쩡컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴�
쿑un뇚o	   쿏lg2BarGGetTit쿌utor쿘arinaldo de Jesus   � Data �26/11/2009�
쳐컴컴컴컴컵컴컴컴컴컴컴컴좔컴컴좔컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴�
쿏escri뇚o 쿝etorna o Titulo do Dialogo da Proc2BarGauge()    			�
쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
쿞intaxe   �<Vide Parametros Formais> 									�
쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
쿛arametros�<Vide Parametros Formais> 									�
쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
쿢so	   쿒ENERICO      												�
읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�/*/
Static Function Dlg2BarGGetTit()
Return( oDlg2BarGauge:cTitle )

/*/
旼컴컴컴컴컫컴컴컴컴컴컴컴쩡컴컴쩡컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴�
쿑un뇚o	   쿏lg2BarGSetTit쿌utor쿘arinaldo de Jesus   � Data �26/11/2009�
쳐컴컴컴컴컵컴컴컴컴컴컴컴좔컴컴좔컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴�
쿏escri뇚o 쿞eta novo Titulo do Dialogo da Proc2BarGauge()    			�
쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
쿞intaxe   �<Vide Parametros Formais> 									�
쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
쿛arametros�<Vide Parametros Formais> 									�
쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
쿢so	   쿒ENERICO      												�
읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�/*/
Static Function Dlg2BarGSetTit( cNewTitle )
	oDlg2BarGauge:cTitle := cNewTitle
	oDlg2BarGauge:Refresh()
Return( SysRefresh() )

/*/
旼컴컴컴컴컫컴컴컴컴컴컴컴쩡컴컴쩡컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴�
쿑un뇚o	   쿞etStatic2BarG쿌utor쿘arinaldo de Jesus   � Data �26/11/2009�
쳐컴컴컴컴컵컴컴컴컴컴컴컴좔컴컴좔컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴�
쿏escri뇚o 쿞etar as Variaveis Statics utilizadas em Proc2BarGauge()    �
쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
쿞intaxe   �<Vide Parametros Formais> 									�
쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
쿛arametros�<Vide Parametros Formais> 									�
쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
쿢so	   쿛ANLIB03      												�
읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�/*/
Static Function SetStatic2BarG()

	oDlg2BarGauge			:= NIL
	oGauge1					:= NIL
	oGauge2 				:= NIL
	oProcG1					:= NIL
	oProcG2 				:= NIL
	aProcTG1				:= Array( __nMsgTimeElements__ )
	aProcTG2				:= Array( __nMsgTimeElements__ )
	DEFAULT nCurrentG1		:= 0
	DEFAULT nCurrentG2		:= 0
	DEFAULT nSetDifG1		:= 1
	DEFAULT nSetDifG2		:= 1
	DEFAULT nTmIncG1Proc	:= 0
	DEFAULT nTmCntG1Proc	:= 0
	DEFAULT nTmLstG1Proc	:= 0
	DEFAULT nTmLstG1Cnt		:= 0
	DEFAULT nTmIncG2Proc    := 0
	DEFAULT nTmCntG2Proc	:= 0
	DEFAULT nTmLstG2Proc	:= 0
	DEFAULT nTmLstG2Cnt		:= 0
	DEFAULT cLstMsgG1		:= "__cLstMsgG1__"
	DEFAULT cLstMsgG2		:= "__cLstMsgG2__"
	DEFAULT cLstMsgG1T		:= "__cLstMsgG1T__"
	DEFAULT cLstMsgG2T		:= "__cLstMsgG2T__"
	
Return( NIL )

/*/
旼컴컴컴컴컫컴컴컴컴컴컴컴쩡컴컴쩡컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴�
쿑un뇚o	   쿝stStatic2BarG쿌utor쿘arinaldo de Jesus   � Data �26/11/2009�
쳐컴컴컴컴컵컴컴컴컴컴컴컴좔컴컴좔컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴�
쿏escri뇚o 쿝esetar as Variaveis Statics utilizadas em Proc2BarGauge()  �
쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
쿞intaxe   �<Vide Parametros Formais> 									�
쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
쿛arametros�<Vide Parametros Formais> 									�
쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
쿢so	   쿛ANLIB03      												�
읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�/*/
Static Function RstStatic2BarG()

	Local nMsgTime
	Local nMsgsTime
	
	ObjFree( @oGauge1 )
	ObjFree( @oGauge2 )
	ObjFree( @oProcG1 )
	ObjFree( @oProcG2 )
	ObjFree( @oDlg2BarGauge )
	nMsgsTime	:= Len( aProcTG1 )
	For nMsgTime := 1 To nMsgsTime
		IF ( ValType( aProcTG1[nMsgTime] ) == "O" )
			ObjFree( @aProcTG1[nMsgTime] )
		EndIF
	Next nMsgTime
	nMsgsTime	:= Len( aProcTG2 )
	For nMsgTime := 1 To nMsgsTime
		IF ( ValType( aProcTG2[nMsgTime] ) == "O" )
			ObjFree( @aProcTG2[nMsgTime] )
		EndIF
	Next nMsgTime
	
	aProcTG1		:= NIL
	aProcTG2		:= NIL
	
	cLstMsgG1		:= NIL
	cLstMsgG2		:= NIL
	cLstMsgG1T		:= NIL
	cLstMsgG2T		:= NIL
	
	nCurrentG1		:= NIL
	nCurrentG2		:= NIL
	nSetDifG1		:= NIL
	nSetDifG2		:= NIL
	nTmIncG1Proc	:= NIL
	nTmCntG1Proc	:= NIL
	nTmLstG1Proc	:= NIL
	nTmLstG1Cnt		:= NIL
	nTmIncG2Proc    := NIL
	nTmCntG2Proc	:= NIL
	nTmLstG2Proc	:= NIL
	nTmLstG2Cnt		:= NIL

Return( NIL )
                
/*/
旼컴컴컴컴컫컴컴컴컴컴컴컴쩡컴컴쩡컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴�
쿑un뇚o	   쿍arGauge1Set  쿌utor쿘arinaldo de Jesus   � Data �26/11/2009�
쳐컴컴컴컴컵컴컴컴컴컴컴컴좔컴컴좔컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴�
쿏escri뇚o 쿞eta o Totalizador da Gauge1                          		�
쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
쿞intaxe   �<Vide Parametros Formais> 									�
쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
쿛arametros�<Vide Parametros Formais> 									�
쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
쿢so	   쿒enerico      												�
읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�/*/
Static Function BarGauge1Set( nProcRegua )

	nCurrentG1		:= 0
	nTmLstG1Cnt		:= 0
	oGauge1:nTotal	:= 25
	nSetDifG1		:= ( 25 / nProcRegua )
	
Return( NIL )

/*/
旼컴컴컴컴컫컴컴컴컴컴컴컴쩡컴컴쩡컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴�
쿑un뇚o	   쿒et1BarSet	  쿌utor쿘arinaldo de Jesus   � Data �26/11/2009�
쳐컴컴컴컴컵컴컴컴컴컴컴컴좔컴컴좔컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴�
쿏escri뇚o 쿞alva as Informacoes da Proc2BarGauge() que serao   restaura�
�          쿭as pela Rst1BarSet()										�
쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
쿞intaxe   �<Vide Parametros Formais> 									�
쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
쿛arametros�<Vide Parametros Formais> 									�
쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
쿢so	   쿒enerico      												�
읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�/*/
Static Function Get1BarSet()
Return( { nCurrentG1 , nTmLstG1Cnt , oGauge1:nTotal , nSetDifG1 , nTmCntG1Proc , nTmLstG1Proc } )

/*/
旼컴컴컴컴컫컴컴컴컴컴컴컴쩡컴컴쩡컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴�
쿑un뇚o	   쿝st1BarSet	  쿌utor쿘arinaldo de Jesus   � Data �26/11/2009�
쳐컴컴컴컴컵컴컴컴컴컴컴컴좔컴컴좔컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴�
쿏escri뇚o 쿝estaura as Informacoes Salvas pela Get1BarSet         		�
쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
쿞intaxe   �<Vide Parametros Formais> 									�
쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
쿛arametros�<Vide Parametros Formais> 									�
쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
쿢so	   쿒enerico      												�
읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�/*/
Static Function Rst1BarSet( a1BarSet )

	nCurrentG1		:= a1BarSet[1]
	nTmLstG1Cnt		:= a1BarSet[2]
	oGauge1:nTotal	:= a1BarSet[3]
	nSetDifG1		:= a1BarSet[4]
	nTmCntG1Proc	:= a1BarSet[5]
	nTmLstG1Proc	:= a1BarSet[6]
	
Return( NIL )

/*/
旼컴컴컴컴컫컴컴컴컴컴컴컴쩡컴컴쩡컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴�
쿑un뇚o	   쿍arGauge2Set  쿌utor쿘arinaldo de Jesus   � Data �26/11/2009�
쳐컴컴컴컴컵컴컴컴컴컴컴컴좔컴컴좔컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴�
쿏escri뇚o 쿞eta o Totalizador da Gauge2                          		�
쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
쿞intaxe   �<Vide Parametros Formais> 									�
쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
쿛arametros�<Vide Parametros Formais> 									�
쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
쿢so	   쿒enerico      												�
읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�/*/
Static Function BarGauge2Set( nProcRegua )

	nCurrentG2		:= 0
	nTmLstG2Cnt		:= 0
	oGauge2:nTotal	:= 25
	nSetDifG2		:= ( 25 / nProcRegua )
	
Return( NIL )

/*/
旼컴컴컴컴컫컴컴컴컴컴컴컴쩡컴컴쩡컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴�
쿑un뇚o	   쿒et2BarSet	  쿌utor쿘arinaldo de Jesus   � Data �26/11/2009�
쳐컴컴컴컴컵컴컴컴컴컴컴컴좔컴컴좔컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴�
쿏escri뇚o 쿞alva as Informacoes da Proc2BarGauge() que serao   restaura�
�          쿭as pela Rst2BarSet()										�
쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
쿞intaxe   �<Vide Parametros Formais> 									�
쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
쿛arametros�<Vide Parametros Formais> 									�
쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
쿢so	   쿒enerico      												�
읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�/*/
Static Function Get2BarSet()
Return( { nCurrentG2 , nTmLstG2Cnt , oGauge2:nTotal , nSetDifG2 , nTmCntG2Proc , nTmLstG2Proc } )

/*/
旼컴컴컴컴컫컴컴컴컴컴컴컴쩡컴컴쩡컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴�
쿑un뇚o	   쿝st2BarSet	  쿌utor쿘arinaldo de Jesus   � Data �26/11/2009�
쳐컴컴컴컴컵컴컴컴컴컴컴컴좔컴컴좔컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴�
쿏escri뇚o 쿝estaura as Informacoes Salvas pela Get2BarSet()       		�
쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
쿞intaxe   �<Vide Parametros Formais> 									�
쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
쿛arametros�<Vide Parametros Formais> 									�
쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
쿢so	   쿒enerico      												�
읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�/*/
Static Function Rst2BarSet( a2BarSet )

	nCurrentG2		:= a2BarSet[1]
	nTmLstG2Cnt		:= a2BarSet[2]
	oGauge2:nTotal	:= a2BarSet[3]
	nSetDifG2		:= a2BarSet[4]
	nTmCntG2Proc	:= a2BarSet[5]
	nTmLstG2Proc	:= a2BarSet[6]
	
Return( NIL )

/*/
旼컴컴컴컴컫컴컴컴컴컴컴컴쩡컴컴쩡컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴�
쿑un뇚o	   쿔ncProcG1	  쿌utor쿘arinaldo de Jesus   � Data �26/11/2009�
쳐컴컴컴컴컵컴컴컴컴컴컴컴좔컴컴좔컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴�
쿏escri뇚o 쿔ncrementa o Totalizador da Gauge1                          �
쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
쿞intaxe   �<Vide Parametros Formais> 									�
쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
쿛arametros�<Vide Parametros Formais> 									�
쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
쿢so	   쿒enerico      												�
읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�/*/
Static Function IncProcG1( cMsg , lIncProcG1 , aMsgTime , lForceRefresh )

	Local lIsMsgChar	:= ( ValType( cMsg ) == "C" )
	Local lIsaMsgTime	:= ( ValType( aMsgTime ) == "A" )
	
	Local nMsgTime
	Local nMsgsTime
	
	DEFAULT lIncProcG1 := .T.
	
	IF (;
			( lIsMsgChar );
			.and.;
			!( cLstMsgG1 == cMsg );
		)
		DEFAULT lForceRefresh := .T.
		IF (;
				!( lNoForceRefresh );
				.and.;
				( lForceRefresh );
			)
			ProcessMessages() //Garanto aqui que a Mensagem sera atualizada
		EndIF
		cLstMsgG1 := cMsg
	Else
		lIsMsgChar := .F.
	EndIF
	
	IF ( lIncProcG1 )
		++nCurrentG1
		oGauge1:Set( ( nCurrentG1 * nSetDifG1 ) )
		IF ( lIsMsgChar )
			oProcG1:SetText( OemToAnsi( cMsg ) )
		EndIF
		IF ( lIsaMsgTime )
			nMsgsTime := Len( aMsgTime )
			For nMsgTime := 1 To nMsgsTime
				IF ( ValType( aMsgTime[ nMsgTime ] ) == "C" )
					IF ( ValType( aProcTG1[nMsgTime] ) == "O" )
						aProcTG1[nMsgTime]:SetText( OemToAnsi( aMsgTime[ nMsgTime ] ) )
					EndIF
				EndIF
			Next nMsgTime
		EndIF
	Else
		IF ( lIsMsgChar )
			oProcG1:SetText( OemToAnsi( cMsg ) )
		EndIF
		IF ( lIsaMsgTime )
			nMsgsTime := Len( aMsgTime )
			For nMsgTime := 1 To nMsgsTime
				IF ( ValType( aMsgTime[ nMsgTime ] ) == "C" )
					IF ( ValType( aProcTG1[nMsgTime] ) == "O" )
						aProcTG1[nMsgTime]:SetText( OemToAnsi( aMsgTime[ nMsgTime ] ) )
					EndIF
				EndIF
			Next nMsgTime
		EndIF
	EndIF

Return( SysRefresh() )

/*/
旼컴컴컴컴컫컴컴컴컴컴컴컴쩡컴컴쩡컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴�
쿑un뇚o	   쿔ncProcG2	  쿌utor쿘arinaldo de Jesus   � Data �26/11/2009�
쳐컴컴컴컴컵컴컴컴컴컴컴컴좔컴컴좔컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴�
쿏escri뇚o 쿔ncrementa o Totalizador da Gauge2                          �
쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
쿞intaxe   �<Vide Parametros Formais> 									�
쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
쿛arametros�<Vide Parametros Formais> 									�
쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
쿢so	   쿒enerico      												�
읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�/*/
Static Function IncProcG2( cMsg , lIncProcG2 , aMsgTime , lForceRefresh )

	Local lIsMsgChar	:= ( ValType( cMsg ) == "C" )
	Local lIsaMsgTime	:= ( ValType( aMsgTime ) == "A" )
	
	Local nMsgTime
	Local nMsgsTime
	
	DEFAULT lIncProcG2 := .T.
	
	IF (;
			( lIsMsgChar );
			.and.;
			!( cLstMsgG2 == cMsg );
		)
		DEFAULT lForceRefresh := .T.
		IF (;
				!( lNoForceRefresh );
				.and.;
				( lForceRefresh );
			)
			ProcessMessages() //Garanto aqui que a Mensagem sera atualizada
		EndIF
		cLstMsgG2 := cMsg
	Else
		lIsMsgChar := .F.
	EndIF
	
	IF ( lIncProcG2 )
		++nCurrentG2
		oGauge2:Set( ( nCurrentG2 * nSetDifG2 ) )
		IF ( lIsMsgChar )
			oProcG2:SetText( OemToAnsi( cMsg ) )
		EndIF
		IF ( lIsaMsgTime )
			nMsgsTime := Len( aMsgTime )
			For nMsgTime := 1 To nMsgsTime
				IF ( ValType( aMsgTime[ nMsgTime ] ) == "C" )
					IF ( ValType( aProcTG2[nMsgTime] ) == "O" )
						aProcTG2[nMsgTime]:SetText( OemToAnsi( aMsgTime[ nMsgTime ] ) )
					EndIF
				EndIF
			Next nMsgTime
		EndIF
	Else
		IF ( lIsMsgChar )
			oProcG2:SetText( OemToAnsi( cMsg ) )
		EndIF
		IF ( lIsaMsgTime )
			nMsgsTime := Len( aMsgTime )
			For nMsgTime := 1 To nMsgsTime
				IF ( ValType( aMsgTime[ nMsgTime ] ) == "C" )
					IF ( ValType( aProcTG2[nMsgTime] ) == "O" )
						aProcTG2[nMsgTime]:SetText( OemToAnsi( aMsgTime[ nMsgTime ] ) )
					EndIF	
				EndIF
			Next nMsgTime
		EndIF
	EndIF

Return( SysRefresh() )

/*/
旼컴컴컴컴컫컴컴컴컴컴컴컴쩡컴컴쩡컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴�
쿑un뇚o	   쿔ncPrcG1Time  쿌utor쿘arinaldo de Jesus   � Data �26/11/2009�
쳐컴컴컴컴컵컴컴컴컴컴컴컴좔컴컴좔컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴�
쿏escri뇚o 쿎hamada a IncProcG1() com calculo de Tempo de Processamento �
쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
쿞intaxe   �<Vide Parametros Formais> 									�
쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
쿛arametros�<Vide Parametros Formais> 									�
쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
쿢so	   쿒enerico      												�
읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�/*/
Static Function IncPrcG1Time(	cMsgIncProc		,;	//01 -> Inicio da Mensagem
								nLastRec		,;	//02 -> Numero de Registros a Serem Processados
								cTimeIni		,;	//03 -> Tempo Inicial
								lOnlyOneProc	,;	//04 -> Defina se eh um processo unico ou nao ( DEFAULT .T. )
								nCountTime		,;	//05 -> Contador de Processos
								nPercent	 	,;	//06 -> Percentual para Incremento
								lIncProcG1		,;	//07 -> Se Deve Incrementar a Barra ou Apenas Atualizar a Mensagem
								lForceRefresh	 ;	//08 -> Se Forca a Atualizacao das Mensagens
							 )

	Local aMsg				:= NIL
	Local cMsg				:= ""
	Local cMsg1 			:= STR0003  //"Inicio	 	 	:"
	Local cMsg2 			:= STR0004  //"Decorridos 	 	:"
	Local cMsg3 			:= STR0005  //"Total	 	 	:"
	Local cMsg4 			:= STR0006  //"Parcial	 	 	:"
	Local cMsg5 			:= STR0007  //"Final estimado 	:"
	Local cMsg6				:= STR0018  //"�s"
	Local cMsg7				:= STR0008  //"Evolu뇙o %		:"
	Local cMsg8				:= STR0019	//"Tempo M�dio:"
	
	Local nSeconds			:= 0
	Local nPercInc			:= 0
	
	Local aEndProc
	
	Local dStartDate
	
	Local c1RemainingTime
	Local c2RemainingTime
	Local cRetTimeEndProc
	Local cEndProc
	
	DEFAULT cMsgIncProc 	:= STR0001	//"Procesando..."
	DEFAULT nLastRec		:= 0
	DEFAULT cTimeIni		:= Time()
	DEFAULT lOnlyOneProc	:= .T.
	DEFAULT nCountTime		:= 0
	DEFAULT nPercent		:= 5
	DEFAULT lIncProcG1		:= .T.
	
	IF !( cLstMsgG1T == cMsgIncProc )
		cLstMsgG1T := cMsgIncProc
	Else
		cMsgIncProc := cLstMsgG1T
	EndIF
	
	IF !( nTmLstG1Cnt == nCountTime )
		nTmLstG1Cnt		:= nCountTime
		nTmCntG1Proc	:= 0
		nTmLstG1Proc	:= 0
	EndIF
	
	IF ( lIncProcG1 )
		nPercInc := ( ( ++nTmCntG1Proc ) / nLastRec )
		nPercInc *= 100
		nPercInc := Int( nPercInc )
		IF ( nTmCntG1Proc == 1 )
			IF ( lOnlyOneProc )
				RemainingTime( cTimeIni , nCountTime , .F. )
			Else
				RemainingTime( cTimeIni , __nFirstRemaining__ , .F. )
				RemainingTime( NIL , nCountTime , .F. )
			EndIF
		EndIF
	EndIF	
	
	IF ( ( lIncProcG1 ) .and. ( ( nPercInc % nPercent ) == 0 ) )
		IF !( nTmLstG1Proc == nPercInc )
			IF ( aScan( GetTimeRemaining() , { |x| ( x[1] == nCountTime ) } ) == 0 )
				dStartDate := MsDate()
			Else
				dStartDate := GetTimeRemaining()[ nCountTime , 2 , 2 ] - GetTimeRemaining()[ nCountTime , 2 , 3 ]
			EndIF	
			nTmLstG1Proc		:= nPercInc
			aMsg				:= Array( __nMsgTimeElements__ )
			cMsg				:= cMsg1
			cMsg				+= " ( "
			cMsg				+= cTimeIni
			cMsg				+= " "
			cMsg				+= STR0020	//"de"
			cMsg				+= " "
			cMsg				+= Dtoc( dStartDate )
			cMsg				+= " ) "
			aMsg[__nMsgTime1__]	:= cMsg
			cMsg				:= cMsg2
			cMsg				+= " ( "
			IF ( lOnlyOneProc )
				cMsg			+= cMsg3
				c1RemainingTime	:= RemainingTime( cTimeIni , nCountTime , .T. , @nSeconds )
				cMsg			+= c1RemainingTime
			Else
				cMsg			+= cMsg3
				c1RemainingTime	:= RemainingTime( cTimeIni , __nFirstRemaining__ , .F. )
				cMsg			+= c1RemainingTime
				cMsg			+= " / "
				cMsg			+= cMsg4
				c2RemainingTime := RemainingTime( NIL , nCountTime , .T. , @nSeconds )
				cMsg			+= c2RemainingTime
			EndIF
			cMsg				+= " ) "
			cMsg				+= " - "
			cMsg				+= cMsg8
			cMsg				+= " ( "
			IF ( lOnlyOneProc )
				cMsg			+= MediumTime( c1RemainingTime , nTmCntG1Proc , .T. )
			Else
				cMsg			+= " "
				cMsg			+= MediumTime( c1RemainingTime , nTmCntG1Proc , .T. )
				cMsg			+= " / "
				cMsg			+= MediumTime( c2RemainingTime , nTmCntG1Proc , .T. )
			EndIF	
			cMsg				+= " )"
			aMsg[__nMsgTime2__]	:= cMsg
			cMsg				:= cMsg5
			cMsg				+= " ( "
			cRetTimeEndProc		:= RetTimeEndProc( nTmCntG1Proc , nLastRec , nSeconds )
			cMsg				+= cRetTimeEndProc
			cMsg				+= " ) "
			cMsg				+= cMsg6
			cMsg				+= " ( " 
			cEndProc			:= IncTime( Time() , NIL , NIL , TimeToSecs( cRetTimeEndProc ) )
			IF ( FindFunction( "Time2NextDay" ) )
				aEndProc		:= Time2NextDay( cEndProc , MsDate() )
				cEndProc		:= ( aEndProc[1] + " " +  STR0020 + " " + Dtoc( aEndProc[2] ) ) //"de"
			EndIF
			cMsg				+= cEndProc
			cMsg				+= " ) "
			aMsg[__nMsgTime3__]	:= cMsg
			cMsg				:= cMsg7
			cMsg				+= " "
			cMsg				+= StrZero( nPercInc , 03 ) + "% - "
			cMsg				+= " ( "
			cMsg				+= AllTrim( Str( nTmCntG1Proc ) ) + " / " + AllTrim( Str( nLastRec ) )
			cMsg				+= " )"
			cMsg				+= " - "
			cMsg				+= STR0021 + " ( " + AllTrim( Str( ( nLastRec - nTmCntG1Proc ) ) ) + " ) "	//"Restando:" +
			aMsg[__nMsgTime4__]	:= cMsg
			IncProcG1( ( AllTrim( cMsgIncProc ) + CRLF ) , lIncProcG1 , aMsg , .T. )
		Else
			IncProcG1( cMsgIncProc , lIncProcG1 , aMsg , lForceRefresh )
		EndIF
	Else
		IncProcG1( cMsgIncProc , lIncProcG1 , aMsg , lForceRefresh )
	EndIF

Return( NIL )

/*/
旼컴컴컴컴컫컴컴컴컴컴컴컴쩡컴컴쩡컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴�
쿑un뇚o	   쿔ncPrcG2Time  쿌utor쿘arinaldo de Jesus   � Data �26/11/2009�
쳐컴컴컴컴컵컴컴컴컴컴컴컴좔컴컴좔컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴�
쿏escri뇚o 쿎hamada a IncProcG2() com calculo de Tempo de Processamento �
쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
쿞intaxe   �<Vide Parametros Formais> 									�
쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
쿛arametros�<Vide Parametros Formais> 									�
쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
쿢so	   쿒enerico      												�
읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�/*/
Static Function IncPrcG2Time(	cMsgIncProc		,;	//01 -> Inicio da Mensagem
	   							nLastRec		,;	//02 -> Numero de Registros a Serem Processados
								cTimeIni		,;	//03 -> Tempo Inicial
								lOnlyOneProc	,;	//04 -> Defina se eh um processo unico ou nao ( DEFAULT .T. )
								nCountTime		,;	//05 -> Contador de Processos
								nPercent	 	,;	//06 -> Percentual para Incremento
								lIncProcG2		,;	//07 -> Se Deve Incrementar a Barra ou Apenas Atualizar a Mensagem
								lForceRefresh	 ;	//08 -> Se Forca a Atualizacao das Mensagens						
							)
         
	Local aMsg				:= NIL
	Local cMsg				:= ""
	Local cMsg1 			:= STR0003  //"Inicio	 	 	:"
	Local cMsg2 			:= STR0004  //"Decorridos 	 	:"
	Local cMsg3 			:= STR0005  //"Total	 	 	:"
	Local cMsg4 			:= STR0006  //"Parcial	 	 	:"
	Local cMsg5 			:= STR0007  //"Final estimado 	:"
	Local cMsg6				:= STR0018  //"�s"
	Local cMsg7				:= STR0008  //"Evolu뇙o %		:"
	Local cMsg8				:= STR0019	//"Tempo M�dio:"
	
	Local nSeconds			:= 0
	Local nPercInc			:= 0
	
	Local aEndProc
	
	Local dStartDate
	
	Local c1RemainingTime
	Local c2RemainingTime
	Local cRetTimeEndProc
	Local cEndProc
	
	DEFAULT cMsgIncProc 	:= STR0001	//"Procesando..."
	DEFAULT nLastRec		:= 0
	DEFAULT cTimeIni		:= Time()
	DEFAULT lOnlyOneProc	:= .T.
	DEFAULT nCountTime		:= 0
	DEFAULT nPercent		:= 5
	DEFAULT lIncProcG2		:= .T.
	
	IF !( cLstMsgG2T == cMsgIncProc )
		cLstMsgG2T := cMsgIncProc
	Else
		cMsgIncProc := cLstMsgG2T
	EndIF
	
	IF !( nTmLstG2Cnt == nCountTime )
		nTmLstG2Cnt		:= nCountTime
		nTmCntG2Proc	:= 0
		nTmLstG2Proc	:= 0
	EndIF
	
	IF ( lIncProcG2 )
		nPercInc := ( ( ++nTmCntG2Proc ) / nLastRec )
		nPercInc *= 100
		nPercInc := Int( nPercInc )
		IF ( nTmCntG2Proc == 1 )
			IF ( lOnlyOneProc )
				RemainingTime( cTimeIni , nCountTime , .F. )
			Else
				RemainingTime( cTimeIni , __nFirstRemaining__ , .F. )
				RemainingTime( NIL , nCountTime , .F. )
			EndIF
		EndIF
	EndIF
	
	IF ( ( lIncProcG2 ) .and. ( ( nPercInc % nPercent ) == 0 ) )
		IF !( nTmLstG2Proc == nPercInc )
			IF ( aScan( GetTimeRemaining() , { |x| ( x[1] == nCountTime ) } ) == 0 )
				dStartDate := MsDate()
			Else
				dStartDate := GetTimeRemaining()[ nCountTime , 2 , 2 ] - GetTimeRemaining()[ nCountTime , 2 , 3 ]
			EndIF	
			nTmLstG2Proc		:= nPercInc
			aMsg				:= Array( __nMsgTimeElements__ )
			cMsg				:= cMsg1
			cMsg				+= " ( "
			cMsg				+= cTimeIni
			cMsg				+= " "
			cMsg				+= STR0020	//"de"
			cMsg				+= " "
			cMsg				+= Dtoc( dStartDate )
			cMsg				+= " ) "
			aMsg[__nMsgTime1__]	:= cMsg
			cMsg				:= cMsg2
			cMsg				+= " ( "
			IF ( lOnlyOneProc )
				cMsg			+= cMsg3
				c1RemainingTime	:= RemainingTime( cTimeIni , nCountTime , .T. , @nSeconds )
				cMsg			+= c1RemainingTime
			Else
				cMsg			+= cMsg3
				c1RemainingTime	:= RemainingTime( cTimeIni , __nFirstRemaining__ , .F. )
				cMsg			+= c1RemainingTime
				cMsg			+= " / "
				cMsg			+= cMsg4
				c2RemainingTime := RemainingTime( NIL , nCountTime , .T. , @nSeconds )
				cMsg			+= c2RemainingTime
			EndIF
			cMsg				+= " ) "
			cMsg				+= " - "
			cMsg				+= cMsg8
			cMsg				+= " ( "
			IF ( lOnlyOneProc )
				cMsg			+= MediumTime( c1RemainingTime , nTmCntG2Proc , .T. )
			Else
				cMsg			+= " "
				cMsg			+= MediumTime( c1RemainingTime , nTmCntG2Proc , .T. )
				cMsg			+= " / "
				cMsg			+= MediumTime( c2RemainingTime , nTmCntG2Proc , .T. )
			EndIF	
			cMsg				+= " )"
			aMsg[__nMsgTime2__]	:= cMsg
			cMsg				:= cMsg5
			cMsg				+= " ( "
			cRetTimeEndProc		:= RetTimeEndProc( nTmCntG2Proc , nLastRec , nSeconds )
			cMsg				+= cRetTimeEndProc
			cMsg				+= " ) "
			cMsg				+= cMsg6
			cMsg				+= " ( "
			cEndProc			:= IncTime( Time() , NIL , NIL , TimeToSecs( cRetTimeEndProc ) )
			IF ( FindFunction( "Time2NextDay" ) )
				aEndProc		:= Time2NextDay( cEndProc , MsDate() )
				cEndProc		:= ( aEndProc[1] + " " +  STR0020 + " " + Dtoc( aEndProc[2] ) ) //"de"
			EndIF
			cMsg				+= cEndProc
			cMsg				+= " ) "
			aMsg[__nMsgTime3__]	:= cMsg
			cMsg				:= cMsg7
			cMsg				+= " "
			cMsg				+= StrZero( nPercInc , 03 ) + "% - "
			cMsg				+= " ( "
			cMsg				+= AllTrim( Str( nTmCntG2Proc ) ) + " / " + AllTrim( Str( nLastRec ) )
			cMsg				+= " )"
			cMsg				+= " - "
			cMsg				+= STR0021 + " ( " + AllTrim( Str( ( nLastRec - nTmCntG2Proc ) ) ) + " ) "	//"Restando:" +
			aMsg[__nMsgTime4__]	:= cMsg
			IncProcG2( ( AllTrim( cMsgIncProc ) + CRLF ) , lIncProcG2 , aMsg , .T. )
		Else
			IncProcG2( cMsgIncProc , lIncProcG2 , aMsg , lForceRefresh )
		EndIF
	Else
		IncProcG2( cMsgIncProc , lIncProcG2 , aMsg , lForceRefresh )
	EndIF

Return( NIL )

/*/
旼컴컴컴컴컫컴컴컴컴컴컴컴컴컫컴컴컫컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴�
쿑un뇚o	   쿒etFirstRemaining쿌utor쿘arinaldo de Jesus� Data �26/11/2009�
쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컨컴컴컨컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴�
쿏escri뇚o 쿝etorna o Conteudo do Primeiro Processo da Proc2BarGauge    �
쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
쿞intaxe   �<Vide Parametros Formais>									�
쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
쿛arametros�<Vide Parametros Formais>									�
쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
쿝etorno   �__nFirstRemaining__        									�
쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
쿢so	   쿒enerica      										    	�
읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�/*/
Static Function GetFirstRemaining()
Return( __nFirstRemaining__ )

/*/
旼컴컴컴컴컫컴컴컴컴컴컴컴컴쩡컴컴쩡컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴�
쿑un뇚o	   쿛rocWaiting		쿌utor쿘arinaldo de Jesus � Data �26/11/2009�
쳐컴컴컴컴컵컴컴컴컴컴컴컴컴좔컴컴좔컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴�
쿏escri뇚o 쿘ostra Barra de Processamento Enquando Aguarda a Confirmacao�
�          쿭e uma determinada operacao									�
쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
쿞intaxe   �<Vide Parametros Formais>									�
쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
쿛arametros�<Vide Parametros Formais>									�
쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
쿝etorno   쿙IL                      									�
쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
쿢so	   쿒enerica      										    	�
읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�/*/
Static Function ProcWaiting( bWaiting , cTitle , cMsgWait , nWaiting , lStop , lShowProc )

	Local nWait			:= 0
	Local lWaitOk		:= .T.
	
	Private lAbortPrint	:= .F.
	
	DEFAULT cTitle		:= OemToAnsi( STR0002 )	//"Aguarde"
	DEFAULT cMsgWait	:= OemToAnsi( STR0011 )	//"Aguardando..."
	DEFAULT nWaiting	:= 500
	DEFAULT bWaiting	:= { || .T. }
	DEFAULT lStop		:= .T.
	DEFAULT lShowProc	:= .T.
	
	IF !( ValType( bWaiting ) == "B" )
		bWaiting := { || .T. }
	EndIF
	IF !( ValType( cTitle ) == "C" )
		cTitle := OemToAnsi( STR0002 )		//"Aguarde"
	EndIF
	IF !( ValType( cMsgWait ) == "C" )
		cMsgWait := OemToAnsi( STR0011 )	//"Aguardando..."
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
旼컴컴컴컴컫컴컴컴컴컴컴컴컴쩡컴컴쩡컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴�
쿑un뇚o	   쿥hileYesNoWait	쿌utor쿘arinaldo de Jesus � Data �26/11/2009�
쳐컴컴컴컴컵컴컴컴컴컴컴컴컴좔컴컴좔컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴�
쿏escri뇚o 쿐xecutar enquanto uma condicao nao for Verdadeira           �
쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
쿞intaxe   �<Vide Parametros Formais>									�
쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
쿛arametros�<Vide Parametros Formais>									�
쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
쿝etorno   쿙IL                      									�
쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
쿢so	   쿒enerica      										    	�
읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�/*/
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
	DEFAULT nWaiting		:= 500
	DEFAULT lStop		:= .T.
	DEFAULT uMsgInfo	:= OemToAnsi( STR0012 )	//"N꼘 foi poss죞el efetuar a opera뇙o."
	DEFAULT cTitInfo	:= OemToAnsi( STR0013 )	//"Aviso!"
	DEFAULT cMsgYesNo	:= OemToAnsi( STR0014 )	//"Tentar novamente?"
	DEFAULT cTitYesNo	:= OemToAnsi( STR0015 )	//"Sim/N꼘"
	DEFAULT cMsgWait	:= OemToAnsi( STR0002 )	//"Aguarde"
	DEFAULT cTitWait	:= OemToAnsi( STR0016 ) //"Tentando novamente..."""
	
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
		uMsgInfo	:= OemToAnsi( STR0012 )	//"N꼘 foi poss죞el efetuar a opera뇙o."
	EndIF
	IF !( ValType( cTitInfo ) == "C" )
		cTitInfo	:= OemToAnsi( STR0013 )	//"Aviso!"
	EndIF
	IF !( ValType( cMsgYesNo ) == "C" )
		cMsgYesNo	:= OemToAnsi( STR0014 )	//"Tentar novamente?"
	EndIF
	IF !( ValType( cTitYesNo ) == "C" )
		cTitYesNo	:= OemToAnsi( STR0015 )	//"Sim/N꼘"
	EndIF
	IF !( ValType( cMsgWait ) == "C" )
		cMsgWait	:= OemToAnsi( STR0002 )	//"Aguarde"
	EndIF
	IF !( ValType( cTitWait ) == "C" )
		cTitWait	:= OemToAnsi( STR0016 ) //"Tentando novamente..."""
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
旼컴컴컴컴컫컴컴컴컴컴컴컴컴쩡컴컴쩡컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴�
쿑un뇚o	   쿥hileNoYesWait	쿌utor쿘arinaldo de Jesus � Data �26/11/2009�
쳐컴컴컴컴컵컴컴컴컴컴컴컴컴좔컴컴좔컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴�
쿏escri뇚o 쿐xecutar enquanto uma condicao nao for Verdadeira           �
쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
쿞intaxe   �<Vide Parametros Formais>									�
쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
쿛arametros�<Vide Parametros Formais>									�
쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
쿝etorno   쿙IL                      									�
쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
쿢so	   쿒enerica      										    	�
읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�/*/
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
	DEFAULT uMsgInfo	:= OemToAnsi( STR0012 )	//"N꼘 foi poss죞el efetuar a opera뇙o."
	DEFAULT cTitInfo	:= OemToAnsi( STR0013 )	//"Aviso!"
	DEFAULT cMsgNoYes	:= OemToAnsi( STR0014 )	//"Tentar novamente?"
	DEFAULT cTitNoYes	:= OemToAnsi( STR0017 )	//"N꼘/Sim"
	DEFAULT cMsgWait	:= OemToAnsi( STR0002 )	//"Aguarde"
	DEFAULT cTitWait	:= OemToAnsi( STR0016 ) //"Tentando novamente..."""
	
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
		uMsgInfo	:= OemToAnsi( STR0012 )	//"N꼘 foi poss죞el efetuar a opera뇙o."
	EndIF
	IF !( ValType( cTitInfo ) == "C" )
		cTitInfo	:= OemToAnsi( STR0013 )	//"Aviso!"
	EndIF
	IF !( ValType( cMsgNoYes ) == "C" )
		cMsgNoYes	:= OemToAnsi( STR0014 )	//"Tentar novamente?"
	EndIF
	IF !( ValType( cTitNoYes ) == "C" )
		cTitNoYes	:= OemToAnsi( STR0017 )	//"N꼘/Sim"
	EndIF
	IF !( ValType( cMsgWait ) == "C" )
		cMsgWait	:= OemToAnsi( STR0002 )	//"Aguarde"
	EndIF
	IF !( ValType( cTitWait ) == "C" )
		cTitWait	:= OemToAnsi( STR0016 ) //"Tentando novamente..."""
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

/*/
旼컴컴컴컴컫컴컴컴컴컴컴컴쩡컴컴쩡컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴�
쿑un뇚o    쿚bjFree	  	  쿌utor쿘arinaldo de Jesus   � Data �26/11/2009�
쳐컴컴컴컴컵컴컴컴컴컴컴컴좔컴컴좔컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴�
쿏escri뇚o 쿑inalizacao dos Objetos                           		    �
쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
쿞intaxe   �<vide parametros formais>									�
쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
쿛arametros�<vide parametros formais>									�
쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
쿢so       쿒enerico                      								�
읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�/*/
Static Function ObjFree( oObjFree )

	TRYEXCEPTION

		IF ( ValType( oObjFree ) == "O" )
			DeleteObject( @oObjFree )
			IF ( ValType( oObjFree ) == "O" )
				TRYEXCEPTION 
					oObjFree:End()
				ENDEXCEPTION
				RELEASE OBJECTS oObjFree
			EndIF
			oObjFree	:= NIL
		EndIF

	ENDEXCEPTION

Return( NIL )

Static Function __Dummy( lRecursa )
	Local oException
	TRYEXCEPTION
        lRecursa := .F.
		IF !( lRecursa )
			BREAK
		EndIF
    	lRecursa	:= __Dummy( .F. )
	     BARGAUGE1SET()
	     BARGAUGE2SET()
	     DLG2BARGGETTIT()
	     DLG2BARGSETTIT()
	     GET1BARSET()
	     GET2BARSET()
	     GETFIRSTREMAINING()
	     INCPRCG1TIME()
	     INCPRCG2TIME()
	     PROC2BARGAUGE()
	     RST1BARSET()
	     RST2BARSET()
	     WHILENOYESWAIT()
	     WHILEYESNOWAIT()
	CATCHEXCEPTION USING oException
	ENDEXCEPTION
Return( lRecursa )