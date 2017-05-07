.pos 0x0
                 ld   $0x1028, r5         # r5 = bottom of stack 
                 ld   $0xfffffff4, r0     # r0 = -12
                 add  r0, r5              # r5 = r5 - 12 = 0x101c
                 ld   $0x200, r0          # r0 = 0x200; 
                 ld   0x0(r0), r0         # r0 = 0; 
                 st   r0, 0x0(r5)         # 0x0(r5) = 0;
                 ld   $0x204, r0          # r0 = 0x204; 
                 ld   0x0(r0), r0         # r0 = 0;
                 st   r0, 0x4(r5)         # 0x4(r5) = 0;
                 ld   $0x208, r0          # r0 = 0x208;
                 ld   0x0(r0), r0         # r0 = 0;
                 st   r0, 0x8(r5)         # 0x8(r5) = 0;
                 gpc  $6, r6              # pc = pc + 6;
                 j    0x300               # goto 0x300;
                 ld   $0x20c, r1          # r1 = address of 0x20c
                 st   r0, 0x0(r1)         # (0x20c) = r0;
                 halt                     # halt;
.pos 0x200
                 .long 0x00000000         # 0x200 = 0 = i r[0] 
                 .long 0x00000000         # 0x204 = 0 = j r[1]
                 .long 0x00000000         # 0x208 = 0 = m r[2]
                 .long 0x00000000         # 0x20c = 0 = n, the result
.pos 0x300
                 ld   0x0(r5), r0         # r0 = 0; 
                 ld   0x4(r5), r1         # r1 = 0;
                 ld   0x8(r5), r2         # r2 = 0;
                 ld   $0xfffffff6, r3     # r3 = -10; 
                 add  r3, r0              # r0 = r3 + r0 = -10;
                 mov  r0, r3              # r3 = r0 = -10;
                 not  r3                  # not r3;
                 inc  r3                  # r3 += 1 = 10;
                 bgt  r3, L6              # if r3 > 0, goto L6;
                 mov  r0, r3              # r3 = r0 = -10;
                 ld   $0xfffffff8, r4     # r4 = -8;
                 add  r4, r3              # r3 += r4 = -10 -8 = -18; 
                 bgt  r3, L6              # if r3 > 0; goto L6;
                 ld   $0x400, r3          # r3 = $0x400;
                 j    *(r3, r0, 4)        # goto *(r3, r0, 4);
.pos 0x330
                 add  r1, r2              # r2 += r1;             0x330 i = 10;
                 br   L7                  # goto L7;
                 not  r2                  # not r2;               0x334 i = 12;
                 inc  r2                  # r2 = -r2;
                 add  r1, r2              # r2 += r1;
                 br   L7                  # goto L7;
                 not  r2                  # not r2;               0x33c i = 14;
                 inc  r2                  # r2 = -r2;
                 add  r1, r2              # r2 += r1;
                 bgt  r2, L0              # if r2 > 0, goto L0;   
                 ld   $0x0, r2            # r2 = 0;
                 br   L1                  # goto L1;
L0:              ld   $0x1, r2            # r2 = 1;               0x34c
L1:              br   L7                  # goto L7;              0x352
                 not  r1                  # r1 = not r1;          0x354 i = 16;
                 inc  r1                  # r1 = -r1;
                 add  r2, r1              # r1 += r2;
                 bgt  r1, L2              # if r1 > 0, goto L2;
                 ld   $0x0, r2            # r2 = 0;
                 br   L3                  # goto L3;
L2:              ld   $0x1, r2            # r2 = 1;               0x364
L3:              br   L7                  # goto L7;              0x36a
                 not  r2                  # r2 = not r2;          0x36c i = 18;
                 inc  r2                  # r2 = -r2;
                 add  r1, r2              # r2 += r1;
                 beq  r2, L4              # if r2 = 0, goto L4;
                 ld   $0x0, r2            # r2 = 0;
                 br   L5                  # goto L5;
L4:              ld   $0x1, r2            # r2 = 1;               0x37c
L5:              br   L7                  # goto L7;              0x382
L6:              ld   $0x0, r2            # r2 = 0;               0x384
                 br   L7                  # goto L7;
L7:              mov  r2, r0              # r0 = r2;              0x38c
                 j    0x0(r6)             # return;
.pos 0x400
                 .long 0x00000330         # 0x330           i = 10;
                 .long 0x00000384         # L6              i = 11; default
                 .long 0x00000334         # 0x334           i = 12;
                 .long 0x00000384         # L6              i = 13; default
                 .long 0x0000033c         # 0x33c           i = 14;
                 .long 0x00000384         # L6              i = 15; default
                 .long 0x00000354         # 0x354           i = 16;
                 .long 0x00000384         # L6              i = 17; default
                 .long 0x0000036c         # 0x36c           i = 18;
.pos 0x1000
                 .long 0x00000000         # 0x1000 = 0     
                 .long 0x00000000         # 0x1004 = 0
                 .long 0x00000000         # 0x1008 = 0
                 .long 0x00000000         # 0x100c = 0
                 .long 0x00000000         # 0x1010 = 0
                 .long 0x00000000         # 0x1014 = 0
                 .long 0x00000000         # 0x1018 = 0
                 .long 0x00000000         # 0x101c = 0
                 .long 0x00000000         # 0x1020 = 0
                 .long 0x00000000         # 0x1024 = 0
