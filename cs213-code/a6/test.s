.pos 0x100
br loop
newloop:  ld $0x0, r1
beq r1, newloopa
loop: ld $0xA, r0
bgt r0, newloop
halt

newloopa: j newloopb

newloopb: gpc $2, r6
          j 0x0(r6)
          halt
