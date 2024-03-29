#INCLUDE "NDJ.CH"
/*/
	Funcao: A140EXC
	Autor:	Marinaldo de Jesus
	Data:	30/01/2011
	Uso:	Executado a partir da A140NFiscal em MATA140.
			Implementa��o do Ponto de Entrada A140EXC, originalmente utilizado para Retornar Modificar o Valor de nOpcA, ser� utilizado, tamb�m, para
			salvar as informa��es da SF1 e SD1 antes da Grava��o para compara��o posterior;
/*/
User Function A140EXC()

	Local aArea			:= GetArea()
	Local aAreaSF1		:= SF1->( GetArea() )
	Local aAreaSD1		:= SD1->( GetArea() )

	Local lContinua 	:= .T.

	Local oException

	TRYEXCEPTION

		StaticCall( U_MT140APV , SF1SD1Arr )

	CATCHEXCEPTION USING oException

	ENDEXCEPTION

	RestArea( aAreaSD1 )
	RestArea( aAreaSF1 )
	RestArea( aArea )

Return( lContinua )

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