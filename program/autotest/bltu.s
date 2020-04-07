# TAG = bltu

    .text

    # Branch op taken
    li x1, 0x00000000
    li x2, 0x00000001
    bltu x1, x2, 1f
    1: li x31, 42

    li x1, 0xfffffffe
    li x2, 0xffffffff
    bltu x1, x2, 1f
    1: li x31, 42

    li x1, 0x00000000
    li x2, 0xffffffff
    bltu x1, x2, 1f
    1: li x31, 42

    # Branch op not taken
    li x1, 0x00000001
    li x2, 0x00000000
    bltu x1, x2, 1f
    li x31, 42
    1:

    li x1, 0xffffffff
    li x2, 0xfffffffe
    bltu x1, x2, 1f
    li x31, 42
    1:

    li x1, 0xffffffff
    li x2, 0x00000000
    bltu x1, x2, 1f
    li x31, 42
    1:

    li x1, 0x80000000
    li x2, 0x7fffffff
    bltu x1, x2, 1f
    li x31, 42
    1:

    # un original
    li x1, 1
    bltu x0, x1, 1f
    addi x1, x1, 1
    addi x1, x1, 1
    addi x1, x1, 1
    addi x31, x1, 1
    1:
        addi x1, x1, 1
        addi x31, x1, 1


    # max_cycle 300
	# pout_start
    # 0000002a
    # 0000002a
    # 0000002a
    # 0000002a
    # 0000002a
    # 0000002a
    # 0000002a
    # 00000003
    # pout_end