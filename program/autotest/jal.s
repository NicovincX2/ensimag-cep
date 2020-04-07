# TAG = jal

    .text

    li  ra, 0
    li x31, 42  # on a 42 si tout se passe bien

    jal x4, target_2

    linkaddr_2:
        nop
        nop
        j fail

    target_2:
        la  x2, linkaddr_2
        bne x2, x4, fail

    fail:
        li x31, -42

    # un original
    li ra, 1
    jal x0, 1f
    addi ra, ra, 1
    addi ra, ra, 1
    addi ra, ra, 1
    addi x31, ra, 1
    1:
        addi ra, ra, 1
        addi x31, ra, 1

    # max_cycle 300
	# pout_start
    # 0000002a
    # 00000003
    # pout_end