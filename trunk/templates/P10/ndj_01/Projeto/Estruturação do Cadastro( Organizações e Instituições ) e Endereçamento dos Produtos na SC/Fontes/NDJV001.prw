#INCLUDE "NDJ.CH"
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NDJV001   �Autor  �Rafael Rezende      � Data � 05/10/2010  ���
�������������������������������������������������������������������������͹��
���Desc.     � Valida��o realizada no Campo de Respons�vel pelo Termo e   ���
���          � Contato ( C1_XRESPON, C1_XCONTAT ), na rotina de Solicita- ���
���          � ��o de Compras.          								  ���
�������������������������������������������������������������������������͹��
���Uso       � SIGACOM                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

*-----------------------------*
User Function NDJV001( _nTipo )
*-----------------------------*
Local _aArea        := GetArea()
Local _cAlias       := GetNextAlias()                                 
Local _cContato     := If( _nTipo == 1, M->C1_XRESPON, M->C1_XCONTAT )
Local _cCodEntidade := GdFieldGet( "C1_XCLIINS" ) + GdFieldGet( "C1_XLOJAIN" )
Local _cQuery       := ""       

_cQuery := "  SELECT AC8_CODCON, AC8_XENDER "
_cQuery += "    FROM " + RetSQLName( "AC8" ) + " (NOLOCK) "
_cQuery += "   WHERE D_E_L_E_T_ = ' ' "
_cQuery += "     AND AC8_FILIAL = '" + XFilial( "AC8" ) + "' "
_cQuery += "     AND AC8_CODCON = '" + _cContato        + "' "
_cQuery += "     AND AC8_FILENT = '" + XFilial( "SA1" ) + "' "
_cQuery += "     AND AC8_CODENT = '" + _cCodEntidade    + "' "
_cQuery += "     AND AC8_ENTIDA = 'SA1' "
TcQuery _cQuery Alias ( _cAlias ) New 
If !( _cAlias )->( Eof() )

	If _nTipo == 1 //Respons�vel
		GdFieldPut( "C1_XCONTAT", ( _cAlias )->AC8_CODCON )
		GdFieldPut( "C1_XENDER" , ( _cAlias )->AC8_XENDER )
	Else   
		GdFieldPut( "C1_XENDER" , ( _cAlias )->AC8_XENDER )
	End If 

Else

	If _nTipo == 1 //Respons�vel
		Aviso( "Anten��o", "O Respons�vel pelo Termo informado n�o foi encontrado.", { "Voltar" } )
	Else
		Aviso( "Anten��o", "O Contato informado n�o foi encontrado.", { "Voltar" } )
	End If

	RestArea( _aArea )
	Return .F.

End If                        

DbSelectArea( _cAlias )
( _cAlias )->( DbCloseArea() )

RestArea( _aArea )

Return .T.

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