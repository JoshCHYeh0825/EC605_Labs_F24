# Lab 4 Assembly

# Task 1: Array Initialization
# Seq[0] = 0; Seq[1] = 1; Seq[i] = Seq[i-2] + Seq[i-1] for i > 1, until i = 32

# Initialize the array
addi x1, zero, 1 # x1 <= 1, assign Seq[1] = 1 to x1
addi x2, zero, 0x80 #x2 <= 0x80, stores memory address of sequence start

# Store Seq[0] at MEM[0x80]
sw zero, 0(x2) # MEM[0x80] <= (Seq[0] which is 0)
sw x1, 4(x2) # MEM[0x84] <= (Seq[1] = 1, 0x84 because 4-bytes per instruction)

# Loop counter
addi x3, zero, 2 # x3 <= i = 2 of for "i" in range (For loop, i = counter)
addi x4, zero, 31 # x4 <= 31 (Loop limit)

# Address register to store the value of last iteration
addi x5, x2, 4 # x5 <= x2 + 4, address of Seq[1]
addi x6, x2, 0 # x6 <= x2, address of Seq[0]

# Initialize Fibonacci Loop
fib_sequence:
  # To start the sequence, load Seq[i-1] and Seq[i-2]
  lw x7, 0(x5) # x7 <= Seq[i-1]
  lw x8, 0(x6) # x8 <= Seq[i-2]

  # Generate Seq[i] as Seq[i] = Seq[i-1] + Seq[i-2]
  add x9, x7, x8 # x9 <= x7 + x8 

  # Update memory and store new Fibonacci value
  addi x2, x5, 4
  sw x9, 0(x2) # MEM[0 + x2] <= x9 (Seq[i])

  # Update registers for next iteration
  addi x6, x5, 0 # x6 becomes new Seq[i-2]
  addi x5, x2, 0 # x5 becomes new Seq[i-1]

  # Update loop counter
  addi x3, x3, 1 # x3 <= x3 + 1 (increment i)

  # End loop when i is 32
  bne x3, x4, fib_sequence # if(x3 != 31, counter is not 31 then branch to fib_sequence)

end

# Task 2: Array Copy and Encrypt
# seq_encrypted[0] = FibSeq[31] ^ <key> ; seq_encrypted[1] = FibSeq[30] ^ <key>

# Initialize key at empty register
addi x10, zero, 2000 # x10 <= 0 + 2000, (key = 2000)

# Encryption Loop
array_encrypt:
  # Load FibSeq value
  lw x12, 0(x5) # x12 <= FibSeq[31 - i]

  # Encrypt value with key
  xor x12, x12, x10 # x12 <= x12 ^ x10, assign x12  to the value of x12 XOR Key at Register x10
  
  # Store the encrypted value
  sw x12, 0(x11) # MEM[0x00] <= x12, assigne encrypted value at x12 into memory address in x11 which was 0

  # Increment counter and addresses for next iteration
  addi x11, x11, 4 # x11 <= x11 + 4, increment to next address of the encrypted array
  addi x5, x5, -4 # x5 <= x5 - 4, Move to the last previous cell of the Fibonacci array
  addi x3, x3, -1 # x3 <= x3 - 1, Decrement the loop counter from 31

  # Loop does not stop until x3 is less than 0
  bge x3, zero, array_encrypt

end
