#INCLUDE "NDJ.CH"
/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �IUSUARIO Autor � LAPORTE               � Data �  22/10/10   ���
�������������������������������������������������������������������������͹��
���Descricao � PONTO DE ENTRADA PARA GRAVA��O DE REGISTROS NA TABELA CTT  ���
���          � (CENTRO DE CUSTOS) AP�S A GRAVA��O NA ENTRADA DE CADA ITEM ���
���          � NO PROGRAMA PMSA110                                        ���
�������������������������������������������������������������������������͹��
���Uso       � AFB                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/                 


User Function PM110AFB()


//���������������������������������������������������������������������Ŀ
//� ESTA FUN��O TEM O OBJETIVO DE INSERIR UM NOVO CENTRO DE CUSTOS      �
//�                                                                     �
//����������������������������������������������������������������������� 
CTT->(DBSETORDER(1))
WCODCC = SPACE(13)
WCODCC = AFB->AFB_XCODOR+AF8->AF8_PROJET 
IF CTT->(!DBSEEK(XFILIAL("CTT")+WCODCC))
   RecLock("CTT",.T.)
   CTT->CTT_FILIAL := XFILIAL("CTT")
   CTT->CTT_CLASSE := "2"   
   CTT->CTT_CUSTO  := WCODCC
   CTT->CTT_DESC01 := AF8->AF8_DESCRI
   CTT->CTT_BLOQ   := "1"   
   CTT->CTT_DTEXIS := DATE()
   CTT->CTT_CCLP   := WCODCC
   CTT->CTT_ITOBRG := "2" 
   CTT->CTT_CLOBRG := "2"
   CTT->CTT_ACITEM := "1"              
   CTT->CTT_ACCLVL := "1" 
   MSUNLOCK()        
//   EmailFin()
endif   

CTD->(DBSETORDER(1))
WCODCTD = SPACE(3)
WCODCTD = AF8->AF8_XCODMA
IF CTD->(!DBSEEK(XFILIAL("CTD")+WCODCTD))
   SZA->(DBSETORDER(1))
   DBSEEK(XFILIAL("SZA")+AF8->AF8_XCODMA)
   RecLock("CTD",.T.)
   CTD->CTD_FILIAL := XFILIAL("CTD")
   CTD->CTD_CLASSE := "2"   
   CTD->CTD_ITEM  := WCODCTD
   CTD->CTD_DESC01 := SZA->ZA_XDESMAC
   CTD->CTD_BLOQ   := "2"   
   CTD->CTD_DTEXIS := DATE()
   CTD->CTD_ITLP   := WCODCTD
//   CTD->CTD_ITOBRG := "2" 
   CTD->CTD_CLOBRG := "2"
//   CTD->CTD_ACITEM := "1"              
   CTD->CTD_ACCLVL := "1" 
   CTD->CTD_BOOK   := "001/002/003/004/005" 
   CTD->CTD_ITSUP := "0200"    
   MSUNLOCK()  
endif             

CTH->(DBSETORDER(1))
WCODCTH = SPACE(3)
WCODCTH = AF8->AF8_XCODIN
IF CTH->(!DBSEEK(XFILIAL("CTH")+WCODCTH))
   SZB->(DBSETORDER(1))
   DBSEEK(XFILIAL("SZB")+AF8->AF8_XCODIN)
   RecLock("CTH",.T.)
   CTH->CTH_FILIAL := XFILIAL("CTH")
   CTH->CTH_CLASSE := "2"   
   CTH->CTH_CLVL := WCODCTH
   CTH->CTH_DESC01 := SZB->ZB_XDESIND
   CTH->CTH_BLOQ   := "2"   
   CTH->CTH_DTEXIS := DATE()
   CTH->CTH_CLVLLP := WCODCTH       
   CTH->CTH_BOOK   := "001/002/003/004/005" 
   MSUNLOCK()  
endif  


Return

//************************************************************************************************
Static Function EmailFin()
//************************************************************************************************

Local cBody         := ""
Local cCC           := ""
Local cMailServer	:= Alltrim(GETMV("MV_RELSERV"))
Local cMailConta	:= Alltrim(GETMV("MV_RELACNT"))
Local cMailSenha	:= Alltrim(GETMV("MV_RELPSW"))

Local lEmail



cDest1   := StaticCall( NDJLIB014 , UsrRetMail , AF8->AF8_XCODGE )
cCc      := GetNewPar("NDJ_EFIN","ndjadvpl@gmail.com")

cSubject := "LIBERACAO DE CENTRO DE CUSTOS - PROJETO "+AF8->AF8_PROJET+"-"+AF8->AF8_DESCRI

cBody :='<html>'
cBody +=	'<head>'
cBody +=		'<meta http-equiv="Content-Type" content="text/html charset=ISO-8859-1">'
cBody +=	'</head>'
cBody +='<body>'
cBody +=	'<div marginheight="0" marginwidth="0">'
cBody +=	'<table border="0" cellpadding="0" cellspacing="0">'
cBody +=		'<tbody>'
cBody +=            '<tr bgcolor="#eeeeee"><td> <img src="' + GetNewPar("NDJ_ELGURL " , "" ) + '" border="0"></td></tr>'
cBody +=			'<tr bgcolor="#bebebe"><td height="20"></td></tr>'
cBody +=			'<tr><td><font face="arial" size="2"><b>LIBERA��O DE CENTRO DE CUSTOS</b><p></font></td></tr>'
cBody +=			'<tr><td><p><font face="arial" size="2">Ger�ncia Financeira,</p>'
cBody +=					'<p>Foi incluido um novo Projeto e para dar continuidade ao '
cBody +=					'processo ser� necess�rio que seja liberado o Centro de Custo conforme informa��o abaixo.</p></font>' 
cBody += '<br><font face="arial" size="2" color="#CC0000"><strong>OBS.: � importante que a libera��o seja realizada, para que o Projeto seja executado</strong></font><br>'
cBody +=			'<p><font face="arial" size="2">Seguem as informa��e do Centro de Custo:</font></p></td></tr>'
cBody +=	'<tr><td><p></p></td></tr></table>'
cBody +=	'<table border="0" cellpadding="0" cellspacing="0">'		
cBody +=		'<tr><td><font face="arial" size="2">Projeto:</td><td>'+AF8->AF8_PROJET+'</font></td></tr>'
cBody +=		'<tr><td><font face="arial" size="2">Descri��o:</td><td>'+AF8->AF8_DESCRI+'</font></tr></td>'
cBody +=		'<tr><td><font face="arial" size="2">Origem do Recurso:</td><td>'+AFB->AFB_XCODOR+'</font></td></tr>'
cBody +=		'<tr><td><font face="arial" size="2">Centro de Custo:</td><td>'+AFB->AFB_XCODOR+AF8->AF8_PROJET+'</font></td></tr>'
cBody +=		'<tr><td><font face="arial" size="2">Gerente:</td><td>'+AF8->AF8_XGER+'</font></td></tr>'
cBody +=	'</table>'  

Connect SMTP Server cMailServer Account cMailConta Password cMailSenha RESULT lEmail
		
If !lEmail
	Alert("Erro ao conectar no servidor SMTP")
Endif
		
If !lEmail
	Alert("Erro ao autenticar no servidor SMTP")
Endif
		

SEND MAIL FROM cMailConta TO cDest1	;
CC cCc ;
SUBJECT cSubject ;
BODY cBody
Get Mail Error cErro
		
DISCONNECT SMTP SERVER
		
RETURN

Static Function __Dummy( lRecursa )
	Local oException
	TRYEXCEPTION
        lRecursa := .F.
		IF !( lRecursa )
			BREAK
		EndIF
		EmailFin()
		lRecursa	:= __Dummy( .F. )
		__cCRLF		:= NIL
	CATCHEXCEPTION USING oException
	ENDEXCEPTION
Return( lRecursa )