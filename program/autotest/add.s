# TAG = add
    .text

    # add rd, rs1, rs2
    # le registre x0 vaut toujours 0
    add x31, zero, zero    # no operation

    addi x1, x0, 1
    addi x2, x0, 1
    add x31, x1, x2

    add x31, x0, x0
    addi x1, x0, 5
    addi x2, x0, -5
    add x31, x1, x2

    add x31, x0, x0
    addi x1, x0, -2048
    addi x2, x0, 0
    add x31, x1, x2

    add x31, x0, x0
    addi x1, x0, 2046
    addi x2, x0, 1
    add x31, x1, x2

	# max_cycle 50
	# pout_start
    # 00000000
    # 00000002
    # 00000000
    # FFFFF800
    # 000007FF
	# pout_end
