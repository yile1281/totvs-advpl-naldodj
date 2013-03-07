#INCLUDE "NDJ.CH"

/*/
	CLASS:		uTVector2D
	Autor:		Marinaldo de Jesus
	Data:		29/03/2012
	Descricao:	Vector2D
	Sintaxe:	uVector2D():New() -> Objeto do Tipo uTVector2D
/*/
CLASS uTVector2D FROM LongClassName

	DATA cClassName

	DATA x
	DATA y

	METHOD NEW(x,y) CONSTRUCTOR

	METHOD ClassName()

ENDCLASS

User Function TVector2D(x,y)
Return( uVector2D():New(@x,@y) )

/*/
	METHOD:		New
	Autor:		Marinaldo de Jesus
	Data:		29/03/2012
	Descricao:	CONSTRUCTOR
	Sintaxe:	uTVector2D():New() -> Self
/*/
METHOD New(x,y) CLASS uTVector2D

	DEFAULT x 	:= 0
	DEFAULT y	:= 0

	Self:cClassName	:= "UTVECTOR2D"

	Self:x		:= x
	Self:y		:= y

Return( Self )

/*/
	METHOD:		ClassName
	Autor:		Marinaldo de Jesus
	Data:		26/03/2012
	Descricao:	Retornar o Nome da Classe
	Sintaxe:	uTVector2D():ClassName() -> cClassName
/*/
METHOD ClassName() CLASS uTVector2D
Return( Self:cClassName )

Static Function __Dummy( lRecursa )
	Local oException
	TRYEXCEPTION
        lRecursa := .F.
		IF !( lRecursa )
			BREAK
		EndIF
    	lRecursa	:= __Dummy( .F. )
    	SYMBOL_UNUSED( __cCRLF )
	CATCHEXCEPTION USING oException
	ENDEXCEPTION
Return( lRecursa )