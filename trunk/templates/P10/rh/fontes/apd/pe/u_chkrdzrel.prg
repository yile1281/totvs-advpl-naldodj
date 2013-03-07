#INCLUDE "PROTHEUS.CH"
#INCLUDE "TRYEXCEPTION.CH"
/*/
��������������������������������������������������������������������������������Ŀ
�Programa  �U_CHKRDZREL�Autor�Marinaldo de Jesus	           �Data  �18/01/2010�
��������������������������������������������������������������������������������Ĵ
�Descricoes�Ponto de Entrada U_CHKRDZREL                         				 �
��������������������������������������������������������������������������������Ĵ
�Uso       �SINAF - Verificar Relacionamento entre RD0 e Entidades Quando RD0 com�
�          �partilhado entre empresas											 �
��������������������������������������������������������������������������������Ĵ
�            ATUALIZACOES SOFRIDAS DESDE A CONSTRU�AO INICIAL                    �
��������������������������������������������������������������������������������Ĵ
�Programador �Data      �Nro. Ocorr.�Motivo da Alteracao                         �
��������������������������������������������������������������������������������Ĵ
�            �          �           �                    						 �
����������������������������������������������������������������������������������/*/
User Function ChkRdzRel()

	Local aArea			:= GetArea()
	Local aAreaRDZ		:= RDZ->( GetArea() )
	Local nRDZOrder 	:= RetOrder("RDZ","RDZ_FILIAL+RDZ_CODRD0")
	
	Local lChange		:= .F.
	Local oException
	
	Static cLastEmpFil

	TRYEXCEPTION

		RDZ->( dbSetOrder( nRDZOrder) )

		IF ( PARAMIXB[1] == "INIT" )
			IF RDZ->( dbSeek( xFilial( "RDZ" ) + GetMemVar(  "RD0_CODIGO" ) ) )
				IF ( RDZ->RDZ_EMPENT <> cEmpAnt )
					cLastEmpFil := ( cEmpAnt +  cFilAnt )
					RDZ->( GetEmpr( RDZ_EMPENT + RDZ_FILENT ) )
					lChange := .T.
				EndIF
			EndIF
		ElseIF (;
					( PARAMIXB[1] == "END" );
					.and.;
					( PARAMIXB[2] );
				)	
			IF (;
					( cLastEmpFil <> NIL );
					.and.;
					!( cLastEmpFil == ( cEmpAnt + cFilAnt ) );
				)	
				GetEmpr( cLastEmpFil )
				cLastEmpFil := NIL
				lChange 	:= .T.
			EndIF
		EndIF
		
	CATCHEXCEPTION USING oException
	
		lChange := .F.
	
	ENDEXCEPTION

	RestArea( aAreaRDZ )
	RestArea( aArea )

Return( lChange )