#INCLUDE "NDJ.CH"
/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � GCNFISCAL � Autor � Jose Carlos Noronha� Data �  30/11/10  ���
�������������������������������������������������������������������������͹��
���Descricao � tratamento para incluir zeros a esquerda na hora do        ���
��             lancamento, validacao do campo F1_DOC.                     ���
�������������������������������������������������������������������������͹��
���Uso       �                                                            ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
User Function GCNFISCAL

Local lRet := .T.
Local nx

If ALLTRIM(VALTYPE(cNFiscal)) <> "U"
	For nx:= 1 To 6
		If !Substr(cNFiscal,nx,1) $ "0123456789 "
			ALLTRIM(CNFISCAL) := ""
			Alert("O Numero da NF Deve Conter Apenas Numeros.")
			lRet := .F.
			RETURN lRet
			Exit
		Endif
	Next nx
Endif

IF lRet
	XNUM     := CNFISCAL
	CNUM     := IF(ALLTRIM(XNUM)<>"",STRZERO(VAL(XNUM),9),"")
	CNFISCAL := ALLTRIM(CNUM)
	lRet     := IF(ALLTRIM(CNUM)="",.F.,.T.)
ENDIF

RETURN lRet

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