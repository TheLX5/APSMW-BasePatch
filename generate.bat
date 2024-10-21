@echo off
rem del "%~dp0smw_basepatch.sfc"
rem del "%~dp0smw_basepatch.bsdiff4"
rem copy /b/v/y "%~dp0Super Mario World (USA).sfc" "%~dp0smw_basepatch.sfc"
rem asar.exe "main.asm" "smw_basepatch.sfc"
rem python generate_bsdiff.py "smw_basepatch.sfc"
@echo on

del "%~dp0smw_sa1_basepatch.sfc"
del "%~dp0smw_sa1_basepatch.bsdiff4"
copy /b/v/y "%~dp0Super Mario World (USA).sfc" "%~dp0smw_sa1_basepatch.sfc"
asar.exe "expand_rom.asm" "smw_sa1_basepatch.sfc"
asar.exe "sa1/sa1.asm" "smw_sa1_basepatch.sfc"
asar.exe "main.asm" "smw_sa1_basepatch.sfc"
python move_graphics.py
python generate_bsdiff.py "smw_sa1_basepatch.sfc"
asar.exe "debug.asm" "smw_sa1_basepatch.sfc"

copy /b/v/y "%~dp0smw_sa1_basepatch.bsdiff4" "A:\Archipelago\worlds\smw\data\smw_sa1_basepatch.bsdiff4"
copy /b/v/y "%~dp0patches\sprite_graphics.bsdiff4" "A:\Archipelago\worlds\smw\data\sprite_graphics.bsdiff4"
copy /b/v/y "%~dp0patches\sprite_page_1.bsdiff4" "A:\Archipelago\worlds\smw\data\sprite_page_1.bsdiff4"
copy /b/v/y "%~dp0patches\sprite_page_2.bsdiff4" "A:\Archipelago\worlds\smw\data\sprite_page_2.bsdiff4"
copy /b/v/y "%~dp0patches\map_sprites.bsdiff4" "A:\Archipelago\worlds\smw\data\map_sprites.bsdiff4"