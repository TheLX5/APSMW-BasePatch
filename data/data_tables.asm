includefrom "main.asm"
;##################################################################################################
;# This file includes data tables that shouldn't move around

;#########################################################################
;# Palette Indexes

level_palette_index:
    print "  level_palette_index: $", pc
    !i #= 0
    while !i != 512
        db $00
        !i #= !i+1
    endwhile

map_palette_index:
    print "    map_palette_index: $", pc
    db $00      ; Main map
    db $00      ; Yoshi's Island
    db $00      ; Vanilla Dome
    db $00      ; Forest of Illusion
    db $00      ; Valley of Bowser
    db $00      ; Special World
    db $00      ; Star World

;#########################################################################
;# Vertical scroll settings override for each level

vertical_scroll_levels:
        db $02,$01,$02,$02,$02,$01,$02,$02,$02,$02,$02,$02,$02,$02,$01,$02 ; Levels 000-00F
        db $01,$02,$02,$02,$02,$01,$02,$02,$02,$02,$02,$02,$01,$02,$02,$02 ; Levels 010-01F
        db $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02 ; Levels 020-02F
        db $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02 ; Levels 030-03F
        db $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02 ; Levels 040-04F
        db $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02 ; Levels 050-05F
        db $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02 ; Levels 060-06F
        db $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02 ; Levels 070-07F
        db $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02 ; Levels 080-08F
        db $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02 ; Levels 090-09F
        db $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02 ; Levels 0A0-0AF
        db $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02 ; Levels 0B0-0BF
        db $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02 ; Levels 0C0-0CF
        db $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$01,$02 ; Levels 0D0-0DF
        db $02,$02,$02,$02,$02,$02,$02,$02,$02,$01,$02,$02,$02,$01,$02,$02 ; Levels 0E0-0EF
        db $02,$02,$01,$02,$02,$01,$01,$02,$02,$01,$02,$02,$02,$02,$01,$02 ; Levels 0F0-0FF
        db $02,$02,$02,$02,$02,$01,$01,$01,$02,$02,$02,$01,$02,$02,$02,$01 ; Levels 100-10F
        db $02,$02,$02,$02,$02,$02,$02,$02,$01,$02,$02,$02,$02,$02,$02,$02 ; Levels 110-11F
        db $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02 ; Levels 120-12F
        db $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02 ; Levels 130-13F
        db $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02 ; Levels 140-14F
        db $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02 ; Levels 150-15F
        db $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02 ; Levels 160-16F
        db $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02 ; Levels 170-17F
        db $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02 ; Levels 180-18F
        db $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02 ; Levels 190-19F
        db $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02 ; Levels 1A0-1AF
        db $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02 ; Levels 1B0-1BF
        db $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02 ; Levels 1C0-1CF
        db $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02 ; Levels 1D0-1DF
        db $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02 ; Levels 1E0-1EF
        db $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$01,$02,$02,$02,$02 ; Levels 1F0-1FF

;#########################################################################
;# Holds level info

map_indicator_data:
    ;     dsbcmy21
        db %10000000        ; 00 - Bonus
        db %01000101        ; 01 - Vanilla Secret 2
        db %01000101        ; 02 - Vanilla Secret 3
        db %10000000        ; 03 - Top Secret Area
        db %01000011        ; 04 - Donut Ghost House
        db %01100101        ; 05 - Donut Plains 3
        db %01011101        ; 06 - Donut Plains 4
        db %01010001        ; 07 - Morton's Castle
        db %00000001        ; 08 - Green Switch Palace
        db %01000111        ; 09 - Donut Plains 2
        db %01000111        ; 0A - Donut Secret 1
        db %01010001        ; 0B - Vanilla Fortress
        db %01100101        ; 0C - Butter Bridge 1
        db %01000101        ; 0D - Butter Bridge 2
        db %01000001        ; 0E - Ludwig Castle
        db %01001111        ; 0F - Cheese Bridge Area
        db %01010101        ; 10 - Cookie Mountain
        db %01000101        ; 11 - Soda Lake
        db %10000000        ; 12 - Test
        db %01000011        ; 13 - Donut Secret House
        db %00000001        ; 14 - Yellow Switch Palace
        db %01010111        ; 15 - Donut Plains 1
        db %10000000        ; 16 - Test
        db %10000000        ; 17 - Test
        db %01000101        ; 18 - Sunken Ghost Ship
        db %10000000        ; 19 - Test
        db %01010001        ; 1A - Wendy's Castle
        db %01000001        ; 1B - Chocolate Fortress
        db %01000101        ; 1C - Chocolate Island 5
        db %01000101        ; 1D - Chocolate Island 4
        db %10000000        ; 1E - Test
        db %01000001        ; 1F - Forest Fortress
        db %01000101        ; 20 - Roy's Castle
        db %01000001        ; 21 - Choco Ghost House
        db %01001101        ; 22 - Chocolate Island 1
        db %01100111        ; 23 - Chocolate Island 3
        db %01010111        ; 24 - Chocolate Island 2
        db %01000001        ; 101 - Iggy's Castle
        db %01010101        ; 102 - Yoshi's Island 4
        db %01100101        ; 103 - Yoshi's Island 3
        db %10000000        ; 104 - Yoshi's House
        db %01001101        ; 105 - Yoshi's Island 1
        db %01000101        ; 106 - Yoshi's Island 2
        db %01010101        ; 107 - Vanilla Ghost House
        db %10000000        ; 108 - Test
        db %01000111        ; 109 - Vanilla Secret 1
        db %01001101        ; 10A - Vanilla Dome 3
        db %01000101        ; 10B - Donut Secret 2
        db %10000000        ; 10C - Test
        db %10000000        ; 10D - Front Door
        db %10000000        ; 10E - Back Door
        db %01000011        ; 10F - Valley of Bowser 4
        db %01010101        ; 110 - Larry's Castle
        db %01000001        ; 111 - Valley Fortress
        db %10000000        ; 112 - Test
        db %01000101        ; 113 - Valley of Bowser 3
        db %01000111        ; 114 - Valley Ghost House
        db %01010111        ; 115 - Valley of Bowser 2
        db %01001101        ; 116 - Valley of Bowser 1
        db %01000001        ; 117 - Chocolate Secret
        db %01000111        ; 118 - Vanilla Dome 2
        db %01010101        ; 119 - Vanilla Dome 4
        db %01000111        ; 11A - Vanilla Dome 1
        db %00000001        ; 11B - Red Switch Palace
        db %01000001        ; 11C - Lemmy's Castle
        db %01001111        ; 11D - Forest Ghost House
        db %01000011        ; 11E - Forest of Illusion 1
        db %01000111        ; 11F - Forest of Illusion 4
        db %01000111        ; 120 - Forest of Illusion 2
        db %00000001        ; 121 - Blue Switch Palace
        db %01000101        ; 122 - Forest Secret Area
        db %01010111        ; 123 - Forest of Illusion 3
        db %10000000        ; 124 - Test
        db %01000101        ; 125 - Funky
        db %01000101        ; 126 - Outrageous
        db %01000101        ; 127 - Mondo
        db %01000101        ; 128 - Groovy
        db %10000000        ; 129 - Test
        db %01010101        ; 12A - Gnarly
        db %01000101        ; 12B - Tubular
        db %01000101        ; 12C - Way Cool
        db %01000101        ; 12D - Awesome
        db %10000000        ; 12E - Test
        db %10000000        ; 12F - Test
        db %01000011        ; 130 - Star World 2
        db %10000000        ; 131 - Test
        db %01000011        ; 132 - Star World 3
        db %10000000        ; 133 - Test
        db %00000111        ; 134 - Star World 1
        db %01000011        ; 135 - Star World 4
        db %01000011        ; 136 - Star World 5
        db %10000000        ; 137 - Test
        db %10000000        ; 138 - Test
        db %10000000        ; 139 - Test
        db %10000000        ; 13A - Test
        db %10000000        ; 13B - Test

;#########################################################################
;# Blocksanity pointers

blocksanity_pointers:
        dw $FFFF
        dw blocksanity_data_vanilla_secret_2
        dw blocksanity_data_vanilla_secret_3
        dw $FFFF
        dw blocksanity_data_donut_ghost_house
        dw blocksanity_data_donut_plains_3
        dw blocksanity_data_donut_plains_4
        dw blocksanity_data_donut_plains_castle
        dw $FFFF
        dw blocksanity_data_donut_plains_2
        dw blocksanity_data_donut_secret_1
        dw blocksanity_data_vanilla_fortress
        dw blocksanity_data_butter_bridge_1
        dw blocksanity_data_butter_bridge_2
        dw blocksanity_data_twin_bridges_castle
        dw blocksanity_data_cheese_bridge
        dw blocksanity_data_cookie_mountain
        dw blocksanity_data_soda_lake
        dw $FFFF
        dw blocksanity_data_donut_secret_house
        dw $FFFF
        dw blocksanity_data_donut_plains_1
        dw $FFFF
        dw $FFFF
        dw blocksanity_data_sunken_ghost_ship
        dw $FFFF
        dw blocksanity_data_chocolate_castle
        dw blocksanity_data_chocolate_fortress
        dw blocksanity_data_chocolate_island_5
        dw blocksanity_data_chocolate_island_4
        dw $FFFF
        dw blocksanity_data_forest_fortress
        dw blocksanity_data_forest_castle
        dw blocksanity_data_chocolate_ghost_house
        dw blocksanity_data_chocolate_island_1
        dw blocksanity_data_chocolate_island_3
        dw blocksanity_data_chocolate_island_2
        dw blocksanity_data_yoshis_island_castle
        dw blocksanity_data_yoshis_island_4
        dw blocksanity_data_yoshis_island_3
        dw $FFFF
        dw blocksanity_data_yoshis_island_1
        dw blocksanity_data_yoshis_island_2
        dw blocksanity_data_vanilla_ghost_house
        dw $FFFF
        dw blocksanity_data_vanilla_secret_1
        dw blocksanity_data_vanilla_dome_3
        dw blocksanity_data_donut_secret_2
        dw $FFFF
        dw $FFFF
        dw $FFFF
        dw blocksanity_data_valley_of_bowser_4
        dw blocksanity_data_valley_castle
        dw blocksanity_data_valley_fortress
        dw $FFFF
        dw blocksanity_data_valley_of_bowser_3
        dw blocksanity_data_valley_ghost_house
        dw blocksanity_data_valley_of_bowser_2
        dw blocksanity_data_valley_of_bowser_1
        dw blocksanity_data_chocolate_secret
        dw blocksanity_data_vanilla_dome_2
        dw blocksanity_data_vanilla_dome_4
        dw blocksanity_data_vanilla_dome_1
        dw $FFFF
        dw blocksanity_data_vanilla_dome_castle
        dw blocksanity_data_forest_ghost_house
        dw blocksanity_data_forest_of_illusion_1
        dw blocksanity_data_forest_of_illusion_4
        dw blocksanity_data_forest_of_illusion_2
        dw $FFFF
        dw blocksanity_data_forest_secret
        dw blocksanity_data_forest_of_illusion_3
        dw $FFFF
        dw blocksanity_data_special_zone_8
        dw blocksanity_data_special_zone_7
        dw blocksanity_data_special_zone_6
        dw blocksanity_data_special_zone_5
        dw $FFFF
        dw blocksanity_data_special_zone_1
        dw blocksanity_data_special_zone_2
        dw blocksanity_data_special_zone_3
        dw blocksanity_data_special_zone_4
        dw $FFFF
        dw $FFFF
        dw blocksanity_data_star_road_2
        dw $FFFF
        dw blocksanity_data_star_road_3
        dw $FFFF
        dw $FFFF
        dw blocksanity_data_star_road_4
        dw blocksanity_data_star_road_5
        dw $FFFF
        dw $FFFF
        dw $FFFF
        dw $FFFF
        dw $FFFF

;#########################################################################
;# Blocksanity data

blocksanity_data:
        .vanilla_secret_2
            dw $0170,$0130,$0000
            dw $02F0,$0170,$0001
            dw $0660,$0110,$0002
            dw $0B70,$0100,$0003
            dw $0DC0,$0120,$0004
            dw $0E70,$0120,$0005
            dw $1180,$0130,$0006
            dw $1190,$0130,$0007
            dw $11A0,$0130,$0008
            dw $11B0,$0130,$0009
            dw $11C0,$0130,$000A
            dw $11D0,$0130,$000B
            dw $FFFF
        .vanilla_secret_3
            dw $0270,$00D0,$000C
            dw $06E0,$00E0,$000D
            dw $FFFF
        .donut_ghost_house
            dw $0120,$0120,$000E
            dw $0070,$0140,$000F
            dw $0610,$0140,$0010
            dw $0640,$0140,$0011
            dw $0670,$0140,$0012
            dw $06A0,$0140,$0013
            dw $FFFF
        .donut_plains_3
            dw $01B0,$00E0,$0014
            dw $0450,$00F0,$0015
            dw $0480,$00F0,$0016
            dw $04E0,$0130,$0017
            dw $0BD0,$0140,$0018
            dw $1250,$00F0,$0019
            dw $FFFF
        .donut_plains_4
            dw $0660,$0130,$001A
            dw $0670,$0130,$001B
            dw $0680,$0130,$001C
            dw $0AF0,$0150,$001D
            dw $FFFF
        .donut_plains_castle
            dw $01E0,$00C0,$001E
            dw $00A0,$0680,$001F
            dw $00B0,$0680,$0020
            dw $00C0,$0680,$0021
            dw $0050,$0450,$0022
            dw $0030,$0320,$0023
            dw $0050,$0250,$0024
            dw $0080,$0250,$0025
            dw $00B0,$0250,$0026
            dw $0090,$0060,$0027
            dw $FFFF
        .donut_plains_2
            dw $00D0,$0120,$0028
            dw $00E0,$0120,$0029
            dw $00F0,$0120,$002A
            dw $0100,$0120,$002B
            dw $0330,$00D0,$002C
            dw $03C0,$00C0,$002D
            dw $0820,$00E0,$002E
            dw $0560,$00E0,$002F
            dw $0050,$0140,$0030
            dw $02B0,$00E0,$0031
            dw $FFFF
        .donut_secret_1
            dw $02C0,$0130,$0032
            dw $02D0,$0130,$0033
            dw $02E0,$0130,$0034
            dw $02F0,$0130,$0035
            dw $00E0,$0480,$0036
            dw $0060,$0250,$0037
            dw $0110,$0070,$0038
            dw $01A0,$0250,$0039
            dw $0570,$0150,$003A
            dw $0940,$0150,$003B
            dw $FFFF
        .vanilla_fortress
            dw $04E0,$0130,$003C
            dw $0220,$0130,$003D
            dw $0780,$0110,$003E
            dw $FFFF
        .butter_bridge_1
            dw $08A0,$0110,$003F
            dw $08B0,$00D0,$0040
            dw $0860,$0090,$0041
            dw $08E0,$0050,$0042
            dw $0840,$0050,$0043
            dw $0BD0,$0130,$0044
            dw $FFFF
        .butter_bridge_2
            dw $0310,$0100,$0045
            dw $0AC0,$0120,$0046
            dw $0C70,$0110,$0047
            dw $FFFF
        .twin_bridges_castle
            dw $01B0,$0370,$0048
            dw $FFFF
        .cheese_bridge
            dw $00C0,$0140,$0049
            dw $0560,$00E0,$004A
            dw $0A10,$0140,$004B
            dw $0B60,$0150,$004C
            dw $FFFF
        .cookie_mountain
            dw $01C0,$0130,$004D
            dw $01D0,$0130,$004E
            dw $01E0,$0130,$004F
            dw $01F0,$0130,$0050
            dw $0200,$0130,$0051
            dw $0210,$0130,$0052
            dw $0220,$0130,$0053
            dw $0230,$0130,$0054
            dw $0240,$0130,$0055
            dw $0200,$00F0,$0056
            dw $0A40,$0070,$0057
            dw $0B20,$0140,$0058
            dw $0C40,$0140,$0059
            dw $11C0,$0140,$005A
            dw $11D0,$0140,$005B
            dw $11E0,$0140,$005C
            dw $11F0,$0140,$005D
            dw $1200,$0140,$005E
            dw $1210,$0140,$005F
            dw $1220,$0140,$0060
            dw $1230,$0140,$0061
            dw $1240,$0140,$0062
            dw $1250,$0140,$0063
            dw $11B0,$0100,$0064
            dw $11C0,$0100,$0065
            dw $11D0,$0100,$0066
            dw $11E0,$0100,$0067
            dw $11F0,$0100,$0068
            dw $1200,$0100,$0069
            dw $1210,$0100,$006A
            dw $1220,$0100,$006B
            dw $1230,$0100,$006C
            dw $1240,$0100,$006D
            dw $1250,$0100,$006E
            dw $1360,$0140,$006F
            dw $FFFF
        .soda_lake
            dw $0200,$0110,$0070
            dw $FFFF
        .donut_secret_house
            dw $0480,$0140,$0071
            dw $0310,$0140,$0072
            dw $04A0,$0140,$0073
            dw $01E0,$0110,$0074
            dw $0180,$0130,$0075
            dw $FFFF
        .donut_plains_1
            dw $0710,$0140,$0076
            dw $0720,$0140,$0077
            dw $0D20,$00F0,$0078
            dw $0DB0,$0130,$0079
            dw $11A0,$0070,$007A
            dw $11A0,$0080,$007B
            dw $11A0,$0090,$007C
            dw $11A0,$00A0,$007D
            dw $11A0,$00B0,$007E
            dw $11A0,$00C0,$007F
            dw $11A0,$00D0,$0080
            dw $11A0,$00E0,$0081
            dw $11A0,$00F0,$0082
            dw $11A0,$0100,$0083
            dw $11A0,$0110,$0084
            dw $11A0,$0120,$0085
            dw $11A0,$0130,$0086
            dw $11A0,$0140,$0087
            dw $11A0,$0150,$0088
            dw $11A0,$0160,$0089
            dw $1240,$0120,$008A
            dw $1280,$0140,$008B
            dw $1290,$0140,$008C
            dw $FFFF
        .sunken_ghost_ship
            dw $0110,$0070,$008D
            dw $0100,$0C80,$008E
            dw $FFFF
        .chocolate_castle
            dw $09C0,$0110,$008F
            dw $0150,$0110,$0090
            dw $0750,$0140,$0091
            dw $FFFF
        .chocolate_fortress
            dw $0380,$0140,$0092
            dw $0360,$0150,$0093
            dw $0370,$0150,$0094
            dw $0380,$0150,$0095
            dw $0AC0,$0130,$0096
            dw $FFFF
        .chocolate_island_5
            dw $0170,$0130,$0097
            dw $0180,$0150,$0098
            dw $0340,$0170,$0099
            dw $0560,$0140,$009A
            dw $FFFF
        .chocolate_island_4
            dw $0700,$0140,$009B
            dw $0920,$00A0,$009C
            dw $0B50,$0040,$009D
            dw $FFFF
        .forest_fortress
            dw $02B0,$00E0,$009E
            dw $0750,$00D0,$009F
            dw $0ED0,$0140,$00A0
            dw $0F10,$0140,$00A1
            dw $0F10,$0100,$00A2
            dw $0F40,$0130,$00A3
            dw $0F70,$0140,$00A4
            dw $0F70,$00F0,$00A5
            dw $0FA0,$0130,$00A6
            dw $0FD0,$0140,$00A7
            dw $0FD0,$0100,$00A8
            dw $FFFF
        .forest_castle
            dw $0CC0,$0120,$00A9
            dw $FFFF
        .chocolate_ghost_house
            dw $0910,$0140,$00AA
            dw $0110,$0140,$00AB
            dw $05D0,$0140,$00AC
            dw $FFFF
        .chocolate_island_1
            dw $0490,$0120,$00AD
            dw $0CD0,$0100,$00AE
            dw $0E10,$0110,$00AF
            dw $0F00,$0140,$00B0
            dw $0070,$0120,$00B1
            dw $FFFF
        .chocolate_island_3
            dw $0530,$0140,$00B2
            dw $0A20,$0140,$00B3
            dw $0F50,$00F0,$00B4
            dw $1080,$00F0,$00B5
            dw $11D0,$0140,$00B6
            dw $1220,$0140,$00B7
            dw $1640,$0140,$00B8
            dw $1670,$0140,$00B9
            dw $16A0,$0140,$00BA
            dw $FFFF
        .chocolate_island_2
            dw $00E0,$00A0,$00BB
            dw $00F0,$00D0,$00BC
            dw $0280,$0040,$00BD
            dw $0080,$0140,$00BE
            dw $05C0,$0140,$00BF
            dw $05F0,$0120,$00C0
            dw $0620,$0100,$00C1
            dw $0040,$0140,$00C2
            dw $0190,$0110,$00C3
            dw $01A0,$0110,$00C4
            dw $0240,$0110,$00C5
            dw $0250,$0110,$00C6
            dw $0260,$0110,$00C7
            dw $0270,$0110,$00C8
            dw $0280,$0110,$00C9
            dw $0290,$0110,$00CA
            dw $FFFF
        .yoshis_island_castle
            dw $0280,$00F0,$00CB
            dw $0290,$00F0,$00CC
            dw $02A0,$00F0,$00CD
            dw $02B0,$00F0,$00CE
            dw $02C0,$00F0,$00CF
            dw $0250,$0150,$00D0
            dw $FFFF
        .yoshis_island_4
            dw $00D0,$00F0,$00D1
            dw $0160,$0140,$00D2
            dw $0290,$0140,$00D3
            dw $04E0,$0120,$00D4
            dw $FFFF
        .yoshis_island_3
            dw $0250,$00C0,$00D5
            dw $0290,$0140,$00D6
            dw $02F0,$00E0,$00D7
            dw $0300,$00E0,$00D8
            dw $0310,$00E0,$00D9
            dw $0320,$00E0,$00DA
            dw $0330,$00E0,$00DB
            dw $0340,$00E0,$00DC
            dw $0350,$00E0,$00DD
            dw $04B0,$00A0,$00DE
            dw $04C0,$00A0,$00DF
            dw $0AC0,$0140,$00E0
            dw $0B00,$00C0,$00E1
            dw $0CD0,$0120,$00E2
            dw $0CE0,$0120,$00E3
            dw $0DA0,$00F0,$00E4
            dw $10A0,$0080,$00E5
            dw $FFFF
        .yoshis_island_1
            dw $0250,$0140,$00E6
            dw $09C0,$0140,$00E7
            dw $0D10,$00F0,$00E8
            dw $0F30,$0110,$00E9
            dw $FFFF
        .yoshis_island_2
            dw $0080,$00F0,$00EA
            dw $00C0,$00E0,$00EB
            dw $0130,$00F0,$00EC
            dw $0140,$00D0,$00ED
            dw $0180,$0100,$00EE
            dw $01C0,$00E0,$00EF
            dw $0260,$0140,$00F0
            dw $0270,$0140,$00F1
            dw $0280,$0140,$00F2
            dw $0350,$0150,$00F3
            dw $0360,$0150,$00F4
            dw $0B20,$0150,$00F5
            dw $0B30,$0150,$00F6
            dw $0B40,$0150,$00F7
            dw $0C80,$0100,$00F8
            dw $0DF0,$0120,$00F9
            dw $FFFF
        .vanilla_ghost_house
            dw $0200,$0100,$00FA
            dw $0750,$0150,$00FB
            dw $0860,$0140,$00FC
            dw $0A00,$0140,$00FD
            dw $05E0,$0120,$00FE
            dw $FFFF
        .vanilla_secret_1
            dw $0030,$0590,$00FF
            dw $0040,$0590,$0100
            dw $0110,$0490,$0101
            dw $01B0,$0520,$0102
            dw $0180,$0470,$0103
            dw $0190,$0350,$0104
            dw $01A0,$0350,$0105
            dw $01B0,$0350,$0106
            dw $FFFF
        .vanilla_dome_3
            dw $01C0,$0140,$0107
            dw $0200,$0160,$0108
            dw $0230,$0120,$0109
            dw $02D0,$0110,$010A
            dw $0480,$0150,$010B
            dw $0800,$0130,$010C
            dw $0830,$0130,$010D
            dw $0D90,$0120,$010E
            dw $03D0,$0130,$010F
            dw $10A0,$0100,$0110
            dw $1A60,$0140,$0111
            dw $1E40,$0090,$0112
            dw $1E50,$00A0,$0113
            dw $1E60,$00B0,$0114
            dw $1E70,$00C0,$0115
            dw $1E80,$00D0,$0116
            dw $1E90,$00E0,$0117
            dw $FFFF
        .donut_secret_2
            dw $00A0,$0170,$0118
            dw $0220,$0100,$0119
            dw $0250,$0040,$011A
            dw $0060,$0140,$011B
            dw $0B00,$0140,$011C
            dw $FFFF
        .valley_of_bowser_4
            dw $0370,$0130,$011D
            dw $0210,$0130,$011E
            dw $05E0,$0110,$011F
            dw $0610,$0040,$0120
            dw $07A0,$00D0,$0121
            dw $0B60,$0110,$0122
            dw $FFFF
        .valley_castle
            dw $0290,$0030,$0123
            dw $0330,$0110,$0124
            dw $0980,$0140,$0125
            dw $FFFF
        .valley_fortress
            dw $0220,$0140,$0126
            dw $0940,$0100,$0127
            dw $FFFF
        .valley_of_bowser_3
            dw $0130,$0110,$0128
            dw $08A0,$00E0,$0129
            dw $FFFF
        .valley_ghost_house
            dw $0160,$0100,$012A
            dw $0570,$0110,$012B
            dw $00E0,$0100,$012C
            dw $0270,$0140,$012D
            dw $FFFF
        .valley_of_bowser_2
            dw $0330,$0130,$012E
            dw $0720,$0140,$012F
            dw $0010,$00A0,$0130
            dw $00D0,$0140,$0131
            dw $FFFF
        .valley_of_bowser_1
            dw $0810,$0140,$0132
            dw $0D40,$0100,$0133
            dw $0D50,$0100,$0134
            dw $0D60,$0100,$0135
            dw $0D60,$0080,$0136
            dw $0D60,$0090,$0137
            dw $0D60,$00A0,$0138
            dw $0D60,$00B0,$0139
            dw $0F20,$0120,$013A
            dw $FFFF
        .chocolate_secret
            dw $04A0,$0120,$013B
            dw $0960,$0140,$013C
            dw $FFFF
        .vanilla_dome_2
            dw $0240,$0100,$013D
            dw $0250,$0100,$013E
            dw $0260,$0100,$013F
            dw $0270,$0100,$0140
            dw $03B0,$0100,$0141
            dw $0720,$00F0,$0142
            dw $0760,$00F0,$0143
            dw $0770,$00F0,$0144
            dw $0780,$00F0,$0145
            dw $0880,$0100,$0146
            dw $0730,$0040,$0147
            dw $0D10,$0100,$0148
            dw $1290,$0130,$0149
            dw $1150,$0140,$014A
            dw $FFFF
        .vanilla_dome_4
            dw $0690,$0100,$014B
            dw $0CB0,$0140,$014C
            dw $0E10,$0120,$014D
            dw $0E20,$0120,$014E
            dw $0E30,$0120,$014F
            dw $0E40,$0120,$0150
            dw $0E50,$0120,$0151
            dw $0E60,$0120,$0152
            dw $0E70,$0120,$0153
            dw $0E80,$0120,$0154
            dw $0E90,$0120,$0155
            dw $FFFF
        .vanilla_dome_1
            dw $0250,$0110,$0156
            dw $0400,$0120,$0157
            dw $0450,$00E0,$0158
            dw $0460,$0120,$0159
            dw $04D0,$0120,$015A
            dw $0640,$0180,$015B
            dw $0680,$00E0,$015C
            dw $00F0,$00E0,$015D
            dw $13A0,$0140,$015E
            dw $17D0,$0150,$015F
            dw $FFFF
        .vanilla_dome_castle
            dw $0110,$0100,$0160
            dw $0210,$0100,$0161
            dw $03A0,$0130,$0162
            dw $0170,$0140,$0163
            dw $0B90,$0140,$0164
            dw $FFFF
        .forest_ghost_house
            dw $0950,$0110,$0165
            dw $0990,$0110,$0166
            dw $0190,$0150,$0167
            dw $0370,$0140,$0168
            dw $0640,$0160,$0169
            dw $FFFF
        .forest_of_illusion_1
            dw $01A0,$0110,$016A
            dw $0360,$0130,$016B
            dw $0FA0,$0150,$016C
            dw $0E00,$0160,$016D
            dw $0610,$0130,$016E
            dw $FFFF
        .forest_of_illusion_4
            dw $0540,$0140,$016F
            dw $05E0,$0140,$0170
            dw $05F0,$0140,$0171
            dw $0600,$0140,$0172
            dw $0620,$0140,$0173
            dw $0630,$0140,$0174
            dw $0640,$0140,$0175
            dw $0E30,$0140,$0176
            dw $0E40,$0140,$0177
            dw $0E40,$0100,$0178
            dw $0EF0,$0140,$0179
            dw $0F00,$0140,$017A
            dw $0EF0,$0100,$017B
            dw $FFFF
        .forest_of_illusion_2
            dw $0070,$0130,$017C
            dw $0480,$0040,$017D
            dw $0600,$0120,$017E
            dw $0610,$0120,$017F
            dw $0620,$0120,$0180
            dw $0630,$0120,$0181
            dw $0950,$0160,$0182
            dw $FFFF
        .forest_secret
            dw $0330,$00A0,$0183
            dw $0450,$0110,$0184
            dw $06A0,$00B0,$0185
            dw $FFFF
        .forest_of_illusion_3
            dw $0350,$0150,$0186
            dw $04C0,$0150,$0187
            dw $04D0,$0140,$0188
            dw $04F0,$0120,$0189
            dw $0D90,$0110,$018A
            dw $0D80,$0150,$018B
            dw $0D90,$0150,$018C
            dw $0DA0,$0150,$018D
            dw $0E40,$0140,$018E
            dw $0E50,$0120,$018F
            dw $0E70,$0150,$0190
            dw $0E90,$0110,$0191
            dw $0EB0,$0130,$0192
            dw $0EE0,$0140,$0193
            dw $0EF0,$0100,$0194
            dw $0F10,$0120,$0195
            dw $0F50,$0130,$0196
            dw $0F70,$0150,$0197
            dw $0F80,$0110,$0198
            dw $0F90,$0130,$0199
            dw $0FC0,$0150,$019A
            dw $0FD0,$0120,$019B
            dw $11A0,$0150,$019C
            dw $11B0,$0120,$019D
            dw $1230,$0150,$019E
            dw $1240,$0140,$019F
            dw $1250,$0130,$01A0
            dw $FFFF
        .special_zone_8
            dw $0390,$0100,$01A1
            dw $04A0,$0130,$01A2
            dw $04B0,$0130,$01A3
            dw $04C0,$0130,$01A4
            dw $04D0,$0130,$01A5
            dw $04E0,$0130,$01A6
            dw $0560,$0140,$01A7
            dw $05D0,$0140,$01A8
            dw $0750,$00F0,$01A9
            dw $0670,$0140,$01AA
            dw $0680,$0140,$01AB
            dw $0690,$0140,$01AC
            dw $06A0,$0140,$01AD
            dw $06B0,$0140,$01AE
            dw $06C0,$0140,$01AF
            dw $06F0,$0140,$01B0
            dw $0700,$0140,$01B1
            dw $0710,$0140,$01B2
            dw $0720,$0140,$01B3
            dw $0730,$0140,$01B4
            dw $0740,$0140,$01B5
            dw $0750,$0140,$01B6
            dw $0CA0,$0100,$01B7
            dw $1100,$0120,$01B8
            dw $1110,$0120,$01B9
            dw $1120,$0120,$01BA
            dw $1130,$0120,$01BB
            dw $1140,$0120,$01BC
            dw $13F0,$0140,$01BD
            dw $1570,$00F0,$01BE
            dw $FFFF
        .special_zone_7
            dw $0350,$0150,$01BF
            dw $0C80,$0140,$01C0
            dw $0F90,$0140,$01C1
            dw $0FA0,$0140,$01C2
            dw $0FB0,$0140,$01C3
            dw $FFFF
        .special_zone_6
            dw $0370,$00F0,$01C4
            dw $0610,$0140,$01C5
            dw $0630,$0120,$01C6
            dw $0650,$0100,$01C7
            dw $07D0,$0140,$01C8
            dw $0950,$0140,$01C9
            dw $0D80,$0140,$01CA
            dw $0D90,$0140,$01CB
            dw $0DA0,$0140,$01CC
            dw $0DB0,$0140,$01CD
            dw $0DC0,$0140,$01CE
            dw $0DD0,$0140,$01CF
            dw $0DE0,$0140,$01D0
            dw $0DF0,$0140,$01D1
            dw $0E00,$0140,$01D2
            dw $0E10,$0140,$01D3
            dw $0E20,$0140,$01D4
            dw $0E30,$0140,$01D5
            dw $0E40,$0140,$01D6
            dw $0E50,$0140,$01D7
            dw $0E60,$0140,$01D8
            dw $0E70,$0140,$01D9
            dw $0D80,$0100,$01DA
            dw $0D90,$0100,$01DB
            dw $0DA0,$0100,$01DC
            dw $0DB0,$0100,$01DD
            dw $0DC0,$0100,$01DE
            dw $0DD0,$0100,$01DF
            dw $0DE0,$0100,$01E0
            dw $0DF0,$0100,$01E1
            dw $0E00,$0100,$01E2
            dw $0E10,$0100,$01E3
            dw $0E20,$0100,$01E4
            dw $0E30,$0100,$01E5
            dw $0E40,$0100,$01E6
            dw $0E50,$0100,$01E7
            dw $0E60,$0100,$01E8
            dw $0E70,$0100,$01E9
            dw $FFFF
        .special_zone_5
            dw $01D0,$0160,$01EA
            dw $FFFF
        .special_zone_1
            dw $0020,$03C0,$01EB
            dw $0050,$03C0,$01EC
            dw $0080,$03C0,$01ED
            dw $00B0,$03C0,$01EE
            dw $0110,$0340,$01EF
            dw $0120,$0280,$01F0
            dw $0080,$01F0,$01F1
            dw $00B0,$01F0,$01F2
            dw $00F0,$00D0,$01F3
            dw $0190,$00C0,$01F4
            dw $01C0,$0130,$01F5
            dw $0180,$01A0,$01F6
            dw $01D0,$01A0,$01F7
            dw $01C0,$0270,$01F8
            dw $01A0,$02C0,$01F9
            dw $0190,$0310,$01FA
            dw $01B0,$0370,$01FB
            dw $0180,$03D0,$01FC
            dw $0200,$0120,$01FD
            dw $0210,$0130,$01FE
            dw $0220,$0140,$01FF
            dw $0230,$0150,$0200
            dw $FFFF
        .special_zone_2
            dw $02E0,$0120,$0201
            dw $0380,$0110,$0202
            dw $0450,$0140,$0203
            dw $04A0,$00F0,$0204
            dw $05C0,$0150,$0205
            dw $05C0,$00F0,$0206
            dw $0760,$0140,$0207
            dw $07E0,$00E0,$0208
            dw $0850,$0100,$0209
            dw $0920,$0140,$020A
            dw $FFFF
        .special_zone_3
            dw $03F0,$0110,$020B
            dw $0080,$0140,$020C
            dw $0A50,$0140,$020D
            dw $FFFF
        .special_zone_4
            dw $0490,$0140,$020E
            dw $0AF0,$00F0,$020F
            dw $FFFF
        .star_road_2
            dw $0460,$0130,$0210
            dw $FFFF
        .star_road_3
            dw $0080,$0030,$0211
            dw $FFFF
        .star_road_4
            dw $0540,$0090,$0212
            dw $0C00,$0140,$0213
            dw $0C10,$0140,$0214
            dw $0C20,$0140,$0215
            dw $0C30,$0140,$0216
            dw $0C40,$0140,$0217
            dw $0C50,$0140,$0218
            dw $0C60,$0140,$0219
            dw $0D40,$0160,$021A
            dw $FFFF
        .star_road_5
            dw $0510,$0140,$021B
            dw $07D0,$0150,$021C
            dw $08E0,$0100,$021D
            dw $08F0,$0050,$021E
            dw $0900,$0050,$021F
            dw $0910,$0050,$0220
            dw $0920,$0050,$0221
            dw $0930,$0050,$0222
            dw $0940,$0050,$0223
            dw $0950,$0050,$0224
            dw $0960,$0050,$0225
            dw $0970,$0050,$0226
            dw $0980,$0050,$0227
            dw $0990,$0050,$0228
            dw $09A0,$0050,$0229
            dw $09B0,$0050,$022A
            dw $09C0,$0050,$022B
            dw $09D0,$0050,$022C
            dw $09E0,$0050,$022D
            dw $09F0,$0050,$022E
            dw $0A00,$0050,$022F
            dw $0A10,$0050,$0230
            dw $0A10,$0060,$0231
            dw $0A20,$0080,$0232
            dw $0A30,$0080,$0233
            dw $0A40,$0080,$0234
            dw $0A50,$0080,$0235
            dw $0A60,$0080,$0236
            dw $0A70,$0080,$0237
            dw $0A80,$0080,$0238
            dw $0A90,$0080,$0239
            dw $0AA0,$0080,$023A
            dw $0AB0,$0080,$023B
            dw $0AC0,$0080,$023C
            dw $0AD0,$0080,$023D
            dw $0AE0,$0080,$023E
            dw $0AF0,$0080,$023F
            dw $0B00,$0080,$0240
            dw $0B10,$0080,$0241
            dw $0B20,$0080,$0242
            dw $0B30,$0080,$0243
            dw $0B40,$0080,$0244
            dw $0B50,$0080,$0245
            dw $FFFF
