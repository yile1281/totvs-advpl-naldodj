#ifdef SPANISH
	#define STR0001 "Este programa imprimira el mayor por "
	#define STR0002 "de acuerdo con los parametros sugeridos por el usuario."
	#define STR0004 "A Rayas"
	#define STR0005 "Administracion"
	#define STR0006 "Emision del libro mayor contable por "
	#define STR0007 "MAYOR POR "
	#define STR0008 " ANALITICO EN "
	#define STR0009 "DE"
	#define STR0010 "A "
	#define STR0011 "(PRESUP.)"
	#define STR0012 "(GESTION)"
	#define STR0013 "LOTE/SUB/DOC/LINEA H I S T O R I A L                        C/PARTIDA"
	Static STR0014 := "LOTE/SUB/DOC/LINEA H I S T O R I A L                        C/PARTIDA                      DEBITO          CREDITO       SALDO ACTUAL"
	#define STR0015 "***** ANULADO POR EL OPERADOR *****"
	#define STR0016 "CLASE DE VALOR  - "
	#define STR0017 "T o t a l  "
	#define STR0018 "Creando archivo temporal..."
	#define STR0019 "FECHA"
	#define STR0020 "T o t a l  de la  C u e n t a  ==> "
	#define STR0021 " SINTETICO EN "
	#define STR0022 "A TRANSPORTAR : "
	#define STR0023 "DE TRANSPORTE : "
	#define STR0024 "CUENTA - "
	Static STR0025 := "FECHA                                                                           DEBITO               CREDITO            SALDO ACTUAL"
	Static STR0026 := "DEBITO         CREDITO     SALDO ACTUAL"
	#define STR0027 "SALDO ANTERIOR:"
	#define STR0028 "FCH."
	#define STR0029 "LOTE/SUB/DOC/LINEA"
	#define STR0030 "HISTORIAL"
	#define STR0031 "CPARTIDA"
	#define STR0032 "DEBITO"
	#define STR0033 "CREDITO"
	#define STR0034 "SALDO ACT."
	#define STR0035 "DESCRIPC."
	#define STR0036 "Total"
	#define STR0037 "Cta."
	#define STR0038 "Complemento"
	#define STR0039 "COMPL.HISTORIAL"
#else
	#ifdef ENGLISH
		#define STR0001 "This program will print the Ledger by "
		#define STR0002 " according to the parameters selected by the user. "
		#define STR0004 "Z.Form"
		#define STR0005 "Management"
		#define STR0006 "Print Ledger by "
		#define STR0007 " LEDGER BY "
		#define STR0008 " DETAILED IN "
		#define STR0009 "FROM"
		#define STR0010 "TO"
		#define STR0011 "(BUDGETED)"
		#define STR0012 "(MANAGERIAL)"
		#define STR0013 "LOT/SUB/DOC/LINE HISTORY                                    W/ENTRY  "
		#define STR0014 "LOT/SUB/DOC/LINE   H I S T O R Y                            W/ENTRY                         DEBIT          CREDIT       CURR.BALANCE"
		#define STR0015 "***** CANCELLED BY THE OPERATOR *****"
		#define STR0016 "VALUE CLASS  - "
		#define STR0017 "T o t a l s  ==> "
		#define STR0018 "Creating Temporary File..."
		#define STR0019 "DATE"
		#define STR0020 "A c c o u n t   T o t a l s   ==> "
		#define STR0021 " SUMMARIZED IN "
		#define STR0022 "TO TRANSPORT : "
		#define STR0023 "FROM TRANSPORT : "
		#define STR0024 "ACCOUNT - "
		#define STR0025 "DATE                                                                             DEBIT                CREDIT            CURR.BALANCE"
		#define STR0026 "DEBIT          CREDIT       CURR.BALAC."
		#define STR0027 "PREVIOUS BALANCE:"
		#define STR0028 "DATE"
		#define STR0029 "LOT/SUB/DOC/LINE"
		#define STR0030 "HISTORY"
		#define STR0031 "C/PART"
		#define STR0032 "DEBIT"
		#define STR0033 "CREDIT"
		#define STR0034 "CURRENT BLC"
		#define STR0035 "DESCRIPTION"
		#define STR0036 "Total"
		#define STR0037 "Account"
		#define STR0038 "Complement"
		#define STR0039 "HIST.COMPLEMENT"
	#else
		Static STR0001 := "Este programa ira imprimir o Razao por "
		Static STR0002 := " de acordo com os parametros sugeridos pelo usuario. "
		Static STR0004 := "Zebrado"
		Static STR0005 := "Administracao"
		Static STR0006 := "Emissao do Razao Contabil por "
		Static STR0007 := "RAZAO POR "
		Static STR0008 := " ANALITICO EM "
		Static STR0009 := "DE"
		Static STR0010 := "ATE"
		Static STR0011 := "(ORCADO)"
		Static STR0012 := "(GERENCIAL)"
		Static STR0013 := "LOTE/SUB/DOC/LINHA H I S T O R I C O                        C/PARTIDA"
		Static STR0014 := "LOTE/SUB/DOC/LINHA H I S T O R I C O                        C/PARTIDA                      DEBITO          CREDITO       SALDO ATUAL"
		Static STR0015 := "***** CANCELADO PELO OPERADOR *****"
		Static STR0016 := "CLASSE DE VALOR  - "
		#define STR0017  "T o t a i s  "
		Static STR0018 := "Criando Arquivo Temporario..."
		Static STR0019 := "DATA"
		Static STR0020 := "T o t a i s  d a  C o n t a  ==> "
		Static STR0021 := " SINTETICO EM "
		Static STR0022 := "A TRANSPORTAR : "
		Static STR0023 := "DE TRANSPORTE : "
		Static STR0024 := "CONTA - "
		Static STR0025 := "DATA                                                                            DEBITO               CREDITO            SALDO ATUAL"
		Static STR0026 := "DEBITO         CREDITO      SALDO ATUAL"
		Static STR0027 := "SALDO ANTERIOR:"
		Static STR0028 := "DATA"
		Static STR0029 := "LOTE/SUB/DOC/LINHA"
		Static STR0030 := "HISTORICO"
		Static STR0031 := "C/PARTIDA"
		Static STR0032 := "DEBITO"
		Static STR0033 := "CREDITO"
		Static STR0034 := "SALDO ATUAL"
		Static STR0035 := "DESCRICAO"
		#define STR0036  "Total"
		#define STR0037  "Conta"
		#define STR0038  "Complemento"
		Static STR0039 := "COMPL.HISTORICO"
	#endif
#endif

#ifdef SPANISH
	STATIC uInit := __InitFun()

	Static Function __InitFun()
	uInit := Nil
		If cPaisLoc == "ANG"
			STR0014 := "LOTE/SUB/PLZ/LINEA H I S T O R I A L                         C/PARTIDA                      CARGO           ABONO         SALDO ACTUAL"
			STR0025 := "FECHA                                                                           CARGO                ABONO               SALDO ACTUAL"
			STR0026 := "CARGO           ABONO       SALDO ACTUAL"
		ElseIf cPaisLoc == "MEX"
			STR0014 := "LOTE/SUB/DOC/LINEA H I S T O R I A L                        C/PARTIDA                      CARGO           ABONO         SALDO ACT. "
			STR0025 := "FECHA                                                                           CARGO                ABONO              SALDO ACT. "
			STR0026 := "CARGO           ABONO       SALDO ACT. "
		ElseIf cPaisLoc == "PTG"
			STR0014 := "LOTE/SUB/PLZ/LINEA H I S T O R I A L                         C/PARTIDA                      CARGO           ABONO         SALDO ACTUAL"
			STR0025 := "FECHA                                                                           CARGO                ABONO               SALDO ACTUAL"
			STR0026 := "CARGO           ABONO       SALDO ACTUAL"
		EndIf
	Return Nil
#ENDIF

#ifndef SPANISH
#ifndef ENGLISH
	STATIC uInit := __InitFun()

	Static Function __InitFun()
	uInit := Nil
	If Type('cPaisLoc') == 'C'

		If cPaisLoc == "ANG"
			STR0014 := "LOTE/SUB/DOC/LINHA H I S T O R I C O                        C/PARTIDA                      DEBITO          CREDITO       SALDO ATUAL"
			STR0025 := "DATA                                                                            DEBITO               CREDITO            SALDO ATUAL"
			STR0026 := "DEBITO         CREDITO      SALDO ATUAL"
		ElseIf cPaisLoc == "MEX"
			STR0014 := "LOTE/SUB/DOC/LINHA H I S T O R I C O                        C/PARTIDA                      DEBITO          CREDITO       SALDO ATUAL"
			STR0025 := "DATA                                                                            DEBITO               CREDITO            SALDO ATUAL"
			STR0026 := "DEBITO         CREDITO      SALDO ATUAL"
		ElseIf cPaisLoc == "PTG"
			STR0001 := "Este programa ir� imprimir o raz�o por "
			STR0002 := " de acordo com os par�metros sugeridos pelo utilizador. "
			STR0004 := "C�digo de barras"
			STR0005 := "Administra��o"
			STR0006 := "Emiss�o do raz�o contabil�stico por "
			STR0007 := "Raz�o por "
			STR0008 := " anal�tico em "
			STR0009 := "De"
			STR0010 := "At�"
			STR0011 := "(or�amentado)"
			STR0012 := "(de gest�o)"
			STR0013 := "Lote/sub/doc/linha H I S T � R I C O                        C/partida"
			STR0014 := "Lote/sub/doc/linha H I S T � R I C O                        C/partida                      D�bito          Cr�dito       Saldo Actual"
			STR0015 := "***** cancelado pelo operador *****"
			STR0016 := "Classe de valor  - "
			STR0018 := "A Criar Ficheiro Tempor�rio..."
			STR0019 := "Data"
			STR0020 := "T o t a i s  d a  c o n t a  ==> "
			STR0021 := " sint�tico em "
			STR0022 := "A transportar : "
			STR0023 := "De transporte : "
			STR0024 := "Conta - "
			STR0025 := "Data                                                                            D�bito               Cr�dito            Saldo Actual"
			STR0026 := "D�bito         Cr�dito      Saldo Actual"
			STR0027 := "Saldo Anterior:"
			STR0028 := "Data"
			STR0029 := "Lote/sub/doc./linha"
			STR0030 := "Hist�rico"
			STR0031 := "C/partida"
			STR0032 := "D�bito"
			STR0033 := "Cr�dito"
			STR0034 := "Saldo Actual"
			STR0035 := "Descri��o"
			STR0039 := "Compl.hist�rico"
		EndIf
		EndIf
	Return Nil
#ENDIF
#ENDIF
