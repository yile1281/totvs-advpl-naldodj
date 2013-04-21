@echo off
echo BATCH FILE FOR Harbour MinGW32
rem ============================================================================

c:\hb32\bin\hbmk2.exe -cpp tBigNtst_array.hbp
c:\hb32\bin\upx.exe   tBigNtst_array.exe
c:\hb32\bin\hbmk2.exe -cpp tBigNtst_array_mt.hbp
c:\hb32\bin\upx.exe   tBigNtst_array_mt.exe
c:\hb32\bin\hbmk2.exe -cpp tBigNtst_dbfile.hbp
c:\hb32\bin\upx.exe   tBigNtst_dbfile.exe
c:\hb32\bin\hbmk2.exe -cpp tBigNtst_dbfile_memio.hbp
c:\hb32\bin\upx.exe   tBigNtst_dbfile_memio.exe
c:\hb32\bin\hbmk2.exe -cpp tBigNtst_dbfile_memio_mt.hbp
c:\hb32\bin\upx.exe   tBigNtst_dbfile_memio_mt.exe
c:\hb32\bin\hbmk2.exe -cpp tBigNtst_dbfile_memio_mt_dyn_obj.hbp
c:\hb32\bin\upx.exe   tBigNtst_dbfile_memio_mt_dyn_obj.exe

move /Y *.exe exe\mingw32 


