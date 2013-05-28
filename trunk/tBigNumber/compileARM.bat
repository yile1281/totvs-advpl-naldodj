@echo off
echo BATCH FILE FOR Harbour MinGW CE ARM
rem ============================================================================
SET _PATH=%PATH%
	SET CYGWIN=nodosfilewarning
	SET PATH=%PATH%;C:\hb30\comp\mingwarm\bin\
	SET PATH=%PATH%;c:\cygwin\bin
	SET PATH=%PATH%;c:\hb30\bin\
	SET PATH=%PATH%;C:\hb30\comp\mingwarm\libexec\gcc\arm-mingw32ce\4.4.0\
	SET PATH=%PATH%;C:\cygwin\bin
	SET PATH=%PATH%;C:\cygwin\usr\bin
	c:\hb30\bin\hbmk2.exe -comp=mingwarm  -cpp tBigNtst_array.hbp  
	rem c:\hb30\bin\hbmk2.exe -comp=mingwarm  -cpp tBigNtst_array_mt.hbp
	c:\hb30\bin\hbmk2.exe -comp=mingwarm  -cpp tBigNtst_dbfile.hbp
	rem c:\hb30\bin\hbmk2.exe -comp=mingwarm  -cpp tBigNtst_dbfile_memio.hbp
	rem c:\hb30\bin\hbmk2.exe -comp=mingwarm  -cpp tBigNtst_dbfile_memio_mt.hbp
	rem c:\hb30\bin\hbmk2.exe -comp=mingwarm  -cpp tBigNtst_dbfile_memio_mt_dyn_obj.hbp
	move /Y *.exe exe\mingwarm
SET PATH=%_PATH%