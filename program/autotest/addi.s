# TAG = addi
    .text
    
    # addi rd, rs1, imm
    # le registre x0 vaut toujours 0
    addi x31, x31, 0       # x31 = 0
	addi x31, x31, 0xfffff # x31 = valeur maximal sur 20 bits
	addi x31, x31, 0x12345 # x31 = valeur quelconque

	# max_cycle 50
    # 00000000
	# FFFFF000
	# 12345000 
	# pout_end