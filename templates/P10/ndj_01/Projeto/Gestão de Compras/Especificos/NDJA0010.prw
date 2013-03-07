#INCLUDE "NDJ.CH"
/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � NDJA0010 � Autor � Jose Carlos Noronha� Data �  22/10/10   ���
�������������������������������������������������������������������������͹��
���Descricao � Cadastro de Grupo de Fornecedores.                         ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       �                                                            ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function NDJA0010


	Local cVldAlt := ".T." // Validacao para permitir a alteracao. Pode-se utilizar ExecBlock.
	Local cVldExc := ".T." // Validacao para permitir a exclusao. Pode-se utilizar ExecBlock.
	
	Local oException
	
	Private cString := "SZ1"
	
	dbSelectArea("SZ1")
	dbSetOrder(1)
	
	TRYEXCEPTION
		
		AxCadastro(cString," Cadastro de Grupo de Fornecedores ",cVldExc,cVldAlt)

	CATCHEXCEPTION USING oException

		IF ( ValType( oException ) == "O" )
			Help( "" , 1 , ProcName() , NIL , OemToAnsi( oException:Description ) , 1 , 0 )
			ConOut( oException:Description , oException:ErrorStack )
		EndIF

	ENDEXCEPTION

Return( NIL )

Static Function __Dummy( lRecursa )
	Local oException
	TRYEXCEPTION
        lRecursa := .F.
		IF !( lRecursa )
			BREAK
		EndIF
		lRecursa := __Dummy( .F. )
		__cCRLF		:= NIL	
	CATCHEXCEPTION USING oException
	ENDEXCEPTION
Return( lRecursa )