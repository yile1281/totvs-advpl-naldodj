@echo off
echo BATCH FILE FOR Harbour MinGW CE ARM
rem ============================================================================
SET _PATH=%PATH%
SET CYGWIN=nodosfilewarning
SET PATH=%PATH%;C:\hb32\comp\mingwarm\bin;c:\cygwin\bin;c:\hb32\bin\
SET PATH=%PATH%;C:\hb32\comp\mingwarm\libexec\gcc\arm-mingw32ce\4.4.0\
SET PATH=%PATH%;C:\cygwin\bin
SET PATH=%PATH%;C:\cygwin\usr\bin

c:\hb32\bin\hbmk2.exe -comp=mingwarm -cpp tBigNtst_array.hbp  
c:\hb32\bin\hbmk2.exe -comp=mingwarm -cpp tBigNtst_array_mt.hbp
c:\hb32\bin\hbmk2.exe -comp=mingwarm -cpp tBigNtst_dbfile.hbp
c:\hb32\bin\hbmk2.exe -comp=mingwarm -cpp tBigNtst_dbfile_memio.hbp
c:\hb32\bin\hbmk2.exe -comp=mingwarm -cpp tBigNtst_dbfile_memio_mt.hbp
c:\hb32\bin\hbmk2.exe -comp=mingwarm -cpp tBigNtst_dbfile_memio_mt_dyn_obj.hbp
c:\hb32\bin\hbmk2.exe -comp=mingwarm -cpp tBigNtst_dbfile_memio_mt_dyn_obj.hbp

move /Y *.exe exe\mingwarm

SET PATH=%_PATH%