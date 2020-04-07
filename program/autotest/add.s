# TAG = add

    .macro TEST_RR_OP 3
        li  x1, %2
        li  x2, %3
        %1 x31, x1, x2
    .endm

    .text
    # add rd, rs1, rs2

    TEST_RR_OP add, 0x00000000, 0x00000000

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

    # On passe en hexa...
    # li x1, 
    # li x2, 
    # add x31, x1, x2


	# max_cycle 100
	# pout_start
    # 00000000
    # 00000000
    # 00000002
    # 00000000
    # 00000000
    # 00000000
    # FFFFF800
    # 00000000
    # 000007FF
	# pout_end
