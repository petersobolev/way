; A bunch of handy PSX routines
; Silpheed/HITMEN September 1998

; NOTE: register k1 is expected to contain $1f800000 (hardware base)

; Define some hardware registers:

GP0 equ $1810            
GP1 equ $1814            
IREG equ $1070        
IMASK equ $1074            
DPCR equ $10f0            
DICR equ $10f4
D2_MADR equ $10a0
D2_BCR equ $10a4
D2_CHCR equ $10a8


; SendList - sends a list of primitives to GPU
; in:   a0 - address of list

SendList    
            move t9, ra
            li t2, $04000002
            jal WaitGPU
            nop

            lw t3, DPCR(k1)
            sw zero, DICR(k1)
            ori t3, $800
            sw t3, DPCR(k1)


            sw t2, GP1(k1)
            sw a0, D2_MADR(k1)
            sw zero, D2_BCR(k1)
            li t1, $01000401
            sw t1, D2_CHCR(k1)
            
            move ra, t9
            jr ra
            nop
            
; WaitGPU - waits until GPU ready to receive commands
            
WaitGPU                     
            lw t1, GP1(k1)             
            li t0, $10000000
            and t1, t1, t0
            beqz t1, WaitGPU
            nop
            jr ra
            nop  
        

            

            

; InitGPU - basic GPU init routine
; in:  a0 - display mode  (  li a0, $08000009  )
            
InitGPU                                    
            move t3,ra                  ; save return addr

            sw zero, GP1(k1)            ; reset

            li t2, $03000001
            sw t2, GP1(k1)              ; disable display
  
            li t2, $06c40240            ; horiz start/end (command $06.  c40  240)
            sw t2, GP1(k1)
            nop
  
            li t2, $07049025            ; vert start/end (command $07.  start , end = $490 - $25 = 1131) 
            sw t2, GP1(k1)              
            nop              
                        
; 1110 0001 0000 0000 0000 0110 1000 0101                        
;
            li t2, $e1000685            ; draw mode, texture page = (8bit,320,0)
            jal WaitGPU
            nop
            sw t2, GP0(k1)
            nop
                                    
            jal WaitGPU
; bits 0-9 - X, bits $0a-13 - Y            
            li t2, $e3000000            ; command $e3 - clip start (set top left corner to draw 0,0)
            sw t2, GP0(k1)
            nop
; bits 0-9 - X, bits $0a-13 - Y
            li t2, $e4077e7f   ; command $e4 - clip end (set bottom right corner ) $e407fd3f for 320x240
            ; ($e4 << 24) + (height<<10) + width
            jal WaitGPU
            nop
            sw t2, GP0(k1)
            
; command $05
; bits 0-9: hor. offset (0-1023)
; bits 10-18: vert offset (0-512)

            li t2, $05000000            ; display offset ( Upper/left Display source address in VRAM.)
            jal WaitGPU
            nop
            sw t2, GP0(k1)
            
            li t2, $e5000000            ; draw offset 
            jal WaitGPU
            nop
            sw t2, GP0(k1)
  
; $08000009  =  1000 0000 0000 0000 0000 0000 1001   = 320, PAL
; command $08:
; bits 1,0: h.res: 00 - 256, 01 - 320, 10 - 512, 11 - 640
; bit 2: v.res: 0 - 240, 1 - 480
; bit 3: pal/ntsc: 0 - PAL, 1 - NTSC
; bit 4: color mode: 1 - 24bit, 0 - 15bit
; bit 5: 1 - interlaced, 0 - non-interlaced
; bit 6: if 1 and bits 0,1 = 0,0 then h.res=384.
            sw a0, GP1(k1)              ; set display mode       
            nop
                      
            li t2, $03000000
            sw t2, GP1(k1)              ; enable display
              
            move ra,t3                  ; restore return addr
            jr ra
            nop
            
