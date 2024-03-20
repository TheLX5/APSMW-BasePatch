del "%~dp0smw_basepatch.sfc"
del "%~dp0smw_basepatch.bsdiff4"
copy /b/v/y "%~dp0Super Mario World (USA).sfc" "%~dp0smw_basepatch.sfc"
asar.exe main.asm "smw_basepatch.sfc"
python generate_bsdiff.py smw_basepatch.sfc