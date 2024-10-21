exgfx_upload:
    .slot_00              ;# 00 - Koopa
        dd $002000,$002040,$002080,$0020C0
        dd $002100
        dd $FFFFFFFF
    .slot_01              ;# 01 - Koopa shell
        dd $002140,$002180,$0021C0
        dd $FFFFFFFF
    .slot_02              ;# 02 - Shelless Koopa (Red, Green, Yellow)
        dd $002400,$002440,$002480,$0024C0
        dd $002500
        dd $FFFFFFFF
    .slot_03              ;# 03 - Shelless Koopa (Blue)
        dd $002800,$002840,$002880,$0028C0
        dd $002900
        dd $FFFFFFFF
    .slot_04              ;# 04 - Goomba
        dd $002580,$0025C0
        dd $FFFFFFFF
    .slot_05              ;# 05 - Piranha plant head
        dd $002980,$0029C0
        dd $FFFFFFFF
    .slot_06              ;# 06 - Misc tiles (piranha plant stem, flat koopa)
        dd $002540
        dd $FFFFFFFF
    .slot_07              ;# 07 - Cheep cheep
        dd $008C00,$008C40,$008C80,$008CC0
        dd $FFFFFFFF
    .slot_08              ;# 08 - Spiny
        dd $002C00,$002C40,$002C80
        dd $FFFFFFFF
    .slot_09              ;# 09 - Lakitu
        dd $002CC0,$002D00,$002D40,$002D80
        dd $002DC0
        dd $FFFFFFFF
    .slot_0A              ;# 0A - Misc tiles (Wiggler eyes & flower, bubble shine, line)
        dd $003100
        dd $FFFFFFFF
    .slot_0B              ;# 0B - Bob-omb
        dd $003400,$003440
        dd $FFFFFFFF
    .slot_0C              ;# 0C - Bubble
        dd $FFFFFFFF
    .slot_0D              ;# 0D - Wiggler
        dd $003000,$003040,$003080,$0030C0
        dd $FFFFFFFF
    .slot_0E              ;# 0E - Para-goomba
        dd $003480,$0034C0
        dd $FFFFFFFF
    .slot_0F              ;# 0F - Para-bob-omb
        dd $003500,$003540
        dd $FFFFFFFF
    .slot_10              ;# 10 - Parachute
        dd $003580,$0035C0
        dd $FFFFFFFF
    .slot_11              ;# 11 - Football
        dd $005580
        dd $FFFFFFFF
    .slot_12              ;# 12 - Bullet bills
        dd $005100,$005140,$005180,$0051C0
        dd $FFFFFFFF
    .slot_13              ;# 13 - Buzzy beetle
        dd $007800,$007840,$007880,$0078C0
        dd $007900
        dd $FFFFFFFF
    .slot_14              ;# 14 - Hopping flame
        dd $0048C0,$004900,$004940
        dd $FFFFFFFF
    .slot_15              ;# 15 - Vertical growing pipe
        dd $004980,$0049C0,$FFFFFFF
    .slot_16              ;# 16 - Spike top
        dd $007C00,$007C40,$007C80,$007CC0
        dd $007D00,$007D40
        dd $FFFFFFFF
    .slot_17              ;# 17 - Swooper bat
        dd $007940,$007980,$0079C0
        dd $FFFFFFFF
    .slot_18              ;# 18 - Blargg 
        dd $008800,$008840,$008880,$0088C0
        dd $008900,$008940,$008980,$0089C0
        dd $FFFFFFFF
    .slot_19              ;# 19 - Floating skull
        dd $006D80,$006DC0
        dd $FFFFFFFF
    .slot_1A              ;# 1A - Piranha plant stem
        dd $006D40
        dd $FFFFFFFF
    .slot_1B              ;# 1B - Ninji
        dd $007D80,$007DC0
        dd $FFFFFFFF
    .slot_1C              ;# 1C - Mega mole
        dd $008000,$008040,$008080,$0080C0
        dd $008100,$008140,$008180,$0081C0
        dd $FFFFFFFF
    .slot_1D              ;# 1D - Banzai bill
        dd $004C00,$004C40,$004C80,$004CC0
        dd $004D00,$004D40,$004D80,$004DC0
        dd $005000,$005040,$005080,$0050C0
        dd $FFFFFFFF
    .slot_1E              ;# 1E - Volcano lotus
        dd $004800,$004840,$004880
        dd $FFFFFFFF
    .slot_1F              ;# 1F - Pokey
        dd $003D80,$003DC0
        dd $FFFFFFFF
    .slot_20              ;# 20 - Rex
        dd $003C00,$003C40,$003C80,$003CC0
        dd $003D00,$003D40
        dd $FFFFFFFF
    .slot_21              ;# 21 - Monty mole
        dd $008400,$008440,$008480,$0084C0
        dd $008500
        dd $FFFFFFFF
    .slot_22              ;# 22 - Sumo bro.
        dd $004000,$004040,$004080,$0040C0
        dd $004100,$004140,$004180,$0041C0
        dd $004400,$004440,$004480
        dd $FFFFFFFF
    .slot_23              ;# 23 - Sumo bro. lightning
        dd $004580
        dd $FFFFFFFF
    .slot_24              ;# 24 - Fire pillar
        dd $0044C0,$004500,$004540
        dd $FFFFFFFF
    .slot_25              ;# 25 - Bony beetle
        dd $00A100,$00A140,$00A180,$00A1C0
        dd $FFFFFFFF
    .slot_26              ;# 26 - Dry bones
        dd $009C00,$009C40,$009C80,$009CC0
        dd $FFFFFFFF
    .slot_27              ;# 27 - Bones
        dd $009D00,$009D40,$009D80,$009DC0
        dd $FFFFFFFF
    .slot_28              ;# 28 - Bone projectile
        dd $00A000,$00A040
        dd $FFFFFFFF
    .slot_29              ;# 29 - Fishbone
        dd $00A540,$00A580,$00A5C0
        dd $FFFFFFFF
    .slot_2A              ;# 2A - Thwomp
        dd $00A800,$00A840,$00A880,$00A8C0
        dd $FFFFFFFF
    .slot_2B              ;# 2B - Thwimp
        dd $00A080
        dd $FFFFFFFF
    .slot_2C              ;# 2C - Magikoopa
        dd $00A400,$00A440,$00A480,$00A4C0,$00A500
        dd $FFFFFFFF
    .slot_2D              ;# 2D - Magikoopa's magic
        dd $00A0C0
        dd $FFFFFFFF
    .slot_2E              ;# 2E - Ball n chain
        dd $00B580,$00B5C0
        dd $FFFFFFFF
    .slot_2F              ;# 2F - Castle block
        dd $00A900,$00A940,$00A980,$00A9C0
        dd $FFFFFFFF
    .slot_30              ;# 30 - Net koopa
        dd $00B000,$00B040,$00B080,$00B0C0
        dd $00B100,$00B140,$00B180,$00B1C0
        dd $00B400,$00B440
        dd $FFFFFFFF
    .slot_31              ;# 31 - Hothead
        dd $00B480,$00B4C0,$00B500
        dd $FFFFFFFF
    .slot_32              ;# 32 - Sparky
        dd $00B540
        dd $FFFFFFFF
    .slot_33              ;# 33 - Climbing net
        dd $00AC00,$00AC40,$00AC80,$00ACC0
        dd $00AD00,$00AD40,$00AD80,$00ADC0
        dd $FFFFFFFF
    .slot_34              ;# 34 - Grinder
        dd $FFFFFFFF
    .slot_35              ;# 35 - Wooden spike
        dd $FFFFFFFF
    .slot_36              ;# 36 - Bowser statue
        dd $FFFFFFFF
    .slot_37              ;# 37 - Bowser statue flame
        dd $FFFFFFFF
    .slot_38              ;# 38 - Reflecting fireball
        dd $FFFFFFFF
    .slot_39              ;# 39 - Background flames
        dd $FFFFFFFF
    .slot_3A              ;# 3A - Falling spike
        dd $FFFFFFFF
    .slot_3B              ;# 3B - Eerie
        dd $FFFFFFFF
    .slot_3C              ;# 3C - Boo
        dd $FFFFFFFF
    .slot_3D              ;# 3D - Boo block
        dd $FFFFFFFF
    .slot_3E              ;# 3E - Big boo
        dd $FFFFFFFF
    .slot_3F              ;# 3F - Fishing boo
        dd $FFFFFFFF
    .slot_40              ;# 40 - Chuck head
        dd $FFFFFFFF
    .slot_41              ;# 41 - Chuck body
        dd $FFFFFFFF
    .slot_42              ;# 42 - Chuck (puntin' & pitchin')
        dd $FFFFFFFF
    .slot_43              ;# 43 - Chuck (diggin')
        dd $FFFFFFFF
    .slot_44              ;# 44 - Chuck rock
        dd $FFFFFFFF
    .slot_45              ;# 45 - Motor
        dd $FFFFFFFF
    .slot_46              ;# 46 - Chainsaw
        dd $FFFFFFFF
    .slot_47              ;# 47 - Rope
        dd $FFFFFFFF
    .slot_48              ;# 48 - Fuzzy
        dd $FFFFFFFF
    .slot_49              ;# 49 - Blurp
        dd $FFFFFFFF
    .slot_4A              ;# 4A - Rip Van Fish
        dd $FFFFFFFF
    .slot_4B              ;# 4B - Horizontal dolphin
        dd $FFFFFFFF
    .slot_4C              ;# 4C - Vertical dolphin
        dd $FFFFFFFF
    .slot_4D              ;# 4D - Torpedo ted
        dd $FFFFFFFF
    .slot_4E              ;# 4E - Torpedo ted hand
        dd $FFFFFFFF
    .slot_4F              ;# 4F - Urchin
        dd $FFFFFFFF
    .slot_50              ;# 50 - Porcu-puffer
        dd $FFFFFFFF
    .slot_51              ;# 51 - Super koopa
        dd $FFFFFFFF
    .slot_52              ;# 52 - Mushroom scale
        dd $FFFFFFFF
    .slot_53              ;# 53 - Rock platform
        dd $FFFFFFFF
    .slot_54              ;# 54 - Orange platform
        dd $FFFFFFFF
    .slot_55              ;# 55 - Spiky balls
        dd $FFFFFFFF
    .slot_56              ;# 56 - Goal question sphere
        dd $FFFFFFFF
    .slot_57              ;# 57 - Springboard
        dd $FFFFFFFF
    .slot_58              ;# 58 - Disco ball
        dd $FFFFFFFF
    .slot_59              ;# 59 - Hammer bro
        dd $FFFFFFFF
    .slot_5A              ;# 5A - Hammer projectile
        dd $FFFFFFFF
    .slot_5B              ;# 5B - Carrot platform
        dd $FFFFFFFF
    .slot_5C              ;# 5C - Timed platform
        dd $FFFFFFFF
    .slot_5D              ;# 5D - Dino rhino
        dd $FFFFFFFF
    .slot_5E              ;# 5E - Dino torch
        dd $FFFFFFFF
    .slot_5F              ;# 5F - Dino fire
        dd $FFFFFFFF
    .slot_60              ;# 60 - Mecha-koopa
        dd $FFFFFFFF
    .slot_61              ;# 61 - Bowling ball
        dd $FFFFFFFF
    .slot_62              ;# 62 - Brown platform
        dd $FFFFFFFF
    .slot_63              ;# 63 - Brown platform chain
        dd $FFFFFFFF
    .slot_64              ;# 64 - Smiling coin
        dd $FFFFFFFF
    .slot_65              ;# 65 - Checkerboard platform
        dd $FFFFFFFF
    .slot_66              ;# 66 - Reznor
        dd $FFFFFFFF
    .slot_67              ;# 67 - Yoshi eggs
        dd $FFFFFFFF
    .slot_68              ;# 68 - Ludwig fireball
        dd $FFFFFFFF
    .slot_69              ;# 69 - Reznor fireball
        dd $FFFFFFFF
    .slot_6A              ;# 6A - Balls
        dd $FFFFFFFF
    .slot_6B              ;# 6B - Reznor platform
        dd $FFFFFFFF
    .slot_6C              ;# 6C - Podoboo
        dd $FFFFFFFF
    .slot_6D              ;# 6D - Gas bubble
        dd $FFFFFFFF
    .slot_6E              ;# 6E - Moving hole
        dd $FFFFFFFF
    .slot_6F              ;# 6F - Red coin
        dd $FFFFFFFF
    .slot_70              ;# 70 - Key
        dd $FFFFFFFF
    .slot_71              ;# 71 - Keyhole
        dd $FFFFFFFF
    .slot_72              ;# 72 - Goal tape
        dd $FFFFFFFF
    .slot_73              ;# 73 - P-Switch
        dd $FFFFFFFF
    .slot_74              ;# 74 - Info box
        dd $FFFFFFFF
    .slot_75              ;# 75 - Question block
        dd $FFFFFFFF
    .slot_76              ;# 76 - Turn block
        dd $FFFFFFFF
    .slot_77              ;# 77 - Used block
        dd $FFFFFFFF
    .slot_78              ;# 78 - ON/OFF bounce block
        dd $FFFFFFFF
    .slot_79              ;# 79 - Note block
        dd $FFFFFFFF
    .slot_7A              ;# 7A - Glass block
        dd $FFFFFFFF
    .slot_7B             ;# 7B - Unused
        dd $FFFFFFFF
    .slot_7C             ;# 7C - Unused
        dd $FFFFFFFF
    .slot_7D             ;# 7D - Unused
        dd $FFFFFFFF
    .slot_7E             ;# 7E - Unused
        dd $FFFFFFFF
    .slot_7F             ;# 7F - Unused
        dd $FFFFFFFF
    .slot_80             ;# 80 - Unused
        dd $FFFFFFFF
    .slot_81             ;# 81 - Unused
        dd $FFFFFFFF
    .slot_82             ;# 82 - Unused
        dd $FFFFFFFF
    .slot_83             ;# 83 - Unused
        dd $FFFFFFFF
    .slot_84             ;# 84 - Unused
        dd $FFFFFFFF
    .slot_85             ;# 85 - Unused
        dd $FFFFFFFF
    .slot_86             ;# 86 - Unused
        dd $FFFFFFFF
    .slot_87             ;# 87 - Unused
        dd $FFFFFFFF
    .slot_88             ;# 88 - Unused
        dd $FFFFFFFF
    .slot_89             ;# 89 - Unused
        dd $FFFFFFFF
    .slot_8A             ;# 8A - Unused
        dd $FFFFFFFF
    .slot_8B             ;# 8B - Unused
        dd $FFFFFFFF
    .slot_8C             ;# 8C - Unused
        dd $FFFFFFFF
    .slot_8D             ;# 8D - Unused
        dd $FFFFFFFF
    .slot_8E             ;# 8E - Unused
        dd $FFFFFFFF
    .slot_8F             ;# 8F - Unused
        dd $FFFFFFFF
    .slot_90             ;# 90 - Unused
        dd $FFFFFFFF
    .slot_91             ;# 91 - Unused
        dd $FFFFFFFF
    .slot_92             ;# 92 - Unused
        dd $FFFFFFFF
    .slot_93             ;# 93 - Unused
        dd $FFFFFFFF
    .slot_94             ;# 94 - Unused
        dd $FFFFFFFF
    .slot_95             ;# 95 - Unused
        dd $FFFFFFFF
    .slot_96             ;# 96 - Unused
        dd $FFFFFFFF
    .slot_97             ;# 97 - Unused
        dd $FFFFFFFF
    .slot_98             ;# 98 - Unused
        dd $FFFFFFFF
    .slot_99             ;# 99 - Unused
        dd $FFFFFFFF
    .slot_9A             ;# 9A - Unused
        dd $FFFFFFFF
    .slot_9B             ;# 9B - Unused
        dd $FFFFFFFF
    .slot_9C             ;# 9C - Unused
        dd $FFFFFFFF
    .slot_9D             ;# 9D - Unused
        dd $FFFFFFFF
    .slot_9E             ;# 9E - Unused
        dd $FFFFFFFF
    .slot_9F             ;# 9F - Unused
        dd $FFFFFFFF
    .slot_A0             ;# A0 - Unused
        dd $FFFFFFFF
    .slot_A1             ;# A1 - Unused
        dd $FFFFFFFF
    .slot_A2             ;# A2 - Unused
        dd $FFFFFFFF
    .slot_A3             ;# A3 - Unused
        dd $FFFFFFFF
    .slot_A4             ;# A4 - Unused
        dd $FFFFFFFF
    .slot_A5             ;# A5 - Unused
        dd $FFFFFFFF
    .slot_A6             ;# A6 - Unused
        dd $FFFFFFFF
    .slot_A7             ;# A7 - Unused
        dd $FFFFFFFF
    .slot_A8             ;# A8 - Unused
        dd $FFFFFFFF
    .slot_A9             ;# A9 - Unused
        dd $FFFFFFFF
    .slot_AA             ;# AA - Unused
        dd $FFFFFFFF
    .slot_AB             ;# AB - Unused
        dd $FFFFFFFF
    .slot_AC             ;# AC - Unused
        dd $FFFFFFFF
    .slot_AD             ;# AD - Unused
        dd $FFFFFFFF
    .slot_AE             ;# AE - Unused
        dd $FFFFFFFF
    .slot_AF             ;# AF - Unused
        dd $FFFFFFFF
    .slot_B0             ;# B0 - Unused
        dd $FFFFFFFF
    .slot_B1             ;# B1 - Unused
        dd $FFFFFFFF
    .slot_B2             ;# B2 - Unused
        dd $FFFFFFFF
    .slot_B3             ;# B3 - Unused
        dd $FFFFFFFF
    .slot_B4             ;# B4 - Unused
        dd $FFFFFFFF
    .slot_B5             ;# B5 - Unused
        dd $FFFFFFFF
    .slot_B6             ;# B6 - Unused
        dd $FFFFFFFF
    .slot_B7             ;# B7 - Unused
        dd $FFFFFFFF
    .slot_B8             ;# B8 - Unused
        dd $FFFFFFFF
    .slot_B9             ;# B9 - Unused
        dd $FFFFFFFF
    .slot_BA             ;# BA - Unused
        dd $FFFFFFFF
    .slot_BB             ;# BB - Unused
        dd $FFFFFFFF
    .slot_BC             ;# BC - Unused
        dd $FFFFFFFF
    .slot_BD             ;# BD - Unused
        dd $FFFFFFFF
    .slot_BE             ;# BE - Unused
        dd $FFFFFFFF
    .slot_BF             ;# BF - Unused
        dd $FFFFFFFF
    .slot_C0             ;# C0 - Unused
        dd $FFFFFFFF
    .slot_C1             ;# C1 - Unused
        dd $FFFFFFFF
    .slot_C2             ;# C2 - Unused
        dd $FFFFFFFF
    .slot_C3             ;# C3 - Unused
        dd $FFFFFFFF
    .slot_C4             ;# C4 - Unused
        dd $FFFFFFFF
    .slot_C5             ;# C5 - Unused
        dd $FFFFFFFF
    .slot_C6             ;# C6 - Unused
        dd $FFFFFFFF
    .slot_C7             ;# C7 - Unused
        dd $FFFFFFFF
    .slot_C8             ;# C8 - Unused
        dd $FFFFFFFF
    .slot_C9             ;# C9 - Unused
        dd $FFFFFFFF
    .slot_CA             ;# CA - Unused
        dd $FFFFFFFF
    .slot_CB             ;# CB - Unused
        dd $FFFFFFFF
    .slot_CC             ;# CC - Unused
        dd $FFFFFFFF
    .slot_CD             ;# CD - Unused
        dd $FFFFFFFF
    .slot_CE             ;# CE - Unused
        dd $FFFFFFFF
    .slot_CF             ;# CF - Unused
        dd $FFFFFFFF
    .slot_D0             ;# D0 - Unused
        dd $FFFFFFFF
    .slot_D1             ;# D1 - Unused
        dd $FFFFFFFF
    .slot_D2             ;# D2 - Unused
        dd $FFFFFFFF
    .slot_D3             ;# D3 - Unused
        dd $FFFFFFFF
    .slot_D4             ;# D4 - Unused
        dd $FFFFFFFF
    .slot_D5             ;# D5 - Unused
        dd $FFFFFFFF
    .slot_D6             ;# D6 - Unused
        dd $FFFFFFFF
    .slot_D7             ;# D7 - Unused
        dd $FFFFFFFF
    .slot_D8             ;# D8 - Unused
        dd $FFFFFFFF
    .slot_D9             ;# D9 - Unused
        dd $FFFFFFFF
    .slot_DA             ;# DA - Unused
        dd $FFFFFFFF
    .slot_DB             ;# DB - Unused
        dd $FFFFFFFF
    .slot_DC             ;# DC - Unused
        dd $FFFFFFFF
    .slot_DD             ;# DD - Unused
        dd $FFFFFFFF
    .slot_DE             ;# DE - Unused
        dd $FFFFFFFF
    .slot_DF             ;# DF - Unused
        dd $FFFFFFFF
    .slot_E0             ;# E0 - Unused
        dd $FFFFFFFF
    .slot_E1             ;# E1 - Unused
        dd $FFFFFFFF
    .slot_E2             ;# E2 - Unused
        dd $FFFFFFFF
    .slot_E3             ;# E3 - Unused
        dd $FFFFFFFF
    .slot_E4             ;# E4 - Unused
        dd $FFFFFFFF
    .slot_E5             ;# E5 - Unused
        dd $FFFFFFFF
    .slot_E6             ;# E6 - Unused
        dd $FFFFFFFF
    .slot_E7             ;# E7 - Unused
        dd $FFFFFFFF
    .slot_E8             ;# E8 - Unused
        dd $FFFFFFFF
    .slot_E9             ;# E9 - Unused
        dd $FFFFFFFF
    .slot_EA             ;# EA - Unused
        dd $FFFFFFFF
    .slot_EB             ;# EB - Unused
        dd $FFFFFFFF
    .slot_EC             ;# EC - Unused
        dd $FFFFFFFF
    .slot_ED             ;# ED - Unused
        dd $FFFFFFFF
    .slot_EE             ;# EE - Unused
        dd $FFFFFFFF
    .slot_EF             ;# EF - Unused
        dd $FFFFFFFF
    .slot_F0             ;# F0 - Unused
        dd $FFFFFFFF
    .slot_F1             ;# F1 - Unused
        dd $FFFFFFFF
    .slot_F2             ;# F2 - Unused
        dd $FFFFFFFF
    .slot_F3             ;# F3 - Unused
        dd $FFFFFFFF
    .slot_F4             ;# F4 - Unused
        dd $FFFFFFFF
    .slot_F5             ;# F5 - Unused
        dd $FFFFFFFF
    .slot_F6             ;# F6 - Unused
        dd $FFFFFFFF
    .slot_F7             ;# F7 - Unused
        dd $FFFFFFFF
    .slot_F8             ;# F8 - Unused
        dd $FFFFFFFF
    .slot_F9             ;# F9 - Unused
        dd $FFFFFFFF
    .slot_FA             ;# FA - Unused
        dd $FFFFFFFF
    .slot_FB             ;# FB - Unused
        dd $FFFFFFFF
    .slot_FC             ;# FC - Unused
        dd $FFFFFFFF
    .slot_FD             ;# FD - Unused
        dd $FFFFFFFF
    .slot_FE             ;# FE - Unused
        dd $FFFFFFFF
    .slot_FF             ;# FF - NULL
        dd $FFFFFFFF