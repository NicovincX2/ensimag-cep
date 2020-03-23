# TAG = add
    .text

    # addi rd, rs1, imm
    # le registre x0 vaut toujours 0
    add x31, zero, zero    # no operation

    lui x1, x0, 0
    lui x2, 1
    add x31, x1, x2

    lui x1, x0, 5
    lui x2, 6
    add x31, x1, x2

    lui x1, x0, -2048
    lui x2, 0
    add x31, x1, x2

    lui x1, x0, 2046
    lui x2, 1
    add x31, x1, x2

	# max_cycle 50
	# pout_start
    # 00000000
    # 10000000
    # B0000000
    # F8000000
    # FFFFFFF0
	# pout_end
