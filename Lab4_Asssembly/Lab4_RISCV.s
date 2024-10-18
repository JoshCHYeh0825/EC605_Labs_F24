# Lab 4 Assembly

# Fibonnaci Sequence, start at 0x80
# Seq[0] = 0; Seq[1] = 1; Seq[i] = Seq[i-2] + Seq[i-1] for i > 1

# Step 1 + 2: Load 0x80 onto empty register as memory address, Store Seq[0] at MEM[0x80]
li t2, 0x80 #t2 <= 0x80 

