# TAG = addi
    .text
    
    # addi rd, rs1, imm
    # le registre x0 vaut toujours 0
    addi zero, zero, 0    # no operation
    addi x31, x0, 0       # copy register
	addi x31, x0, -2048   # li x31, -2048
	addi x31, zero, -1    # li x31, 0xFFFF

	# max_cycle 50
	# pout_begin
    # 00000000
    # 00000000
    # F8000000
	# FFFF0000
	# pout_end