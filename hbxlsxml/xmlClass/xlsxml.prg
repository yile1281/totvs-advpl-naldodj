/*
 * $Id: xlsxml.prg 17100 2011-10-28 22:05:33Z vouchcac $
 */

/*
 * Harbour Project source code:
 *
 * Copyright 2011 Fausto Di Creddo Trautwein, ftwein@yahoo.com.br
 * www - http://www.xharbour.org http://harbour-project.org
 *
 * Thanks TO Robert F Greer, PHP original version
 * http://sourceforge.net/projects/excelwriterxml/ 
 *
 * This program is free software; you can redistribute it AND/OR modify
 * it under the terms of the GNU General PUBLIC License as published by
 * the Free Software Foundation; either version 2, OR( at your option )
 * any later version.
 *
 * This program is distributed IN the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General PUBLIC License FOR more details.
 *
 * You should have received a copy of the GNU General PUBLIC License
 * along WITH this software; see the file COPYING.  IF NOT, write TO
 * the Free Software Foundation, Inc., 59 Temple Place, Suite 330,
 * Boston, MA 02111-1307 USA( OR visit the web site http://www.gnu.org/ ).
 *
 * As a special exception, the Harbour Project gives permission FOR
 * additional uses of the text contained IN its release of Harbour.
 *
 * The exception is that, IF you link the Harbour libraries WITH other
 * files TO produce an executable, this does NOT by itself cause the
 * resulting executable TO be covered by the GNU General PUBLIC License.
 * Your use of that executable is IN no way restricted on account of
 * linking the Harbour library code into it.
 *
 * This exception does NOT however invalidate any other reasons why
 * the executable file might be covered by the GNU General PUBLIC License.
 *
 * This exception applies only TO the code released by the Harbour
 * Project under the name Harbour.  IF you copy code FROM other
 * Harbour Project OR Free Software Foundation releases into a copy of
 * Harbour, as the General PUBLIC License permits, the exception does
 * NOT apply TO the code that you add IN this way.  TO avoid misleading
 * anyone as TO the status of such modified files, you must delete
 * this exception notice FROM them.
 *
 * IF you write modifications of your own FOR Harbour, it is your choice
 * whether TO permit this exception TO apply TO your modifications.
 * IF you DO NOT wish that, delete this exception notice.
 *
 */
/*----------------------------------------------------------------------*/

#IFDEF __HARBOUR__
	#include "hbclass.ch"
#ELSE
	#include "ptxlsxml.ch"
#ENDIF	

#include "fileio.ch"

/*----------------------------------------------------------------------*/

CREATE CLASS ExcelWriterXML

   DATA   styles                                  INIT {}
   DATA   formatErrors                            INIT hb_hash()
   DATA   sheets                                  INIT {}
   DATA   lShowErrorSheet                         INIT .f.
   DATA   overwriteFile                           INIT .f.
   DATA   docFileName                             
   DATA   cDocTitle                                
   DATA   cDocSubject                              
   DATA   cDocAuthor                               
   DATA   cDocCreated                              
   DATA   cDocManager                              
   DATA   cDocCompany                              
   DATA   cDocVersion                             INIT "11.9999"

   DATA   cError                                  INIT ""
   DATA   errors                                  INIT .f.
   
   METHOD New( fileName )
   METHOD setOverwriteFile( overwrite ) 
   METHOD showErrorSheet( show ) 
   METHOD addError( cFunction, cMessage ) 
   METHOD getDefaultStyle() 
   METHOD addStyle( id ) 
   METHOD addSheet( id ) 
   METHOD checkSheetID( id ) 
   METHOD checkStyleID( id ) 
   METHOD writeData( target )
   METHOD docTitle( title ) 
   METHOD docSubject( subject ) 
   METHOD docAuthor( author ) 
   METHOD docManager( manager ) 
   METHOD docCompany( company ) 
   
   ENDCLASS 

/*----------------------------------------------------------------------*/
      
METHOD ExcelWriterXML:new( fileName )
   LOCAL style

#ifndef __HARBOUR__

   ::styles				:= {}
   ::formatErrors		:= hb_hash()
   ::sheets				:= {}
   ::lShowErrorSheet	:= .f.
   ::overwriteFile		:= .f.
   ::cDocVersion		:= "11.9999"

   ::cError				:= ""
   ::errors				:= .f.

#endif
   
   style := ::addStyle( 'DEFAULT' )
   style:SetName( 'Normal' )
   style:alignVertical( 'Bottom' )
   
   IF empty( fileName )
      fileName := 'file.xml'
   ENDIF
   
   ::docFileName := fileName
   ::cDocCreated := DTOS( DATE() ) + 'T' + TIME() + 'Z'
      
   RETURN SELF

/*----------------------------------------------------------------------*/

METHOD ExcelWriterXML:setOverwriteFile( overwrite )

   IF ! ( VALTYPE( overwrite ) == "L" )
      ::overwriteFile := .f.
   ELSE
      ::overwriteFile := overwrite
   ENDIF
      
   RETURN NIL

/*----------------------------------------------------------------------*/
   
METHOD ExcelWriterXML:showErrorSheet( show )

   IF ! ( VALTYPE( show ) == "L" )
      ::lShowErrorSheet := .t.
   ELSE
      ::lShowErrorSheet := show
   ENDIF         
   
   RETURN NIL

/*----------------------------------------------------------------------*/

METHOD ExcelWriterXML:addError( cFunction, cMessage )
   LOCAL tmp := hb_hash()
   
   tmp[ 'FUNCTION' ] := cFunction
   tmp[ 'MESSAGE'   ] := cMessage
           
   ::formatErrors += tmp
      
   RETURN NIL
   
/*----------------------------------------------------------------------*/
   
METHOD ExcelWriterXML:getDefaultStyle()

   RETURN ::styles[ 1 ]

/*----------------------------------------------------------------------*/
      
METHOD ExcelWriterXML:addStyle( id ) 
   LOCAL style

   STATIC styleNum := 1
   
   IF alltrim( id ) == ''
      id := NIL
   ENDIF
   
   IF id == NIL
      id := 'CustomStyle' + ALLTRIM( STR( styleNum, 3 ) )
      styleNum++
   ENDIF
   
   WHILE ! ::checkStyleID( id )
      id := 'CustomStyle' + ALLTRIM( STR( styleNum, 3 ) )
      styleNum++
   ENDDO
   
   style := ExcelWriterXML_Style():new( id )
   AADD( ::styles, style )
      
   RETURN style
  
/*----------------------------------------------------------------------*/
    
METHOD ExcelWriterXML:addSheet( id ) 
   LOCAL sheet
   
   STATIC sheetNum:= 1
   
   IF id == NIL
      id := 'Sheet' + ALLTRIM( STR( sheetNum, 3 ) )
      sheetNum++
   ENDIF
   
   WHILE ! ::checkSheetID( id )
      id := 'Sheet' + ALLTRIM( STR( sheetNum, 3 ) )
      sheetNum++
   ENDDO
   
   sheet := ExcelWriterXML_Sheet():New( id )    
   AADD( ::sheets, sheet )
      
   RETURN sheet 

/*----------------------------------------------------------------------*/
              
METHOD ExcelWriterXML:checkSheetID( id )
   LOCAL sheet
   
   IF len( ::sheets ) > 0
      FOR EACH sheet IN ::sheets
         IF id == sheet:getID()
            RETURN .f.
         ENDIF
      NEXT
   ELSE
      RETURN .t.
   ENDIF
   
   RETURN .t.

/*----------------------------------------------------------------------*/
           
METHOD ExcelWriterXML:checkStyleID( id )
   LOCAL style
   
   IF LEN( ::styles ) > 0
      FOR EACH style IN ::styles
         IF id == style:getID()
            RETURN .f.
         ENDIF
      NEXT
   ELSE
      RETURN .t.
   ENDIF
   
   RETURN .t.

/*----------------------------------------------------------------------*/
      
METHOD ExcelWriterXML:writeData( target )
   LOCAL style, sheet, xml := "", handle, fileExists, format
  
   LOCAL docTitle   := ''
   LOCAL docSubject := ''
   LOCAL docAuthor  := ''
   LOCAL docCreated := ''
   LOCAL docManager := ''
   LOCAL docCompany := ''
   
   IF target == NIL
      ::cError := "Target filename missing!"
      ::errors := .t.
      RETURN .t.
   ENDIF    
   
   fileExists := hb_fileExists( target )
   IF ( fileExists == .t. .AND. ::overwriteFile == .f. )
      ::cError := target + " exists and overwriteFile is set to false"
      ::errors := .t.
      RETURN .f.
   ENDIF
   handle := hb_fcreate( target, FC_NORMAL, FO_EXCLUSIVE )
   IF handle == -1
      ::cError := "Not able to open " + target + " for writing"
      ::errors := .t.
      RETURN .f.
   ENDIF
   
   IF ::lShowErrorSheet == .t.
      format := ::addStyle( "formatErrorsHeader" )
      format:setFontBold()
      format:bgColor( "red" )
   ENDIF
   
   IF ! empty( ::cDocTitle   ); docTitle   := "<Title>"   + OemToHtmlEspecial( ::cDocTitle   ) + "</Title>"   + HB_OsNewLine(); ENDIF
   IF ! empty( ::cDocSubject ); docSubject := "<Subject>" + OemToHtmlEspecial( ::cDocSubject ) + "</Subject>" + HB_OsNewLine(); ENDIF
   IF ! empty( ::cDocAuthor  ); docAuthor  := "<Author>"  + OemToHtmlEspecial( ::cDocAuthor  ) + "</Author>"  + HB_OsNewLine(); ENDIF
   IF ! empty( ::cDocCreated ); docCreated := "<Created>" + OemToHtmlEspecial( ::cDocCreated ) + "</Created>" + HB_OsNewLine(); ENDIF
   IF ! empty( ::cDocManager ); docManager := "<Manager>" + OemToHtmlEspecial( ::cDocManager ) + "</Manager>" + HB_OsNewLine(); ENDIF
   IF ! empty( ::cDocCompany ); docCompany := "<Company>" + OemToHtmlEspecial( ::cDocCompany ) + "</Company>" + HB_OsNewLine(); ENDIF
   
   xml := '<?xml version="1.0"?>' + HB_OsNewLine() 
   xml += '<?mso-application progid="Excel.Sheet"?>' + HB_OsNewLine() 
   xml += '<Workbook' + HB_OsNewLine() 
   xml += 'xmlns="urn:schemas-microsoft-com:office:spreadsheet"' + HB_OsNewLine() 
   xml += 'xmlns:o="urn:schemas-microsoft-com:office:office"' + HB_OsNewLine() 
   xml += 'xmlns:x="urn:schemas-microsoft-com:office:excel"' + HB_OsNewLine() 
   xml += 'xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet"' + HB_OsNewLine() 
   xml += 'xmlns:html="http://www.w3.org/TR/REC-html40">' + HB_OsNewLine() 
   xml += '<DocumentProperties xmlns="urn:schemas-microsoft-com:office:office">' + HB_OsNewLine() 
   IF ! empty( ::cDocTitle   ); xml += '   ' + docTitle  ; ENDIF
   IF ! empty( ::cDocSubject ); xml += '   ' + docSubject; ENDIF
   IF ! empty( ::cDocAuthor  ); xml += '   ' + docAuthor ; ENDIF
   IF ! empty( ::cDocCreated ); xml += '   ' + docCreated; ENDIF
   IF ! empty( ::cDocManager ); xml += '   ' + docManager; ENDIF
   IF ! empty( ::cDocCompany ); xml += '   ' + docCompany; ENDIF
   xml += '   <Version>' + ::cDocVersion + '</Version>' + HB_OsNewLine()
   xml += '</DocumentProperties>' + HB_OsNewLine()
   xml += '<ExcelWorkbook xmlns="urn:schemas-microsoft-com:office:excel" />' + HB_OsNewLine()
   xml += '<Styles>' + HB_OsNewLine()
             
   fwrite( handle,xml )
   xml := ""
   
   FOR EACH style IN ::styles 
      xml += style:getStyleXML()
   NEXT
   xml += '</Styles>'+HB_OsNewLine()
   
   fwrite( handle, xml )
   xml := ""
   
   IF LEN( ::sheets ) == 0
      ::addSheet()
   ENDIF
   IF len( ::sheets ) > 0
      FOR EACH sheet IN ::sheets 
         xml += sheet:getSheetXML( handle )
         IF LEN( sheet:getErrors() ) > 0
             ::errors := .t.
         ENDIF
      NEXT
   ENDIF
   IF LEN( ::formatErrors ) > 0
      ::errors := .t.
   ENDIF
   xml += '</Workbook>'
             
   fwrite( handle, xml )
   xml := ""
   fclose( handle )
   
   RETURN .t.
 
/*----------------------------------------------------------------------*/
                
METHOD ExcelWriterXML:docTitle( title )

   IF hb_isChar( title )
      ::cDocTitle := title
   ENDIF    
   
   RETURN NIL

/*----------------------------------------------------------------------*/
      
METHOD ExcelWriterXML:docSubject( subject )

   IF hb_isChar( subject )
      ::cDocSubject := subject
   ENDIF    
   
   RETURN NIL

/*----------------------------------------------------------------------*/
      
METHOD ExcelWriterXML:docAuthor( author )
   
   IF hb_isChar( author )
      ::cDocAuthor := author
   ENDIF 
      
   RETURN NIL

/*----------------------------------------------------------------------*/
      
METHOD ExcelWriterXML:docManager( manager )

   IF hb_isChar( manager )
      ::cDocManager := manager
   ENDIF    
   
   RETURN NIL

/*----------------------------------------------------------------------*/
      
METHOD ExcelWriterXML:docCompany( company )

   IF hb_isChar( company )
      ::cDocCompany := company
   ENDIF 
   
   RETURN NIL

/*----------------------------------------------------------------------*/
#ifndef __HARBOUR__ 
STATIC FUNCTION AnsiToHtml( x )
#else
FUNCTION AnsiToHtml( x )
#endif
   RETURN( x )

/*----------------------------------------------------------------------*/
#ifndef __HARBOUR__
STATIC FUNCTION OEMTOHTML( xtxt )
#else
FUNCTION OEMTOHTML( xtxt )
#endif
   LOCAL afrm, i, xret:= "", xpos
   
   afrm := {;
           { "�", "&aacute;" },;       
           { "�", "&acirc;"  },;      
           { "�", "&agrave;" },;       
           { "�", "&atilde;" },;       
           { "�", "&ccedil;" },;       
           { "�", "&eacute;" },;       
           { "�", "&ecirc;"  },;      
           { "�", "&iacute;" },;       
           { "�", "&oacute;" },;       
           { "�", "&ocirc;"  },;      
           { "�", "&otilde;" },;       
           { "�", "&uacute;" },;       
           { "�", "&uuml;"   },;     
           { "�", "&Aacute;" },;       
           { "�", "&Acirc;"  },;      
           { "�", "&Agrave;" },;       
           { "�", "&Atilde;" },;       
           { "�", "&Ccedil;" },;       
           { "�", "&Eacute;" },;       
           { "�", "&Ecirc;"  },;      
           { "�", "&Iacute;" },;       
           { "�", "&Oacute;" },;       
           { "�", "&Ocirc;"  },;      
           { "�", "&Otilde;" },;       
           { "�", "&Uacute;" },;       
           { "�", "&Uuml;"   },;  
           { "-", "&ndash;"  } ;
           }
   
   FOR i:= 1 TO LEN( xtxt )
      IF( xpos:= ASCAN( afrm, {|x| SUBS( xtxt,i,1 ) == x[1] } ) ) > 0
         xret+= afrm[xpos,2]
      ELSE
         xret+= SUBS( xtxt,i,1 )
      ENDIF
   NEXT
   
   RETURN( xret )

/*----------------------------------------------------------------------*/
#ifndef __HARBOUR__
STATIC FUNCTION OEMTOHTMLESPECIAL( xtxt )
#else
FUNCTION OEMTOHTMLESPECIAL( xtxt )
#endif
   LOCAL afrm, i, xret:= "", xpos
   
   xtxt := exretiraAcentos( xtxt )
   afrm := {;
           { '&', "&amp;"  },;       
           { '"', "&quot;" },;      
           { "'", "&#039;" },;       
           { "<", "&lt;"   },;       
           { ">", "&gt;"   } ;       
           }
   
   FOR i := 1 TO LEN( xtxt )
      IF ( xpos := ASCAN( afrm, {|x| SUBSTR( xtxt, i, 1 ) == x[ 1 ] } ) ) > 0
         xret += afrm[xpos,2]
      ELSE
         xret += SUBSTR( xtxt,i,1 )
      ENDIF
   NEXT
   
   RETURN xret

/*----------------------------------------------------------------------*/
#ifndef __HARBOUR__
STATIC FUNCTION EXRETIRAACENTOS( xtxt )
#else
FUNCTION EXRETIRAACENTOS( xtxt )
#endif
   LOCAL afrm, i, xret:= "", xpos
   
   afrm := {;
           { "�", "a" },;       
           { "�", "a" },;      
           { "�", "a" },;       
           { "�", "a" },;       
           { "�", "c" },;       
           { "�", "e" },;       
           { "�", "e" },;      
           { "�", "i" },;       
           { "�", "o" },;       
           { "�", "o" },;      
           { "�", "o" },;       
           { "�", "u" },;       
           { "�", "u" },;     
           { "�", "A" },;       
           { "�", "A" },;      
           { "�", "A" },;       
           { "�", "A" },;       
           { "�", "C" },;       
           { "�", "E" },;       
           { "�", "E" },;      
           { "�", "I" },;       
           { "�", "O" },;       
           { "�", "O" },;      
           { "�", "O" },;       
           { "�", "U" },;       
           { "�", "U" },;  
           { CHR( 166 ), "." },;
           { CHR( 167 ), "." },;  
           { CHR( 248 ), "." },;  
           { CHR( 141 ), ""  } ;
           }
   
   FOR i := 1 TO LEN( xtxt )
      IF ( xpos:= ASCAN( afrm, { |x| SUBSTR( xtxt, i, 1 ) == x[ 1 ] } ) ) > 0
         xret += afrm[ xpos, 2 ]
      ELSE
         xret += SUBSTR( xtxt, i, 1 )
      ENDIF
   NEXT
   
   RETURN xret

/*----------------------------------------------------------------------*/

#ifndef __HARBOUR__
	Static Function __Dummy()
		Local __lDummy := .F.
		IF ( __lDummy )
			AnsiToHtml()
			OEMTOHTML()
			__Dummy()
		EndIF	
	Return( NIL )
#endif	