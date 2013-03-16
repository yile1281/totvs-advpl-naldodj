#include "tBigNumber.ch"
#include "paramtypex.ch"

#IFDEF __PROTHEUS__
	#xcommand ? <e> => ConOut(<e>)
#ENDIF	

#DEFINE ACC_SET	 25
#DEFINE __SLEEP 0

#DEFINE N_TEST 50

#IFDEF __HARBOUR__
Function Main()
#ELSE
User Function tBigNTst()
#ENDIF	

	Local otBigN	AS OBJECT CLASS "TBIGNUMBER" VALUE tBigNumber():New()
	Local otBigW	AS OBJECT CLASS "TBIGNUMBER" VALUE tBigNumber():New()

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

#IFDEF __HARBOUR__
	MEMVAR __CRLF
#ENDIF	

	Private __CRLF	AS CHARACTER VALUE CRLF

	ASSIGN fhLog := fCreate(cLog , FC_NORMAL)
	fClose(fhLog)
	ASSIGN fhLog := fOpen(cLog , FO_READWRITE + FO_SHARED)

	otBigN:SetDecimals(ACC_SET)

	Set(_SET_DECIMALS , ACC_SET)

#IFDEF __HARBOUR__	
	CLS
#ENDIF	

	ASSIGN nSetDec := Set(_SET_DECIMALS , ACC_SET)

	__ConOut(fhLog,"---------------------------------------------------------")

	__ConOut(fhLog,"START ")
	__ConOut(fhLog,"DATE        : " , Date())
	__ConOut(fhLog,"TIME        : " , Time())

	#IFDEF TBN_DBFILE
		#IFNDEF TBN_MEMIO
			__ConOut(fhLog,"USING       : " , "DBFILE")
		#ELSE
			__ConOut(fhLog,"USING       : " , "DBMEMIO")
		#ENDIF	
	#ELSE
		__ConOut(fhLog,"USING       : " , "ARRAY")
	#ENDIF	

	#ifdef __MT__
		__ConOut(fhLog,"MULTITHREAD : " , "True")
	#else
		__ConOut(fhLog,"MULTITHREAD : " , "False")
	#endif

	__ConOut(fhLog,"---------------------------------------------------------")
	__ConOut(fhLog,"")
	__ConOut(fhLog,"---------------------------------------------------------")

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

	__tbnSleep()

	__ConOut(fhLog,"")

	__ConOut(fhLog," BEGIN ------------ Teste GCD/LCM 0 -------------- ")
	
	__ConOut(fhLog,"")

	For x := 1 TO N_TEST
		ASSIGN cX := LTrim(Str(x))
		For n := N_TEST To 1 Step -1
			ASSIGN cN	:= LTrim(Str(n))
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

	__tbnSleep()

	__ConOut(fhLog,"")

	__ConOut(fhLog," BEGIN ------------ Teste HEX16 0 -------------- ")
	
	__ConOut(fhLog,"")

	For x := 0 TO 99999 STEP 99
		ASSIGN n	:= x
		ASSIGN cN	:= LTrim(Str(n))
		ASSIGN cHex	:= otBigN:SetValue(cN):D2H("16")
		__ConOut(fhLog,cN+':tBigNumber():D2H(16)',"RESULT: "+cHex)
		ASSIGN cN	:= otBigN:H2D(cHex,'16'):Int()
		__ConOut(fhLog,'tBigNumber():H2D('+cHex+',16)',"RESULT: "+cN)
		__ConOut(fhLog,cN+"=="+LTrim(Str(n)),"RESULT: "+cValToChar(cN==LTrim(Str(n))))		
		ASSIGN cN	:= otBigN:H2B(cHex,'16')
		__ConOut(fhLog,'tBigNumber():H2B('+cHex+',16)',"RESULT: "+cN)
		ASSIGN cHex	:= otBigN:B2H(cN,'16')
		__ConOut(fhLog,'tBigNumber():B2H('+cN+',16)',"RESULT: "+cHex)
		__ConOut(fhLog,"---------------------------------------------------------")
	Next x

	__ConOut(fhLog,"")

	__ConOut(fhLog," ------------ Teste HEX16 0 -------------- END ")

	__ConOut(fhLog,"")

	__tbnSleep()

	__ConOut(fhLog,"")

	__ConOut(fhLog," BEGIN ------------ Teste HEX32 0 -------------- ")

	__ConOut(fhLog,"")

	For x := 0 TO 99999 STEP 99
		ASSIGN n	:= x
		ASSIGN cN	:= LTrim(Str(n))
		ASSIGN cHex	:= otBigN:SetValue(cN):D2H("32")
		__ConOut(fhLog,cN+':tBigNumber():D2H(32)',"RESULT: "+cHex)
		ASSIGN cN	:= otBigN:H2D(cHex,"32"):Int()
		__ConOut(fhLog,'tBigNumber():H2D('+cHex+',32)',"RESULT: "+cN)
		__ConOut(fhLog,cN+"=="+LTrim(Str(n)),"RESULT: "+cValToChar(cN==LTrim(Str(n))))		
		ASSIGN cN	:= otBigN:H2B(cHex,'32')
		__ConOut(fhLog,'tBigNumber():H2B('+cHex+',32)',"RESULT: "+cN)
		ASSIGN cHex	:= otBigN:B2H(cN,'32')
		__ConOut(fhLog,'tBigNumber():B2H('+cN+',32)',"RESULT: "+cHex)
		__ConOut(fhLog,"---------------------------------------------------------")
	Next x

	__ConOut(fhLog,"")

	__ConOut(fhLog," ------------ Teste HEX32 0 -------------- END ")
	
	__ConOut(fhLog,"")

	__tbnSleep()

	__ConOut(fhLog,"")

	__ConOut(fhLog," BEGIN ------------ ADD Teste 1 -------------- ")

	__ConOut(fhLog,"")

	ASSIGN n := 1
	otBigN:SetValue("1")
	
	For x := 1 TO N_TEST
		ASSIGN cN	:= LTrim(Str(n))
		ASSIGN n	+= 9999.9999999999
		__ConOut(fhLog,cN+'+=9999.9999999999',"RESULT: " + LTrim(Str(n)))
		ASSIGN cN	:= otBigN:ExactValue()
		otBigN:SetValue(otBigN:Add("9999.9999999999"))
		__ConOut(fhLog,cN+':tBigNumber():Add(9999.9999999999)',"RESULT: "+otBigN:ExactValue())
		__ConOut(fhLog,"---------------------------------------------------------")
	Next x

	__ConOut(fhLog,"")
	
	__ConOut(fhLog," ------------ ADD 1 -------------- END ")
	
	__ConOut(fhLog,"")
	
	__tbnSleep()

	__ConOut(fhLog,"")

	__ConOut(fhLog," BEGIN ------------ ADD Teste 2 -------------- ")

	__ConOut(fhLog,"")

	ASSIGN cN	:= ("0."+Replicate("0",MIN(ACC_SET,10)))
	ASSIGN n 	:= Val(cN)
	otBigN:SetValue(cN)
	
	For x := 1 TO N_TEST
		ASSIGN cN	:= LTrim(Str(n))
		ASSIGN n	+= 9999.9999999999
		__ConOut(fhLog,cN+'+=9999.9999999999',"RESULT: " + LTrim(Str(n)))
		ASSIGN cN	:= otBigN:ExactValue()
		otBigN:SetValue(otBigN:Add("9999.9999999999"))
		__ConOut(fhLog,cN+':tBigNumber():Add(9999.9999999999)',"RESULT: "+otBigN:ExactValue())
		__ConOut(fhLog,"---------------------------------------------------------")
	Next x
	
	__ConOut(fhLog,"")
	
	__ConOut(fhLog," ------------ ADD Teste 2 -------------- END ")
	
	__ConOut(fhLog,"")

	__tbnSleep()

	__ConOut(fhLog,"")

	__ConOut(fhLog," BEGIN ------------ ADD Teste 3 -------------- ")
	
	__ConOut(fhLog,"")
	
	For x := 1 TO N_TEST
		ASSIGN cN	:= LTrim(Str(n))
		ASSIGN n	+= -9999.9999999999
		__ConOut(fhLog,cN+'+=-9999.9999999999',"RESULT: " + LTrim(Str(n)))
		ASSIGN cN	:= otBigN:ExactValue()
		otBigN:SetValue(otBigN:add("-9999.9999999999"))
		__ConOut(fhLog,cN+':tBigNumber():add(-9999.9999999999)',"RESULT: "+otBigN:ExactValue())
		__ConOut(fhLog,"---------------------------------------------------------")
	Next x

	__ConOut(fhLog,"")
	
	__ConOut(fhLog," ------------ ADD Teste 3 -------------- END ")
	
	__ConOut(fhLog,"")

	__tbnSleep()

	__ConOut(fhLog,"")
	
	__ConOut(fhLog," BEGIN ------------ SUB Teste 1 -------------- ")
	
	__ConOut(fhLog,"")
	
	For x := 1 TO N_TEST
		ASSIGN cN	:= LTrim(Str(n))
		ASSIGN n	-=9999.9999999999
		__ConOut(fhLog,cN+'-=9999.9999999999',"RESULT: " + LTrim(Str(n)))
		ASSIGN cN	:= otBigN:ExactValue()
		otBigN:SetValue(otBigN:Sub("9999.9999999999"))
		__ConOut(fhLog,cN+':tBigNumber():Sub(9999.9999999999)',"RESULT: "+otBigN:ExactValue())
		__ConOut(fhLog,"---------------------------------------------------------")
	Next x

	__ConOut(fhLog,"")

	__ConOut(fhLog," ------------ SUB Teste 1 -------------- END ")
	
	__ConOut(fhLog,"")
	
	__tbnSleep()

	__ConOut(fhLog,"")

	__ConOut(fhLog," BEGIN ------------ SUB Teste 2 -------------- ")
	
	For x := 1 TO N_TEST
		ASSIGN cN := LTrim(Str(n))
		ASSIGN n  -= 9999.9999999999
		__ConOut(fhLog,cN+'-=9999.9999999999',"RESULT: " + LTrim(Str(n)))
		ASSIGN cN := otBigN:ExactValue()
		otBigN:SetValue(otBigN:Sub("9999.9999999999"))
		__ConOut(fhLog,cN+':tBigNumber():Sub(9999.9999999999)',"RESULT: "+otBigN:ExactValue())
		__ConOut(fhLog,"---------------------------------------------------------")
	Next x

	__ConOut(fhLog,"")

	__ConOut(fhLog," ------------ SUB Teste 2 -------------- END")
	
	__ConOut(fhLog,"")
	
	__tbnSleep()

	__ConOut(fhLog,"")

	__ConOut(fhLog," BEGIN ------------ SUB Teste 3 -------------- ")

	For x := 1 TO N_TEST
		ASSIGN cN := LTrim(Str(n))
		ASSIGN n  -= -9999.9999999999
		__ConOut(fhLog,cN+'-=-9999.9999999999',"RESULT: " + LTrim(Str(n)))
		ASSIGN cN := otBigN:ExactValue()
		otBigN:SetValue(otBigN:Sub("-9999.9999999999"))
		__ConOut(fhLog,cN+':tBigNumber():Sub(-9999.9999999999)',"RESULT: "+otBigN:ExactValue())
		__ConOut(fhLog,"---------------------------------------------------------")
	Next x

	__ConOut(fhLog,"")
	
	__ConOut(fhLog," ------------ SUB Teste 3 -------------- END ")
	
	__ConOut(fhLog,"")
	
	__tbnSleep()

	__ConOut(fhLog,"")

	__ConOut(fhLog," BEGIN ------------ MULT Teste 1 -------------- ")
	
	__ConOut(fhLog,"")

	ASSIGN n := 1
	otBigN:SetValue("1")
	otBigW:SetValue("1")
	
	For x := 1 TO N_TEST
		ASSIGN cN	:= LTrim(Str(n))
		ASSIGN z	:= Len(cN)
		While ((SubStr(cN,-1) == "0") .and. (z > 1))
			ASSIGN cN := SubStr(cN,1,--z)
		End While
		ASSIGN z	:= Len(cN)
		While ((SubStr(cN,-1) == "*") .and. (z > 1))
			ASSIGN cN := SubStr(cN,1,--z)
		End While
		ASSIGN n	*= 1.5
		__ConOut(fhLog,cN+'*=1.5',"RESULT: " + LTrim(Str(n)))
		ASSIGN cN	:= otBigN:ExactValue()
		otBigN:SetValue(otBigN:Mult("1.5"))
		__ConOut(fhLog,cN+':tBigNumber():Mult(1.5)',"RESULT: "+otBigN:ExactValue())
		ASSIGN cN	:= otBigW:ExactValue()
		otBigW:SetValue(otBigW:Mult("1.5",.T.))
		__ConOut(fhLog,cN+':tBigNumber():Mult(1.5,.T.)',"RESULT: "+otBigW:ExactValue())
		__ConOut(fhLog,"---------------------------------------------------------")
	Next x

	__ConOut(fhLog,"")
	
	__ConOut(fhLog," ------------ MULT Teste 1 -------------- END ")
	
	__ConOut(fhLog,"")

	__tbnSleep()

	__ConOut(fhLog,"")

	__ConOut(fhLog," BEGIN ------------ MULT Teste 2 -------------- ")
	
	__ConOut(fhLog,"")

	ASSIGN w := 1
	otBigW:SetValue("1")

	For x := 1 TO 50
		ASSIGN cN	:= LTrim(Str(w))
		ASSIGN w	*=3.555
		ASSIGN z	:= Len(cN)
		While ((SubStr(cN,-1) == "0") .and. (z > 1))
			ASSIGN cN := SubStr(cN,1,--z)
		End While
		ASSIGN z := Len(cN)
		While ((SubStr(cN,-1) == "*") .and. (z > 1))
			ASSIGN cN := SubStr(cN,1,--z)
		End While
		__ConOut(fhLog,cN+'*=3.555',"RESULT: " + LTrim(Str(w)))
		ASSIGN cN := otBigW:ExactValue()
		otBigW:SetValue(otBigW:Mult("3.555",.T.))
		__ConOut(fhLog,cN+':tBigNumber():Mult(3.555,.T.)',"RESULT: "+otBigW:ExactValue())
		__ConOut(fhLog,"---------------------------------------------------------")
	Next x

	__ConOut(fhLog,"")
	
	__ConOut(fhLog," ------------ MULT Teste 2 -------------- END ")
	
	__ConOut(fhLog,"")

	__tbnSleep()

	__ConOut(fhLog,"")

	__ConOut(fhLog," BEGIN ------------ DIV Teste 0 -------------- ")
	
	__ConOut(fhLog,"")

	For n := 0 TO N_TEST
		ASSIGN cN := LTrim(Str(n))
		otBigN:SetValue(cN)
		For x := 0 TO N_TEST
			ASSIGN cX := LTrim(Str(x))
			otBigN:SetValue(cN)
			__ConOut(fhLog,cN+'/'+cX,"RESULT: " + LTrim(Str(n/x)))
			__ConOut(fhLog,cN+':tBigNumber():Div('+cX+')',"RESULT: "+otBigN:Div(cX):ExactValue())
			__ConOut(fhLog,"---------------------------------------------------------")
		Next x
		__tbnSleep()
	Next n	

	__ConOut(fhLog,"")
	
	__ConOut(fhLog," ------------ DIV Teste 0 -------------- END ")
	
	__ConOut(fhLog,"")

	__tbnSleep()

	__ConOut(fhLog,"")

	__ConOut(fhLog,"")

	__ConOut(fhLog," BEGIN ------------ DIV Teste 1 -------------- ")
	
	__ConOut(fhLog,"")

	ASSIGN cN := LTrim(Str(n))
	otBigN:SetValue(cN)

	For x := 1 TO N_TEST
		ASSIGN cW	:= LTrim(Str(n))
		ASSIGN n	/= 1.5
		__ConOut(fhLog,cW+'/=1.5',"RESULT: "+LTrim(Str(n)))
		ASSIGN cN	:= otBigN:ExactValue()
		otBigN:SetValue(otBigN:Div("1.5"))
		__ConOut(fhLog,cN+':tBigNumber():Div(1.5)',"RESULT: "+otBigN:ExactValue())
		__ConOut(fhLog,"---------------------------------------------------------")
	Next x

	__ConOut(fhLog,"")
	
	__ConOut(fhLog," ------------ DIV Teste 1 -------------- END ")
	
	__ConOut(fhLog,"")

	__tbnSleep()

	__ConOut(fhLog,"")

	__ConOut(fhLog," BEGIN ------------ DIV Teste 2 -------------- ")
	
	__ConOut(fhLog,"")

	otBigN:SetValue("1")
	For x := 1 TO N_TEST
		ASSIGN cN := LTrim(Str(x))
		otBigN:SetValue(cN)
		__ConOut(fhLog,cN+"/3","RESULT: "+LTrim(Str(x/3)))
		otBigN:SetValue(otBigN:Div("3"))
		__ConOut(fhLog,cN+':tBigNumber():Div(3)',"RESULT: "+otBigN:ExactValue())
		__ConOut(fhLog,"---------------------------------------------------------")
	Next x

	__ConOut(fhLog,"")
	
	__ConOut(fhLog," ------------ DIV Teste 2 -------------- END ")
	
	__ConOut(fhLog,"")

	__tbnSleep()

	__ConOut(fhLog," BEGIN ------------ Teste FI 0 -------------- ")
	//http://www.javascripter.net/math/calculators/eulertotientfunction.htm
	
	__ConOut(fhLog,"")

	For n := 1 To N_TEST
		ASSIGN cN := LTrim(Str(n))
		__ConOut(fhLog,cN+':tBigNumber():FI()',"RESULT: "+otBigN:SetValue(cN):FI():ExactValue())
		__ConOut(fhLog,"---------------------------------------------------------")
	Next n
	
	__ConOut(fhLog,"")

	__ConOut(fhLog," ------------ Teste FI  0 -------------- END ")

	__tbnSleep()

*	otBigN:SysSQRT(999999999999999)
	otBigN:SysSQRT(0)

	__ConOut(fhLog,"")

	__ConOut(fhLog," BEGIN ------------ Teste SQRT 0 -------------- ")
	
	__ConOut(fhLog,"")

	For x := 1 TO N_TEST
		ASSIGN n  	:= x
		ASSIGN cN 	:= LTrim(Str(n))
		__ConOut(fhLog,'SQRT('+cN+')',"RESULT: " + LTrim(Str(SQRT(n))))
		otBigN:SetValue(cN)
		otBigN:SetValue(otBigN:SQRT())
		ASSIGN cW	:= otBigN:GetValue()
		__ConOut(fhLog,cN+':tBigNumber():SQRT()',"RESULT: "+cW)
		ASSIGN cW	:= otBigN:GetValue()
		__ConOut(fhLog,cN+':tBigNumber():SQRT()',"RESULT: "+cW)
		__ConOut(fhLog,"---------------------------------------------------------")
	Next x

	__ConOut(fhLog,"")

	__ConOut(fhLog,"  ------------ Teste SQRT 0 -------------- END ")
	
	__ConOut(fhLog,"")

	__tbnSleep()

	__ConOut(fhLog,"")

	__ConOut(fhLog," BEGIN ------------ Teste SQRT 1 -------------- ")
	
	__ConOut(fhLog,"")

	For x := 999999999999999 - 999 TO 999999999999999 + 999 STEP 99
		ASSIGN n  := x
		ASSIGN cN := LTrim(Str(n))
		__ConOut(fhLog,'SQRT('+cN+')',"RESULT: " + LTrim(Str(SQRT(n))))
		otBigN:SetValue(cN)
		__ConOut(fhLog,cN+':tBigNumber():SQRT()',"RESULT: "+otBigN:SQRT():GetValue())
		__ConOut(fhLog,"---------------------------------------------------------")
	Next x

	__ConOut(fhLog,"")

	__ConOut(fhLog," ------------ Teste SQRT 1 -------------- END ")
	
	__ConOut(fhLog,"")

*	otBigN:SysSQRT(0)

	__ConOut(fhLog,"")

	__ConOut(fhLog," BEGIN ------------ Teste SQRT 2 -------------- ")
	
	__ConOut(fhLog,"")

	For x := 1 TO N_TEST
		ASSIGN n  	:= x
		ASSIGN cN 	:= LTrim(Str(n))
		__ConOut(fhLog,'SQRT('+cN+')',"RESULT: " + LTrim(Str(SQRT(n))))
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

	__tbnSleep()

	__ConOut(fhLog,"")

	__ConOut(fhLog," BEGIN ------------ Teste SQRT 3 -------------- ")
	
	__ConOut(fhLog,"")

	For x := 999999999999999 - 100 TO 999999999999999 + 100 STEP 10
		ASSIGN n  := x
		ASSIGN cN := LTrim(Str(n))
		__ConOut(fhLog,'SQRT('+cN+')',"RESULT: " + LTrim(Str(SQRT(n))))
		otBigN:SetValue(cN)
		__ConOut(fhLog,cN+':tBigNumber():SQRT()',"RESULT: "+otBigN:SQRT():Rnd(ACC_SET):GetValue())
		__ConOut(fhLog,"---------------------------------------------------------")
	Next x

	__ConOut(fhLog,"")

	__ConOut(fhLog," ------------ Teste SQRT 3 -------------- END ")
	
	__ConOut(fhLog,"")

	__tbnSleep()

	otBigN:SetValue("1")
	otBigN:Exp()

	__ConOut(fhLog,"")

	__ConOut(fhLog," BEGIN ------------ Teste Exp 0 -------------- ")
	
	__ConOut(fhLog,"")
	
	For x := 0 TO (N_TEST / 2)
		ASSIGN n  := x
		ASSIGN cN := LTrim(Str(n))
		__ConOut(fhLog,'Exp('+cN+')',"RESULT: " + LTrim(Str(Exp(n))))
		otBigN:SetValue(cN)
		__ConOut(fhLog,cN+':tBigNumber():Exp()',"RESULT: "+otBigN:Exp():ExactValue())
		__ConOut(fhLog,"---------------------------------------------------------")
	Next x

	__ConOut(fhLog,"")

	__ConOut(fhLog," ------------ Teste Exp 0 -------------- END ")
	
	__ConOut(fhLog,"")

	__tbnSleep()

	__ConOut(fhLog,"")

	__ConOut(fhLog," BEGIN ------------ Teste Pow 0 -------------- ")
	
	__ConOut(fhLog,"")

	For x := IF(.NOT.(IsHb()) , 1 , 0) TO N_TEST //Tem um BUG aqui. Servidor __PROTHEUS__ Fica Maluco se (0 ^ -n) e Senta..........
		ASSIGN cN := LTrim(Str(x))
		For w := -N_TEST To 0
			ASSIGN cW	:= Ltrim(Str(w))
			ASSIGN n 	:= x
			ASSIGN n	:= (n ^ w)
			__ConOut(fhLog,cN+'^'+cW,"RESULT: " + LTrim(Str(n)))
			otBigN:SetValue(cN)
			ASSIGN cN	:= otBigN:ExactValue()
			otBigN:SetValue(otBigN:Pow(cW))
			__ConOut(fhLog,cN+':tBigNumber():Pow('+cW+')',"RESULT: "+otBigN:ExactValue())
			__ConOut(fhLog,"---------------------------------------------------------")
		Next w
		__tbnSleep()
	Next x

	__ConOut(fhLog,"")

	__ConOut(fhLog," ------------ Teste Pow 0 -------------- END ")
	
	__ConOut(fhLog,"")

	__tbnSleep()

	__ConOut(fhLog,"")

	__ConOut(fhLog," BEGIN ------------ Teste Pow 1 -------------- ")
	
	__ConOut(fhLog,"")

	For x := 0 TO N_TEST STEP 10
		ASSIGN cN := LTrim(Str(x))
		For w := 0 To N_TEST STEP 10
			ASSIGN cW	:= LTrim(Str(w+.5))
			ASSIGN n 	:= x
			ASSIGN n	:= (n ^ (w+.5))
			__ConOut(fhLog,cN+'^'+cW,"RESULT: " + LTrim(Str(n)))
			otBigN:SetValue(cN)
			ASSIGN cN	:= otBigN:ExactValue()
			otBigN:SetValue(otBigN:Pow(cW))
			__ConOut(fhLog,cN+':tBigNumber():Pow('+cW+')',"RESULT: "+otBigN:ExactValue())
			__ConOut(fhLog,"---------------------------------------------------------")
		Next w
		__tbnSleep()
	Next x

	__ConOut(fhLog,"")

	__ConOut(fhLog," ------------ Teste Pow 1 -------------- END ")
	
	__ConOut(fhLog,"")

	__ConOut(fhLog,"")

	__ConOut(fhLog," BEGIN ------------ Teste LOG 0 -------------- ")
	
	__ConOut(fhLog,"")

	ASSIGN cX	:= otBigW:SetValue("1215"):Ln():GetValue()
	__ConOut(fhLog,'1215:tBigNumber():Ln()',"RESULT: "+cX)
*	__ConOut(fhLog,cX+':tBigNumber():aLn()',"RESULT: "+otBigW:SetValue(cX):aLn():GetValue())
	__ConOut(fhLog,"")
	
	ASSIGN cX	:= otBigW:SetValue("1215"):Log2():GetValue()
	__ConOut(fhLog,'1215:tBigNumber():Log2()',"RESULT: "+cX)
*	__ConOut(fhLog,cX+':tBigNumber():aLog2()',"RESULT: "+otBigW:SetValue(cX):aLog2():GetValue())
	__ConOut(fhLog,"")
	
	
	ASSIGN cX	:= otBigW:SetValue("1215"):Log10():GetValue()
	__ConOut(fhLog,'1215:tBigNumber():Log10()',"RESULT: "+cX)
*	__ConOut(fhLog,cX+':tBigNumber():aLog10()',"RESULT: "+otBigW:SetValue(cX):aLog10():GetValue())

	__ConOut(fhLog,"")
	__ConOut(fhLog,"")

	ASSIGN cX	:= otBigW:SetValue("1215"):Log(otBigN:SetValue("1")):GetValue()
	__ConOut(fhLog,'1215:tBigNumber():Log("1")'  ,"RESULT: "+cX)
*	__ConOut(fhLog,cX+':tBigNumber():aLog("1")'  ,"RESULT: "+otBigW:SetValue(cX):aLog(otBigN:SetValue("1")):GetValue())
	__ConOut(fhLog,"")
	
	ASSIGN cX	:= otBigW:SetValue("1215"):Log(otBigN:SetValue("2")):GetValue()
	__ConOut(fhLog,'1215:tBigNumber():Log("2")'  ,"RESULT: "+cX)
*	__ConOut(fhLog,cX+':tBigNumber():aLog("2")'  ,"RESULT: "+otBigW:SetValue(cX):aLog(otBigN:SetValue("2")):GetValue())
	__ConOut(fhLog,"")
	
	ASSIGN cX	:= otBigW:SetValue("1215"):Log(otBigN:SetValue("3")):GetValue()
	__ConOut(fhLog,'1215:tBigNumber():Log("3")'  ,"RESULT: "+cX)
*	__ConOut(fhLog,cX+':tBigNumber():aLog("3")'  ,"RESULT: "+otBigW:SetValue(cX):aLog(otBigN:SetValue("3")):GetValue())
	__ConOut(fhLog,"")
	
	ASSIGN cX	:= otBigW:SetValue("1215"):Log(otBigN:SetValue("4")):GetValue()
	__ConOut(fhLog,'1215:tBigNumber():Log("4")'  ,"RESULT: "+cX)
*	__ConOut(fhLog,cX+':tBigNumber():aLog("4")'  ,"RESULT: "+otBigW:SetValue(cX):aLog(otBigN:SetValue("4")):GetValue())
	__ConOut(fhLog,"")
	
	ASSIGN cX	:= otBigW:SetValue("1215"):Log(otBigN:SetValue("5")):GetValue()
	__ConOut(fhLog,'1215:tBigNumber():Log("5")'  ,"RESULT: "+cX)
*	__ConOut(fhLog,cX+':tBigNumber():aLog("5")'  ,"RESULT: "+otBigW:SetValue(cX):aLog(otBigN:SetValue("5")):GetValue())
	__ConOut(fhLog,"")
	
	ASSIGN cX	:= otBigW:SetValue("1215"):Log(otBigN:SetValue("6")):GetValue()
	__ConOut(fhLog,'1215:tBigNumber():Log("6")'  ,"RESULT: "+cX)
*	__ConOut(fhLog,cX+':tBigNumber():aLog("6")'  ,"RESULT: "+otBigW:SetValue(cX):aLog(otBigN:SetValue("6")):GetValue())
	__ConOut(fhLog,"")
	
	ASSIGN cX	:= otBigW:SetValue("1215"):Log(otBigN:SetValue("7")):GetValue()
	__ConOut(fhLog,'1215:tBigNumber():Log("7")'  ,"RESULT: "+cX)
*	__ConOut(fhLog,cX+':tBigNumber():aLog("7")'  ,"RESULT: "+otBigW:SetValue(cX):aLog(otBigN:SetValue("7")):GetValue())
	__ConOut(fhLog,"")
	
	ASSIGN cX	:= otBigW:SetValue("1215"):Log(otBigN:SetValue("8")):GetValue()
	__ConOut(fhLog,'1215:tBigNumber():Log("8")'  ,"RESULT: "+cX)
*	__ConOut(fhLog,cX+':tBigNumber():aLog("8")'  ,"RESULT: "+otBigW:SetValue(cX):aLog(otBigN:SetValue("8")):GetValue())
	__ConOut(fhLog,"")
	
	ASSIGN cX	:= otBigW:SetValue("1215"):Log(otBigN:SetValue("9")):GetValue()
	__ConOut(fhLog,'1215:tBigNumber():Log("9")'  ,"RESULT: "+cX) 
*	__ConOut(fhLog,cX+':tBigNumber():aLog("9")'  ,"RESULT: "+otBigW:SetValue(cX):aLog(otBigN:SetValue("9")):GetValue()) 	
	__ConOut(fhLog,"")
	
	ASSIGN cX	:= otBigW:SetValue("1215"):Log(otBigN:SetValue("10")):GetValue()
	__ConOut(fhLog,'1215:tBigNumber():Log("10")' ,"RESULT: "+cX)
*	__ConOut(fhLog,cX+':tBigNumber():aLog("10")' ,"RESULT: "+otBigW:SetValue(cX):aLog(otBigN:SetValue("10")):GetValue())
	__ConOut(fhLog,"")

	__ConOut(fhLog,"")

	__ConOut(fhLog," ------------ Teste LOG 0 -------------- END ")

	__ConOut(fhLog,"")

	__tbnSleep()

	__ConOut(fhLog,"")

	__ConOut(fhLog," BEGIN ------------ Teste LOG 1 -------------- ")
	
	__ConOut(fhLog,"")

	//Quer comparar o resultado:http://www.gyplan.com/pt/logar_pt.html

	For w := 2 TO N_TEST
		ASSIGN cW := LTrim(Str(w))
		otBigW:SetValue(cW)
		For n := 0 TO INT( MAX( N_TEST , 5 ) / 5 )
			ASSIGN cN	:= Ltrim(Str(n))
			ASSIGN cX	:= otBigW:SetValue(cW):Log(cN):GetValue()
			__ConOut(fhLog,cW+':tBigNumber():Log("'+cN+'")'  ,"RESULT: "+cX)
*			__ConOut(fhLog,cX+':tBigNumber():aLog("'+cN+'")'  ,"RESULT: "+otBigW:SetValue(cX):aLog(cN):GetValue())
			__ConOut(fhLog,"---------------------------------------------------------")
		Next n
		__tbnSleep()
	Next w

	__ConOut(fhLog,"")

	__ConOut(fhLog," ------------ Teste LOG 1 -------------- END ")

	__ConOut(fhLog,"")

	__tbnSleep()

	__ConOut(fhLog,"")

	__ConOut(fhLog," BEGIN ------------ Teste LN 1 -------------- ")
	
	__ConOut(fhLog,"")
    
	//Quer comparar o resultado:http://www.gyplan.com/pt/logar_pt.html
	
	For w := 0 TO N_TEST
		ASSIGN cW	:= LTrim(Str(w))
		ASSIGN cX	:= otBigW:SetValue(cW):Ln():GetValue()
		__ConOut(fhLog,cW+':tBigNumber():Ln()',"RESULT: "+cX)
*		__ConOut(fhLog,cX+':tBigNumber():aLn()',"RESULT: "+otBigW:SetValue(cX):aLn():GetValue())
		__ConOut(fhLog,"---------------------------------------------------------")
		__tbnSleep()
	Next w

	__ConOut(fhLog,"")

	__ConOut(fhLog," ------------ Teste LN 1 -------------- END ")

	__ConOut(fhLog,"")

	__tbnSleep()

	__ConOut(fhLog," BEGIN ------------ Teste millerRabin 0 -------------- ")
	
	__ConOut(fhLog,"")

	For n := 0 To 9000
		ASSIGN cN := LTrim(Str(n))		
		__ConOut(fhLog,cN+':tBigNumber():millerRabin()',"RESULT: "+cValToChar(otBigN:SetValue(cN):millerRabin("2	")))
		__ConOut(fhLog,"---------------------------------------------------------")
	Next n

	__ConOut(fhLog,"")

	__ConOut(fhLog," ------------ Teste millerRabin 0 -------------- END ")

	__ConOut(fhLog,"")

	__tbnSleep()

	__ConOut(fhLog,"")

	__ConOut(fhLog,"---------------------------------------------------------")
	__ConOut(fhLog,"")
	__ConOut(fhLog,"---------------------------------------------------------")

	__ConOut(fhLog,"END ")
	__ConOut(fhLog,"DATE " , Date())
	__ConOut(fhLog,"TIME " , Time())

	__ConOut(fhLog,"---------------------------------------------------------")

	fClose(fhLog)

	Set(_SET_DECIMALS, nSetDec)
	
Return(NIL)

Static Procedure __tbnSleep(nSleep)
	PARAMTYPE 1 VAR nSleep AS NUMBER OPTIONAL DEFAULT __SLEEP
	#IFDEF __PROTHEUS__
		Sleep(nSleep*1000)
	#ELSE
		hb_idleSleep(nSleep)
		hb_gcAll()
	#ENDIF	
Return

Static Procedure __ConOut(fhLog,e,d)

	Local ld	AS LOGICAL
	
	Local p		AS CHARACTER

	Local nATd  AS NUMBER

#IFDEF __HARBOUR__	
	MEMVAR __CRLF
#ENDIF	

	PARAMTYPE 1 VAR fhLog	AS NUMBER
	PARAMTYPE 2 VAR e     	AS UNDEFINED
	PARAMTYPE 3 VAR d		AS UNDEFINED

	ASSIGN ld	:= .NOT.(Empty(d))

	ASSIGN e 	:= cValToChar(e)

	IF (ld)
		ASSIGN d 	:= cValToChar(d)
		ASSIGN nATd	:= AT("RESULT",d)
	Else
		ASSIGN d	:= ""
	EndIF	

	ASSIGN p := e + IF(ld , " " + d , "")
	
	? p

	IF ((ld) .and. (nATd > 0))
		fWrite(fhLog,e+__CRLF)
		fWrite(fhLog,"...................................................................................................."+d+__CRLF)
	Else
		fWrite(fhLog,e+d+__CRLF)
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
		   	s := IF(e , ".T." , ".F.")	
		   	EXIT
		OTHERWISE   	
			s := ""
   		ENDSWITCH
	Return(s)
#ENDIF