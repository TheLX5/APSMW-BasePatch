includefrom "queno.asm"
;##################################################################################################
;# Documents every single SFX call supported by the Python side and prepares some of those to
;# actually be able to be randomized
;# 
;# This file isn't meant to be patched, the Python side care of this.

;# Pending:
;#  $02894C

;# Jump SFX
org $00D65E
    lda #$01
    sta $1DFA

;# Spinjump SFX
org $00D649
    lda #$04
    sta $1DFC

;# Hit head on ceiling SFX 
org $00ED41
    lda #$01
    sta $1DF9
    nop #4
    
;# Hit head on sprite
org $01B4F2
    lda #$01
    sta $1DF9 

;# Shooting a fireball
org $00FEB5
    lda #$06
    sta $1DFC

;# Cape spin SFX
org $00D07B
    lda #$04
    sta $1DFC

;# Cape smash SFX
org $00D8A8
    lda #$09
    sta $1DF9

;# Taking damage
org $00F5F3
    ldy #$04
    sty $1DF9

;# Cape hurt SFX
org $00F5E2
    ldy #$0F
    sty $1DF9

;# Something during a boss fight
org $00F919
    lda #$01
    sta $1DF9

;# Swim SFX
org $00DAA9
    lda #$0E
    sta $1DF9

;# Jump off water
org $00EA8D
    lda #$04
    sta $1DFC

;# Jump off a net SFX
org $00DBA5
    lda #$01
    sta $1DFA

;# Punching a net
org $00DBB2
    lda #$01
    sta $1DF9

;# Entering door SFX
org $00EC10
    lda #$0F
    sta $1DFC

;# Entering pipe SFX 
org $00D254
    lda #$04
    sta $1DF9

;# Entering pipe SFX #2
org $00F439
    lda #$04
    sta $1DF9

;# Shot out of a diagonal pipe
org $00D2A5
    lda #$09
    sta $1DFC

;# Collect Yoshi Coin
org $00F358
    lda #$1C
    sta $1DF9

;# Hit a midpoint
org $00F2E8
    lda #$05
    sta $1DF9 

;# Hit a wrong block
org $00F236
    lda #$2A
    sta $1DFC

;# Spawning a powerup during the goal tape
org $00FB7D
    lda #$0C
    sta $1DF9

;# Invisible mushroom spawn
org $03C342
    lda #$02
    sta $1DFC

;# Scrolling the screen with L/R
org $00CE3F
    ldy #$0E
    sty $1DFC

;# Pressing a P-Switch
org $01AAFD
    lda #$0B
    sta $1DF9

;# P-Switch running out
org $00C557
    lda #$24
    sta $1DFC

;# Climbing door turning
org $01BAD7
    lda #$0F
    sta $1DF9

;# Break goal tape
org $01C109
    lda #$09
    sta $1DFC

;# Putting item in item box
org $01C548
    lda #$0B
    sta $1DFC

;# Trigger item box
org $028012
    lda #$0C
    sta $1DFC

;# Collecting a coin
org $05B34D
    lda #$01
    sta $1DFC

;# Collecting a powerup (generic)
org $01C57A
    lda #$0A
    sta $1DF9

;# Collecting a feather
org $01C59C
    lda #$0D
    sta $1DF9

;# Grabbing a P-Balloon
org $01C309
    lda #$1E
    sta $1DF9

;# Bouncing off a springboard
org $01E6A9
    lda #$08
    sta $1DFC

;# Bouncing off a note block
org $02917D
    lda #$08
    sta $1DFC

;# Bouncing off a wall springboard
org $02CDEC
    lda #$08
    sta $1DFC

;# Block shatter
org $02867F
    lda #$07
    sta $1DFC

;# Activate ON/OFF switch
org $02881E
    ldx #$0B
    stx $1DF9

;# Activate ON/OFF switch (duped)
org $02918C
    lda #$0B
    sta $1DF9

;# Fireballs hitting a block/sprite
org $02A045
    lda #$01
    sta $1DF9

;$ Fireballs defeating a chuck
org $02A106
    lda #$02
    sta $1DF9

;# Fireballs converting a sprite into a coin
org $02A124
    lda #$03
    sta $1DF9

;# Activating a message box
org $038D7D
    lda #$22
    sta $1DFC

;# Activating a red question block
org $03C209
    ldy #$0B
    sty $1DF9

;#################################################################
;# Yoshi

;# Baby Yoshi swallowing an item #1
org $01A290
    lda #$06
    sta $1DF9

;# Baby Yoshi swallowing an item #2
org $03C037
    lda #$06
    sta $1DF9

;# Yoshi egg hatching
org $01F756
    lda #$0A
    sta $1DFC

;# Yoshi growing #1
org $01A2C5
    lda #$1F
    sta $1DFC

;# Yoshi growing #2
org $03C06C
    lda #$1F
    sta $1DFC

;# Yoshi mount
org $01ED5F
    lda #$1F
    sta $1DFC

;# Yoshi hurt
org $01F71D
    lda #$13
    sta $1DFC

;# Yoshi hurt (projectiles)
org $02A481
    lda #$13
    sta $1DFC

;# Yoshi flying
org $01EF0E
    ldy #$21
    sty $1DFC

;# Yoshi stomps an enemy
org $00EF90
    lda #$25
    sta $1DFC

;# Yoshi ground pounds (yellow shell)
org $00EFB6
    lda #$09
    sta $1DFC

;# Yoshi bounces off a triangle
org $00F024
    lda #$08
    sta $1DFC

;# Yoshi stomping the ground
org $029BE9
    lda #$09
    sta $1DFC

;# Yoshi swallowing a sprite
org $01F0D3
    lda #$06
    sta $1DF9

;# Yoshi eating a green berry
org $01F0FD
    lda #$29
    sta $1DFC

;# Yoshi sticking out tongue
org $01F30E
    lda #$21
    sta $1DFC

;# Yoshi unable to eat
org $01F5A1
    lda #$01
    sta $1DF9

;# Yoshi spitting out an item
org $01F2DF
    lda #$20
    sta $1DF9

;# Yoshi spitting out flames
org $01F28F
    lda #$17
    sta $1DFC

;# Collecting Yoshi's wings (eaten)
org $01F3EC
    lda #$03
    sta $1DFC

;# Collecting Yoshi's wings (touched)
org $01F6C8
    lda #$03
    sta $1DFC

;#################################################################
;# Enemies

macro thrown_sprite_sfx(i)
        if stringsequal("<i>", "y")
            cpy.b #!i+1
        elseif stringsequal("<i>", "x")
            cpx.b #!i+1
        endif
        bne +
        print "Thrown sprite combo #!{i} loc: ", pc
        lda.b #$13+!i
        sta $1DF9
        rtl
    +   
        !i #= !i+1
endmacro

org $0FFE00
    combo_y:
        !i #= 0
        %thrown_sprite_sfx("y")
        %thrown_sprite_sfx("y")
        %thrown_sprite_sfx("y")
        %thrown_sprite_sfx("y")
        %thrown_sprite_sfx("y")
        %thrown_sprite_sfx("y")
        %thrown_sprite_sfx("y")
        rtl
    combo_x:
        !i #= 0
        %thrown_sprite_sfx("x")
        %thrown_sprite_sfx("x")
        %thrown_sprite_sfx("x")
        %thrown_sprite_sfx("x")
        %thrown_sprite_sfx("x")
        %thrown_sprite_sfx("x")
        %thrown_sprite_sfx("x")
        rtl

;# Thrown sprites combo #1
org $01A60B
    jsl combo_y
    nop
    
;# Thrown sprites combo #2
org $01A659
    jsl combo_x
    nop

;# Defeating sprites with a star combo
org $01A865
    jsl combo_x
    nop

;# Bouncing off sprites combo
org $01AB57
    jsl combo_y
    nop 

;# Defeating Wigglers with a star combo
org $02F2C0
    jsl combo_y
    nop 

;# Defeating rexes with a star combo
org $03961D
    jsl combo_y
    nop 

;# Bouncing off rexes combo
org $039639
    jsl combo_y
    nop 

;# Kicked sprite (throw)
org $01A728
    lda #$03
    sta $1DF9

;# Kicked sprite (defeat)
org $01B12F
    lda #$03
    sta $1DF9

;# Spinjump on immune enemy
org $01A8D8
    lda #$02
    sta $1DF9

;# Spinjump on enemy
org $01A93F
    lda #$08
    sta $1DF9

;# Thrown sprite hitting ground from the side
org $01999E
    lda #$01
    sta $1DF9

;# Creating/Eating block
org $0392B8
    lda #$04
    sta $1DFA

;# Rex stomped
org $0395EC
    lda #$08
    sta $1DF9

;# Bullet bill from shooter
org $02B4A7
    lda #$09
    sta $1DFC

;# Bullet bill generator shooting
org $02B088
    lda #$09
    sta $1DFC

;# Bullet bill generator shooting x2
org $02B0DF
    lda #$09
    sta $1DFC

;# Bob-omb explosion
org $019631
    lda #$09
    sta $1DFC

;# Popping a bubble
org $02D918
    lda #$19
    sta $1DFC

;# Sumo bro stomp
org $02DD64
    lda #$09
    sta $1DFC

;# Sumo bro lightning spawning flames
org $02DECC
    lda #$17
    sta $1DFC

;# Bouncing off wiggler
org $02F26B
    lda #$03
    sta $1DF9

;# Banzai bill spawn
org $018390
    lda #$09
    sta $1DFC

;# Thwomp hitting the ground
org $01AF17
    lda #$09
    sta $1DFC

;# Thwimp hitting the ground
org $01AFFC
    lda #$01
    sta $1DF9

;# Chuck running
org $02C707
    lda #$01
    sta $1DF9

;# Chuck whistling
org $02C381
    lda #$1E
    sta $1DFC

;# Chuck clapping
org $02C4F8
    lda #$19
    sta $1DFC

;# Chuck jumping
org $02C536
    lda #$08
    sta $1DFC

;# Chuck splitting
org $02C5AE
    lda #$10
    sta $1DF9

;# Chuck bounce
org $02C7D2
    lda #$02
    sta $1DF9

;# Chuck hurt
org $02C7F6
    lda #$28
    sta $1DFC

;# Chuck defeated
org $02C7B8
    lda #$03
    sta $1DF9

;# Dino torch shooting fire
org $039D55
    ldy #$17
    sty $1DFC

;# Blargg attacking
org $039FFA
    lda #$25
    sta $1DF9

;# Swooper bat swooping
org $0388FF
    lda #$26
    sta $1DFC

;# Bowser statue flame spawn
org $018584
    lda #$17
    sta $1DFC

;# Bowser statue shooting a flame
org $038ADA
    lda #$17
    sta $1DFC

;# Bowser statue flame from generator
org $02B043
    lda #$17
    sta $1DFC

;# Magikoopa shooting magic spell
org $01BF28
    lda #$10
    sta $1DF9

;# Magikoopa's magic hitting the ground
org $01BC5F
    lda #$01
    sta $1DF9

;# Line guided sprites' SFX
org $01D745
    lda #$04
    sta $1DFA

;# Grinder SFX
org $01DB70
    lda #$04
    sta $1DFA

;# Podoboo jumping
org $01E0A1
    lda #$27
    sta $1DFC

;# Dry bones/Bony beetle collapsing
org $01E5F2
    lda #$07
    sta $1DF9

;# Wooden pillar hitting the ground
org $02D474
    lda #$09
    sta $1DFC

;# Smashers hitting the ground
org $05C9C1
    lda #$09
    sta $1DFC

;#################################################################
;# Bosses

;# Reznor shooting fireball
org $039B03
    lda #$10
    sta $1DF9

;# Hitting Reznor platform
org $039A66
    lda #$01
    sta $1DF9

;# Reznor bridge collapsing
org $03D752
    lda #$07
    sta $1DFC

;# Reznor defeated
org $039ABB
    lda #$03
    sta $1DF9

;# Big boo boss reappearing
org $0380E9
    ldy #$10
    sty $1DF9

;# Big boo boss hurt
org $038233
    lda #$28
    sta $1DFC

;# Big boo boss dying
org $0381DE
    lda #$23
    sta $1DF9

;# Hitting dummies
org $03CEC1
    lda #$02
    sta $1DF9

;# Wendy/Lemmy hurt
org $03CECB
    lda #$28
    sta $1DFC

;# Wendy/Lemmy hurt (correct)
org $03CE33
    ldy #$29
    sty $1DFC

;# Wendy/Lemmmy hurt (incorrect)
org $03CE46
    ldy #$2A
    sty $1DFC

;# Wendy/Lemmy defeated
org $03CE24
    lda #$23
    sta $1DF9

;# Wendy/Lemmy falling into lava
org $03CE7E
    lda #$20
    sta $1DFC

;# Ludwig jump
org $01CF0A
    lda #$08
    sta $1DFC

;# Ludwig fireball
org $01D059
    lda #$17
    sta $1DFC

;# Morton/Roy pillar drop
org $028414
    lda #$09
    sta $1DFC

;# Morton/Roy ground smash
org $01D299
    lda #$09
    sta $1DFC

;# Hurting Morton/Roy/Ludwig
org $01D3AB
    lda #$28
    sta $1DFC

;# Hurting Morton/Roy/Ludwig with a fireball
org $01D3F3
    lda #$01
    sta $1DF9

;# Bouncing on Morton/Roy/Ludwig
org $01D2FD
    lda #$02
    sta $1DF9

;# Bouncing on Morton/Roy/Ludwig (immune)
org $01D31E
    lda #$01
    sta $1DF9

;# Bouncing on Morton/Roy/Ludwig (immune, going up a wall)
org $01D334
    lda #$01
    sta $1DF9

;# Morton/Roy/Ludwig defeated
org $01CFD0
    lda #$1F
    sta $1DF9

;# Iggy/Larry throwing a ball
org $01FDB2
    lda #$20
    sta $1DF9

;# Hitting Iggy/Larry
org $01FCCE
    lda #$28
    sta $1DFC

;# Hitting Iggy/Larry with a fireball
org $01FD40
    lda #$01
    sta $1DF9

;# Iggy/Larry falling in lava
org $01FB60
    lda #$20
    sta $1DFC

;# Peach emerging from Clown car
org $03A8B2
    ldy #$2A
    sty $1DF9

;# Peach throwning an item
org $03A8E3
    lda #$10
    sta $1DF9

;# Bumping into Clown Car
org $03B0B8
    lda #$01
    sta $1DF9

;# Bowser slamming the ground
org $03AB8C
    lda #$09
    sta $1DFC

;# Bowser throwing a Mecha-Koopa
org $03A5D0
    lda #$08
    sta $1DFC

;# Bowser dropping a ball
org $03A603
    lda #$09
    sta $1DFC

;# Bowser ball's slam
org $03B1A3
    ldy #$25
    sty $1DFC

;# Bowser ball's bounce
org $03B1B1
    lda #$01
    sta $1DF9

;# Bowser flame spawning
org $03A7F6
    lda #$17
    sta $1DFC 

;# Disable panning on Bowser's flames
org $03A83D
    nop #3

;# Bowser hurt
org $03B129
    lda #$28
    sta $1DFC

;# Lightning
org $03E016
    lda #$18
    sta $1DFC

;#################################################################
;# Map
;#
;# Pending
;#  $048403 (wtf is this)

;# Stepping onto a level tile
org $04969F
    lda #$0023
    sta $1DFC

;# Level tile reveal
org $04ECAA
    lda #$01
    sta $1DFC

;# Tile reveal
org $04E763
    lda #$15
    sta $1DFC

;# Star warp
org $049170
    lda #$0D
    sta $1DF9

;# Castle destruction
org $04E66F
    lda #$16
    sta $1DFC

;# Switch palace blocks spawning
org $04F2A4
    lda #$1C
    sta $1DFC

;# Earthquake
org $0483CC
    lda #$21
    sta $1DF9

;# Fish jumping
org $04FA78
    lda #$0E
    sta $1DF9

;# Valley of bowser thunder
org $04F736
    lda #$18
    sta $1DFC

    
;#################################################################
;# Menus

;# Nintendo presents
org $0093C0
    lda #$01
    sta $1DFC

;# File menu option select
org $009AE3
    lda #$01
    sta $1DFC

;# File menu option change
org $009AF9
    ldy #$06
    sty $1DFC

;# Save game SFX
org $009BBB
    lda #$05
    sta $1DF9

;# OW options menu appearing
org $04F3FF
    lda #$22
    sta $1DFC

;# OW options 
org $04F567
    lda #$23
    sta $1DFC

;#################################################################
;# Cutscenes
;#
;# Pending:
;#  $03C84F

;# Castle door opening
org $02F67A
    ldy #$0F
    sty $1DFC

;# Castle door closing
org $02F683
    ldy #$10
    sty $1DFC

;# Ghost house door opening
org $02F765
    ldy #$0F
    sty $1DFC

;# Ghost house door closing
org $02F76E
    ldy #$10
    sty $1DFC

;# Detonation switch fuse
org $00C720
    lda #$1B
    sta $1DFC

;# Bouncing off something
org $00C732
    ldx #$01
    stx $1DF9

;# Tossing the castle
org $00C75F
    lda #$1E
    sta $1DF9

;# Picking up the castle
org $00C798
    lda #$09
    sta $1DF9

;# Huff sound during Morton/Roy sequence
org $00C7AC
    lda #$0E
    sta $1DF9

;# Hitting a castle
org $00C7D1
    lda #$09
    sta $1DFC

;# Shooting a firework
org $03C830
    lda #$25
    sta $1DFC

;# Egg shattering during credits
org $0CA5AF
    lda #$0A
    sta $1DFC

;# Hitting hill
org $0CCF2C
    lda #$08
    sta $1DF9

;# Castle crashing
org $0CD12A
    lda #$1A
    sta $1DFC

;# Explosion
org $0CD295
    lda #$1A
    sta $1DFC

;# Castle sinking
org $0CD2B2
    lda #$21
    sta $1DF9

;# Castle flying
org $0CD2BD
    lda #$17
    sta $1DFC

;# Fake explosion
org $0CD2D8
    lda #$19
    sta $1DFC

;# Hit castle with hammer
org $0CD3E7
    lda #$07
    sta $1DFC

;# Using a mop
org $0CD7D8
    lda #$0F
    sta $1DF9 
