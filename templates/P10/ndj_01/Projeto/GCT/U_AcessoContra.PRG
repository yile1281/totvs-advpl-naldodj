#INCLUDE "RWMAKE.CH"
#INCLUDE "TOPCONN.CH"
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �ACESSOCONTRA�Autor  �Leonardo Santos   � Data �  22/04/10   ���
�������������������������������������������������������������������������͹��
���Desc.     � Programa que libera acesso completo a todos os contratos.  ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function AcessoContra(cUser)

Local cQuery    := ""
Local cFimLn    := CHR(13)+CHR(10)
Local nCont     := 0
Local cNomeUsr  := ""

If Empty(cUser); cUser := __cUserID; EndIf
cNomeUsr := AllTrim(UsrFullName(cUser))

cAliasCN9 := GetNextAlias()

cQuery := " SELECT DISTINCT CN9_NUMERO FROM "+RetSQLName("CN9") + cFimLn
cQuery += " WHERE D_E_L_E_T_ = '' "                             + cFimLn
cQuery += " ORDER BY CN9_NUMERO "                               + cFimLn

dbUseArea( .T., "TOPCONN", TcGenQry( ,, cQuery ), cAliasCN9, .F., .T. ) 

While !(cAliasCN9)->( Eof() )
	cContra         := 	(cAliasCN9)->CN9_NUMERO 
	aArea := GetArea()
	dbSelectArea("CNN")
	dbSetOrder(1)
	If !(dbSeek(xFilial("CN9")+cUser+cContra+"001"))
		dbSelectArea("CNN")
		Reclock("CNN",.T.)
		
		CNN->CNN_FILIAL := xFilial("CN9")
		CNN->CNN_CONTRA := cContra
		CNN->CNN_USRCOD := cUser
		CNN->CNN_TRACOD := "001"
		
		CN9->( MsUnlock() )
		nCont++
	EndIf
	RestArea(aArea)
	(cAliasCN9)->( dbSkip() )
EndDo
If ( nCont>0 )
	Alert("Foram adicionadas permiss�es em "+AllTrim(Str(nCont))+" contratos para o usu�rio: " +cNomeUsr+" ")
Else
	Alert("N�o foram adicionadas novas permiss�es")
EndIf

Return