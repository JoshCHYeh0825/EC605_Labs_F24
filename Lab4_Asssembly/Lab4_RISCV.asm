# Lab 4 Assembly

# Fibonnaci Sequence, start at 0x80
# Seq[0] = 0; Seq[1] = 1; Seq[i] = Seq[i-2] + Seq[i-1] for i > 1

#Step 1: Assign Seq[1] = 1 to x1
li x1, 1 # x1 <= 1

# Step 2: Load 0x80 onto an empty register as memory address
li x2, 0x80 #x2 <= 0x80 

#Step 3: Store Seq[0] at MEM[0x80]
sw zero, 0(x2) # MEM[0x80] <= (Seq[0] which is 0)

#Step 4: Store Seq[1] at MEM[0x84] (84 because 4 byte per ++)
sw x1, 4(x2) # MEM[0x84] <= (Seq[1] = 1)
