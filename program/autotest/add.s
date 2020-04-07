# TAG = add

    # le registre x0 vaut toujours 0
    add x31, zero, zero  # no operation
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

    # On passe en hexa avec lui
    li x1, 0xffff8000 
    li x2, 0x00000000
    add x31, x1, x2

    li x1, 0x80000000
    li x2, 0x80000000
    add x31, x1, x2


	# max_cycle 100
	# pout_start
    # 00000000
    # 00000002
    # 00000000
    # 00000000
    # 00000000
    # FFFFF800
    # 00000000
    # 000007FF
    # ffff8000
    # 00000000
	# pout_end
