#INCLUDE "RWMAKE.CH"
/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � MT103NTZ � Autor � Jose Carlos Noronha� Data �  17/12/10   ���
�������������������������������������������������������������������������͹��
���Descricao � Ponto de entrada para tratar a natureza de acordo com a TES���
��             e o produto, na gera��o do documento de entrada.           ���
��                                                                        ���
�������������������������������������������������������������������������͹��
���Uso       �                                                            ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������/*/
User Function MT103NTZ()

	Local cNatureza	:= ParamIxb[1]
	Local cMT103NTZ	:= cNatureza

	If Posicione("SF4",1,xFilial("SF4")+SD1->D1_XTES,"F4_ATUATF") == "S"
		cMT103NTZ := Posicione("SB1",1,xFilial("SB1")+SD1->D1_COD,"B1_XNATURE")
 	Else
		cMT103NTZ := Posicione("SB1",1,xFilial("SB1")+SD1->D1_COD,"B1_XNATU02")
	Endif

Return(cMT103NTZ)