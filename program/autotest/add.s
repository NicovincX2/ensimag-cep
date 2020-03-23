# TAG = add
    .text

    # add rd, rs1, rs2
    # le registre x0 vaut toujours 0
    add x31, zero, zero    # no operation

    addi x1, x0, 1
    add x31, x31, x1

    addi x1, x0, 5
    addi x2, x1, 6
    add x31, x1, x2

    # addi x1, x0, -2048
    # addi x2, x1, 0
    # add x31, x1, x2
    #
    # addi x1, x0, 2046
    # addi x2, x1, 1
    # add x31, x1, x2

	# max_cycle 50
	# pout_start
    # 00000000
    # 00000001
    # 0000000B
	# pout_end
    # FFFFF800
    # 000007FF
