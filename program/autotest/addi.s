# TAG = addi
    .text
    
    # addi rd, rs1, imm
    # le registre x0 vaut toujours 0
    addi x0, x0, 0    # no operation
    addi x31, x0, 0       # copy register
	addi x31, x0, -2048   # li x31, -2048
	addi x31, x0, -1    # li x31, 0xFFFFF

	# max_cycle 50
    # 00000000
	# FFFFF000
	# 12345000 
	# pout_end