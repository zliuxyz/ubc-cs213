.pos 0x100
start:
    ld $sb, r5          # sp = address of last word of stack = sb
    inca    r5          # sp = address of word after stack
    gpc $6, r6          # r6 = pc + 6 = ra
    j main              # call main
    halt

f:
    deca r5             # allocate callee part of f
    ld $0, r0           # r0 = 0
    ld 4(r5), r1        # r1 = x[7]
    ld $0x80000000, r2  # r2 = 0x80000000 
f_loop:
    beq r1, f_end       # if r1 = 0, goto f_end
    mov r1, r3          # r3 = r1 = x[7]
    and r2, r3          # r3 = x[7] & 0x8000000
    beq r3, f_if1       # if r3 = 0, goto f_if1
    inc r0              # r0+=1 
f_if1:
    shl $1, r1          # r1 = r1 shift left one bit 
    br f_loop           # goto f_loop
f_end:
    inca r5             # r5 = r5 + 4
    j(r6)               # return

main:
    deca r5             # allocate callee part of main
    deca r5             # allocate callee part of main
    st r6, 4(r5)        # save ra on stock
    ld $8, r4           # r4 = 8 
main_loop:
    beq r4, main_end    # if r4 = 0, goto main_end
    dec r4              # r4-=1
    ld $x, r0           # r0 = address of x
    ld (r0,r4,4), r0    # r0 = x[7]
    deca r5             # allocate caller part of f
    st r0, (r5)         # save r0/x[7] on stack
    gpc $6, r6          # r6 = pc + 6
    j f                 # call f
    inca r5             # r5 = r5 + 4
    ld $y, r1           # r1 = address of y = y[0]
    st r0, (r1,r4,4)    # y[r4] = r0
    br main_loop        # goto main_loop
main_end:
    ld 4(r5), r6        # restore ra to r6
    inca r5             # deallocate space
    inca r5             # deallocate space
    j (r6)              # return

.pos 0x2000
x:
    .long 1               # x[0] = 1
    .long 2               # x[1] = 2
    .long 3               # x[2] = 3
    .long 0xffffffff      # x[3] = -1
    .long 0xfffffffe      # x[4] = -2
    .long 0               # x[5] = 0
    .long 184             # x[6] = 184
    .long 340057058       # x[7] = 340057058

y:
    .long 0               # y[0] = 0
    .long 0               # y[1] = 0
    .long 0               # y[2] = 0
    .long 0               # y[3] = 0
    .long 0               # y[4] = 0
    .long 0               # y[5] = 0
    .long 0               # y[6] = 0
    .long 0               # y[7] = 0

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

