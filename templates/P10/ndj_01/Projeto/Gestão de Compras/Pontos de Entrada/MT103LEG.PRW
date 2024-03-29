#INCLUDE "NDJ.CH"
/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � MT103LEG � Autor � Jose Carlos Noronha� Data �  05/11/10   ���
�������������������������������������������������������������������������͹��
���Descricao � Ponto de entrada para tratar as cores do browse com a      ���
��             inclusao do ATESTO.                                        ���
��                                                                        ���
�������������������������������������������������������������������������͹��
���Uso       �                                                            ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
User Function MT103LEG()

	Local aLegend := ParamIxb[1]
	
	If !( ValType( aLegend ) == "A" )
		aLegend := {}
	EndIf
	
	aAdd( aLegend , { "CADEADO_16"	, OemToAnsi( "Aguardando Atesto" ) } )
	aAdd( aLegend , { "BR_CANCEL"	, OemToAnsi( "Recusa de Atesto"  ) } )
	
	IF IsInCallStack( "GetF1Status" )
		__aLegend_ := aLegend
		UserException( "IGetF1Status" )
	EndIF
	
Return( aLegend )

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