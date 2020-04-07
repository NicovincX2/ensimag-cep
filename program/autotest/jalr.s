# TAG = jalr

    .text

    li t0, 0
    li x31, 42  # on a 42 si tout se passe bien

    # test 1
    la   t1, target_2

    jalr t0, t1, 0

    linkaddr_2:
        j fail

    target_2:
        la  t1, linkaddr_2
        bne t0, t1, fail

    # test 2
    la   t0, target_3

    jalr t0, t0, 0

    linkaddr_3:
        j fail

    target_3:
        la  t1, linkaddr_3
        bne t0, t1, fail

    
    fail:
        li x31, -42

    # un original
    li t0, 1
    la t1, 1f
    jr t1, -4
    addi t0, t0, 1
    addi t0, t0, 1
    addi t0, t0, 1
    addi x31, t0, 1
    1:
        addi t0, t0, 1
        addi x31, t0, 1

    # max_cycle 300
	# pout_start
    # 0000002a
    # 00000004
    # pout_end