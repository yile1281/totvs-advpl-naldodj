@echo off
echo BATCH FILE FOR Harbour MinGW CE ARM
rem ============================================================================
SET _PATH=%PATH%
	SET CYGWIN=nodosfilewarning
	SET PATH=%PATH%;c:\hb30\bin\
	SET PATH=%PATH%;c:\hb30\comp\mingwarm\bin\
	SET PATH=%PATH%;c:\hb30\comp\mingwarm\libexec\gcc\arm-mingw32ce\4.4.0\
	SET PATH=%PATH%;c:\cygwin\bin\
	SET PATH=%PATH%;c:\cygwin\usr\bin\
	c:\hb30\bin\hbmk2.exe -comp=mingwarm -cpp tBigNtst_array.hbp  
	c:\hb30\bin\hbmk2.exe -comp=mingwarm -cpp tBigNtst_dbfile.hbp
	move /Y *.exe exe\mingwarm
SET PATH=%_PATH%