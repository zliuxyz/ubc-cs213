.pos 0x0
start:           ld   $sb, r5          # sp = address of last word of stack 
                 inca r5               # sp = address of word after stack
                 gpc  $6, r6           # r6 = pc + 6
                 j    foo              # call foo 
                 halt                  # halt   
.pos 0x100
                 .long 0x00001000         
.pos 0x200
bar:             ld   0x0(r5), r0      # r0 = a0 = 3 ; 1
                 ld   0x4(r5), r1      # r1 = a1 = 4 ; 2 
                 ld   $0x100, r2       # r2 = 0x100   
                 ld   0x0(r2), r2      # r2 = 0x1000 = a
                 ld   (r2, r1, 4), r3  # r3 = a[4] = 0 ; a[2] = 0
                 add  r3, r0           # r0 = a[4] + 3 = 3 ; a[2] + 1 = 1
                 st   r0, (r2, r1, 4)  # a[4] = 3 ; 1
                 j    0x0(r6)          # return
.pos 0x300
foo:             ld   $0xfffffff4, r0  # r0 = -12  
                 add  r0, r5           # allocate callee part of foo 
                 st   r6, 0x8(r5)      # save ra on stack 
                 ld   $0x1, r0         # r0 = 1 = l0
                 st   r0, 0x0(r5)      # save value of l0 to stack
                 ld   $0x2, r0         # r0 = 2 = l1
                 st   r0, 0x4(r5)      # save value of l1 to stack
                 ld   $0xfffffff8, r0  # r0 = -8   
                 add  r0, r5           # allocate caller part of bar
                 ld   $0x3, r0         # r0 = 3   
                 st   r0, 0x0(r5)      # save value of a0 to stack
                 ld   $0x4, r0         # r0 = 4
                 st   r0, 0x4(r5)      # save value of a1 to stack
                 gpc  $6, r6           # r6 = pc + 6       
                 j    bar              # call bar
                 ld   $0x8, r0         # r0 = 8   
                 add  r0, r5           # deallocate caller part of bar  
                 ld   0x0(r5), r1      # r1 = l0 = 1
                 ld   0x4(r5), r2      # r2 = l1 = 2   
                 ld   $0xfffffff8, r0  # r0 = -8   
                 add  r0, r5           # allocate caller part of bar 
                 st   r1, 0x0(r5)      # save value of a0 to stack   
                 st   r2, 0x4(r5)      # save value of a1 to stack   
                 gpc  $6, r6           # r6 = pc + 6       
                 j    bar              # call bar
                 ld   $0x8, r0         # r0 = 8   
                 add  r0, r5           # deallocate caller part of bar   
                 ld   0x8(r5), r6      # r6 = ra   
                 ld   $0xc, r0         # r0 = 12   
                 add  r0, r5           # deallocate callee part of foo 
                 j    0x0(r6)          # return   
.pos 0x1000
a:               .long 0x00000000      # a[0]         
                 .long 0x00000000      # a[1]   
                 .long 0x00000000      # a[2]  
                 .long 0x00000000      # a[3]  
                 .long 0x00000000      # a[4]  
                 .long 0x00000000      # a[5]  
                 .long 0x00000000      # a[6]  
                 .long 0x00000000      # a[7]   
                 .long 0x00000000      # a[8]  
                 .long 0x00000000      # a[9]  
.pos 0x8000
# These are here so you can see (some of) the stack contents.
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
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
sb: .long 0
