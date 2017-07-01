.pos 0x100
          ld $0x0, r0         # r0 = temp_i = 0
          ld $a, r1           # r1 = address of a[0]
          ld $0x0, r2         # r2 = temp_s = 0
          ld $0xffffffffb, r4 # r4 = -5  
loop:     mov r0, r5          # r5 = temp_i 
          add r4, r5          # r5 = temp_i - 5
          beq r5, end_loop    # if temp_i = 5 goto end_loop 
          ld (r1,r0,4), r3    # r3 = a[i]
          bgt r3, then        # if (a[i] > 0), goto then
else:     inc r0              # temp_i++     
          br loop             # goto loop
then:     add r3, r2          # s += a[i]
          inc r0              # temp_i++
          br loop             # goto loop
end_loop: ld $s, r1           # r1 = address of s
          st r2, 0x0(r1)      # s = temp_s
          st r0, 0x4(r1)      # i = temp_i
          halt 

.pos 0x1000
s:        .long 0x00000000  # s
i:        .long 0x0000000a  # i
a:        .long 0x0000000a  # a[0] = 10
          .long 0xffffffe2  # a[1] = -30
          .long 0xfffffff4  # a[2] = -12
          .long 0x00000004  # a[3] = 4
          .long 0x00000008  # a[4] = 8
