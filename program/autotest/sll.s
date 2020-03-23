# TAG = sll
    .text

    # sll rd, rs1, rs2
    # le registre x0 vaut toujours 0

    addi x1, x0, 0
    addi x2, x0, 0
    sll x31, x1, x2

    addi x1, x0, 0
    addi x2, x0, 5
    sll x31, x1, x2

    addi x1, x0, 2
    addi x2, x0, 5
    sll x31, x1, x2

    addi x1, x0, -4
    addi x2, x0, 3
    sll x31, x1, x2

	# max_cycle 100
	# pout_start
    # 00000000
    # 00000000
    # 00000040
    # FFFFFFE0
	# pout_end
