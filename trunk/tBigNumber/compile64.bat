@echo off
echo BATCH FILE FOR Harbour MinGW64
rem ============================================================================
SET _PATH=%PATH%
	c:\hb32\bin\hbmk2.exe tBigNtst_array.hbp -comp=mingw64 -cpp
	c:\hb32\bin\hbmk2.exe tBigNtst_array_mt.hbp -comp=mingw64 -cpp
	c:\hb32\bin\hbmk2.exe tBigNtst_dbfile.hbp -comp=mingw64 -cpp
	c:\hb32\bin\hbmk2.exe tBigNtst_dbfile_memio.hbp -comp=mingw64 -cpp
	c:\hb32\bin\hbmk2.exe tBigNtst_dbfile_memio_mt.hbp -comp=mingw64 -cpp
	c:\hb32\bin\hbmk2.exe tBigNtst_dbfile_memio_mt_dyn_obj.hbp -comp=mingw64 -cpp 
	move /Y *.exe exe\mingw64
SET PATH=%_PATH%



