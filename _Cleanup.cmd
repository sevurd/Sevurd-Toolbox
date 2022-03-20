@echo off
@echo
@echo
@echo Open system restore
START control.exe sysdm.cpl ,4
@echo
@echo
@echo Open disk cleanup
START cleanmgr.exe
@echo
@echo
@echo Open temp folder
START TEMP
@echo
@echo
@echo Open %temp% folder
START %TEMP%




