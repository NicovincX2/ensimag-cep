# TAG = slt
    .text

    # Toujours plus de tests...
    # Groupement 1
    li x1, 0x00000000
    li x2, 0x00000000
    slt x31, x1, x2

    li x1, 0x00000001
    li x2, 0x00000001
    slt x31, x1, x2

    li x1, 0x00000003
    li x2, 0x00000007
    slt x31, x1, x2

    li x1, 0x00000007
    li x2, 0x00000003
    slt x31, x1, x2

    # Groupement 2
    li x1, 0x00000000
    li x2, 0xffff8000
    slt x31, x1, x2

    li x1, 0x80000000
    li x2, 0x00000000
    slt x31, x1, x2

    li x1, 0x80000000
    li x2, 0xffff8000
    slt x31, x1, x2

    # Groupement 3
    li x1, 0x00000000
    li x2, 0x00007fff
    slt x31, x1, x2

    li x1, 0x7fffffff
    li x2, 0x00000000
    slt x31, x1, x2

    li x1, 0x7fffffff
    li x2, 0x00007fff
    slt x31, x1, x2

    # Groupement 4
    li x1, 0x80000000
    li x2, 0x00007fff
    slt x31, x1, x2

    li x1, 0x7fffffff
    li x2, 0xffff8000
    slt x31, x1, x2

    # Groupement 5
    li x1, 0x00000000
    li x2, 0xffffffff
    slt x31, x1, x2

    li x1, 0xffffffff
    li x2, 0x00000001
    slt x31, x1, x2

    li x1, 0xffffffff
    li x2, 0xffffffff
    slt x31, x1, x2

    # Groupement 6
    li x1, -1
    slt x31, x0, x1

    li x1, 1
    slt x31, x1, x0

    slt x31, zero, zero

    li x1, 16
    li x2, 30
    slt x0, x1, x2  # mv x31, x0

	# max_cycle 300
	# pout_start
    # 00000000
    # 00000000
    # 00000001
    # 00000000
    # 00000000
    # 00000001
    # 00000001
    # 00000001
    # 00000000
    # 00000000
    # 00000001
    # 00000000
    # 00000000
    # 00000001
    # 00000000
    # 00000000
    # 00000001
    # 00000000
	# pout_end
