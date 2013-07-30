#include "tBigNumber.ch"
#include "paramtypex.ch"

#IFDEF __PROTHEUS__
	#xcommand ? <e> => ConOut(<e>)
#ENDIF	

#DEFINE ACC_SET			     100
#DEFINE ROOT_ACC_SET	      99
#DEFINE ACC_ALOG		 ACC_SET

#DEFINE __SLEEP 0
                                   
#DEFINE N_TEST 10

#IFDEF __HARBOUR__
Function Main()
	#IFDEF __HARBOUR__
	    #IFDEF __ALT_D__	// Compile with -b
		   AltD(1)			// Enables the debugger. Press F5 to go.
		   AltD()			// Invokes the debugger
		#ENDIF
	#ENDIF
Return(tBigNTst())
Static Function tBigNTst()
#ELSE
User Function tBigNTst()
#ENDIF	

#IFDEF __HARBOUR__
	Local tsBegin	:= HB_DATETIME()
	Local nsElapsed
#ENDIF

	Local dStartDate AS DATE 	  VALUE Date()
	Local dEndDate	
	Local cStartTime AS CHARACTER VALUE Time()
	Local cEndTime	 AS CHARACTER

	Local o0		AS OBJECT CLASS "TBIGNUMBER" VALUE tBigNumber():New("0")
	Local o1		AS OBJECT CLASS "TBIGNUMBER" VALUE tBigNumber():New("1")
	Local o2		AS OBJECT CLASS "TBIGNUMBER" VALUE tBigNumber():New("2")
	Local o3		AS OBJECT CLASS "TBIGNUMBER" VALUE tBigNumber():New("3")
	Local o4		AS OBJECT CLASS "TBIGNUMBER" VALUE tBigNumber():New("4")
	Local o5		AS OBJECT CLASS "TBIGNUMBER" VALUE tBigNumber():New("5")	
	Local o6		AS OBJECT CLASS "TBIGNUMBER" VALUE tBigNumber():New("6")
	Local o7		AS OBJECT CLASS "TBIGNUMBER" VALUE tBigNumber():New("7")
	Local o8		AS OBJECT CLASS "TBIGNUMBER" VALUE tBigNumber():New("8")
	Local o9		AS OBJECT CLASS "TBIGNUMBER" VALUE tBigNumber():New("9")
	Local o10		AS OBJECT CLASS "TBIGNUMBER" VALUE tBigNumber():New("10")
	
	Local otBigN	AS OBJECT CLASS "TBIGNUMBER" VALUE tBigNumber():New()
	Local otBigW	AS OBJECT CLASS "TBIGNUMBER" VALUE tBigNumber():New()
	Local otBBin	AS OBJECT CLASS "TBIGNUMBER" VALUE tBigNumber():New(NIL,2)
	Local otBH16	AS OBJECT CLASS "TBIGNUMBER" VALUE tBigNumber():New(NIL,16)
	Local otBH32	AS OBJECT CLASS "TBIGNUMBER" VALUE tBigNumber():New(NIL,32)
	Local oPrime	AS OBJECT CLASS "TPRIME"
	Local aPFact	AS ARRAY
	Local aPrimes	AS ARRAY  VALUE {;                                                                                               
										 "15485783",  "15485801",  "15485807",  "15485837",  "15485843",  "15485849",  "15485857",  "15485863",;
										 "15487403",  "15487429",  "15487457",  "15487469",  "15487471",  "15487517",  "15487531",  "15487541",;
										 "32458051",  "32458057",  "32458073",  "32458079",  "32458091",  "32458093",  "32458109",  "32458123",;
										 "49981171",  "49981199",  "49981219",  "49981237",  "49981247",  "49981249",  "49981259",  "49981271",;
										 "67874921",  "67874959",  "67874969",  "67874987",  "67875007",  "67875019",  "67875029",  "67875061",;
										"982451501", "982451549", "982451567", "982451579", "982451581", "982451609", "982451629", "982451653";
									} 

#IFDEF __HARBOUR__
	Local cLog		AS CHARACTER VALUE "tBigNTst_"+Dtos(Date())+"_"+StrTran(Time(),":","_")+"_"+StrZero(HB_RandomInt(1,999),3)+".log"
#ELSE
	Local cLog		AS CHARACTER VALUE GetTempPath()+"\tBigNTst_"+Dtos(Date())+"_"+StrTran(Time(),":","_")+"_"+StrZero(Randomize(1,999),3)+".log"
#ENDIF

	Local cN 		AS CHARACTER 
	Local cW 		AS CHARACTER 
	Local cX 		AS CHARACTER 
	Local cHex		AS CHARACTER 

	Local n			AS NUMBER
	Local w			AS NUMBER
	Local x			AS NUMBER
	Local z			AS NUMBER

	Local fhLog		AS NUMBER
	Local nSetDec	AS NUMBER
	Local nAccRoot	AS NUMBER
	Local nAccLog	AS NUMBER	
	
	Local lMR		AS LOGICAL
	Local lPn		AS LOGICAL
	Local laLog		AS LOGICAL

#IFDEF __HARBOUR__
	MEMVAR __CRLF
#ENDIF	

	Private __CRLF	AS CHARACTER VALUE CRLF

	ASSIGN fhLog := fCreate(cLog,FC_NORMAL)
	fClose(fhLog)
	ASSIGN fhLog := fOpen(cLog,FO_READWRITE+FO_SHARED)

	otBigN:SetDecimals(ACC_SET)
	otBigN:nthRootAcc(ROOT_ACC_SET)
	otBigN:SysSQRT(0)

	otBigW:SetDecimals(ACC_SET)
	otBigW:nthRootAcc(ROOT_ACC_SET)
	otBigW:SysSQRT(0)

#IFDEF __HARBOUR__	
	CLS
#ENDIF	

	__ConOut(fhLog,"---------------------------------------------------------")

	__ConOut(fhLog,"START ")
	__ConOut(fhLog,"DATE        : " , dStartDate)
	__ConOut(fhLog,"TIME        : " , cStartTime)

	#IFDEF __HARBOUR__
		__ConOut(fhLog,"TIMESTAMP   : " , HB_TTOC(tsBegin))
	#ENDIF

	#IFDEF TBN_DBFILE
		#IFNDEF TBN_MEMIO
			__ConOut(fhLog,"USING       : " , "DBFILE")
		#ELSE
			__ConOut(fhLog,"USING       : " , "DBMEMIO")
		#ENDIF	
	#ELSE
		__ConOut(fhLog,"USING       : " , "ARRAY")
	#ENDIF	

	#ifdef __POWMT__
		__ConOut(fhLog,"POWTHREAD   : " , "True")
	#else
		__ConOut(fhLog,"POWTHREAD   : " , "False")
	#endif

	#ifdef __ROOTMT__
		__ConOut(fhLog,"ROOTTHREAD  : " , "True")
	#else
		__ConOut(fhLog,"ROOTTHREAD  : " , "False")
	#endif

	#ifdef __SUBTMT__
		__ConOut(fhLog,"SUBTHREAD   : " , "True")
	#else
		__ConOut(fhLog,"SUBTHREAD   : " , "False")
	#endif

	#ifdef __MULTMT__
		__ConOut(fhLog,"MULTTHREAD  : " , "True")
	#else
		__ConOut(fhLog,"MULTTHREAD  : " , "False")
	#endif

	__ConOut(fhLog,"---------------------------------------------------------")
	__ConOut(fhLog,"")
	__ConOut(fhLog,"---------------------------------------------------------")

	__ConOut(fhLog,"")

	__ConOut(fhLog," BEGIN ------------ CARREGANDO PRIMOS -------------- ")

	ASSIGN oPrime := tPrime():New() 

	__ConOut(fhLog," ------------ CARREGANDO PRIMOS -------------- END ")

	__ConOut(fhLog,"")
	
#IFNDEF __PROTHEUS__
	__ConOut(fhLog," BEGIN ------------ Teste Operator Overloading 0 -------------- ")
	For w := 0 To 10
		ASSIGN cW	:= hb_ntos(w)
		otBigW 		:= cW
		__ConOut(fhLog,"otBigW:="+cW ,"RESULT: "+otBigW:ExactValue())
		__ConOut(fhLog,"otBigW=="+cW ,"RESULT: "+cValToChar(otBigW==cW))
		For n := 1 To 10
			ASSIGN cN	:= hb_ntos(n)
			__ConOut(fhLog,"otBigW=="+cN ,"RESULT: "+cValToChar(otBigW==cN))
			__ConOut(fhLog,"otBigW%="+cW ,"RESULT: "+(otBigW%=cW):ExactValue())
			__ConOut(fhLog,"otBigW+="+cN ,"RESULT: "+(otBigW+=cN):ExactValue()) 			
			__ConOut(fhLog,"otBigW++"    ,"RESULT: "+(otBigW++):ExactValue())
			__ConOut(fhLog,"++otBigW"    ,"RESULT: "+(++otBigW):ExactValue())
			__ConOut(fhLog,"otBigW-="+cN ,"RESULT: "+(otBigW-=cN):ExactValue())
			__ConOut(fhLog,"otBigW+="+cW ,"RESULT: "+(otBigW+=cW):ExactValue())
			__ConOut(fhLog,"otBigW*="+cN ,"RESULT: "+(otBigW*=cN):ExactValue())
			__ConOut(fhLog,"otBigW+="+cW ,"RESULT: "+(otBigW+=cW):ExactValue())
			__ConOut(fhLog,"otBigW^="+cN ,"RESULT: "+(otBigW^=cN):ExactValue())
			__ConOut(fhLog,"otBigW++"    ,"RESULT: "+(otBigW++):ExactValue())		
			__ConOut(fhLog,"++otBigW"    ,"RESULT: "+(++otBigW):ExactValue())
			__ConOut(fhLog,"otBigW--"    ,"RESULT: "+(otBigW--):ExactValue())
			__ConOut(fhLog,"--otBigW"    ,"RESULT: "+(--otBigW):ExactValue())
			__ConOut(fhLog,"otBigW=="+cN ,"RESULT: "+cValToChar(otBigW==cN))
			__ConOut(fhLog,"otBigW>"+cN  ,"RESULT: "+cValToChar(otBigW>cN))
			__ConOut(fhLog,"otBigW<"+cN  ,"RESULT: "+cValToChar(otBigW<cN))
			__ConOut(fhLog,"otBigW>="+cN ,"RESULT: "+cValToChar(otBigW>=cN))
			__ConOut(fhLog,"otBigW<="+cN ,"RESULT: "+cValToChar(otBigW<=cN))
			__ConOut(fhLog,"otBigW!="+cN ,"RESULT: "+cValToChar(otBigW!=cN))
			__ConOut(fhLog,"otBigW#"+cN  ,"RESULT: "+cValToChar(otBigW#cN))
			__ConOut(fhLog,"otBigW<>"+cN ,"RESULT: "+cValToChar(otBigW<>cN))
		    __ConOut(fhLog,"otBigW+"+cN  ,"RESULT: "+(otBigW+cN):ExactValue())
			__ConOut(fhLog,"otBigW-"+cN  ,"RESULT: "+(otBigW-cN):ExactValue())
			__ConOut(fhLog,"otBigW*"+cN  ,"RESULT: "+(otBigW*cN):ExactValue())
			__ConOut(fhLog,"otBigW/"+cN  ,"RESULT: "+(otBigW/cN):ExactValue())
			__ConOut(fhLog,"otBigW%"+cN  ,"RESULT: "+(otBigW%cN):ExactValue())
			__ConOut(fhLog,"---------------------------------------------------------")
            otBigN := otBigW
			__ConOut(fhLog,"otBigN:=otBigW"   ,"RESULT: "+otBigN:ExactValue())
			__ConOut(fhLog,"otBigN"           ,"RESULT: "+otBigW:ExactValue())
			__ConOut(fhLog,"otBigW"           ,"RESULT: "+otBigW:ExactValue())
			__ConOut(fhLog,"otBigW==otBigN"   ,"RESULT: "+cValToChar(otBigW==otBigN))
			__ConOut(fhLog,"otBigW>otBigN"    ,"RESULT: "+cValToChar(otBigW>otBigN))
			__ConOut(fhLog,"otBigW<otBigN"    ,"RESULT: "+cValToChar(otBigW<otBigN))
			__ConOut(fhLog,"otBigW>=otBigN"   ,"RESULT: "+cValToChar(otBigW>=otBigN))
			__ConOut(fhLog,"otBigW<=otBigN"   ,"RESULT: "+cValToChar(otBigW<=otBigN))
			__ConOut(fhLog,"otBigW!=otBigN"   ,"RESULT: "+cValToChar(otBigW!=otBigN))
			__ConOut(fhLog,"otBigW#otBigN"    ,"RESULT: "+cValToChar(otBigW#otBigN))
			__ConOut(fhLog,"otBigW<>otBigN"   ,"RESULT: "+cValToChar(otBigW<>otBigN))
		    __ConOut(fhLog,"otBigW+otBigN"    ,"RESULT: "+(otBigW+otBigN):ExactValue())
			__ConOut(fhLog,"otBigW-otBigN"    ,"RESULT: "+(otBigW-otBigN):ExactValue())
			__ConOut(fhLog,"otBigW*otBigN"    ,"RESULT: "+(otBigW*otBigN):ExactValue())
			__ConOut(fhLog,"otBigW/otBigN"    ,"RESULT: "+(otBigW/otBigN):ExactValue())
			__ConOut(fhLog,"otBigW%otBigN"    ,"RESULT: "+(otBigW%otBigN):ExactValue())	
			__ConOut(fhLog,"otBigW+=otBigN"   ,"RESULT: "+(otBigW+=otBigN):ExactValue()) 			
			__ConOut(fhLog,"otBigW+=otBigN++" ,"RESULT: "+(otBigW+=otBigN++):ExactValue())
			__ConOut(fhLog,"otBigW+=++otBigN" ,"RESULT: "+(otBigW+=++otBigN):ExactValue())
			__ConOut(fhLog,"otBigW-=otBigN"   ,"RESULT: "+(otBigW-=otBigN):ExactValue())
			__ConOut(fhLog,"otBigW+=otBigN"   ,"RESULT: "+(otBigW+=otBigN):ExactValue())
			__ConOut(fhLog,"otBigW*=otBigN"   ,"RESULT: "+(otBigW*=otBigN):ExactValue())
			__ConOut(fhLog,"otBigW+=otBigN"   ,"RESULT: "+(otBigW+=otBigN):ExactValue())
			otBigN := cW
			__ConOut(fhLog,"otBigN:="+cW ,"RESULT: "+otBigN:ExactValue())
			__ConOut(fhLog,"otBigN=="+cW ,"RESULT: "+cValToChar(otBigN==cW))
			__ConOut(fhLog,"otBigW^=otBigN"   ,"RESULT: "+(otBigW^=otBigN):ExactValue())
			__ConOut(fhLog,"otBigW--"         ,"RESULT: "+(otBigW--):ExactValue())
			__ConOut(fhLog,"otBigW+=otBigN--" ,"RESULT: "+(otBigW+=otBigN--):ExactValue())
			__ConOut(fhLog,"otBigW+=--otBigN" ,"RESULT: "+(otBigW+=--otBigN):ExactValue())
			__ConOut(fhLog,"---------------------------------------------------------")
		Next n
		__ConOut(fhLog,"---------------------------------------------------------")
	Next w
	__ConOut(fhLog," END ------------ Teste Operator Overloading 0 -------------- ")
#ENDIF

	__ConOut(fhLog," BEGIN ------------ Teste Prime 0 -------------- ")

	For n := 1 To 1000
		ASSIGN cN		:= hb_ntos(n)
		ASSIGN aPFact	:= otBigN:SetValue(cN):PFactors()
		For x := 1 To Len( aPFact )
			ASSIGN cW	:= aPFact[x][2]
#IFNDEF __PROTHEUS__
			otBigW := cW
			While otBigW > o0
#ELSE
			otBigW:SetValue(cW)
			While otBigW:gt(o0)
#ENDIF			
				otBigW:SetValue(otBigW:Sub(o1))
				__ConOut(fhLog,cN+':tBigNumber():PFactors()',"RESULT: "+aPFact[x][1])
			End While
		Next x	
		__ConOut(fhLog,"---------------------------------------------------------")
	Next n

	__ConOut(fhLog,"")

	__ConOut(fhLog," ------------ Teste Prime 0 -------------- END ")

*	__tbnSleep()

	__ConOut(fhLog,"")

	__ConOut(fhLog," BEGIN ------------ Teste Prime 1 -------------- ")
	
	__ConOut(fhLog,"")

	oPrime:IsPReset()
	oPrime:NextPReset()

	For n := 1 To Len( aPrimes )
		ASSIGN cN := PadL( aPrimes[n] , oPrime:nSize )
		__ConOut(fhLog,'tPrime():NextPrime('+cN+')',"RESULT: "+cValToChar(oPrime:NextPrime(cN)))	
		__ConOut(fhLog,'tPrime():NextPrime('+cN+')',"RESULT: "+oPrime:cPrime)	
		__ConOut(fhLog,'tPrime():IsPrime('+oPrime:cPrime+')',"RESULT: "+cValToChar(oPrime:IsPrime()))	
	Next n	

	__ConOut(fhLog,"")

	__ConOut(fhLog," ------------ Teste Prime 1 -------------- END ")

*	__tbnSleep()
	
	__ConOut(fhLog,"")

	__ConOut(fhLog," BEGIN ------------ Teste RANDOMIZE 0 -------------- ")
	
	__ConOut(fhLog,"")

	For n := 1 To ( N_TEST * 2 )
		__ConOut(fhLog,'tBigNumber():Randomize()',"RESULT: "+otBigN:Randomize():ExactValue())
		__ConOut(fhLog,'tBigNumber():Randomize(999999999999,9999999999999)',"RESULT: "+otBigN:Randomize("999999999999","9999999999999"):ExactValue())
		__ConOut(fhLog,'tBigNumber():Randomize(1,9999999999999999999999999999999999999999"',"RESULT: "+otBigN:Randomize("1","9999999999999999999999999999999999999999"):ExactValue())
		__ConOut(fhLog,"---------------------------------------------------------")
	Next n
	
	__ConOut(fhLog,"")

	__ConOut(fhLog," ------------ Teste RANDOMIZE  0 -------------- END ")

*	__tbnSleep()

	__ConOut(fhLog,"")

	__ConOut(fhLog," BEGIN ------------ Teste GCD/LCM 0 -------------- ")
	
	__ConOut(fhLog,"")

	For x := 1 TO N_TEST
		ASSIGN cX := hb_ntos(x)
		For n := N_TEST To 1 Step -1
			ASSIGN cN	:= hb_ntos(n)
			ASSIGN cW	:= otBigN:SetValue(cX):GCD(cN):GetValue()
			__ConOut(fhLog,cX+':tBigNumber():GCD('+cN+')',"RESULT: "+cW)
			ASSIGN cW	:= otBigN:LCM(cN):GetValue()
			__ConOut(fhLog,cX+':tBigNumber():LCM('+cN+')',"RESULT: "+cW)
			__ConOut(fhLog,"---------------------------------------------------------")
		Next n
	Next x
	
	__ConOut(fhLog,"")

	__ConOut(fhLog," ------------ Teste GCD/LCM 0 -------------- END ")

	__ConOut(fhLog,"")

*	__tbnSleep()

	__ConOut(fhLog,"")

	__ConOut(fhLog," BEGIN ------------ Teste HEX16 0 -------------- ")
	
	__ConOut(fhLog,"")

	For x := 0 TO 99999 STEP 99
		ASSIGN n	:= x
		ASSIGN cN	:= hb_ntos(n)
		ASSIGN cHex	:= otBigN:SetValue(cN):D2H("16"):Int()
		__ConOut(fhLog,cN+':tBigNumber():D2H(16)',"RESULT: "+cHex)
		ASSIGN cN	:= otBH16:SetValue(cHex):H2D():Int()
		__ConOut(fhLog,cHex+':tBigNumber():H2D()',"RESULT: "+cN)
		__ConOut(fhLog,cN+"=="+hb_ntos(n),"RESULT: "+cValToChar(cN==hb_ntos(n)))
		ASSIGN cN	:= otBH16:H2B():Int()
		__ConOut(fhLog,cHex+':tBigNumber():H2B()',"RESULT: "+cN)
		ASSIGN cHex	:= otBBin:SetValue(cN):B2H('16'):Int()
		__ConOut(fhLog,cN+':tBigNumber():B2H(16)',"RESULT: "+cHex)
		__ConOut(fhLog,"---------------------------------------------------------")
	Next x

	__ConOut(fhLog,"")

	__ConOut(fhLog," ------------ Teste HEX16 0 -------------- END ")

	__ConOut(fhLog,"")

*	__tbnSleep()

	__ConOut(fhLog,"")

	__ConOut(fhLog," BEGIN ------------ Teste HEX32 0 -------------- ")

	__ConOut(fhLog,"")

	For x := 0 TO 99999 STEP 99
		ASSIGN n	:= x
		ASSIGN cN	:= hb_ntos(n)
		ASSIGN cHex	:= otBigN:SetValue(cN):D2H("32"):Int()
		__ConOut(fhLog,cN+':tBigNumber():D2H(32)',"RESULT: "+cHex)
		ASSIGN cN	:= otBH32:SetValue(cHex):H2D("32"):Int()
		__ConOut(fhLog,cHex+':tBigNumber():H2D()',"RESULT: "+cN)
		__ConOut(fhLog,cN+"=="+hb_ntos(n),"RESULT: "+cValToChar(cN==hb_ntos(n)))
		ASSIGN cN	:= otBH32:H2B('32'):Int()
		__ConOut(fhLog,cHex+':tBigNumber():H2B()',"RESULT: "+cN)
		ASSIGN cHex	:= otBBin:SetValue(cN):B2H('32'):Int()
		__ConOut(fhLog,cN+':tBigNumber():B2H(32)',"RESULT: "+cHex)
		__ConOut(fhLog,"---------------------------------------------------------")
	Next x

	__ConOut(fhLog,"")

	__ConOut(fhLog," ------------ Teste HEX32 0 -------------- END ")
	
	__ConOut(fhLog,"")

*	__tbnSleep()

	__ConOut(fhLog,"")

	__ConOut(fhLog," BEGIN ------------ ADD Teste 1 -------------- ")

	__ConOut(fhLog,"")

	ASSIGN n := 1

#IFNDEF __PROTHEUS__
	otBigN := o1
#ELSE
	otBigN:SetValue(o1)
#ENDIF	
	
	For x := 1 TO N_TEST
		ASSIGN cN	:= hb_ntos(n)
		ASSIGN n	+= 9999.9999999999
		__ConOut(fhLog,cN+'+=9999.9999999999',"RESULT: " + hb_ntos(n))
		ASSIGN cN	:= otBigN:ExactValue()
#IFNDEF __PROTHEUS__
		otBigN += "9999.9999999999"
#ELSE
		otBigN:SetValue(otBigN:Add("9999.9999999999"))
#ENDIF		
		__ConOut(fhLog,cN+':tBigNumber():Add(9999.9999999999)',"RESULT: "+otBigN:ExactValue())
		__ConOut(fhLog,"---------------------------------------------------------")
	Next x

	__ConOut(fhLog,"")
	
	__ConOut(fhLog," ------------ ADD 1 -------------- END ")
	
	__ConOut(fhLog,"")
	
*	__tbnSleep()

	__ConOut(fhLog,"")

	__ConOut(fhLog," BEGIN ------------ ADD Teste 2 -------------- ")

	__ConOut(fhLog,"")

	ASSIGN cN	:= ("0."+Replicate("0",MIN(ACC_SET,10)))
	ASSIGN n 	:= Val(cN)
	otBigN:SetValue(cN)
	
	For x := 1 TO N_TEST
		ASSIGN cN	:= hb_ntos(n)
		ASSIGN n	+= 9999.9999999999
		__ConOut(fhLog,cN+'+=9999.9999999999',"RESULT: " + hb_ntos(n))
		ASSIGN cN	:= otBigN:ExactValue()
#IFNDEF __PROTHEUS__
		otBigN += "9999.9999999999"
#ELSE
		otBigN:SetValue(otBigN:Add("9999.9999999999"))
#ENDIF		
		__ConOut(fhLog,cN+':tBigNumber():Add(9999.9999999999)',"RESULT: "+otBigN:ExactValue())
		__ConOut(fhLog,"---------------------------------------------------------")
	Next x
	
	__ConOut(fhLog,"")
	
	__ConOut(fhLog," ------------ ADD Teste 2 -------------- END ")
	
	__ConOut(fhLog,"")

*	__tbnSleep()

	__ConOut(fhLog,"")

	__ConOut(fhLog," BEGIN ------------ ADD Teste 3 -------------- ")
	
	__ConOut(fhLog,"")
	
	For x := 1 TO N_TEST
		ASSIGN cN	:= hb_ntos(n)
		ASSIGN n	+= -9999.9999999999
		__ConOut(fhLog,cN+'+=-9999.9999999999',"RESULT: " + hb_ntos(n))
		ASSIGN cN	:= otBigN:ExactValue()
#IFNDEF __PROTHEUS__ 
		otBigN += "-9999.9999999999"
#ELSE
		otBigN:SetValue(otBigN:add("-9999.9999999999"))
#ENDIF		
		__ConOut(fhLog,cN+':tBigNumber():add(-9999.9999999999)',"RESULT: "+otBigN:ExactValue())
		__ConOut(fhLog,"---------------------------------------------------------")
	Next x

	__ConOut(fhLog,"")
	
	__ConOut(fhLog," ------------ ADD Teste 3 -------------- END ")
	
	__ConOut(fhLog,"")

*	__tbnSleep()

	__ConOut(fhLog,"")
	
	__ConOut(fhLog," BEGIN ------------ SUB Teste 1 -------------- ")
	
	__ConOut(fhLog,"")
	
	For x := 1 TO N_TEST
		ASSIGN cN	:= hb_ntos(n)
		ASSIGN n	-=9999.9999999999
		__ConOut(fhLog,cN+'-=9999.9999999999',"RESULT: " + hb_ntos(n))
		ASSIGN cN	:= otBigN:ExactValue()
#IFNDEF __PROTHEUS__
		otBigN -= "9999.9999999999"
#ELSE		
		otBigN:SetValue(otBigN:Sub("9999.9999999999"))
#ENDIF		
		__ConOut(fhLog,cN+':tBigNumber():Sub(9999.9999999999)',"RESULT: "+otBigN:ExactValue())
		__ConOut(fhLog,"---------------------------------------------------------")
	Next x

	__ConOut(fhLog,"")

	__ConOut(fhLog," ------------ SUB Teste 1 -------------- END ")
	
	__ConOut(fhLog,"")
	
*	__tbnSleep()

	__ConOut(fhLog,"")

	__ConOut(fhLog," BEGIN ------------ SUB Teste 2 -------------- ")
	
	For x := 1 TO N_TEST
		ASSIGN cN := hb_ntos(n)
		ASSIGN n  -= 9999.9999999999
		__ConOut(fhLog,cN+'-=9999.9999999999',"RESULT: " + hb_ntos(n))
		ASSIGN cN := otBigN:ExactValue()
#IFNDEF __PROTHEUS__
		otBigN -= "9999.9999999999"
#ELSE
		otBigN:SetValue(otBigN:Sub("9999.9999999999"))
#ENDIF		
		__ConOut(fhLog,cN+':tBigNumber():Sub(9999.9999999999)',"RESULT: "+otBigN:ExactValue())
		__ConOut(fhLog,"---------------------------------------------------------")
	Next x

	__ConOut(fhLog,"")

	__ConOut(fhLog," ------------ SUB Teste 2 -------------- END")
	
	__ConOut(fhLog,"")
	
*	__tbnSleep()

	__ConOut(fhLog,"")

	__ConOut(fhLog," BEGIN ------------ SUB Teste 3 -------------- ")

	For x := 1 TO N_TEST
		ASSIGN cN := hb_ntos(n)
		ASSIGN n  -= -9999.9999999999
		__ConOut(fhLog,cN+'-=-9999.9999999999',"RESULT: " + hb_ntos(n))
		ASSIGN cN := otBigN:ExactValue()
#IFNDEF __PROTHEUS__
		otBigN -= "-9999.9999999999"
#ELSE		
		otBigN:SetValue(otBigN:Sub("-9999.9999999999"))
#ENDIF		
		__ConOut(fhLog,cN+':tBigNumber():Sub(-9999.9999999999)',"RESULT: "+otBigN:ExactValue())
		__ConOut(fhLog,"---------------------------------------------------------")
	Next x

	__ConOut(fhLog,"")
	
	__ConOut(fhLog," ------------ SUB Teste 3 -------------- END ")
	
	__ConOut(fhLog,"")
	
*	__tbnSleep()

	__ConOut(fhLog,"")

	__ConOut(fhLog," BEGIN ------------ MULT Teste 1 -------------- ")
	
	__ConOut(fhLog,"")

	ASSIGN n := 1
	otBigN:SetValue(o1)
	otBigW:SetValue(o1)
	
	For x := 1 TO N_TEST
		ASSIGN cN	:= hb_ntos(n)
		ASSIGN z	:= Len(cN)
		While ((SubStr(cN,-1) == "0") .and. (z>1))
			ASSIGN cN := SubStr(cN,1,--z)
		End While
		ASSIGN z	:= Len(cN)
		While ((SubStr(cN,-1) == "*") .and. (z>1))
			ASSIGN cN := SubStr(cN,1,--z)
		End While
		ASSIGN n	*= 1.5
		__ConOut(fhLog,cN+'*=1.5',"RESULT: " + hb_ntos(n))
		ASSIGN cN	:= otBigN:ExactValue()
#IFNDEF __PROTHEUS__
		otBigN *= "1.5"
#ELSE
		otBigN:SetValue(otBigN:Mult("1.5"))
#ENDIF		
		__ConOut(fhLog,cN+':tBigNumber():Mult(1.5)',"RESULT: "+otBigN:ExactValue())
		ASSIGN cN	:= otBigW:ExactValue()
		otBigW:SetValue(otBigW:Mult("1.5",.T.))
		__ConOut(fhLog,cN+':tBigNumber():Mult(1.5,.T.)',"RESULT: "+otBigW:ExactValue())
		__ConOut(fhLog,"---------------------------------------------------------")
	Next x

	__ConOut(fhLog,"")
	
	__ConOut(fhLog," ------------ MULT Teste 1 -------------- END ")
	
	__ConOut(fhLog,"")

*	__tbnSleep()

	__ConOut(fhLog,"")

	__ConOut(fhLog," BEGIN ------------ MULT Teste 2 -------------- ")
	
	__ConOut(fhLog,"")

	ASSIGN w := 1
	otBigW:SetValue(o1)

	For x := 1 TO 50
		ASSIGN cN	:= hb_ntos(w)
		ASSIGN w	*= 3.555
		ASSIGN z	:= Len(cN)
		While ((SubStr(cN,-1) == "0") .and. (z>1))
			ASSIGN cN := SubStr(cN,1,--z)
		End While
		ASSIGN z := Len(cN)
		While ((SubStr(cN,-1) == "*") .and. (z>1))
			ASSIGN cN := SubStr(cN,1,--z)
		End While
		__ConOut(fhLog,cN+'*=3.555',"RESULT: " + hb_ntos(w))
		ASSIGN cN := otBigW:ExactValue()
#IFNDEF __PROTHEUS__
		otBigW *= "3.555"
#ELSE
		otBigW:SetValue(otBigW:Mult("3.555"))
#ENDIF
		__ConOut(fhLog,cN+':tBigNumber():Mult(3.555)',"RESULT: "+otBigW:ExactValue())
		__ConOut(fhLog,"---------------------------------------------------------")
	Next x

	__ConOut(fhLog,"")
	
	__ConOut(fhLog," ------------ MULT Teste 2 -------------- END ")
	
	__ConOut(fhLog,"")

*	__tbnSleep()

	__ConOut(fhLog,"")

	__ConOut(fhLog," BEGIN ------------ DIV Teste 0 -------------- ")
	
	__ConOut(fhLog,"")

	For n := 0 TO N_TEST
		ASSIGN cN := hb_ntos(n)
		For x := 0 TO N_TEST
			ASSIGN cX := hb_ntos(x)
			__ConOut(fhLog,cN+'/'+cX,"RESULT: " + hb_ntos(n/x))
#IFNDEF __PROTHEUS__
			otBigN := cN
			__ConOut(fhLog,cN+':tBigNumber():Div('+cX+')',"RESULT: "+(otBigN/cX):ExactValue())
#ELSE
			otBigN:SetValue(cN)
			__ConOut(fhLog,cN+':tBigNumber():Div('+cX+')',"RESULT: "+otBigN:Div(cX):ExactValue())
#ENDIF			
			__ConOut(fhLog,"---------------------------------------------------------")
		Next x
	*	__tbnSleep()
	Next n	

	__ConOut(fhLog,"")
	
	__ConOut(fhLog," ------------ DIV Teste 0 -------------- END ")
	
	__ConOut(fhLog,"")

*	__tbnSleep()

	__ConOut(fhLog,"")

	__ConOut(fhLog,"")

	__ConOut(fhLog," BEGIN ------------ DIV Teste 1 -------------- ")
	
	__ConOut(fhLog,"")

	ASSIGN cN := hb_ntos(n)
	otBigN:SetValue(cN)

	For x := 1 TO N_TEST
		ASSIGN cW	:= hb_ntos(n)
		ASSIGN n	/= 1.5
		__ConOut(fhLog,cW+'/=1.5',"RESULT: "+hb_ntos(n))
		ASSIGN cN	:= otBigN:ExactValue()
#IFNDEF __PROTHEUS__
		otBigN /= "1.5"
#ELSE
		otBigN:SetValue(otBigN:Div("1.5"))
#ENDIF		
		__ConOut(fhLog,cN+':tBigNumber():Div(1.5)',"RESULT: "+otBigN:ExactValue())
		__ConOut(fhLog,"---------------------------------------------------------")
	Next x

	__ConOut(fhLog,"")
	
	__ConOut(fhLog," ------------ DIV Teste 1 -------------- END ")
	
	__ConOut(fhLog,"")

*	__tbnSleep()

	__ConOut(fhLog,"")

	__ConOut(fhLog," BEGIN ------------ DIV Teste 2 -------------- ")
	
	__ConOut(fhLog,"")

	otBigN:SetValue(o1)
	For x := 1 TO N_TEST
		ASSIGN cN := hb_ntos(x)
		otBigN:SetValue(cN)
		__ConOut(fhLog,cN+"/3","RESULT: "+hb_ntos(x/3))
#IFNDEF __PROTHEUS__
		otBigN /= o3
#ELSE
		otBigN:SetValue(otBigN:Div(o3))
#ENDIF		
		__ConOut(fhLog,cN+':tBigNumber():Div(3)',"RESULT: "+otBigN:ExactValue())
		__ConOut(fhLog,"---------------------------------------------------------")
	Next x

	__ConOut(fhLog,"")
	
	__ConOut(fhLog," ------------ DIV Teste 2 -------------- END ")
	
	__ConOut(fhLog,"")

*	__tbnSleep()

	__ConOut(fhLog," BEGIN ------------ Teste FI 0 -------------- ")
	//http://www.javascripter.net/math/calculators/eulertotientfunction.htm
	
	__ConOut(fhLog,"")

	For n := 1 To N_TEST
		ASSIGN cN := hb_ntos(n)
		__ConOut(fhLog,cN+':tBigNumber():FI()',"RESULT: "+otBigN:SetValue(cN):FI():ExactValue())
		__ConOut(fhLog,"---------------------------------------------------------")
	Next n
	
	__ConOut(fhLog,"")

	__ConOut(fhLog," ------------ Teste FI  0 -------------- END ")

*	__tbnSleep()

*	otBigN:SysSQRT(999999999999999)
	otBigN:SysSQRT(0)

*	otBigW:SysSQRT(999999999999999)
	otBigW:SysSQRT(0)
	
	__ConOut(fhLog,"")

	__ConOut(fhLog," BEGIN ------------ Teste SQRT 1 -------------- ")
	
	__ConOut(fhLog,"")

	For x := 999999999999999 - 999 TO 999999999999999 + 999 STEP 99
		ASSIGN n  := x
		ASSIGN cN := hb_ntos(n)
		__ConOut(fhLog,'SQRT('+cN+')',"RESULT: " + hb_ntos(SQRT(n)))
		otBigN:SetValue(cN)
		__ConOut(fhLog,cN+':tBigNumber():SQRT()',"RESULT: "+otBigN:SQRT():GetValue())
		__ConOut(fhLog,"---------------------------------------------------------")
	Next x

	__ConOut(fhLog,"")

	__ConOut(fhLog," ------------ Teste SQRT 1 -------------- END ")
	
	__ConOut(fhLog,"")

*	otBigN:SysSQRT(0)
*	otBigW:SysSQRT(0)

	__ConOut(fhLog,"")

	__ConOut(fhLog," BEGIN ------------ Teste SQRT 2 -------------- ")
	
	__ConOut(fhLog,"")

	For x := 1 TO N_TEST
		ASSIGN n  	:= x
		ASSIGN cN 	:= hb_ntos(n)
		__ConOut(fhLog,'SQRT('+cN+')',"RESULT: " + hb_ntos(SQRT(n)))
		otBigN:SetValue(cN)
		otBigN:SetValue(otBigN:SQRT())
		ASSIGN cW	:= otBigN:GetValue()
		__ConOut(fhLog,cN+':tBigNumber():SQRT()',"RESULT: "+cW)
		ASSIGN cW	:= otBigN:Rnd(ACC_SET):GetValue()
		__ConOut(fhLog,cN+':tBigNumber():SQRT()',"RESULT: "+cW)
		__ConOut(fhLog,"---------------------------------------------------------")
	Next x

	__ConOut(fhLog,"")

	__ConOut(fhLog," ------------ Teste SQRT 2 -------------- END ")
	
	__ConOut(fhLog,"")

	__ConOut(fhLog," ------------ Teste SQRT 3 -------------- END ")
	
	__ConOut(fhLog,"")

*	__tbnSleep()

	__ConOut(fhLog,"")

	__ConOut(fhLog," BEGIN ------------ Teste Exp 0 -------------- ")
	
	__ConOut(fhLog,"")
	
	For x := 0 TO (N_TEST / 2)
		ASSIGN n  := x
		ASSIGN cN := hb_ntos(n)
		__ConOut(fhLog,'Exp('+cN+')',"RESULT: " + hb_ntos(Exp(n)))
		otBigN:SetValue(cN)
		__ConOut(fhLog,cN+':tBigNumber():Exp()',"RESULT: "+otBigN:Exp():ExactValue())
		__ConOut(fhLog,"---------------------------------------------------------")
	Next x

	__ConOut(fhLog,"")

	__ConOut(fhLog," ------------ Teste Exp 0 -------------- END ")
	
	__ConOut(fhLog,"")

*	__tbnSleep()

	__ConOut(fhLog,"")

	__ConOut(fhLog," BEGIN ------------ Teste Pow 0 -------------- ")
	
	__ConOut(fhLog,"")

	For x := IF(.NOT.(IsHb()) , 1 , 0) TO N_TEST //Tem um BUG aqui. Servidor __PROTHEUS__ Fica Maluco se (0^-n) e Senta..........
		ASSIGN cN := hb_ntos(x)
		For w := -N_TEST To 0
			ASSIGN cW	:= hb_ntos(w)
			ASSIGN n 	:= x
			ASSIGN n	:= (n^w)
			__ConOut(fhLog,cN+'^'+cW,"RESULT: " + hb_ntos(n))
			otBigN:SetValue(cN)
			ASSIGN cN	:= otBigN:ExactValue()
#IFNDEF __PROTHEUS__
			otBigN ^= cW
#ELSE
			otBigN:SetValue(otBigN:Pow(cW))
#ENDIF			
			__ConOut(fhLog,cN+':tBigNumber():Pow('+cW+')',"RESULT: "+otBigN:ExactValue())
			__ConOut(fhLog,"---------------------------------------------------------")
		Next w
	*	__tbnSleep()
	Next x

	__ConOut(fhLog,"")

	__ConOut(fhLog," ------------ Teste Pow 0 -------------- END ")
	
	__ConOut(fhLog,"")

*	__tbnSleep()

	__ConOut(fhLog,"")

	__ConOut(fhLog," BEGIN ------------ Teste Pow 1 -------------- ")
	
	__ConOut(fhLog,"")

	For x := 0 TO N_TEST STEP 5
		ASSIGN cN := hb_ntos(x)
		For w := 0 To N_TEST STEP 5
			ASSIGN cW	:= hb_ntos(w+.5)
			ASSIGN n 	:= x
			ASSIGN n	:= (n^(w+.5))
			__ConOut(fhLog,cN+'^'+cW,"RESULT: " + hb_ntos(n))
			otBigN:SetValue(cN)
			ASSIGN cN	:= otBigN:ExactValue()
#IFNDEF __PROTHEUS__
			otBigN ^= cW
#ELSE
			otBigN:SetValue(otBigN:Pow(cW))
#ENDIF
			__ConOut(fhLog,cN+':tBigNumber():Pow('+cW+')',"RESULT: "+otBigN:ExactValue())
			__ConOut(fhLog,"---------------------------------------------------------")
		Next w
	*	__tbnSleep()
	Next x

	__ConOut(fhLog,"")

	__ConOut(fhLog," ------------ Teste Pow 1 -------------- END ")
	
	__ConOut(fhLog,"")

	__ConOut(fhLog,"")
	
	nSetDec 	:= otBigN:SetDecimals(ACC_ALOG)
	nAccLog		:= otBigN:SetDecimals(ACC_ALOG)
	laLog		:= ( nAccLog >= 500 )
	otBigW:SetDecimals(ACC_ALOG)
	nAccRoot	:= otBigN:nthRootAcc(ACC_ALOG-1)
	otBigW:nthRootAcc(ACC_ALOG-1)

	__ConOut(fhLog," BEGIN ------------ Teste LOG 0 -------------- ")
	
	__ConOut(fhLog,"")

	ASSIGN cX	:= otBigW:SetValue("1215"):Ln():GetValue()
	__ConOut(fhLog,'1215:tBigNumber():Ln()',"RESULT: "+cX)
	IF ( laLog )
		__ConOut(fhLog,cX+':tBigNumber():aLn()',"RESULT: "+otBigW:SetValue(cX):aLn():GetValue())
	EndIF
	__ConOut(fhLog,"")
	
	ASSIGN cX	:= otBigW:SetValue("1215"):Log2():GetValue()
	__ConOut(fhLog,'1215:tBigNumber():Log2()',"RESULT: "+cX)
	IF ( laLog )
		__ConOut(fhLog,cX+':tBigNumber():aLog2()',"RESULT: "+otBigW:SetValue(cX):aLog2():GetValue())
	EndIF
	__ConOut(fhLog,"")
	
	ASSIGN cX	:= otBigW:SetValue("1215"):Log10():GetValue()
	__ConOut(fhLog,'1215:tBigNumber():Log10()',"RESULT: "+cX)
	IF ( laLog )
		__ConOut(fhLog,cX+':tBigNumber():aLog10()',"RESULT: "+otBigW:SetValue(cX):aLog10():GetValue())
    EndIF
	__ConOut(fhLog,"")
	__ConOut(fhLog,"")

	ASSIGN cX	:= otBigW:SetValue("1215"):Log(otBigN:SetValue(o1)):GetValue()
	__ConOut(fhLog,'1215:tBigNumber():Log("1")'  ,"RESULT: "+cX)
	IF ( laLog )
		__ConOut(fhLog,cX+':tBigNumber():aLog("1")'  ,"RESULT: "+otBigW:SetValue(cX):aLog(otBigN:SetValue(o1)):GetValue())
	EndIF
	__ConOut(fhLog,"")
	
	ASSIGN cX	:= otBigW:SetValue("1215"):Log(otBigN:SetValue(o2)):GetValue()
	__ConOut(fhLog,'1215:tBigNumber():Log("2")'  ,"RESULT: "+cX)
	IF ( laLog )
		__ConOut(fhLog,cX+':tBigNumber():aLog("2")'  ,"RESULT: "+otBigW:SetValue(cX):aLog(otBigN:SetValue(o2)):GetValue())
	EndIF
	__ConOut(fhLog,"")
	
	ASSIGN cX	:= otBigW:SetValue("1215"):Log(otBigN:SetValue(o3)):GetValue()
	__ConOut(fhLog,'1215:tBigNumber():Log("3")'  ,"RESULT: "+cX)
	IF ( laLog )
		__ConOut(fhLog,cX+':tBigNumber():aLog("3")'  ,"RESULT: "+otBigW:SetValue(cX):aLog(otBigN:SetValue(o3)):GetValue())
	EndIF
	__ConOut(fhLog,"")
	
	ASSIGN cX	:= otBigW:SetValue("1215"):Log(otBigN:SetValue(o4)):GetValue()
	__ConOut(fhLog,'1215:tBigNumber():Log("4")'  ,"RESULT: "+cX)
	IF ( laLog )
		__ConOut(fhLog,cX+':tBigNumber():aLog("4")'  ,"RESULT: "+otBigW:SetValue(cX):aLog(otBigN:SetValue(o4)):GetValue())
	EndIF
	__ConOut(fhLog,"")
	
	ASSIGN cX	:= otBigW:SetValue("1215"):Log(otBigN:SetValue(o5)):GetValue()
	__ConOut(fhLog,'1215:tBigNumber():Log("5")'  ,"RESULT: "+cX)
	IF ( laLog )
		__ConOut(fhLog,cX+':tBigNumber():aLog("5")'  ,"RESULT: "+otBigW:SetValue(cX):aLog(otBigN:SetValue(o5)):GetValue())
	EndIF
	__ConOut(fhLog,"")
	
	ASSIGN cX	:= otBigW:SetValue("1215"):Log(otBigN:SetValue(o6)):GetValue()
	__ConOut(fhLog,'1215:tBigNumber():Log("6")'  ,"RESULT: "+cX)
	IF ( laLog )
		__ConOut(fhLog,cX+':tBigNumber():aLog("6")'  ,"RESULT: "+otBigW:SetValue(cX):aLog(otBigN:SetValue(o6)):GetValue())
	EndIF
	__ConOut(fhLog,"")
	
	ASSIGN cX	:= otBigW:SetValue("1215"):Log(otBigN:SetValue(o7)):GetValue()
	__ConOut(fhLog,'1215:tBigNumber():Log("7")'  ,"RESULT: "+cX)
	IF ( laLog )
		__ConOut(fhLog,cX+':tBigNumber():aLog("7")'  ,"RESULT: "+otBigW:SetValue(cX):aLog(otBigN:SetValue(o7)):GetValue())
	EndIF
	__ConOut(fhLog,"")
	
	ASSIGN cX	:= otBigW:SetValue("1215"):Log(otBigN:SetValue(o8)):GetValue()
	__ConOut(fhLog,'1215:tBigNumber():Log("8")'  ,"RESULT: "+cX)
	IF ( laLog )
		__ConOut(fhLog,cX+':tBigNumber():aLog("8")'  ,"RESULT: "+otBigW:SetValue(cX):aLog(otBigN:SetValue(o8)):GetValue())
	EndIF
	__ConOut(fhLog,"")
	
	ASSIGN cX	:= otBigW:SetValue("1215"):Log(otBigN:SetValue(o9)):GetValue()
	__ConOut(fhLog,'1215:tBigNumber():Log("9")'  ,"RESULT: "+cX) 
	IF ( laLog )
		__ConOut(fhLog,cX+':tBigNumber():aLog("9")'  ,"RESULT: "+otBigW:SetValue(cX):aLog(otBigN:SetValue(o9)):GetValue()) 	
	EndIF
	__ConOut(fhLog,"")
	
	ASSIGN cX	:= otBigW:SetValue("1215"):Log(otBigN:SetValue(o10)):GetValue()
	__ConOut(fhLog,'1215:tBigNumber():Log("10")' ,"RESULT: "+cX)
	IF ( laLog )
		__ConOut(fhLog,cX+':tBigNumber():aLog("10")' ,"RESULT: "+otBigW:SetValue(cX):aLog(otBigN:SetValue(o10)):GetValue())
	EndIF
	__ConOut(fhLog,"")

	__ConOut(fhLog,"")

	__ConOut(fhLog," ------------ Teste LOG 0 -------------- END ")

	__ConOut(fhLog,"")

*	__tbnSleep()

	__ConOut(fhLog,"")

	__ConOut(fhLog," BEGIN ------------ Teste LOG 1 -------------- ")
	
	__ConOut(fhLog,"")

	//Quer comparar o resultado:http://www.gyplan.com/pt/logar_pt.html

	For w := 0 TO N_TEST
		ASSIGN cW := hb_ntos(w)
		otBigW:SetValue(cW)
		__ConOut(fhLog,'Log('+cW+')',"RESULT: "+hb_ntos(Log(w)))
		__ConOut(fhLog,cW+':tBigNumber():Log()'  ,"RESULT: "+otBigW:SetValue(cW):Log():GetValue()) 
		__ConOut(fhLog,"---------------------------------------------------------")
		For n := 0 TO INT( MAX( N_TEST , 5 ) / 5 )
			ASSIGN cN	:= hb_ntos(n)
			ASSIGN cX	:= otBigW:SetValue(cW):Log(cN):GetValue()
			__ConOut(fhLog,cW+':tBigNumber():Log("'+cN+'")'  ,"RESULT: "+cX)
			IF ( laLog )
				__ConOut(fhLog,cX+':tBigNumber():aLog("'+cN+'")'  ,"RESULT: "+otBigW:SetValue(cX):aLog(cN):GetValue())
			EndIF
			__ConOut(fhLog,"---------------------------------------------------------")
		Next n
	*	__tbnSleep()
	Next w

	__ConOut(fhLog,"")

	__ConOut(fhLog," ------------ Teste LOG 1 -------------- END ")

	__ConOut(fhLog,"")

*	__tbnSleep()

	__ConOut(fhLog,"")

	__ConOut(fhLog," BEGIN ------------ Teste LN 1 -------------- ")
	
	__ConOut(fhLog,"")
    
	//Quer comparar o resultado:http://www.gyplan.com/pt/logar_pt.html
	
	For w := 0 TO N_TEST
		ASSIGN cW	:= hb_ntos(w)
		ASSIGN cX	:= otBigW:SetValue(cW):Ln():GetValue()
		__ConOut(fhLog,cW+':tBigNumber():Ln()',"RESULT: "+cX)
		IF ( laLog )
			__ConOut(fhLog,cX+':tBigNumber():aLn()',"RESULT: "+otBigW:SetValue(cX):aLn():GetValue())
		EndIF
		__ConOut(fhLog,"---------------------------------------------------------")
	*	__tbnSleep()
	Next w

	__ConOut(fhLog,"")

	__ConOut(fhLog," ------------ Teste LN 1 -------------- END ")

	__ConOut(fhLog,"")

*	__tbnSleep()
    
	otBigN:SetDecimals(nSetDec)
	otBigN:nthRootAcc(nAccRoot)
	otBigW:SetDecimals(nSetDec)
	otBigW:nthRootAcc(nAccRoot)
	
	__ConOut(fhLog," BEGIN ------------ Teste millerRabin 0 -------------- ")
	
	__ConOut(fhLog,"")

	n := 0
	While ( n <= 300 )
		IF ( n < 3 )
			ASSIGN n += 1
		Else
			ASSIGN n += 2
		EndIF
		ASSIGN cN 	:= hb_ntos(n)
		ASSIGN lPn	:= oPrime:IsPrime(cN,.T.)
		ASSIGN lMR	:= IF( lPn , lPn , otBigN:SetValue(cN):millerRabin(o2) )
		__ConOut(fhLog,cN+':tBigNumber():millerRabin()',"RESULT: "+cValToChar(lMR)+IF(lMR,"","   "))
		__ConOut(fhLog,cN+':tPrime():IsPrime()',"RESULT: "+cValToChar(lPn)+IF(lPn,"","   "))
		__ConOut(fhLog,"---------------------------------------------------------")
	End While

	__ConOut(fhLog,"")

	__ConOut(fhLog," ------------ Teste millerRabin 0 -------------- END ")

	__ConOut(fhLog,"")

*	__tbnSleep()
	
	__ConOut(fhLog,"")

	__ConOut(fhLog,"---------------------------------------------------------")
	__ConOut(fhLog,"")
	__ConOut(fhLog,"---------------------------------------------------------")

	__ConOut(fhLog,"END ")

	dEndDate := Date()
	__ConOut(fhLog,"DATE    :" , dEndDate )
	
	ASSIGN cEndTime	:= Time()
	__ConOut(fhLog,"TIME    :" , cEndTime )

#IFDEF __PROTHEUS__
	While dStartDate < dEndDate
		cEndTime := IncTime( cEndTime , 24 )
		++dStartDate
	End While
	__ConOut(fhLog,"ELAPSED :" , ElapTime(cStartTime,cEndTime) )
#ELSE	
	#IFDEF __HARBOUR__
		nsElapsed	:= (HB_DATETIME()-tsBegin)
		__ConOut(fhLog,"ELAPSED :" , HB_TTOC(HB_NTOT(nsElapsed)) )
	#ENDIF
#ENDIF

	__ConOut(fhLog,"---------------------------------------------------------")

	fClose(fhLog)
	
Return(NIL)

/*
Static Procedure __tbnSleep(nSleep)
	PARAMTYPE 1 VAR nSleep AS NUMBER OPTIONAL DEFAULT __SLEEP
	#IFDEF __PROTHEUS__
		Sleep(nSleep*1000)
	#ELSE
		hb_idleSleep(nSleep)
		hb_gcAll()
	#ENDIF	
Return
*/

Static Procedure __ConOut(fhLog,e,d)

	Local ld	AS LOGICAL
	
	Local p		AS CHARACTER

	Local nATd  AS NUMBER
	
	Local x		AS UNDEFINED
	Local y		AS UNDEFINED

#IFDEF __HARBOUR__	
	MEMVAR __CRLF
#ENDIF	

	PARAMTYPE 1 VAR fhLog	AS NUMBER
	PARAMTYPE 2 VAR e     	AS UNDEFINED
	PARAMTYPE 3 VAR d		AS UNDEFINED

	ASSIGN ld	:= .NOT.(Empty(d))

	ASSIGN x 	:= cValToChar(e)

	IF (ld)
		ASSIGN y	:= cValToChar(d)
		ASSIGN nATd	:= AT("RESULT",y)
	Else
		ASSIGN y	:= ""
	EndIF	

	ASSIGN p := x + IF(ld , " " + y , "")
	
	? p

	IF ((ld) .and. (nATd>0))
		fWrite(fhLog,x+__CRLF)
		fWrite(fhLog,"...................................................................................................."+y+__CRLF)
	Else
		fWrite(fhLog,x+y+__CRLF)
	EndIF	

Return

Static Function IsHb()
	Local lHarbour AS LOGICAL
	#IFDEF __HARBOUR__
		ASSIGN lHarbour	:= .T.
	#ELSE
		ASSIGN lHarbour	:= .F.
	#ENDIF
Return(lHarbour)

#IFDEF __HARBOUR__
	Static Function cValToChar(e)
		Local s AS UNDEFINED
		SWITCH ValType(e) 
   		CASE "C"
   			s := e
   			EXIT
   		CASE "D"
			s := Dtoc(e)
			EXIT
		CASE "N"
	   		s := Str(e)
	   		EXIT
	   	CASE "L"
		   	s := IF(e,".T.",".F.")	
		   	EXIT
		OTHERWISE   	
			s := ""
   		ENDSWITCH
	Return(s)
#ENDIF 