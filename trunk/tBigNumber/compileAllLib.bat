@echo off
echo BATCH FILE FOR Harbour tBigNumber
rem ============================================================================
SET _PATH=%PATH%
	call compileLib.bat
	call compileLib64.bat
	call compileLibARM.bat
SET PATH=%_PATH%