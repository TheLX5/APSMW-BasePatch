xcopy /b/v/y "%~dp0Super Mario World (USA).sfc" "%~dp0smw.sfc"

asar.exe main.asm "smw.sfc"

python generate_bsdiff.py smw.sfc

ren "%~dp0smw.bsdiff4" "smw_basepatch.bsdiff4"
