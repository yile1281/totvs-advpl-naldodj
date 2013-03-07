#INCLUDE "PROTHEUS.CH"
#INCLUDE "APWEBSRV.CH"

/* ===============================================================================
WSDL Location    http://200.143.193.18/ws/U_WSNDJATESTONF.apw?WSDL
Gerado em        07/11/11 12:44:42
Observa��es      C�digo-Fonte gerado por ADVPL WSDL Client 1.101007
                 Altera��es neste arquivo podem causar funcionamento incorreto
                 e ser�o perdidas caso o c�digo-fonte seja gerado novamente.
=============================================================================== */

User Function _YBDTEMW ; Return  // "dummy" function - Internal Use 

/* -------------------------------------------------------------------------------
WSDL Service WSU_WSNDJATESTONF
------------------------------------------------------------------------------- */

WSCLIENT WSU_WSNDJATESTONF

	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD RESET
	WSMETHOD CLONE
	WSMETHOD EXISTNFE
	WSMETHOD GETNFE
	WSMETHOD GETNFEMEMOFIELDS
	WSMETHOD GETNFEOBSITEM
	WSMETHOD ISAUTHENTICATED
	WSMETHOD SENDNFE
	WSMETHOD VALIDUSER

	WSDATA   _URL                      AS String
	WSDATA   _HEADOUT                  AS Array of String
	WSDATA   cUSERID                   AS string
	WSDATA   cMAILID                   AS base64Binary
	WSDATA   lEXISTNFERESULT           AS boolean
    WSDATA   oWSGETNFERESULT           AS U_WSNDJATESTONF_TGETNFES
    WSDATA   oWSGETNFEMEMOFIELDSRESULT AS U_WSNDJATESTONF_TMEMOFIELD
	WSDATA   cRECNO                    AS string
	WSDATA   cNFEMEMOFIELD             AS string
	WSDATA   cGETNFEOBSITEMRESULT      AS string
	WSDATA   cUSERWS                   AS string
	WSDATA   lISAUTHENTICATEDRESULT    AS boolean
    WSDATA   oWSNFESEND                AS U_WSNDJATESTONF_TSENDNFES
	WSDATA   lSENDNFERESULT            AS boolean
	WSDATA   cVALIDUSERRESULT          AS string

	// Estruturas mantidas por compatibilidade - N�O USAR
    WSDATA   oWSTSENDNFES              AS U_WSNDJATESTONF_TSENDNFES

ENDWSCLIENT

WSMETHOD NEW WSCLIENT WSU_WSNDJATESTONF
::Init()
If !FindFunction("XMLCHILDEX")
	UserException("O C�digo-Fonte Client atual requer os execut�veis do Protheus Build [7.00.101202A-20110330] ou superior. Atualize o Protheus ou gere o C�digo-Fonte novamente utilizando o Build atual.")
EndIf
Return Self

WSMETHOD INIT WSCLIENT WSU_WSNDJATESTONF
    ::oWSGETNFERESULT    := U_WSNDJATESTONF_TGETNFES():New()
    ::oWSGETNFEMEMOFIELDSRESULT := U_WSNDJATESTONF_TMEMOFIELD():New()
    ::oWSNFESEND         := U_WSNDJATESTONF_TSENDNFES():New()

	// Estruturas mantidas por compatibilidade - N�O USAR
	::oWSTSENDNFES       := ::oWSNFESEND
Return

WSMETHOD RESET WSCLIENT WSU_WSNDJATESTONF
	::cUSERID            := NIL 
	::cMAILID            := NIL 
	::lEXISTNFERESULT    := NIL 
	::oWSGETNFERESULT    := NIL 
	::oWSGETNFEMEMOFIELDSRESULT := NIL 
	::cRECNO             := NIL 
	::cNFEMEMOFIELD      := NIL 
	::cGETNFEOBSITEMRESULT := NIL 
	::cUSERWS            := NIL 
	::lISAUTHENTICATEDRESULT := NIL 
	::oWSNFESEND         := NIL 
	::lSENDNFERESULT     := NIL 
	::cVALIDUSERRESULT   := NIL 

	// Estruturas mantidas por compatibilidade - N�O USAR
	::oWSTSENDNFES       := NIL
	::Init()
Return

WSMETHOD CLONE WSCLIENT WSU_WSNDJATESTONF
Local oClone := WSU_WSNDJATESTONF():New()
	oClone:_URL          := ::_URL 
	oClone:cUSERID       := ::cUSERID
	oClone:cMAILID       := ::cMAILID
	oClone:lEXISTNFERESULT := ::lEXISTNFERESULT
	oClone:oWSGETNFERESULT :=  IIF(::oWSGETNFERESULT = NIL , NIL ,::oWSGETNFERESULT:Clone() )
	oClone:oWSGETNFEMEMOFIELDSRESULT :=  IIF(::oWSGETNFEMEMOFIELDSRESULT = NIL , NIL ,::oWSGETNFEMEMOFIELDSRESULT:Clone() )
	oClone:cRECNO        := ::cRECNO
	oClone:cNFEMEMOFIELD := ::cNFEMEMOFIELD
	oClone:cGETNFEOBSITEMRESULT := ::cGETNFEOBSITEMRESULT
	oClone:cUSERWS       := ::cUSERWS
	oClone:lISAUTHENTICATEDRESULT := ::lISAUTHENTICATEDRESULT
	oClone:oWSNFESEND    :=  IIF(::oWSNFESEND = NIL , NIL ,::oWSNFESEND:Clone() )
	oClone:lSENDNFERESULT := ::lSENDNFERESULT
	oClone:cVALIDUSERRESULT := ::cVALIDUSERRESULT

	// Estruturas mantidas por compatibilidade - N�O USAR
	oClone:oWSTSENDNFES  := oClone:oWSNFESEND
Return oClone

// WSDL Method EXISTNFE of Service WSU_WSNDJATESTONF

WSMETHOD EXISTNFE WSSEND cUSERID,cMAILID WSRECEIVE lEXISTNFERESULT WSCLIENT WSU_WSNDJATESTONF
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<EXISTNFE xmlns="http://200.143.193.18/ws/u_wsNDJatestonf.apw">'
cSoap += WSSoapValue("USERID", ::cUSERID, cUSERID , "string", .T. , .F., 0 , NIL, .T.) 
cSoap += WSSoapValue("MAILID", ::cMAILID, cMAILID , "base64Binary", .T. , .F., 0 , NIL, .T.) 
cSoap += "</EXISTNFE>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
    "http://200.143.193.18/ws/u_wsNDJatestonf.apw/EXISTNFE",; 
    "DOCUMENT","http://200.143.193.18/ws/u_wsNDJatestonf.apw",,"1.031217",; 
    "http://200.143.193.18/ws/U_WSNDJATESTONF.apw")

::Init()
::lEXISTNFERESULT    :=  WSAdvValue( oXmlRet,"_EXISTNFERESPONSE:_EXISTNFERESULT:TEXT","boolean",NIL,NIL,NIL,NIL,NIL,NIL) 

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method GETNFE of Service WSU_WSNDJATESTONF

WSMETHOD GETNFE WSSEND cUSERID,cMAILID WSRECEIVE oWSGETNFERESULT WSCLIENT WSU_WSNDJATESTONF
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<GETNFE xmlns="http://200.143.193.18/ws/u_wsNDJatestonf.apw">'
cSoap += WSSoapValue("USERID", ::cUSERID, cUSERID , "string", .T. , .F., 0 , NIL, .T.) 
cSoap += WSSoapValue("MAILID", ::cMAILID, cMAILID , "base64Binary", .T. , .F., 0 , NIL, .T.) 
cSoap += "</GETNFE>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
    "http://200.143.193.18/ws/u_wsNDJatestonf.apw/GETNFE",; 
    "DOCUMENT","http://200.143.193.18/ws/u_wsNDJatestonf.apw",,"1.031217",; 
    "http://200.143.193.18/ws/U_WSNDJATESTONF.apw")

::Init()
::oWSGETNFERESULT:SoapRecv( WSAdvValue( oXmlRet,"_GETNFERESPONSE:_GETNFERESULT","TGETNFES",NIL,NIL,NIL,NIL,NIL,NIL) )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method GETNFEMEMOFIELDS of Service WSU_WSNDJATESTONF

WSMETHOD GETNFEMEMOFIELDS WSSEND cUSERID,cMAILID WSRECEIVE oWSGETNFEMEMOFIELDSRESULT WSCLIENT WSU_WSNDJATESTONF
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<GETNFEMEMOFIELDS xmlns="http://200.143.193.18/ws/u_wsNDJatestonf.apw">'
cSoap += WSSoapValue("USERID", ::cUSERID, cUSERID , "string", .T. , .F., 0 , NIL, .T.) 
cSoap += WSSoapValue("MAILID", ::cMAILID, cMAILID , "base64Binary", .T. , .F., 0 , NIL, .T.) 
cSoap += "</GETNFEMEMOFIELDS>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
    "http://200.143.193.18/ws/u_wsNDJatestonf.apw/GETNFEMEMOFIELDS",; 
    "DOCUMENT","http://200.143.193.18/ws/u_wsNDJatestonf.apw",,"1.031217",; 
    "http://200.143.193.18/ws/U_WSNDJATESTONF.apw")

::Init()
::oWSGETNFEMEMOFIELDSRESULT:SoapRecv( WSAdvValue( oXmlRet,"_GETNFEMEMOFIELDSRESPONSE:_GETNFEMEMOFIELDSRESULT","TMEMOFIELD",NIL,NIL,NIL,NIL,NIL,NIL) )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method GETNFEOBSITEM of Service WSU_WSNDJATESTONF

WSMETHOD GETNFEOBSITEM WSSEND cUSERID,cMAILID,cRECNO,cNFEMEMOFIELD WSRECEIVE cGETNFEOBSITEMRESULT WSCLIENT WSU_WSNDJATESTONF
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<GETNFEOBSITEM xmlns="http://200.143.193.18/ws/u_wsNDJatestonf.apw">'
cSoap += WSSoapValue("USERID", ::cUSERID, cUSERID , "string", .T. , .F., 0 , NIL, .T.) 
cSoap += WSSoapValue("MAILID", ::cMAILID, cMAILID , "base64Binary", .T. , .F., 0 , NIL, .T.) 
cSoap += WSSoapValue("RECNO", ::cRECNO, cRECNO , "string", .T. , .F., 0 , NIL, .T.) 
cSoap += WSSoapValue("NFEMEMOFIELD", ::cNFEMEMOFIELD, cNFEMEMOFIELD , "string", .T. , .F., 0 , NIL, .T.) 
cSoap += "</GETNFEOBSITEM>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
    "http://200.143.193.18/ws/u_wsNDJatestonf.apw/GETNFEOBSITEM",; 
    "DOCUMENT","http://200.143.193.18/ws/u_wsNDJatestonf.apw",,"1.031217",; 
    "http://200.143.193.18/ws/U_WSNDJATESTONF.apw")

::Init()
::cGETNFEOBSITEMRESULT :=  WSAdvValue( oXmlRet,"_GETNFEOBSITEMRESPONSE:_GETNFEOBSITEMRESULT:TEXT","string",NIL,NIL,NIL,NIL,NIL,NIL) 

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method ISAUTHENTICATED of Service WSU_WSNDJATESTONF

WSMETHOD ISAUTHENTICATED WSSEND cUSERWS,cMAILID WSRECEIVE lISAUTHENTICATEDRESULT WSCLIENT WSU_WSNDJATESTONF
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<ISAUTHENTICATED xmlns="http://200.143.193.18/ws/u_wsNDJatestonf.apw">'
cSoap += WSSoapValue("USERWS", ::cUSERWS, cUSERWS , "string", .T. , .F., 0 , NIL, .T.) 
cSoap += WSSoapValue("MAILID", ::cMAILID, cMAILID , "base64Binary", .T. , .F., 0 , NIL, .T.) 
cSoap += "</ISAUTHENTICATED>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
    "http://200.143.193.18/ws/u_wsNDJatestonf.apw/ISAUTHENTICATED",; 
    "DOCUMENT","http://200.143.193.18/ws/u_wsNDJatestonf.apw",,"1.031217",; 
    "http://200.143.193.18/ws/U_WSNDJATESTONF.apw")

::Init()
::lISAUTHENTICATEDRESULT :=  WSAdvValue( oXmlRet,"_ISAUTHENTICATEDRESPONSE:_ISAUTHENTICATEDRESULT:TEXT","boolean",NIL,NIL,NIL,NIL,NIL,NIL) 

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method SENDNFE of Service WSU_WSNDJATESTONF

WSMETHOD SENDNFE WSSEND cUSERID,cMAILID,oWSNFESEND WSRECEIVE lSENDNFERESULT WSCLIENT WSU_WSNDJATESTONF
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<SENDNFE xmlns="http://200.143.193.18/ws/u_wsNDJatestonf.apw">'
cSoap += WSSoapValue("USERID", ::cUSERID, cUSERID , "string", .T. , .F., 0 , NIL, .T.) 
cSoap += WSSoapValue("MAILID", ::cMAILID, cMAILID , "base64Binary", .T. , .F., 0 , NIL, .T.) 
cSoap += WSSoapValue("NFESEND", ::oWSNFESEND, oWSNFESEND , "TSENDNFES", .T. , .F., 0 , NIL, .T.) 
cSoap += "</SENDNFE>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
    "http://200.143.193.18/ws/u_wsNDJatestonf.apw/SENDNFE",; 
    "DOCUMENT","http://200.143.193.18/ws/u_wsNDJatestonf.apw",,"1.031217",; 
    "http://200.143.193.18/ws/U_WSNDJATESTONF.apw")

::Init()
::lSENDNFERESULT     :=  WSAdvValue( oXmlRet,"_SENDNFERESPONSE:_SENDNFERESULT:TEXT","boolean",NIL,NIL,NIL,NIL,NIL,NIL) 

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method VALIDUSER of Service WSU_WSNDJATESTONF

WSMETHOD VALIDUSER WSSEND cUSERWS,cMAILID WSRECEIVE cVALIDUSERRESULT WSCLIENT WSU_WSNDJATESTONF
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<VALIDUSER xmlns="http://200.143.193.18/ws/u_wsNDJatestonf.apw">'
cSoap += WSSoapValue("USERWS", ::cUSERWS, cUSERWS , "string", .T. , .F., 0 , NIL, .T.) 
cSoap += WSSoapValue("MAILID", ::cMAILID, cMAILID , "base64Binary", .T. , .F., 0 , NIL, .T.) 
cSoap += "</VALIDUSER>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
    "http://200.143.193.18/ws/u_wsNDJatestonf.apw/VALIDUSER",; 
    "DOCUMENT","http://200.143.193.18/ws/u_wsNDJatestonf.apw",,"1.031217",; 
    "http://200.143.193.18/ws/U_WSNDJATESTONF.apw")

::Init()
::cVALIDUSERRESULT   :=  WSAdvValue( oXmlRet,"_VALIDUSERRESPONSE:_VALIDUSERRESULT:TEXT","string",NIL,NIL,NIL,NIL,NIL,NIL) 

END WSMETHOD

oXmlRet := NIL
Return .T.


// WSDL Data Structure TGETNFES

WSSTRUCT U_WSNDJATESTONF_TGETNFES
    WSDATA   oWSNFE                    AS U_WSNDJATESTONF_ARRAYOFTGETNFE
	WSDATA   cRECNO                    AS string
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT U_WSNDJATESTONF_TGETNFES
	::Init()
Return Self

WSMETHOD INIT WSCLIENT U_WSNDJATESTONF_TGETNFES
Return

WSMETHOD CLONE WSCLIENT U_WSNDJATESTONF_TGETNFES
    Local oClone := U_WSNDJATESTONF_TGETNFES():NEW()
	oClone:oWSNFE               := IIF(::oWSNFE = NIL , NIL , ::oWSNFE:Clone() )
	oClone:cRECNO               := ::cRECNO
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT U_WSNDJATESTONF_TGETNFES
	Local oNode1
	::Init()
	If oResponse = NIL ; Return ; Endif 
	oNode1 :=  WSAdvValue( oResponse,"_NFE","ARRAYOFTGETNFE",NIL,"Property oWSNFE as s0:ARRAYOFTGETNFE on SOAP Response not found.",NIL,"O",NIL,NIL) 
	If oNode1 != NIL
        ::oWSNFE := U_WSNDJATESTONF_ARRAYOFTGETNFE():New()
		::oWSNFE:SoapRecv(oNode1)
	EndIf
	::cRECNO             :=  WSAdvValue( oResponse,"_RECNO","string",NIL,"Property cRECNO as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
Return

// WSDL Data Structure TMEMOFIELD

WSSTRUCT U_WSNDJATESTONF_TMEMOFIELD
    WSDATA   oWSMEMOFIELD              AS U_WSNDJATESTONF_ARRAYOFSTRING
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT U_WSNDJATESTONF_TMEMOFIELD
	::Init()
Return Self

WSMETHOD INIT WSCLIENT U_WSNDJATESTONF_TMEMOFIELD
Return

WSMETHOD CLONE WSCLIENT U_WSNDJATESTONF_TMEMOFIELD
    Local oClone := U_WSNDJATESTONF_TMEMOFIELD():NEW()
	oClone:oWSMEMOFIELD         := IIF(::oWSMEMOFIELD = NIL , NIL , ::oWSMEMOFIELD:Clone() )
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT U_WSNDJATESTONF_TMEMOFIELD
	Local oNode1
	::Init()
	If oResponse = NIL ; Return ; Endif 
	oNode1 :=  WSAdvValue( oResponse,"_MEMOFIELD","ARRAYOFSTRING",NIL,"Property oWSMEMOFIELD as s0:ARRAYOFSTRING on SOAP Response not found.",NIL,"O",NIL,NIL) 
	If oNode1 != NIL
        ::oWSMEMOFIELD := U_WSNDJATESTONF_ARRAYOFSTRING():New()
		::oWSMEMOFIELD:SoapRecv(oNode1)
	EndIf
Return

// WSDL Data Structure TSENDNFES

WSSTRUCT U_WSNDJATESTONF_TSENDNFES
    WSDATA   oWSNFE                    AS U_WSNDJATESTONF_TSENDNFE
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT U_WSNDJATESTONF_TSENDNFES
	::Init()
Return Self

WSMETHOD INIT WSCLIENT U_WSNDJATESTONF_TSENDNFES
Return

WSMETHOD CLONE WSCLIENT U_WSNDJATESTONF_TSENDNFES
    Local oClone := U_WSNDJATESTONF_TSENDNFES():NEW()
	oClone:oWSNFE               := IIF(::oWSNFE = NIL , NIL , ::oWSNFE:Clone() )
Return oClone

WSMETHOD SOAPSEND WSCLIENT U_WSNDJATESTONF_TSENDNFES
	Local cSoap := ""
	cSoap += WSSoapValue("NFE", ::oWSNFE, ::oWSNFE , "TSENDNFE", .T. , .F., 0 , NIL, .T.) 
Return cSoap

// WSDL Data Structure ARRAYOFTGETNFE

WSSTRUCT U_WSNDJATESTONF_ARRAYOFTGETNFE
    WSDATA   oWSTGETNFE                AS U_WSNDJATESTONF_TGETNFE OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT U_WSNDJATESTONF_ARRAYOFTGETNFE
	::Init()
Return Self

WSMETHOD INIT WSCLIENT U_WSNDJATESTONF_ARRAYOFTGETNFE
    ::oWSTGETNFE           := {} // Array Of  U_WSNDJATESTONF_TGETNFE():New()
Return

WSMETHOD CLONE WSCLIENT U_WSNDJATESTONF_ARRAYOFTGETNFE
    Local oClone := U_WSNDJATESTONF_ARRAYOFTGETNFE():NEW()
	oClone:oWSTGETNFE := NIL
	If ::oWSTGETNFE <> NIL 
		oClone:oWSTGETNFE := {}
		aEval( ::oWSTGETNFE , { |x| aadd( oClone:oWSTGETNFE , x:Clone() ) } )
	Endif 
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT U_WSNDJATESTONF_ARRAYOFTGETNFE
	Local nRElem1, oNodes1, nTElem1
	::Init()
	If oResponse = NIL ; Return ; Endif 
	oNodes1 :=  WSAdvValue( oResponse,"_TGETNFE","TGETNFE",{},NIL,.T.,"O",NIL,NIL) 
	nTElem1 := len(oNodes1)
	For nRElem1 := 1 to nTElem1 
		If !WSIsNilNode( oNodes1[nRElem1] )
            aadd(::oWSTGETNFE , U_WSNDJATESTONF_TGETNFE():New() )
			::oWSTGETNFE[len(::oWSTGETNFE)]:SoapRecv(oNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure ARRAYOFSTRING

WSSTRUCT U_WSNDJATESTONF_ARRAYOFSTRING
	WSDATA   cSTRING                   AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT U_WSNDJATESTONF_ARRAYOFSTRING
	::Init()
Return Self

WSMETHOD INIT WSCLIENT U_WSNDJATESTONF_ARRAYOFSTRING
	::cSTRING              := {} // Array Of  ""
Return

WSMETHOD CLONE WSCLIENT U_WSNDJATESTONF_ARRAYOFSTRING
    Local oClone := U_WSNDJATESTONF_ARRAYOFSTRING():NEW()
	oClone:cSTRING              := IIf(::cSTRING <> NIL , aClone(::cSTRING) , NIL )
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT U_WSNDJATESTONF_ARRAYOFSTRING
	Local oNodes1 :=  WSAdvValue( oResponse,"_STRING","string",{},NIL,.T.,"S",NIL,"a") 
	::Init()
	If oResponse = NIL ; Return ; Endif 
	aEval(oNodes1 , { |x| aadd(::cSTRING ,  x:TEXT  ) } )
Return

// WSDL Data Structure TSENDNFE

WSSTRUCT U_WSNDJATESTONF_TSENDNFE
    WSDATA   oWSATESTO                 AS U_WSNDJATESTONF_ARRAYOFTITENSATESTO
	WSDATA   cMOTIVO                   AS string OPTIONAL
	WSDATA   cRECNO                    AS string
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT U_WSNDJATESTONF_TSENDNFE
	::Init()
Return Self

WSMETHOD INIT WSCLIENT U_WSNDJATESTONF_TSENDNFE
Return

WSMETHOD CLONE WSCLIENT U_WSNDJATESTONF_TSENDNFE
    Local oClone := U_WSNDJATESTONF_TSENDNFE():NEW()
	oClone:oWSATESTO            := IIF(::oWSATESTO = NIL , NIL , ::oWSATESTO:Clone() )
	oClone:cMOTIVO              := ::cMOTIVO
	oClone:cRECNO               := ::cRECNO
Return oClone

WSMETHOD SOAPSEND WSCLIENT U_WSNDJATESTONF_TSENDNFE
	Local cSoap := ""
	cSoap += WSSoapValue("ATESTO", ::oWSATESTO, ::oWSATESTO , "ARRAYOFTITENSATESTO", .T. , .F., 0 , NIL, .T.) 
	cSoap += WSSoapValue("MOTIVO", ::cMOTIVO, ::cMOTIVO , "string", .F. , .F., 0 , NIL, .T.) 
	cSoap += WSSoapValue("RECNO", ::cRECNO, ::cRECNO , "string", .T. , .F., 0 , NIL, .T.) 
Return cSoap

// WSDL Data Structure TGETNFE

WSSTRUCT U_WSNDJATESTONF_TGETNFE
    WSDATA   oWSTHEADER                AS U_WSNDJATESTONF_TABLEVIEW
    WSDATA   oWSTITENS                 AS U_WSNDJATESTONF_TABLEVIEW
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT U_WSNDJATESTONF_TGETNFE
	::Init()
Return Self

WSMETHOD INIT WSCLIENT U_WSNDJATESTONF_TGETNFE
Return

WSMETHOD CLONE WSCLIENT U_WSNDJATESTONF_TGETNFE
    Local oClone := U_WSNDJATESTONF_TGETNFE():NEW()
	oClone:oWSTHEADER           := IIF(::oWSTHEADER = NIL , NIL , ::oWSTHEADER:Clone() )
	oClone:oWSTITENS            := IIF(::oWSTITENS = NIL , NIL , ::oWSTITENS:Clone() )
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT U_WSNDJATESTONF_TGETNFE
	Local oNode1
	Local oNode2
	::Init()
	If oResponse = NIL ; Return ; Endif 
	oNode1 :=  WSAdvValue( oResponse,"_THEADER","TABLEVIEW",NIL,"Property oWSTHEADER as s0:TABLEVIEW on SOAP Response not found.",NIL,"O",NIL,NIL) 
	If oNode1 != NIL
        ::oWSTHEADER := U_WSNDJATESTONF_TABLEVIEW():New()
		::oWSTHEADER:SoapRecv(oNode1)
	EndIf
	oNode2 :=  WSAdvValue( oResponse,"_TITENS","TABLEVIEW",NIL,"Property oWSTITENS as s0:TABLEVIEW on SOAP Response not found.",NIL,"O",NIL,NIL) 
	If oNode2 != NIL
        ::oWSTITENS := U_WSNDJATESTONF_TABLEVIEW():New()
		::oWSTITENS:SoapRecv(oNode2)
	EndIf
Return

// WSDL Data Structure ARRAYOFTITENSATESTO

WSSTRUCT U_WSNDJATESTONF_ARRAYOFTITENSATESTO
    WSDATA   oWSTITENSATESTO           AS U_WSNDJATESTONF_TITENSATESTO OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT U_WSNDJATESTONF_ARRAYOFTITENSATESTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT U_WSNDJATESTONF_ARRAYOFTITENSATESTO
    ::oWSTITENSATESTO      := {} // Array Of  U_WSNDJATESTONF_TITENSATESTO():New()
Return

WSMETHOD CLONE WSCLIENT U_WSNDJATESTONF_ARRAYOFTITENSATESTO
    Local oClone := U_WSNDJATESTONF_ARRAYOFTITENSATESTO():NEW()
	oClone:oWSTITENSATESTO := NIL
	If ::oWSTITENSATESTO <> NIL 
		oClone:oWSTITENSATESTO := {}
		aEval( ::oWSTITENSATESTO , { |x| aadd( oClone:oWSTITENSATESTO , x:Clone() ) } )
	Endif 
Return oClone

WSMETHOD SOAPSEND WSCLIENT U_WSNDJATESTONF_ARRAYOFTITENSATESTO
	Local cSoap := ""
	aEval( ::oWSTITENSATESTO , {|x| cSoap := cSoap  +  WSSoapValue("TITENSATESTO", x , x , "TITENSATESTO", .F. , .F., 0 , NIL, .T.)  } ) 
Return cSoap

// WSDL Data Structure TABLEVIEW

WSSTRUCT U_WSNDJATESTONF_TABLEVIEW
    WSDATA   oWSTABLEDATA              AS U_WSNDJATESTONF_ARRAYOFFIELDVIEW
    WSDATA   oWSTABLESTRUCT            AS U_WSNDJATESTONF_ARRAYOFFIELDSTRUCT
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT U_WSNDJATESTONF_TABLEVIEW
	::Init()
Return Self

WSMETHOD INIT WSCLIENT U_WSNDJATESTONF_TABLEVIEW
Return

WSMETHOD CLONE WSCLIENT U_WSNDJATESTONF_TABLEVIEW
    Local oClone := U_WSNDJATESTONF_TABLEVIEW():NEW()
	oClone:oWSTABLEDATA         := IIF(::oWSTABLEDATA = NIL , NIL , ::oWSTABLEDATA:Clone() )
	oClone:oWSTABLESTRUCT       := IIF(::oWSTABLESTRUCT = NIL , NIL , ::oWSTABLESTRUCT:Clone() )
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT U_WSNDJATESTONF_TABLEVIEW
	Local oNode1
	Local oNode2
	::Init()
	If oResponse = NIL ; Return ; Endif 
	oNode1 :=  WSAdvValue( oResponse,"_TABLEDATA","ARRAYOFFIELDVIEW",NIL,"Property oWSTABLEDATA as s0:ARRAYOFFIELDVIEW on SOAP Response not found.",NIL,"O",NIL,NIL) 
	If oNode1 != NIL
        ::oWSTABLEDATA := U_WSNDJATESTONF_ARRAYOFFIELDVIEW():New()
		::oWSTABLEDATA:SoapRecv(oNode1)
	EndIf
	oNode2 :=  WSAdvValue( oResponse,"_TABLESTRUCT","ARRAYOFFIELDSTRUCT",NIL,"Property oWSTABLESTRUCT as s0:ARRAYOFFIELDSTRUCT on SOAP Response not found.",NIL,"O",NIL,NIL) 
	If oNode2 != NIL
        ::oWSTABLESTRUCT := U_WSNDJATESTONF_ARRAYOFFIELDSTRUCT():New()
		::oWSTABLESTRUCT:SoapRecv(oNode2)
	EndIf
Return

// WSDL Data Structure TITENSATESTO

WSSTRUCT U_WSNDJATESTONF_TITENSATESTO
	WSDATA   cRECNO                    AS string
	WSDATA   cTIPO                     AS string
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT U_WSNDJATESTONF_TITENSATESTO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT U_WSNDJATESTONF_TITENSATESTO
Return

WSMETHOD CLONE WSCLIENT U_WSNDJATESTONF_TITENSATESTO
    Local oClone := U_WSNDJATESTONF_TITENSATESTO():NEW()
	oClone:cRECNO               := ::cRECNO
	oClone:cTIPO                := ::cTIPO
Return oClone

WSMETHOD SOAPSEND WSCLIENT U_WSNDJATESTONF_TITENSATESTO
	Local cSoap := ""
	cSoap += WSSoapValue("RECNO", ::cRECNO, ::cRECNO , "string", .T. , .F., 0 , NIL, .T.) 
	cSoap += WSSoapValue("TIPO", ::cTIPO, ::cTIPO , "string", .T. , .F., 0 , NIL, .T.) 
Return cSoap

// WSDL Data Structure ARRAYOFFIELDVIEW

WSSTRUCT U_WSNDJATESTONF_ARRAYOFFIELDVIEW
    WSDATA   oWSFIELDVIEW              AS U_WSNDJATESTONF_FIELDVIEW OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT U_WSNDJATESTONF_ARRAYOFFIELDVIEW
	::Init()
Return Self

WSMETHOD INIT WSCLIENT U_WSNDJATESTONF_ARRAYOFFIELDVIEW
    ::oWSFIELDVIEW         := {} // Array Of  U_WSNDJATESTONF_FIELDVIEW():New()
Return

WSMETHOD CLONE WSCLIENT U_WSNDJATESTONF_ARRAYOFFIELDVIEW
    Local oClone := U_WSNDJATESTONF_ARRAYOFFIELDVIEW():NEW()
	oClone:oWSFIELDVIEW := NIL
	If ::oWSFIELDVIEW <> NIL 
		oClone:oWSFIELDVIEW := {}
		aEval( ::oWSFIELDVIEW , { |x| aadd( oClone:oWSFIELDVIEW , x:Clone() ) } )
	Endif 
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT U_WSNDJATESTONF_ARRAYOFFIELDVIEW
	Local nRElem1, oNodes1, nTElem1
	::Init()
	If oResponse = NIL ; Return ; Endif 
	oNodes1 :=  WSAdvValue( oResponse,"_FIELDVIEW","FIELDVIEW",{},NIL,.T.,"O",NIL,NIL) 
	nTElem1 := len(oNodes1)
	For nRElem1 := 1 to nTElem1 
		If !WSIsNilNode( oNodes1[nRElem1] )
            aadd(::oWSFIELDVIEW , U_WSNDJATESTONF_FIELDVIEW():New() )
			::oWSFIELDVIEW[len(::oWSFIELDVIEW)]:SoapRecv(oNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure ARRAYOFFIELDSTRUCT

WSSTRUCT U_WSNDJATESTONF_ARRAYOFFIELDSTRUCT
    WSDATA   oWSFIELDSTRUCT            AS U_WSNDJATESTONF_FIELDSTRUCT OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT U_WSNDJATESTONF_ARRAYOFFIELDSTRUCT
	::Init()
Return Self

WSMETHOD INIT WSCLIENT U_WSNDJATESTONF_ARRAYOFFIELDSTRUCT
    ::oWSFIELDSTRUCT       := {} // Array Of  U_WSNDJATESTONF_FIELDSTRUCT():New()
Return

WSMETHOD CLONE WSCLIENT U_WSNDJATESTONF_ARRAYOFFIELDSTRUCT
    Local oClone := U_WSNDJATESTONF_ARRAYOFFIELDSTRUCT():NEW()
	oClone:oWSFIELDSTRUCT := NIL
	If ::oWSFIELDSTRUCT <> NIL 
		oClone:oWSFIELDSTRUCT := {}
		aEval( ::oWSFIELDSTRUCT , { |x| aadd( oClone:oWSFIELDSTRUCT , x:Clone() ) } )
	Endif 
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT U_WSNDJATESTONF_ARRAYOFFIELDSTRUCT
	Local nRElem1, oNodes1, nTElem1
	::Init()
	If oResponse = NIL ; Return ; Endif 
	oNodes1 :=  WSAdvValue( oResponse,"_FIELDSTRUCT","FIELDSTRUCT",{},NIL,.T.,"O",NIL,NIL) 
	nTElem1 := len(oNodes1)
	For nRElem1 := 1 to nTElem1 
		If !WSIsNilNode( oNodes1[nRElem1] )
            aadd(::oWSFIELDSTRUCT , U_WSNDJATESTONF_FIELDSTRUCT():New() )
			::oWSFIELDSTRUCT[len(::oWSFIELDSTRUCT)]:SoapRecv(oNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure FIELDVIEW

WSSTRUCT U_WSNDJATESTONF_FIELDVIEW
    WSDATA   oWSFLDTAG                 AS U_WSNDJATESTONF_ARRAYOFSTRING
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT U_WSNDJATESTONF_FIELDVIEW
	::Init()
Return Self

WSMETHOD INIT WSCLIENT U_WSNDJATESTONF_FIELDVIEW
Return

WSMETHOD CLONE WSCLIENT U_WSNDJATESTONF_FIELDVIEW
    Local oClone := U_WSNDJATESTONF_FIELDVIEW():NEW()
	oClone:oWSFLDTAG            := IIF(::oWSFLDTAG = NIL , NIL , ::oWSFLDTAG:Clone() )
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT U_WSNDJATESTONF_FIELDVIEW
	Local oNode1
	::Init()
	If oResponse = NIL ; Return ; Endif 
	oNode1 :=  WSAdvValue( oResponse,"_FLDTAG","ARRAYOFSTRING",NIL,"Property oWSFLDTAG as s0:ARRAYOFSTRING on SOAP Response not found.",NIL,"O",NIL,NIL) 
	If oNode1 != NIL
        ::oWSFLDTAG := U_WSNDJATESTONF_ARRAYOFSTRING():New()
		::oWSFLDTAG:SoapRecv(oNode1)
	EndIf
Return

// WSDL Data Structure FIELDSTRUCT

WSSTRUCT U_WSNDJATESTONF_FIELDSTRUCT
	WSDATA   nFLDDEC                   AS integer
	WSDATA   cFLDNAME                  AS string
	WSDATA   nFLDSIZE                  AS integer
	WSDATA   cFLDTYPE                  AS string
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT U_WSNDJATESTONF_FIELDSTRUCT
	::Init()
Return Self

WSMETHOD INIT WSCLIENT U_WSNDJATESTONF_FIELDSTRUCT
Return

WSMETHOD CLONE WSCLIENT U_WSNDJATESTONF_FIELDSTRUCT
    Local oClone := U_WSNDJATESTONF_FIELDSTRUCT():NEW()
	oClone:nFLDDEC              := ::nFLDDEC
	oClone:cFLDNAME             := ::cFLDNAME
	oClone:nFLDSIZE             := ::nFLDSIZE
	oClone:cFLDTYPE             := ::cFLDTYPE
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT U_WSNDJATESTONF_FIELDSTRUCT
	::Init()
	If oResponse = NIL ; Return ; Endif 
	::nFLDDEC            :=  WSAdvValue( oResponse,"_FLDDEC","integer",NIL,"Property nFLDDEC as s:integer on SOAP Response not found.",NIL,"N",NIL,NIL) 
	::cFLDNAME           :=  WSAdvValue( oResponse,"_FLDNAME","string",NIL,"Property cFLDNAME as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::nFLDSIZE           :=  WSAdvValue( oResponse,"_FLDSIZE","integer",NIL,"Property nFLDSIZE as s:integer on SOAP Response not found.",NIL,"N",NIL,NIL) 
	::cFLDTYPE           :=  WSAdvValue( oResponse,"_FLDTYPE","string",NIL,"Property cFLDTYPE as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
Return
