@echo off
echo BATCH FILE FOR Harbour MinGW CE ARM
rem ============================================================================
SET _PATH=%PATH%
SET _HB_PATH=%HB_PATH%
SET _cygwin_PATH=%cygwin_PATH%
SET HB_PATH=c:\hb30\
SET cygwin_PATH=c:\cygwin\
	SET CYGWIN=nodosfilewarning
	SET PATH=%PATH%;%HB_PATH%bin\
	SET PATH=%PATH%;%HB_PATH%comp\mingwarm\bin\
	SET PATH=%PATH%;%HB_PATH%comp\mingwarm\libexec\gcc\arm-mingw32ce\4.4.0\
	SET PATH=%PATH%;%cygwin_PATH%bin\
	SET PATH=%PATH%;%cygwin_PATH%usr\bin\
	%HB_PATH%bin\hbmk2.exe -cpp -comp=mingwarm tBigNtst_array.hbp
	%HB_PATH%bin\upx.exe   tBigNtst_array.exe
	%HB_PATH%bin\hbmk2.exe -cpp -comp=mingwarm tBigNtst_array_mt.hbp
	%HB_PATH%bin\upx.exe   tBigNtst_array_mt.exe
	%HB_PATH%bin\hbmk2.exe -cpp -comp=mingwarm tBigNtst_dbfile.hbp
	%HB_PATH%bin\upx.exe   tBigNtst_dbfile.exe
	%HB_PATH%bin\hbmk2.exe -cpp -comp=mingwarm tBigNtst_dbfile_mt.hbp
	%HB_PATH%bin\upx.exe   tBigNtst_dbfile_mt.exe
	move /Y *.exe exe\mingwarm
SET cygwin_PATH=%_cygwin_PATH%
SET HB_PATH=%_HB_PATH%
SET PATH=%_PATH%