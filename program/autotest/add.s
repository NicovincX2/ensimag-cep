# TAG = add
    .text

    # addi rd, rs1, imm
    # le registre x0 vaut toujours 0
    add x31, zero, zero    # no operation

    addi x1, x0, 1
    add x31, x1, x2

    addi x1, x0, 5
    addi x2, x1, 6
    add x31, x1, x2

    addi x1, x0, -2048
    addi x2, x1, 0
    add x31, x1, x2

    addi x1, x0, 2046
    addi x2, x1, 1
    add x31, x1, x2

	# max_cycle 50
	# pout_start
    # 00000000
    # 10000000
    # B0000000
    # F8000000
    # FFFFFFF0
	# pout_end
