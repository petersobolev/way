;
; "Way"
; 1k procedural graphics for Chaos Constructions'2024
; by Frog //ROi
;
; http://enlight.ru/roi
; frog@enlight.ru


            org $80010000
            
            li sp, $801fff00
            li k1, $1f800000            ; set to hardware base

            li a0, $0800002f            ; 640x480, PAL, interlaced
            jal InitGPU                 ; initialize the GPU
            nop

            
            la a0, list    
            jal SendList                ; send display list to GPU
            nop


loop
            j loop                     ; loop forever
            nop

            

include lib.inc                       ; some useful routines            

align 4

; display list

; header { size(hi byte), pointer to next element (other bytes. $ffffff if last) }
; packet { type (hi byte), ... }

list


; gradated 4 point polygon
sky    
    db soil, soil>>8, soil>>16, $8   ; link to next list element, size of current element
    dw $38aa5b00    ; $38 - gradated 4p poly. CCBBGGRR (C - command, b,g,r - color0) $38c4deeb 
    dw $00000000    ; y0  x0 0 0
    dw $30bb5b00    ; color 1  
    dw $0000027f    ; y1  x1 639 0
    dw $30f3dec6    ; color 2    
    dw $01300000    ;  y2  x2 0 304
    dw $30f3dec6    ; color 3 
    dw $0141027f    ; y3  x3 639 321


soil
    db road_surface, road_surface>>8, road_surface>>16, $8   ; link to next list element, size of current element
    dw $38fffce8    ; $38 - gradated 4p poly. CCBBGGRR (C - command, b,g,r - color0) $38c4deeb 
	dw $01300000  ; y0  x0 0 304 
    dw $30f4f1e1    ; color 1  
	dw $0141027f  ; y1  x1 639 321 
    dw $30b2b2b4    ; color 2    
	dw $01df0000  ; y2  x2 0 479 
    dw $30b2b2b4    ; color 3 
	dw $01df027f  ; y3  x3 639 479





road_surface
    db road_1, road_1>>8, road_1>>16, $8   ; link to next list element, size of current element
    dw $38000000    ; $38 - gradated 4p poly. CCBBGGRR (C - command, b,g,r - color0) $38c4deeb 
	dw $01360102  ; y0  x0 258 310	 
    dw $301a1815    ; color 1  
	dw $01380121  ; y1  x1 289 312	 
    dw $304e524c    ; color 2    
	dw $01df0078  ; y2  x2 120 479	 
    dw $304f534d    ; color 3 
	dw $01df01d2  ; y3  x3 466 479	



road_1
    db road_2, road_2>>8, road_2>>16, $5   ; link to next list element, size of current element
    dw $20ffffff    ; $20 - flat 3p poly. CCBBGGRR (C - command, b,g,r - color0)
	dw $013c0110  ; y0  x0 272 316	 
	dw $015e011c  ; y1  x1 284 350	 
	dw $015c010f  ; y2  x2 271 348	



road_2
    db road_3, road_3>>8, road_3>>16, $5   ; link to next list element, size of current element
    dw $28ffffff    ; $28 - flat 4p poly. CCBBGGRR (C - command, b,g,r - color0)
	dw $01770111  ; y0  x0 273 375	 
	dw $0177011f  ; y1  x1 287 375	 
	dw $019c010d  ; y2  x2 269 412	 
	dw $019af127  ; y3  x3 295 411	


road_3
    db sun_1, sun_1>>8, sun_1>>16, $5   ; link to next list element, size of current element
    dw $28ffffff    ; $28 - flat 4p poly. CCBBGGRR (C - command, b,g,r - color0)
	dw $01b1010e  ; y0  x0 270 430	 
	dw $01af0128  ; y1  x1 296 431	 
	dw $01df0107  ; y2  x2 263 479	 
	dw $01df0132  ; y3  x3 306 479	



sun_1:
    db sun_2, sun_2>>8, sun_2>>16, $5   ; link to next list element, size of current element
    dw $2800fff4    ; $28 - flat 4p poly. CCBBGGRR (C - command, b,g,r - color0)
	dw $00000000  ; y0  x0 0 0	 
	dw $004a0034  ; y0  x0 52 74
	dw $00520000  ; y2  x2 0 82	 
	dw $0052000e  ; y3  x3 14 82	


sun_2:
    db sun_3, sun_3>>8, sun_3>>16, $5   ; link to next list element, size of current element
    dw $2800fff4    ; $28 - flat 4p poly. CCBBGGRR (C - command, b,g,r - color0)
	dw $004a0034  ; y0  x0 52 74
		 
	dw $00000053  ; y1  x1 83 0	 
	dw $$0049002f  ; y3  x3 47 73
	dw $002e0046  ; y2  x2 70 46	 


sun_3:
    db sun_ray_1, sun_ray_1>>8, sun_ray_1>>16, $5   ; link to next list element, size of current element
    dw $2800ffff    ; $28 - flat 4p poly. CCBBGGRR (C - command, b,g,r - color0)
	dw $002e0046  ; y0  x0 70 46	 
	dw $00000053  ; y1  x1 83 0	 
	dw $000d0053  ; y2  x2 83 13	 
	dw $0026004a  ; y3  x3 74 38	


sun_ray_1:
    db sun_ray_2, sun_ray_2>>8, sun_ray_2>>16, $5   ; link to next list element, size of current element
    dw $2800fff4    ; $28 - flat 4p poly. CCBBGGRR (C - command, b,g,r - color0)
	dw $00510008  ; y0  x0 8 81	 
	dw $004e0012  ; y1  x1 18 78	 
	dw $00880013  ; y2  x2 19 136	 
	dw $00810024  ; y3  x3 36 129	


sun_ray_2:
    db sun_ray_3, sun_ray_3>>8, sun_ray_3>>16, $5   ; link to next list element, size of current element
    dw $2800fff4    ; $28 - flat 4p poly. CCBBGGRR (C - command, b,g,r - color0)
	dw $0047002c  ; y0  x0 44 71	 
	dw $00410033  ; y1  x1 51 65	 
	dw $00860051  ; y2  x2 81 134	 
	dw $007a0062  ; y3  x3 98 122	

sun_ray_3:
    db sun_ray_4, sun_ray_4>>8, sun_ray_4>>16, $5   ; link to next list element, size of current element
    dw $2800fff4    ; $28 - flat 4p poly. CCBBGGRR (C - command, b,g,r - color0)
	dw $002d0044  ; y0  x0 68 45	 
	dw $00250047  ; y1  x1 71 37	 
	dw $00610093  ; y2  x2 147 97	 
	dw $0050009e  ; y3  x3 158 80	

sun_ray_4:
    db sign_column, sign_column>>8, sign_column>>16, $5   ; link to next list element, size of current element
    dw $2800fff4    ; $28 - flat 4p poly. CCBBGGRR (C - command, b,g,r - color0)
	dw $00040051  ; y0  x0 81 4	 
	dw $00080088  ; y1  x1 136 8	 
	dw $000d004f  ; y2  x2 79 13	 
	dw $001c0082  ; y3  x3 130 28	






sign_column
    db sign_shadow, sign_shadow>>8, sign_shadow>>16, $8   ; link to next list element, size of current element
    dw $38c6b9ac    ; $38 - gradated 4p poly. CCBBGGRR (C - command, b,g,r - color0) $38c4deeb 
	dw $012401fc  ; y0  x0 508 292	 
    dw $30000000    ; color 1  
	dw $01240206  ; y1  x1 518 292	 
    dw $30c6b9ac    ; color 2    
	dw $01c701fc  ; y2  x2 508 455	 
    dw $30000000    ; color 3 
	dw $01c70206  ; y3  x3 518 455	





sign_shadow
    db sign_border, sign_border>>8, sign_border>>16, $8   ; link to next list element, size of current element
    dw $38000000    ; $38 - gradated 4p poly. CCBBGGRR (C - command, b,g,r - color0) $38c4deeb 
	dw $01c701fc  ; y0  x0 508 455	 
    dw $300000    ; color 1  
	dw $01c70206  ; y1  x1 518 455	 
    dw $30464544    ; color 2    
	dw $01df0216  ; y2  x2 534 479	 
    dw $30969290    ; color 3 
	dw $01df0241  ; y3  x3 577 479	



sign_border:
    db sign_back, sign_back>>8, sign_back>>16, $5   ; link to next list element, size of current element
    dw $28f7f7f7    ; $28 - flat 4p poly. CCBBGGRR (C - command, b,g,r - color0)

	dw $008401c8  ; y0  x0 456 132	 
	dw $007e0236  ; y1  x1 566 126	 
	dw $012901ce  ; y2  x2 462 297	 
	dw $01220234  ; y3  x3 564 290	


sign_back:
    db sign_frame, sign_frame>>8, sign_frame>>16, $5   ; link to next list element, size of current element
    dw $28d15d5d    ; $28 - flat 4p poly. CCBBGGRR (C - command, b,g,r - color0)

	dw $008601cb  ; y0  x0 459 134	 
	dw $00800233  ; y1  x1 563 128	 
	dw $012501d1  ; y2  x2 465 293	 
	dw $011f0231  ; y3  x3 561 287	


sign_frame:
    db sign_tree_1, sign_tree_1>>8, sign_tree_1>>16, $5   ; link to next list element, size of current element
    dw $28f7f7f7    ; $28 - flat 4p poly. CCBBGGRR (C - command, b,g,r - color0)

	dw $009601d3  ; y0  x0 467 152	 
	dw $0094022d  ; y1  x1 557 152	 
	dw $00f501d7  ; y2  x2 471 243	 
	dw $00f3022b  ; y3  x3 555 243	


sign_tree_1:
    db sign_tree_2, sign_tree_2>>8, sign_tree_2>>16, $5   ; link to next list element, size of current element
    dw $28000000    ; $28 - flat 4p poly. CCBBGGRR (C - command, b,g,r - color0)

	dw $00da0207  ; y0  x0 519 218	 
	dw $00da0212  ; y1  x1 530 218	 
	dw $00e90207  ; y2  x2 519 233	 
	dw $00e90212  ; y3  x3 530 233	


sign_tree_2:
    db sign_tree_3, sign_tree_3>>8, sign_tree_3>>16, $4   ; link to next list element, size of current element
    dw $20000000    ; $20 - polygon. CCBBGGRR (C - command, b,g,r - color)

	dw $00c5020a  ; y0  x0 522 197	 
	dw $00d90226  ; y1  x1 550 217	 
	dw $00e101f5  ; y2  x2 501 225	

sign_tree_3:
    db sign_tree_4, sign_tree_4>>8, sign_tree_4>>16, $4   ; link to next list element, size of current element
    dw $20000000    ; $20 - polygon. CCBBGGRR (C - command, b,g,r - color)

	dw $00b30204  ; y0  x0 516 179	 
	dw $00c7021c  ; y1  x1 540 199	 
	dw $00d001f7  ; y2  x2 503 208	

sign_tree_4:
    db bench_1, bench_1>>8, bench_1>>16, $4   ; link to next list element, size of current element
    dw $20000000    ; $20 - polygon. CCBBGGRR (C - command, b,g,r - color)

	dw $00a301fd  ; y0  x0 509 163	 
	dw $00b30210  ; y1  x1 528 179	 
	dw $00ba01fa  ; y2  x2 506 186	



bench_1:
    db bench_2, bench_2>>8, bench_2>>16, $5   ; link to next list element, size of current element
    dw $28000000    ; $28 - flat 4p poly. CCBBGGRR (C - command, b,g,r - color0)
	dw $00da01dd  ; y0  x0 477 218	 
	dw $00da01ee  ; y1  x1 494 218	 
	dw $00de01dd  ; y2  x2 477 222	 
	dw $00de01ee  ; y3  x3 494 222	

bench_2:
    db bench_3, bench_3>>8, bench_3>>16, $5   ; link to next list element, size of current element
    dw $28000000    ; $28 - flat 4p poly. CCBBGGRR (C - command, b,g,r - color0)
	dw $00de01df  ; y0  x0 479 222	 
	dw $00de01e3  ; y1  x1 483 222	 
	dw $00e801dc  ; y2  x2 476 232	 
	dw $00e901e0  ; y3  x3 480 233	

bench_3:
    db comp_1, comp_1>>8, comp_1>>16, $5   ; link to next list element, size of current element
    dw $28000000    ; $28 - flat 4p poly. CCBBGGRR (C - command, b,g,r - color0)
	dw $00de01e8  ; y0  x0 490 222	 
	dw $00de01ec  ; y1  x1 492 222	 
	dw $00e901ec  ; y2  x2 492 232	 
	dw $00e901f0  ; y3  x3 495 232	




comp_1:  
    db comp_2, comp_2>>8, comp_2>>16, $3   ; link to next list element, size of current element
    dw $60000000     ; $60 - flat block. CCBBGGRR (C - command, b,g,r - color)

	dw $00d201dd  ; y0  x0 477 210	 
	dw $00060011  ; y1  x1 494 215	

comp_2:  
    db comp_3, comp_3>>8, comp_3>>16, $3   ; link to next list element, size of current element
    dw $60000000     ; $60 - flat block. CCBBGGRR (C - command, b,g,r - color)

	dw $00c301dd  ; y0  x0 477 195	 
	dw $000d0011  ; y1  x1 494 207	

comp_3:  
    db $ff, $ff, $ff, $3   ; link to next list element, size of current element
    dw $60f7f7f7     ; $60 - flat block. CCBBGGRR (C - command, b,g,r - color)

	dw $00c601e0  ; y0  x0 480 198	 
	dw $0007000b  ; y1  x1 492 204	



