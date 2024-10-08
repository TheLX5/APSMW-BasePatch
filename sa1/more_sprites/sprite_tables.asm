includefrom "sa1.asm"
!sa1 = 2        ; Set to 0 if you are not using SA-1, 1 if you are using normal (old) SA-1 Pack and 2 if you are using SA-1 with more sprites enabled (1.10+)

macro define_sprite_table(name, addr, addr_sa1, addr_more_sprites)
if !sa1 == 0
    !<name> = <addr>
elsif !sa1 == 1
    !<name> = <addr_sa1>
else
    !<name> = <addr_more_sprites>
endif
endmacro

%define_sprite_table(sprite_num, $9E, $9E, $3200)
%define_sprite_table(sprite_speed_y, $AA, $AA, $9E)
%define_sprite_table(sprite_speed_x, $B6, $B6, $B6)
%define_sprite_table(sprite_misc_c2, $C2, $C2, $D8)
%define_sprite_table(sprite_y_low, $D8, $D8, $3216)
%define_sprite_table(sprite_x_low, $E4, $E4, $322C)
%define_sprite_table(sprite_status, $14C8, $74C8, $3242)
%define_sprite_table(sprite_y_high, $14D4, $74D4, $3258)
%define_sprite_table(sprite_x_high, $14E0, $74E0, $326E)
%define_sprite_table(sprite_speed_y_frac, $14EC, $74EC, $74C8)
%define_sprite_table(sprite_speed_x_frac, $14F8, $74F8, $74DE)
%define_sprite_table(sprite_misc_1504, $1504, $7504, $74F4)
%define_sprite_table(sprite_misc_1510, $1510, $7510, $750A)
%define_sprite_table(sprite_misc_151c, $151C, $751C, $3284)
%define_sprite_table(sprite_misc_1528, $1528, $7528, $329A)
%define_sprite_table(sprite_misc_1534, $1534, $7534, $32B0)
%define_sprite_table(sprite_misc_1540, $1540, $7540, $32C6)
%define_sprite_table(sprite_misc_154c, $154C, $754C, $32DC)
%define_sprite_table(sprite_misc_1558, $1558, $7558, $32F2)
%define_sprite_table(sprite_misc_1564, $1564, $7564, $3308)
%define_sprite_table(sprite_misc_1570, $1570, $7570, $331E)
%define_sprite_table(sprite_misc_157c, $157C, $757C, $3334)
%define_sprite_table(sprite_blocked_status, $1588, $7588, $334A)
%define_sprite_table(sprite_misc_1594, $1594, $7594, $3360)
%define_sprite_table(sprite_off_screen_horz, $15A0, $75A0, $3376)
%define_sprite_table(sprite_misc_15ac, $15AC, $75AC, $338C)
%define_sprite_table(sprite_slope, $15B8, $75B8, $7520)
%define_sprite_table(sprite_off_screen, $15C4, $75C4, $7536)
%define_sprite_table(sprite_being_eaten, $15D0, $75D0, $754C)
%define_sprite_table(sprite_obj_interact, $15DC, $75DC, $7562)
%define_sprite_table(sprite_oam_index, $15EA, $75EA, $33A2)
%define_sprite_table(sprite_oam_properties, $15F6, $75F6, $33B8)
%define_sprite_table(sprite_misc_1602, $1602, $7602, $33CE)
%define_sprite_table(sprite_misc_160e, $160E, $760E, $33E4)
%define_sprite_table(sprite_index_in_level, $161A, $761A, $7578)
%define_sprite_table(sprite_misc_1626, $1626, $7626, $758E)
%define_sprite_table(sprite_behind_scenery, $1632, $7632, $75A4)
%define_sprite_table(sprite_misc_163e, $163E, $763E, $33FA)
%define_sprite_table(sprite_in_water, $164A, $764A, $75BA)
%define_sprite_table(sprite_tweaker_1656, $1656, $7656, $75D0)
%define_sprite_table(sprite_tweaker_1662, $1662, $7662, $75EA)
%define_sprite_table(sprite_tweaker_166e, $166E, $766E, $7600)
%define_sprite_table(sprite_tweaker_167a, $167A, $767A, $7616)
%define_sprite_table(sprite_tweaker_1686, $1686, $7686, $762C)
%define_sprite_table(sprite_off_screen_vert, $186C, $786C, $7642)
%define_sprite_table(sprite_misc_187b, $187B, $787B, $3410)
%define_sprite_table(sprite_tweaker_190f, $190F, $790F, $7658)
%define_sprite_table(sprite_misc_1fd6, $1FD6, $7FD6, $766E)
%define_sprite_table(sprite_cape_disable_time, $1FE2, $7FE2, $7FD6)