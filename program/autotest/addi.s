# TAG = addi
    .text
    
    # addi rd, rs1, imm
    addi x1, x1, 0       # x1 = 0
	addi x1, x1, 0xfffff # x1 = valeur maximal sur 20 bits
	addi x1, x1, 0x12345 # x1 = valeur quelconque

	# max_cycle 50
    # 00000000
	# FFFFF000
	# 12345000 
	# pout_end