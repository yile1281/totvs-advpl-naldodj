@echo off
echo BATCH FILE FOR Harbour MinGW32
rem ============================================================================
SET _PATH=%PATH%
SET _HB_PATH=%HB_PATH%
SET HB_PATH=c:\hb32\

    %HB_PATH%bin\hbmk2.exe -cpp tBigNtst_array.hbp
    %HB_PATH%bin\upx.exe   tBigNtst_array.exe
	
    %HB_PATH%bin\hbmk2.exe -cpp tBigNtst_array_assignv.hbp
    %HB_PATH%bin\upx.exe   tBigNtst_array_assignv.exe
	
    %HB_PATH%bin\hbmk2.exe -cpp tBigNtst_array_mt.hbp
    %HB_PATH%bin\upx.exe   tBigNtst_array_mt.exe
	
    %HB_PATH%bin\hbmk2.exe -cpp tBigNtst_array_mt_assignv.hbp
    %HB_PATH%bin\upx.exe   tBigNtst_array_mt_assignv.exe
	
    %HB_PATH%bin\hbmk2.exe -cpp tBigNtst_dbfile.hbp
    %HB_PATH%bin\upx.exe   tBigNtst_dbfile.exe
	
    %HB_PATH%bin\hbmk2.exe -cpp tBigNtst_dbfile_assignv.hbp
    %HB_PATH%bin\upx.exe   tBigNtst_dbfile_assignv.exe

	%HB_PATH%bin\hbmk2.exe -cpp tBigNtst_dbfile_mt.hbp
    %HB_PATH%bin\upx.exe   tBigNtst_dbfile_mt.exe
	
    %HB_PATH%bin\hbmk2.exe -cpp tBigNtst_dbfile_mt_assignv.hbp
    %HB_PATH%bin\upx.exe   tBigNtst_dbfile_mt_assignv.exe
		
    %HB_PATH%bin\hbmk2.exe -cpp tBigNtst_dbfile_memio.hbp
    %HB_PATH%bin\upx.exe   tBigNtst_dbfile_memio.exe
	
    %HB_PATH%bin\hbmk2.exe -cpp tBigNtst_dbfile_memio_assignv.hbp
    %HB_PATH%bin\upx.exe   tBigNtst_dbfile_memio_assignv.exe
	
    %HB_PATH%bin\hbmk2.exe -cpp tBigNtst_dbfile_memio_dyn_obj.hbp
    %HB_PATH%bin\upx.exe   tBigNtst_dbfile_memio_dyn_obj.exe
	
    %HB_PATH%bin\hbmk2.exe -cpp tBigNtst_dbfile_memio_dyn_obj_assignv.hbp
    %HB_PATH%bin\upx.exe   tBigNtst_dbfile_memio_dyn_obj_assignv.exe
	
    %HB_PATH%bin\hbmk2.exe -cpp tBigNtst_dbfile_memio_mt.hbp
    %HB_PATH%bin\upx.exe   tBigNtst_dbfile_memio_mt.exe
	
    %HB_PATH%bin\hbmk2.exe -cpp tBigNtst_dbfile_memio_mt_assignv.hbp
    %HB_PATH%bin\upx.exe   tBigNtst_dbfile_memio_mt_assignv.exe
	
    %HB_PATH%bin\hbmk2.exe -cpp tBigNtst_dbfile_memio_mt_dyn_obj.hbp
    %HB_PATH%bin\upx.exe   tBigNtst_dbfile_memio_mt_dyn_obj.exe
	
    %HB_PATH%bin\hbmk2.exe -cpp tBigNtst_dbfile_memio_mt_dyn_obj_assignv.hbp
    %HB_PATH%bin\upx.exe   tBigNtst_dbfile_memio_mt_dyn_obj_assignv.exe
	
    move /Y *.exe exe\mingw32 
SET HB_PATH=%_HB_PATH%
SET PATH=%_PATH%


