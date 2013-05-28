@echo off
echo BATCH FILE FOR Harbour tBigNumber
rem ============================================================================
SET _PATH=%PATH%
	call compile.bat
	call compile64.bat
	call compilearm.bat
SET PATH=%_PATH%