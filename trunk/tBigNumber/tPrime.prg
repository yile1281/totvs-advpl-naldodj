#include "fileio.ch"
#include "directry.ch"
#include "tBigNumber.ch"

THREAD Static __aPTables

/*
	Class		: tPrime
	Autor		: Marinaldo de Jesus [ http://www.blacktdn.com.br ]
	Data		: 16/03/2013
	Descricao	: Instancia um novo objeto do tipo tPrime
	Sintaxe		: tPrime():New() -> self
	Obs.		: Obter os Numeros Primos a Partir das Tabelas de Numeros Primos 
				  fornecidas por primes.utm.edu (http://primes.utm.edu/lists/small/millions/)	
*/
CLASS tPrime

	DATA cPrime
	DATA cFPrime
	DATA cLPrime
	
	DATA nSize

	Method New( cPath ) CONSTRUCTOR

	Method ClassName()

	Method IsPrime(cN)
	Method NextPrime(cN)

END CLASS

/*
	Fun��o		: tPrime():New
	Autor		: Marinaldo de Jesus [ http://www.blacktdn.com.br ]
	Data		: 04/02/2013
	Descricao	: Instancia um novo Objeto tPrime
	Sintaxe		: tPrime():New() -> self
*/
#IFDEF __PROTHEUS__
	User Function tPrime( cPath )
	Return( tPrime():New( cPath ) )
#ENDIF

/*
	Method		: New
	Autor		: Marinaldo de Jesus [ http://www.blacktdn.com.br ]
	Data		: 04/02/2013
	Descricao	: CONSTRUCTOR
	Sintaxe		: tPrime():New( cPath ) -> self
*/
Method New( cPath ) CLASS tPrime 

	Local aLine
	Local aFiles
	
	Local cLine
	Local cFile

	Local cFPrime
	Local cLPrime

	Local nSize
	Local nLine
	Local nFile
	Local nFiles
	Local ofRead

	IF ( __aPTables == NIL )
		self:nSize	:= 10
        __aPTables	:= Array(0)
        #IFDEF __HARBOUR__
	        DEFAULT cPath := hb_CurDrive()+hb_osDriveSeparator()+hb_ps()+CurDir()+hb_ps()+"PrimesTables"+hb_ps()
		#ELSE //__PROTHEUS__
	        DEFAULT cPath := "\PrimesTables\"
		#ENDIF
		aFiles	:= Directory( cPath + "prime*.txt" )
		nFiles	:= Len( aFiles )
		nSize	:= 10	
		ofRead	:= tfRead():New()
		For nFile := 1 To nFiles
			cFile	:= cPath+aFiles[nFile][F_NAME]
			nLine	:= 0
			ofRead:Open(cFile)
			ofRead:ReadLine()
			While ofRead:MoreToRead()
				cLine := ofRead:ReadLine()
				IF Empty(cLine)
					Loop
    			EndIF
    			While ( "  " $ cLine )
    				cLine	:= StrTran(cLine,"  "," ")
    			End While	
    			nLine	:= Max(nLine,Len(cLine))
    			While ( SubStr(cLine,1,1) == " " )
    				cLine := SubStr(cLine,2)
    			End While
    			While ( SubStr(cLine,-1) == " " )
    				cLine := SubStr(cLine,1,Len(cLine)-1)
    			End While
    			#IFDEF __HARBOUR__
     				aLine := hb_ATokens(cLine," ")
    			#ELSE //__PROTHEUS__
				     aLine := StrTokArr(cLine," ")
			    #ENDIF
			    cFPrime := aLine[1]
			    nSize	:= Max(Len(cFPrime),nSize)
			    cFPrime := PadL(cFPrime,nSize)
			    EXIT
			End While
			ofRead:Seek( -nLine , FS_END )
			nLine	:= 0
			While ofRead:MoreToRead()
				cLine := ofRead:ReadLine()
				IF Empty(cLine)
					Loop
    			EndIF
    			While ( "  " $ cLine )
    				cLine	:= StrTran(cLine,"  "," ")
    			End While	
    			nLine	:= Max(nLine,Len(cLine))
    			While ( SubStr(cLine,1,1) == " " )
    				cLine := SubStr(cLine,2)
    			End While
    			While ( SubStr(cLine,-1) == " " )
    				cLine := SubStr(cLine,1,Len(cLine)-1)
    			End While
    			#IFDEF __HARBOUR__
     				aLine := hb_ATokens(cLine," ")
    			#ELSE //__PROTHEUS__
				     aLine := StrTokArr(cLine," ")
			    #ENDIF
				cLPrime := aLine[Len(aLine)]
			    nSize	:= Max(Len(cFPrime),nSize)
			    cLPrime := PadL(cLPrime,nSize)
				EXIT
			End While
			ofRead:Close()
			aAdd( __aPTables , { cFile , cFPrime , cLPrime } )
		Next nFile
		nFiles	:= Len( __aPTables )
		IF ( nFiles > 0 )
			IF ( nSize > self:nSize )
				self:nSize := nSize
				For nFile := 1 To nFiles
					__aPTables[nFile][2] := PadL(__aPTables[nFile][2],nSize)
					__aPTables[nFile][3] := PadL(__aPTables[nFile][3],nSize)
				Next nFile
			EndIF
			aSort( __aPTables , NIL , NIL , { |x,y| x[2] < y[2] } )
			self:cFPrime	:= __aPTables[1][2]
			self:cLPrime	:= __aPTables[nFiles][3]
		EndIF	
		
	EndIF

    self:cPrime	:= ""

	IF ( self:cFPrime == NIL )
		self:cFPrime := ""
	EndIF
	
	IF ( self:cLPrime == NIL )
		self:cLPrime := ""
	EndIF

	IF ( self:nSize == NIL )
		self:nSize := Len(self:cLPrime)
	EndIF

Return( self )

/*
	Method		: ClassName
	Autor		: Marinaldo de Jesus [ http://www.blacktdn.com.br ]
	Data		: 04/02/2013
	Descricao	: ClassName
	Sintaxe		: tPrime():ClassName() -> cClassName
*/
Method ClassName() CLASS tPrime
Return( "TPRIME" )

/*
	Method		: IsPrime
	Autor		: Marinaldo de Jesus [ http://www.blacktdn.com.br ]
	Data		: 04/02/2013
	Descricao	: Verifica se o Numero passado por Parametro consta nas Tabelas de Numeros Primo
	Sintaxe		: tPrime():IsPrime( cN ) -> lPrime
*/
Method IsPrime( cN ) CLASS tPrime

	Local aLine

	Local cLine
	Local cPrime
	
	Local lPrime	:= .F.
	
	Local nPrime
	Local nTable
	
	Local ofRead

	BEGIN SEQUENCE

		IF Empty( __aPTables )
			BREAK
		EndIF

		DEFAULT cN 	:= self:cPrime
		cN			:= PadL( cN , self:nSize )

		nTable		:= aScan( __aPTables , { |x| cN >= x[2] .and. cN <= x[3] } )
		
		IF ( nTable == 0 )
			BREAK
		ENDIF

		ofRead		:= tfRead():New(__aPTables[nTable][1])		
		
		ofRead:Open()
		ofRead:ReadLine()

		While ofRead:MoreToRead()
			cLine := ofRead:ReadLine()
			IF Empty(cLine)
				Loop
    		EndIF
    		While ( "  " $ cLine )
    			cLine	:= StrTran(cLine,"  "," ")
    		End While	
    		While ( SubStr(cLine,1,1) == " " )
    			cLine := SubStr(cLine,2)
    		End While
    		While ( SubStr(cLine,-1) == " " )
    			cLine := SubStr(cLine,1,Len(cLine)-1)
    		End While
    		#IFDEF __HARBOUR__
     			aLine := hb_ATokens(cLine," ")
    		#ELSE //__PROTHEUS__
			    aLine := StrTokArr(cLine," ")
		    #ENDIF
			nPrime	:= aScan( aLine , { |x| PadL(x,self:nSize) == cN } )
			IF ( nPrime > 0 )
				cPrime	:= PadL(aLine[nPrime],self:nSize)
				EXIT
			EndIF	
		End While

		ofRead:Close()

	END SEQUENCE

	lPrime	:= ( cPrime == cN )

Return( lPrime )

/*
	Method		: NextPrime
	Autor		: Marinaldo de Jesus [ http://www.blacktdn.com.br ]
	Data		: 04/02/2013
	Descricao	: Obtem o Proximo Numero da Tabela de Numeros Primos
	Sintaxe		: tPrime():NextPrime( cN ) -> lPrime
*/
Method NextPrime( cN ) CLASS tPrime

	Local aLine

	Local cLine
	Local cPrime
	
	Local lPrime
	
	Local nPrime
	Local nTable
	
	Local ofRead
	
	BEGIN SEQUENCE
	
		IF Empty( __aPTables )
			BREAK
		EndIF

		DEFAULT cN 	:= self:cPrime
		cN			:= PadL( cN , self:nSize )

		IF Empty( cN )
			nTable := 1
		Else
			nTable	:= aScan( __aPTables , { |x| cN >= x[2] .and. cN <= x[3] } )
		EndIF	

		IF ( nTable == 0 )
			BREAK
		ENDIF

		ofRead		:= tfRead():New(__aPTables[nTable][1])		
		
		ofRead:Open()
		ofRead:ReadLine()

		While ofRead:MoreToRead()
			cLine := ofRead:ReadLine()
			IF Empty(cLine)
				Loop
    		EndIF
    		While ( "  " $ cLine )
    			cLine	:= StrTran(cLine,"  "," ")
    		End While	
    		While ( SubStr(cLine,1,1) == " " )
    			cLine := SubStr(cLine,2)
    		End While
    		While ( SubStr(cLine,-1) == " " )
    			cLine := SubStr(cLine,1,Len(cLine)-1)
    		End While
    		#IFDEF __HARBOUR__
     			aLine := hb_ATokens(cLine," ")
    		#ELSE //__PROTHEUS__
			    aLine := StrTokArr(cLine," ")
		    #ENDIF
			nPrime	:= aScan( aLine , { |x| PadL(x,self:nSize) > cN } )
			IF ( nPrime > 0 )
				cPrime	:= PadL(aLine[nPrime],self:nSize)
				EXIT
			EndIF	
		End While

		ofRead:Close()
		
		self:cPrime := cPrime

	END SEQUENCE

	lPrime	:= .NOT.( Empty( cPrime ) )

Return( lPrime )