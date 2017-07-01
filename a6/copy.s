.pos 0x100
start:      ld $sb , r5
            inca r5
            gpc $6 , r6
            j copy
            halt
copy:       deca r5
            st r6 , 0x0(r5)
            ld $0xfffffff8, r0
            add r0 , r5
            ld $0 , r0
            ld $src , r1
copy_loop:  ld (r1, r0, 4) , r3
            beq r3 , copy_end
            st r3 , (r5,r0,4)                
            inc r0
            br copy_loop
copy_end:   ld $0, r3
            st r3 , (r5, r0, 4)       
            ld $8 , r4
            add r4, r5
            ld 0x0(r5), r6
            j 0x0(r6)

.pos 0x2000
src:    .long 1             
        .long 1             
        .long 0x2010
        .long 0             
        .long 0x0000ffff      
        .long 0xffff0100      
        .long 0xffffffff    
        .long 0x0200ffff             
        .long 0xffff0300            
        .long 0xffffffff             
        .long 0x0400ffff
        .long 0xffff0500
        .long 0xffffffff
        .long 0x0600ffff
        .long 0xffff0700
        .long 0xffffffff
        .long 0xf000ff00 

.pos 0x8000
        .long 0
        .long 0
        .long 0
        .long 0
        .long 0
        .long 0
        .long 0
sb:     .long 0
        .long 0
        .long 0
        .long 0
        .long 0
        .long 0
        .long 0
        .long 0
        .long 0
        .long 0
        .long 0
        .long 0
        .long 0
        .long 0
        .long 0
        .long 0
        .long 0
        .long 0
