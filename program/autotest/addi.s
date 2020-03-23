# TAG = addi
    .text

    # addi rd, rs1, imm
    # le registre x0 vaut toujours 0
    # addi zero, zero, 0    # no operation # 00000000
    addi x31, x0, 0     # copy register
	# addi x31, x0, -2048   # li x31, -2048
	# addi x31, zero, -1    # li x31, 0xFFFF
	# addi x31, zero, 2047    # li x31, 0x7F
	# addi x31, zero, 2048    # li x31, 0x800 fail car range -2048 à 2047

	# max_cycle 50
	# pout_start
    # 00000000
	# pout_end
    # F8000000
	# FFFF0000
	# FFFFFFF0
