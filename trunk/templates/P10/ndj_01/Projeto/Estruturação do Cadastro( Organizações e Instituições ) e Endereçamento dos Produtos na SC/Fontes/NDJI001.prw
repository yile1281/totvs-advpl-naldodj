#INCLUDE "NDJ.CH"
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NDJI001   �Autor  �Rafael Rezende      � Data � 06/10/2010  ���
�������������������������������������������������������������������������͹��
���Desc.     �  Inicializador padr�o do campo AC8_XCONTA.                 ���
���          �  1 - Inicializador Padr�o                                  ���
���          �  1 - Inicializador Browser                                 ���
�������������������������������������������������������������������������͹��
���Uso       � SIGACOM                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

*-----------------------------*
User Function NDJI001( _nTipo )
*-----------------------------*
Local _aArea := GetArea()
Local _cRet  := ""

If _nTipo == 1
	If Inclui
		_cRet := ""
	Else                
		_cRet := Posicione( "SU5", 01, XFilial( "SU5" ) + GdFieldGet( "AC8_CODCON" ), "U5_CONTAT" )
	End If 
Else
	If Inclui
		_cRet := ""
	Else
		_cRet := Posicione( "SU5", 01, XFilial( "SU5" ) + M->AC8_CODCON, "U5_CONTAT" )
	End If 
End If 
             
RestArea( _aArea )  

Return _cRet

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